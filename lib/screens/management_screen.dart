import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/custom_app_bar.dart';
import 'home_screen.dart';

class ManagementScreen extends StatelessWidget {
  const ManagementScreen({super.key});

  void _showPopup(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          title,
          style: GoogleFonts.inter(fontWeight: FontWeight.w700),
        ),
        content: Text(
          message,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: customAppBar(context, title: 'Management'),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Row 1: ADD 30 Min, ADD 1 Hour
            Row(
              children: [
                Expanded(
                  child: _buildManagementButton(
                    context,
                    'assets/management/add-30-min.png',
                    'Add 30 Minutes',
                    '30 minutes have been added to your session.',
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildManagementButton(
                    context,
                    'assets/management/add-1-hour.png',
                    'Add 1 Hour',
                    '1 hour has been added to your session.',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Row 2: STOP Time, END Session
            Row(
              children: [
                Expanded(
                  child: _buildManagementButton(
                    context,
                    'assets/management/stop-time.png',
                    'Stop Time',
                    'Your session time has been paused.',
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => const HomeScreen()),
                        (route) => false,
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.asset(
                          'assets/management/end-session.png',
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Row 3: CALL Administrator
            Row(
              children: [
                Expanded(
                  child: _buildManagementButton(
                    context,
                    'assets/management/call-admin.png',
                    'Call Administrator',
                    'An administrator has been notified and will be with you shortly.',
                  ),
                ),
                const Spacer(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildManagementButton(
    BuildContext context,
    String assetPath,
    String title,
    String message,
  ) {
    return GestureDetector(
      onTap: () => _showPopup(context, title, message),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Image.asset(
            assetPath,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
