import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/custom_app_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'privacy_policy_screen.dart';
import 'rules_of_use_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _nickname = '';
  int _avatarIndex = 0;
  String? _playerId;

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final nickname = prefs.getString('user_nickname') ?? 'Nickname';
    final avatar = prefs.getInt('user_avatar') ?? 0;

    String? playerId = prefs.getString('player_id');
    if (playerId == null) {
      playerId =
          'PLAYER-${Random().nextInt(900000) + 100000}-${Random().nextInt(9000) + 1000}';
      await prefs.setString('player_id', playerId);
    }

    setState(() {
      _nickname = nickname;
      _avatarIndex = avatar;
      _playerId = playerId;
    });
  }

  void _showQrCode() {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Loyalty Card',
                style: GoogleFonts.inter(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF1A1A1A),
                ),
              ),
              const SizedBox(height: 20),
              if (_playerId != null)
                QrImageView(
                  data: _playerId!,
                  version: QrVersions.auto,
                  size: 220,
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
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFFCC00),
                    foregroundColor: Colors.black,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                  child: Text(
                    'Ok',
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: customAppBar(context, title: 'Profile'),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    const SizedBox(height: 24),
                    // Avatar
                    Container(
                      width: 160,
                      height: 160,
                      padding: const EdgeInsets.all(8),
                      child: Image.asset(
                        'assets/nickname/avatar_active${_avatarIndex + 1}.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(height: 12),
                    // Nickname
                    Text(
                      _nickname,
                      style: GoogleFonts.inter(
                        fontSize: 26,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w900,
                        color: const Color(0xFF1A1A1A),
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Hours in the club card
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.asset(
                        'assets/profile/hours-in-club.png',
                        fit: BoxFit.contain,
                        width: double.infinity,
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Loyalty card
                    GestureDetector(
                      onTap: _showQrCode,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.asset(
                          'assets/profile/loyalty-card.png',
                          fit: BoxFit.contain,
                          width: double.infinity,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Bottom buttons
          Padding(
            padding: const EdgeInsets.only(bottom: 40, top: 16),
            child: Column(
              children: [
                // Privacy Policy button
                SizedBox(
                  width: 240,
                  height: 48,
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const PrivacyPolicyScreen(),
                        ),
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: const Color(0xFF1A1A1A),
                      side: const BorderSide(
                        color: Color(0xFFE0E0E0),
                        width: 1,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      'Privacy Policy',
                      style: GoogleFonts.inter(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        fontStyle: FontStyle.italic,
                        color: const Color(0xFF1A1A1A),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                // Rules of use button
                SizedBox(
                  width: 240,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const RulesOfUseScreen(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFFCC00),
                      foregroundColor: Colors.black,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                        side: const BorderSide(
                          color: Color(0xFFE6B800),
                          width: 1,
                        ),
                      ),
                    ),
                    child: Text(
                      'Rules of use',
                      style: GoogleFonts.inter(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        fontStyle: FontStyle.italic,
                        color: const Color.fromARGB(255, 255, 255, 255),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
