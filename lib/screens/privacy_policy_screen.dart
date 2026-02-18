import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/custom_app_bar.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: customAppBar(context, title: 'Privacy Policy'),
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
                'Privacy Policy',
                style: GoogleFonts.inter(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF1A1A1A),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Last updated: January 2025',
                style: GoogleFonts.inter(
                  fontSize: 13,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 20),
              _buildSection(
                'Introduction',
                'Welcome to InterCyber Wettenberg. We are committed to protecting your personal information and your right to privacy. This Privacy Policy explains how we collect, use, disclose, and safeguard your information when you use our mobile application.',
              ),
              _buildSection(
                '1. Information We Collect',
                'We collect the following information when you use our app:\n\n'
                    '\u2022 Nickname: The display name you choose during registration.\n'
                    '\u2022 Avatar Selection: Your chosen avatar image.\n'
                    '\u2022 Player ID: A unique identifier generated for your account, used for QR code identification and loyalty tracking.\n'
                    '\u2022 Reservation Data: Information about your bookings including date, time, and selected location.\n'
                    '\u2022 Session Data: Duration of your visits for loyalty rewards calculation.',
              ),
              _buildSection(
                '2. How We Use Your Information',
                'We use the information we collect to:\n\n'
                    '\u2022 Provide and maintain our services.\n'
                    '\u2022 Identify you within our club via QR code.\n'
                    '\u2022 Track your loyalty rewards and cashback.\n'
                    '\u2022 Process and manage your reservations.\n'
                    '\u2022 Improve and personalize your experience.\n'
                    '\u2022 Communicate with you about promotions and events.',
              ),
              _buildSection(
                '3. Data Storage',
                'Your personal data is stored locally on your device using secure storage mechanisms. We do not transfer your personal information to external servers without your explicit consent. Reservation and session data may be stored on our secure servers to provide club services.',
              ),
              _buildSection(
                '4. Data Sharing',
                'We do not sell, trade, or rent your personal identification information to third parties. We may share generic aggregated demographic information not linked to any personal identification information with our business partners for the purposes outlined above.',
              ),
              _buildSection(
                '5. Security',
                'We adopt appropriate data collection, storage, and processing practices and security measures to protect against unauthorized access, alteration, disclosure, or destruction of your personal information stored in our app.',
              ),
              _buildSection(
                '6. Your Rights',
                'You have the right to:\n\n'
                    '\u2022 Access and review your personal data.\n'
                    '\u2022 Request correction of inaccurate data.\n'
                    '\u2022 Request deletion of your data by contacting our administration.\n'
                    '\u2022 Withdraw consent for data processing at any time.',
              ),
              _buildSection(
                '7. Contact Us',
                'If you have any questions about this Privacy Policy, please contact us at the front desk of InterCyber Wettenberg or reach out to our administration team.',
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
