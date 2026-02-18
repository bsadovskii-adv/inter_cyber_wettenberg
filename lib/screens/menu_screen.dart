import 'package:flutter/material.dart';
import '../widgets/custom_app_bar.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  int _selectedTab = 0;

  static const _navigationImages = [
    'assets/menu/navigation-drinks.png',
    'assets/menu/navigation-food.png',
    'assets/menu/navigation-sweets.png',
  ];

  static const _tabItems = [
    ['assets/menu/drink1.png', 'assets/menu/drink2.png', 'assets/menu/drink3.png'],
    ['assets/menu/food1.png', 'assets/menu/food2.png', 'assets/menu/food3.png'],
    ['assets/menu/sweets1.png', 'assets/menu/sweets2.png', 'assets/menu/sweets3.png'],
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: customAppBar(context, title: 'Menu'),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Tab navigation image
            GestureDetector(
              onTapUp: (details) {
                final width = context.size?.width ?? 0;
                final tapX = details.localPosition.dx;
                final third = (width - 32) / 3; // account for padding
                int newTab;
                if (tapX < third) {
                  newTab = 0;
                } else if (tapX < third * 2) {
                  newTab = 1;
                } else {
                  newTab = 2;
                }
                if (newTab != _selectedTab) {
                  setState(() => _selectedTab = newTab);
                }
              },
              child: Image.asset(
                _navigationImages[_selectedTab],
                width: double.infinity,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 16),
            // Menu items grid
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.75,
                ),
                itemCount: _tabItems[_selectedTab].length,
                itemBuilder: (context, index) {
                  return Image.asset(
                    _tabItems[_selectedTab][index],
                    fit: BoxFit.contain,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
