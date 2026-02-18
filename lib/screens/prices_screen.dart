import 'package:flutter/material.dart';
import '../widgets/custom_app_bar.dart';

class PricesScreen extends StatelessWidget {
  const PricesScreen({super.key});

  static const _images = [
    'assets/prices/1hour.png',
    'assets/prices/3hours.png',
    'assets/prices/5hours.png',
    'assets/prices/all-day.png',
    'assets/prices/all-night.png',
    'assets/prices/one-hour-ps.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: customAppBar(context, title: 'Prices'),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemCount: _images.length,
          itemBuilder: (context, index) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                _images[index],
                fit: BoxFit.cover,
              ),
            );
          },
        ),
      ),
    );
  }
}
