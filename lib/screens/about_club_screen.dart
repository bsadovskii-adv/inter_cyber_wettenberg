import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/custom_app_bar.dart';

class AboutClubScreen extends StatelessWidget {
  const AboutClubScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: customAppBar(context, title: 'About the club'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 32),
              Text(
                'InterCyber\nWettenberg',
                style: GoogleFonts.inter(
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                  fontStyle: FontStyle.italic,
                  color: const Color(0xFF1A1A1A),
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'is a cutting-edge gaming club where virtual worlds, esports competition, and team play collide. A stylish hub for gamers of all levels — from casual players to pros — featuring tournaments, immersive experiences, and an energetic atmosphere charged with digital adrenaline.',
                style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF1A1A1A),
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 40),
              // Opening Hours
              Text(
                'Opening hours:',
                style: GoogleFonts.inter(
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                  fontStyle: FontStyle.italic,
                  color: const Color(0xFF1A1A1A),
                ),
              ),
              const SizedBox(height: 12),
              _buildScheduleRow('Mon – Fri', '14:00 – 00:00'),
              const SizedBox(height: 6),
              _buildScheduleRow('Saturday', '12:00 – 02:00'),
              const SizedBox(height: 6),
              _buildScheduleRow('Sunday', '12:00 – 22:00'),
              const SizedBox(height: 40),
              // What we offer
              Text(
                'What we offer:',
                style: GoogleFonts.inter(
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                  fontStyle: FontStyle.italic,
                  color: const Color(0xFF1A1A1A),
                ),
              ),
              const SizedBox(height: 12),
              _buildBullet('High-end gaming PCs & consoles'),
              const SizedBox(height: 6),
              _buildBullet('Fast internet & low latency'),
              const SizedBox(height: 6),
              _buildBullet('Regular esports tournaments'),
              const SizedBox(height: 6),
              _buildBullet('Snacks, drinks & energy bar'),
              const SizedBox(height: 6),
              _buildBullet('Cozy lounge & streaming area'),
              const SizedBox(height: 6),
              _buildBullet('Private rooms for team practice'),
              const SizedBox(height: 40),
              // Address
              Text(
                'Adress:',
                style: GoogleFonts.inter(
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                  fontStyle: FontStyle.italic,
                  color: const Color(0xFF1A1A1A),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Hubertusallee 8',
                style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF1A1A1A),
                ),
              ),
              const SizedBox(height: 24),
              ClipRRect(
                borderRadius: BorderRadius.circular(0),
                child: Image.asset(
                  'assets/about/map.png',
                  width: double.infinity,
                  fit: BoxFit.fitWidth,
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildScheduleRow(String day, String hours) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          day,
          style: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF1A1A1A),
          ),
        ),
        Text(
          hours,
          style: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: const Color(0xFF1A1A1A),
          ),
        ),
      ],
    );
  }

  Widget _buildBullet(String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '•  ',
          style: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: const Color(0xFFFFCC00),
          ),
        ),
        Expanded(
          child: Text(
            text,
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF1A1A1A),
            ),
          ),
        ),
      ],
    );
  }
}
