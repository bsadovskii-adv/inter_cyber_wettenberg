import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/custom_app_bar.dart';

class RulesOfUseScreen extends StatelessWidget {
  const RulesOfUseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: customAppBar(context, title: 'Rules of use'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Rules of Use',
                style: GoogleFonts.inter(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF1A1A1A),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'InterCyber Wettenberg Club Rules',
                style: GoogleFonts.inter(
                  fontSize: 13,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 20),
              _buildSection(
                '1. General Rules',
                '\u2022 All visitors must register in the app and present their QR code upon entry.\n'
                    '\u2022 Visitors must treat all equipment with care and respect.\n'
                    '\u2022 Any intentional damage to club property will result in financial liability.\n'
                    '\u2022 The club administration reserves the right to refuse service to anyone violating these rules.',
              ),
              _buildSection(
                '2. Session Rules',
                '\u2022 Sessions begin at the time of check-in via QR code scan.\n'
                    '\u2022 Time packages (1 hour, 3 hours, 5 hours, all day, all night) must be selected before starting a session.\n'
                    '\u2022 Session time can be paused by contacting an administrator.\n'
                    '\u2022 Additional time can be added during an active session (30 min or 1 hour increments).\n'
                    '\u2022 Unused session time is non-refundable and non-transferable.',
              ),
              _buildSection(
                '3. Reservations',
                '\u2022 Reservations can be made through the app for available time slots.\n'
                    '\u2022 Please arrive within 15 minutes of your reserved time. Late arrivals may forfeit their reservation.\n'
                    '\u2022 Cancellations must be made at least 2 hours before the reserved time.\n'
                    '\u2022 Repeated no-shows may result in suspension of reservation privileges.',
              ),
              _buildSection(
                '4. Loyalty Program',
                '\u2022 All registered users automatically participate in the loyalty program.\n'
                    '\u2022 Cashback is earned based on hours spent in the club.\n'
                    '\u2022 Current cashback rate: 5% on all session purchases.\n'
                    '\u2022 Accumulated cashback can be used for future sessions and menu purchases.\n'
                    '\u2022 Loyalty rewards are non-transferable between accounts.',
              ),
              _buildSection(
                '5. Behavior',
                '\u2022 Maintain a respectful and friendly atmosphere at all times.\n'
                    '\u2022 Excessive noise, offensive language, and aggressive behavior are prohibited.\n'
                    '\u2022 Food and beverages purchased outside the club are not allowed.\n'
                    '\u2022 Smoking and alcohol consumption are strictly prohibited on the premises.\n'
                    '\u2022 Visitors under 16 must be accompanied by a parent or guardian.',
              ),
              _buildSection(
                '6. Equipment',
                '\u2022 Use equipment only for its intended purpose.\n'
                    '\u2022 Do not install or uninstall any software on club computers.\n'
                    '\u2022 Do not alter hardware settings or disconnect peripherals.\n'
                    '\u2022 Report any equipment malfunction to an administrator immediately.\n'
                    '\u2022 Personal peripherals (mouse, keyboard, headset) may be used with staff approval.',
              ),
              _buildSection(
                '7. Liability',
                '\u2022 InterCyber Wettenberg is not responsible for personal belongings left at the club.\n'
                    '\u2022 The club is not liable for any data loss on personal devices connected to the club network.\n'
                    '\u2022 Visitors use the club facilities at their own risk.',
              ),
              _buildSection(
                '8. Contact',
                'For questions, complaints, or suggestions, please reach out to our administration team at the front desk or use the "Call Admin" feature in the app during your session.',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection(String title, String content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF1A1A1A),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            content,
            style: GoogleFonts.inter(
              fontSize: 14,
              height: 1.6,
              color: const Color(0xFF424242),
            ),
          ),
        ],
      ),
    );
  }
}
