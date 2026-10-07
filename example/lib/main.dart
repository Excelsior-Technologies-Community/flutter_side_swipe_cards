import 'package:flutter/material.dart';
import 'package:flutter_side_swipe_cards/flutter_side_swipe_cards.dart';

void main() {
  runApp(const SideSwipeCardsExampleApp());
}

class SideSwipeCardsExampleApp extends StatelessWidget {
  const SideSwipeCardsExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Side Swipe Cards',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2563EB),
        ),
        scaffoldBackgroundColor: const Color(0xFFF5F7FB),
      ),
      home: const SideSwipeCardsDemoPage(),
    );
  }
}

class SideSwipeCardsDemoPage extends StatefulWidget {
  const SideSwipeCardsDemoPage({super.key});

  @override
  State<SideSwipeCardsDemoPage> createState() =>
      _SideSwipeCardsDemoPageState();
}

class _SideSwipeCardsDemoPageState
    extends State<SideSwipeCardsDemoPage> {
  late final List<SideSwipeCardItem> cards;

  String _lastAction = 'Swipe a card left or right';

  @override
  void initState() {
    super.initState();

    cards = [
      SideSwipeCardItem(
        id: '1',
        child: _buildCard(
          title: 'Mountain Adventure',
          subtitle: 'Explore beautiful mountain views.',
          icon: Icons.landscape_rounded,
        ),
      ),
      SideSwipeCardItem(
        id: '2',
        child: _buildCard(
          title: 'Ocean Escape',
          subtitle: 'Relax with peaceful ocean waves.',
          icon: Icons.waves_rounded,
        ),
      ),
      SideSwipeCardItem(
        id: '3',
        child: _buildCard(
          title: 'City Lights',
          subtitle: 'Discover the beauty of the city.',
          icon: Icons.location_city_rounded,
        ),
      ),
      SideSwipeCardItem(
        id: '4',
        child: _buildCard(
          title: 'Forest Journey',
          subtitle: 'Enjoy a calm walk through nature.',
          icon: Icons.forest_rounded,
        ),
      ),
    ];
  }

  Widget _buildCard({
    required String title,
    required String subtitle,
    required IconData icon,
  }) {
    return Container(
      width: double.infinity,
      height: 430,
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: const [
          BoxShadow(
            blurRadius: 20,
            offset: Offset(0, 10),
            color: Color(0x14000000),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: const Color(0xFFE8F0FF),
              borderRadius: BorderRadius.circular(60),
            ),
            child: Icon(
              icon,
              size: 60,
              color: const Color(0xFF2563EB),
            ),
          ),
          const SizedBox(height: 28),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 15,
              height: 1.5,
              color: Colors.black54,
            ),
          ),
          const SizedBox(height: 28),
          const Text(
            'Swipe left or right',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0xFF2563EB),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Side Swipe Cards',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              'Smooth left / right swipe animation',
              style: TextStyle(
                fontSize: 12,
                color: Colors.black54,
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(height: 20),
              const Text(
                'Swipe through the cards',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                _lastAction,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 30),
              Expanded(
                child: SideSwipeCards(
                  cards: cards,
                  config: const SideSwipeCardConfig(
                    visibleCards: 3,
                    swipeThreshold: 120,
                    maxRotation: 0.08,
                    stackOffset: 14,
                    stackScale: 0.04,
                  ),
                  onSwipeLeft: (card) {
                    setState(() {
                      _lastAction =
                      'Swiped left: ${card.id ?? 'card'}';
                    });
                  },
                  onSwipeRight: (card) {
                    setState(() {
                      _lastAction =
                      'Swiped right: ${card.id ?? 'card'}';
                    });
                  },
                  onCardTap: (card) {
                    setState(() {
                      _lastAction =
                      'Tapped: ${card.id ?? 'card'}';
                    });
                  },
                  onEmpty: () {
                    setState(() {
                      _lastAction = 'No more cards';
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}