import 'package:flutter/material.dart';
import '../widgets/custom_app_bar.dart';

class PromotionsScreen extends StatelessWidget {
  const PromotionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final images = [
      'assets/promotions/Cont-1.png',
      'assets/promotions/Cont-2.png',
      'assets/promotions/Cont-3.png',
      'assets/promotions/Cont-4.png',
      'assets/promotions/Cont.png',
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: customAppBar(context, title: 'Promotions'),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: images.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Image.asset(
              images[index],
              width: double.infinity,
              fit: BoxFit.fitWidth,
            ),
          );
        },
      ),
    );
  }
}
