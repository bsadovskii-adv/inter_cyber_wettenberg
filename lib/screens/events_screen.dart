import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/custom_app_bar.dart';

class Event {
  final String name;
  final String date;
  final String imagePath;

  const Event({
    required this.name,
    required this.date,
    required this.imagePath,
  });
}

class EventsScreen extends StatelessWidget {
  const EventsScreen({super.key});

  static const List<Event> _events = [
    Event(
      name: 'Esports\nTournament',
      date: '26.02.2026',
      imagePath: 'assets/events/event.png',
    ),
    Event(
      name: 'Cyber\nCup',
      date: '02.03.2026',
      imagePath: 'assets/events/event.png',
    ),
    Event(
      name: 'Gaming\nTournament',
      date: '12.03.2026',
      imagePath: 'assets/events/event.png',
    ),
    Event(
      name: 'Esports\nChampionship',
      date: '15.03.2026',
      imagePath: 'assets/events/event.png',
    ),
    Event(
      name: 'Cyber\nTournament',
      date: '25.03.2026',
      imagePath: 'assets/events/event.png',
    ),
    Event(
      name: 'Gaming\nOpen',
      date: '01.04.2026',
      imagePath: 'assets/events/event.png',
    ),
    Event(
      name: 'Esports\nCup',
      date: '05.04.2026',
      imagePath: 'assets/events/event.png',
    ),
    Event(
      name: 'Cyber\nLeague',
      date: '10.04.2026',
      imagePath: 'assets/events/event.png',
    ),
    Event(
      name: 'Gaming\nOpen',
      date: '22.04.2026',
      imagePath: 'assets/events/event.png',
    ),
    Event(
      name: 'Esports\nChampionship',
      date: '30.04.2026',
      imagePath: 'assets/events/event.png',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: customAppBar(context, title: 'Events'),
      body: ListView.separated(
        padding: const EdgeInsets.all(20),
        itemCount: _events.length,
        separatorBuilder: (_, __) => const SizedBox(height: 16),
        itemBuilder: (context, index) => _buildEventCard(_events[index]),
      ),
    );
  }

  Widget _buildEventCard(Event event) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Stack(
        children: [
          // Game image background
          Image.asset(
            event.imagePath,
            width: double.infinity,
            fit: BoxFit.fitWidth,
          ),
          // Text content
          Positioned(
            left: 16,
            top: 16,
            bottom: 16,
            right: 100,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  event.name,
                  style: GoogleFonts.inter(
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                    fontStyle: FontStyle.italic,
                    color: const Color(0xFF1A1A1A),
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  event.date,
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF1A1A1A),
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
