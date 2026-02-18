import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingScreen extends StatefulWidget {
  final VoidCallback onComplete;

  const OnboardingScreen({super.key, required this.onComplete});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardingSlide> _slides = [
    OnboardingSlide(
      image: 'assets/onboarding/img1.png',
      title: 'Esports starts\nhere',
      subtitle: 'Top-of-the-line PCs and total\nimmersion in the game.',
    ),
    OnboardingSlide(
      image: 'assets/onboarding/img2.png',
      title: 'Play to the max',
      subtitle: 'Team matches, training sessions, and a lively atmosphere.',
    ),
    OnboardingSlide(
      image: 'assets/onboarding/img3.png',
      title: 'Level up.',
      subtitle: 'Tournaments, bonuses, and PRO mode.',
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() async {
    if (_currentPage < _slides.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('onboarding_complete', true);
      widget.onComplete();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Background image at the bottom
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Image.asset(
              'assets/onboarding/bg.png',
              fit: BoxFit.fitWidth,
            ),
          ),
          // Main content
          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 20),
                // Logo
                Image.asset(
                  'assets/general/logo.png',
                  height: 60,
                ),
                // PageView with slides
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: _slides.length,
                    onPageChanged: (index) {
                      setState(() {
                        _currentPage = index;
                      });
                    },
                    itemBuilder: (context, index) {
                      return _buildSlide(_slides[index]);
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSlide(OnboardingSlide slide) {
    return Column(
      children: [
        const Spacer(flex: 1),
        // Slide image
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Image.asset(
            slide.image,
            height: MediaQuery.of(context).size.height * 0.35,
            fit: BoxFit.contain,
          ),
        ),
        const Spacer(flex: 1),
        // Page indicators
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            _slides.length,
            (index) => _buildDot(index),
          ),
        ),
        const SizedBox(height: 30),
        // Title
        Text(
          slide.title,
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(
            fontSize: 36,
            fontWeight: FontWeight.w900,
            fontStyle: FontStyle.italic,
            color: const Color(0xFF1A1A1A),
            height: 1.1,
          ),
        ),
        const SizedBox(height: 16),
        // Subtitle
        Text(
          slide.subtitle,
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF1A1A1A),
            height: 1.4,
          ),
        ),
        const SizedBox(height: 30),
        // Next button
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              onPressed: _nextPage,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: const Color(0xFFFFCC00),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28),
                ),
              ),
              child: Text(
                _currentPage < _slides.length - 1 ? 'Next' : 'Get Started',
                style: GoogleFonts.inter(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 40),
      ],
    );
  }

  Widget _buildDot(int index) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: _currentPage == index ? 24 : 8,
      height: 8,
      decoration: BoxDecoration(
        color: _currentPage == index
            ? Colors.white
            : Colors.white.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}

class OnboardingSlide {
  final String image;
  final String title;
  final String subtitle;

  OnboardingSlide({
    required this.image,
    required this.title,
    required this.subtitle,
  });
}
