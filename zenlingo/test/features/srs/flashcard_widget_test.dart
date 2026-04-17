import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zenlingo/data/database/app_database.dart';
import 'package:zenlingo/features/srs/widgets/flashcard_widget.dart';

VocabularyCard _makeCard() => VocabularyCard(
      id: 1,
      word: '水',
      reading: 'みず',
      meaning: 'water',
      exampleSentence: '水を飲みます。',
      jlptLevel: 5,
      languageCode: 'ja',
      stability: 1.0,
      difficulty: 5.0,
      retrievability: 0.9,
      reps: 0,
      easinessFactor: 2.5,
      interval: 1,
      nextReviewDate: DateTime.now(),
      lastReviewDate: null,
      tags: '[]',
    );

Widget _wrap(Widget child) => MaterialApp(home: Scaffold(body: child));

void main() {
  testWidgets('front face shows word and reading', (tester) async {
    await tester.pumpWidget(_wrap(
      FlashcardWidget(
        card: _makeCard(),
        isFlipped: false,
        onTap: () {},
      ),
    ));
    expect(find.text('水'), findsOneWidget);
    expect(find.text('みず'), findsOneWidget);
    expect(find.text('water'), findsNothing);
  });

  testWidgets('back face shows meaning and example', (tester) async {
    await tester.pumpWidget(_wrap(
      FlashcardWidget(
        card: _makeCard(),
        isFlipped: true,
        onTap: () {},
      ),
    ));
    // Pump past animation
    await tester.pump(const Duration(milliseconds: 350));
    expect(find.text('water'), findsOneWidget);
    expect(find.text('水を飲みます。'), findsOneWidget);
  });

  testWidgets('tapping calls onTap', (tester) async {
    var tapped = false;
    await tester.pumpWidget(_wrap(
      FlashcardWidget(
        card: _makeCard(),
        isFlipped: false,
        onTap: () => tapped = true,
      ),
    ));
    await tester.tap(find.byType(FlashcardWidget));
    expect(tapped, isTrue);
  });
}
