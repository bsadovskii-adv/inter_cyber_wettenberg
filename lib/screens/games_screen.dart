import 'package:flutter/material.dart';
import '../widgets/custom_app_bar.dart';

class Game {
  final String name;
  final String imagePath;

  const Game({required this.name, required this.imagePath});
}

class GamesScreen extends StatelessWidget {
  const GamesScreen({super.key});

  static const List<Game> _games = [
    Game(name: 'CS:GO', imagePath: 'assets/game/CSGO.png'),
    Game(name: 'Overwatch', imagePath: 'assets/game/Overwatch.png'),
    Game(name: 'Dota 2', imagePath: 'assets/game/Dota.png'),
    Game(name: 'League of Legends', imagePath: 'assets/game/LoL.png'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: customAppBar(context, title: 'Games'),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: GridView.builder(
          itemCount: _games.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemBuilder: (context, index) => _buildGameCard(_games[index]),
        ),
      ),
    );
  }

  Widget _buildGameCard(Game game) {
    return Container(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Image.asset(
          game.imagePath,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
