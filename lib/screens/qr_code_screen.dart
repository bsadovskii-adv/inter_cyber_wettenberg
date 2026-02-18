import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/custom_app_bar.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'management_screen.dart';

class QrCodeScreen extends StatefulWidget {
  const QrCodeScreen({super.key});

  @override
  State<QrCodeScreen> createState() => _QrCodeScreenState();
}

class _QrCodeScreenState extends State<QrCodeScreen> {
  // The valid QR code that triggers the management panel
  static const String validQrCode = 'INTERCYBER-WETTENBERG-SESSION-2026';

  bool _showMyQrCode = false;
  bool _isScanning = false;
  String? _playerId;
  MobileScannerController? _scannerController;
  bool _hasScanned = false;

  @override
  void initState() {
    super.initState();
    _loadOrGeneratePlayerId();
  }

  Future<void> _loadOrGeneratePlayerId() async {
    final prefs = await SharedPreferences.getInstance();
    String? playerId = prefs.getString('player_id');
    if (playerId == null) {
      playerId =
          'PLAYER-${Random().nextInt(900000) + 100000}-${Random().nextInt(9000) + 1000}';
      await prefs.setString('player_id', playerId);
    }
    setState(() {
      _playerId = playerId;
    });
  }

  void _startScanning() {
    setState(() {
      _isScanning = true;
      _hasScanned = false;
      _scannerController = MobileScannerController();
    });
  }

  void _stopScanning() {
    _scannerController?.dispose();
    setState(() {
      _isScanning = false;
      _scannerController = null;
    });
  }

  void _onQrDetected(BarcodeCapture capture) {
    if (_hasScanned) return;

    final List<Barcode> barcodes = capture.barcodes;
    for (final barcode in barcodes) {
      final String? code = barcode.rawValue;
      if (code == null) continue;

      _hasScanned = true;
      _stopScanning();

      if (code == validQrCode) {
        // Unlock "Visit the club for the first time" achievement
        SharedPreferences.getInstance().then((prefs) {
          prefs.setBool('achievement_first_visit', true);
        });
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const ManagementScreen(),
          ),
        );
      } else {
        _showInvalidQrDialog();
      }
      break;
    }
  }

  void _showInvalidQrDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          'Invalid QR Code',
          style: GoogleFonts.inter(fontWeight: FontWeight.w700),
        ),
        content: Text(
          'This QR code is not recognized. Please scan a valid InterCyber QR code.',
          style: GoogleFonts.inter(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              'OK',
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w600,
                color: const Color(0xFFFFCC00),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showMyQr() {
    setState(() {
      _showMyQrCode = true;
    });
  }

  void _hideMyQr() {
    setState(() {
      _showMyQrCode = false;
    });
  }

  @override
  void dispose() {
    _scannerController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: customAppBar(
        context,
        title: 'QR code',
        onBack: () {
          if (_isScanning) {
            _stopScanning();
          } else {
            Navigator.of(context).pop();
          }
        },
      ),
      body: Stack(
        children: [
          // Main content
          if (_isScanning) _buildScannerView() else _buildDefaultView(),
          // My QR Code overlay
          if (_showMyQrCode) _buildMyQrOverlay(),
        ],
      ),
    );
  }

  Widget _buildDefaultView() {
    return Column(
      children: [
        Expanded(
          child: Center(
            child: _buildScannerFrame(),
          ),
        ),
        _buildButtons(),
        const SizedBox(height: 40),
      ],
    );
  }

  Widget _buildScannerFrame() {
    const double frameSize = 260;
    const double cornerLength = 40;
    const double cornerWidth = 4;

    return SizedBox(
      width: frameSize,
      height: frameSize,
      child: CustomPaint(
        painter: _CornerFramePainter(
          cornerLength: cornerLength,
          cornerWidth: cornerWidth,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildScannerView() {
    return Column(
      children: [
        Expanded(
          child: Stack(
            children: [
              MobileScanner(
                controller: _scannerController!,
                onDetect: _onQrDetected,
              ),
              Center(
                child: _buildScannerFrame(),
              ),
            ],
          ),
        ),
        _buildButtons(),
        const SizedBox(height: 40),
      ],
    );
  }

  Widget _buildButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: [
          // My QR Code button (white)
          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton(
              onPressed: _showMyQr,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28),
                ),
              ),
              child: Text(
                'My QR Code',
                style: GoogleFonts.inter(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Scan QR Code button (yellow)
          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton(
              onPressed: _isScanning ? null : _startScanning,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFFCC00),
                foregroundColor: Colors.black,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28),
                ),
              ),
              child: Text(
                'Scan QR Code',
                style: GoogleFonts.inter(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMyQrOverlay() {
    return Container(
      color: Colors.black.withValues(alpha: 0.7),
      child: Column(
        children: [
          Expanded(
            child: Center(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 40),
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: _playerId == null
                    ? const CircularProgressIndicator()
                    : QrImageView(
                        data: _playerId!,
                        version: QrVersions.auto,
                        size: 240,
                        eyeStyle: const QrEyeStyle(
                          eyeShape: QrEyeShape.square,
                          color: Color(0xFFFFCC00),
                        ),
                        dataModuleStyle: const QrDataModuleStyle(
                          dataModuleShape: QrDataModuleShape.square,
                          color: Color(0xFFFFCC00),
                        ),
                        backgroundColor: Colors.white,
                      ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: Column(
              children: [
                // Ok button
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: _hideMyQr,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFFCC00),
                      foregroundColor: Colors.black,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28),
                      ),
                    ),
                    child: Text(
                      'Ok',
                      style: GoogleFonts.inter(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                // Scan QR Code button (dimmed)
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: () {
                      _hideMyQr();
                      _startScanning();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          const Color(0xFFFFCC00).withValues(alpha: 0.5),
                      foregroundColor: Colors.black,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28),
                      ),
                    ),
                    child: Text(
                      'Scan QR Code',
                      style: GoogleFonts.inter(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}

class _CornerFramePainter extends CustomPainter {
  final double cornerLength;
  final double cornerWidth;
  final Color color;

  _CornerFramePainter({
    required this.cornerLength,
    required this.cornerWidth,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = cornerWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.square;

    // Top-left corner
    canvas.drawLine(
      const Offset(0, 0),
      Offset(cornerLength, 0),
      paint,
    );
    canvas.drawLine(
      const Offset(0, 0),
      Offset(0, cornerLength),
      paint,
    );

    // Top-right corner
    canvas.drawLine(
      Offset(size.width, 0),
      Offset(size.width - cornerLength, 0),
      paint,
    );
    canvas.drawLine(
      Offset(size.width, 0),
      Offset(size.width, cornerLength),
      paint,
    );

    // Bottom-left corner
    canvas.drawLine(
      Offset(0, size.height),
      Offset(cornerLength, size.height),
      paint,
    );
    canvas.drawLine(
      Offset(0, size.height),
      Offset(0, size.height - cornerLength),
      paint,
    );

    // Bottom-right corner
    canvas.drawLine(
      Offset(size.width, size.height),
      Offset(size.width - cornerLength, size.height),
      paint,
    );
    canvas.drawLine(
      Offset(size.width, size.height),
      Offset(size.width, size.height - cornerLength),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
