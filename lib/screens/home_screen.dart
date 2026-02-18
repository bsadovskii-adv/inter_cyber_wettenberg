import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'promotions_screen.dart';
import 'prices_screen.dart';
import 'qr_code_screen.dart';
import 'reservation_screen.dart';
import 'profile_screen.dart';
import 'events_screen.dart';
import 'about_club_screen.dart';
import 'achievements_screen.dart';
import 'menu_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 250, 250, 250),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const SizedBox(height: 42),
              // Logo
              Image.asset(
                'assets/general/logo.png',
                height: 200,
              ),
              const SizedBox(height: 16),
              // INTERCYBER text
              Text(
                'INTERCYBER',
                style: GoogleFonts.inter(
                  fontSize: 32,
                  fontWeight: FontWeight.w900,
                  fontStyle: FontStyle.normal,
                  color: const Color(0xFFFFCC00),
                  letterSpacing: 1,
                ),
              ),
              // WETTENBERG text
              Text(
                'WETTENBERG',
                style: GoogleFonts.inter(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: const Color(0xFF1A1A1A),
                  letterSpacing: 2,
                ),
              ),
              const Spacer(),
              // Menu grid
              GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 2.6,
                  children: [
                    _buildMenuButton(context, 'Promotions', () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const PromotionsScreen(),
                        ),
                      );
                    }),
                    _buildMenuButton(context, 'Prices', () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const PricesScreen(),
                        ),
                      );
                    }),
                    _buildMenuButton(context, 'Menu', () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const MenuScreen(),
                        ),
                      );
                    }),
                    _buildMenuButton(context, 'QR code', () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const QrCodeScreen(),
                        ),
                      );
                    }),
                    _buildMenuButton(context, 'Reservations', () async {
                      final result = await Navigator.of(context).push<bool>(
                        MaterialPageRoute(
                          builder: (context) => const ReservationScreen(),
                        ),
                      );
                      if (result == true && context.mounted) {
                        showDialog(
                          context: context,
                          builder: (dialogContext) => AlertDialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            title: Text(
                              'Reservation confirmed!',
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF1A1A1A),
                              ),
                            ),
                            content: Text(
                              'Your place has been successfully reserved.',
                              style: GoogleFonts.inter(
                                fontSize: 16,
                                color: const Color(0xFF1A1A1A),
                              ),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.of(dialogContext).pop(),
                                child: Text(
                                  'OK',
                                  style: GoogleFonts.inter(
                                    fontWeight: FontWeight.w700,
                                    color: const Color(0xFFFFCC00),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                    }),
                    _buildMenuButton(context, 'Profile', () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const ProfileScreen(),
                        ),
                      );
                    }),
                    _buildMenuButton(context, 'Events', () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const EventsScreen(),
                        ),
                      );
                    }),
                    _buildMenuButton(context, 'About the club', () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const AboutClubScreen(),
                        ),
                      );
                    }),
                    _buildMenuButton(context, 'Achievements', () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const AchievementsScreen(),
                        ),
                      );
                    }),
                  ],
                ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuButton(BuildContext context, String title, VoidCallback onTap) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.12),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: Colors.black,
                width: 1.5,
              ),
            ),
          child: Center(
            child: Text(
              title,
              style: GoogleFonts.inter(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF1A1A1A),
              ),
            ),
          ),
        ),
      ),
      ),
    );
  }
}
