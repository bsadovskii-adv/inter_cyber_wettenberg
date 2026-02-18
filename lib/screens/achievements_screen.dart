import 'package:flutter/material.dart';
import '../widgets/custom_app_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AchievementsScreen extends StatefulWidget {
  const AchievementsScreen({super.key});

  @override
  State<AchievementsScreen> createState() => _AchievementsScreenState();
}

class _AchievementsScreenState extends State<AchievementsScreen> {
  bool _firstVisitUnlocked = false;

  @override
  void initState() {
    super.initState();
    _loadAchievements();
  }

  Future<void> _loadAchievements() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _firstVisitUnlocked = prefs.getBool('achievement_first_visit') ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Achievement images in order, with index 5 being the "first visit" achievement
    final achievements = [
      'assets/achievements/Cont.png',
      'assets/achievements/Cont-1.png',
      'assets/achievements/Cont-2.png',
      'assets/achievements/Cont-3.png',
      'assets/achievements/Cont-4.png',
      _firstVisitUnlocked
          ? 'assets/achievements/fitst-time-actiive.png'
          : 'assets/achievements/first-time-inactive.png',
      'assets/achievements/Cont-6.png',
      'assets/achievements/Cont-7.png',
      'assets/achievements/Cont-8.png',
      'assets/achievements/Cont-9.png',
      'assets/achievements/Cont-10.png',
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: customAppBar(context, title: 'Achievements'),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        itemCount: achievements.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                achievements[index],
                width: double.infinity,
                fit: BoxFit.fitWidth,
              ),
            ),
          );
        },
      ),
    );
  }
}
