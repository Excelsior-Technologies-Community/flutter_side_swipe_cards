import 'package:flutter/material.dart';
import 'package:flutter_side_swipe_cards/flutter_side_swipe_cards.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets(
    'Side swipe cards renders correctly',
        (WidgetTester tester) async {
      final cards = [
        const SideSwipeCardItem(
          id: '1',
          child: Text('Card 1'),
        ),
        const SideSwipeCardItem(
          id: '2',
          child: Text('Card 2'),
        ),
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SizedBox(
              height: 400,
              child: SideSwipeCards(
                cards: cards,
              ),
            ),
          ),
        ),
      );

      expect(find.byType(SideSwipeCards), findsOneWidget);
      expect(find.text('Card 1'), findsOneWidget);
    },
  );
}