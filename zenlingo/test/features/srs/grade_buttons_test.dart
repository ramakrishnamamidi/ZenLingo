import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zenlingo/core/srs/srs_algorithm.dart';
import 'package:zenlingo/features/srs/widgets/grade_buttons.dart';

Widget _wrap(Widget child) => MaterialApp(home: Scaffold(body: child));

void main() {
  testWidgets('shows four grade labels', (tester) async {
    await tester.pumpWidget(
      _wrap(GradeButtons(onGrade: (_) {})),
    );
    expect(find.text('Again'), findsOneWidget);
    expect(find.text('Hard'), findsOneWidget);
    expect(find.text('Good'), findsOneWidget);
    expect(find.text('Easy'), findsOneWidget);
  });

  testWidgets('tapping Again calls onGrade with SrsGrade.again', (tester) async {
    SrsGrade? received;
    await tester.pumpWidget(
      _wrap(GradeButtons(onGrade: (g) => received = g)),
    );
    await tester.tap(find.text('Again'));
    expect(received, SrsGrade.again);
  });

  testWidgets('tapping Easy calls onGrade with SrsGrade.easy', (tester) async {
    SrsGrade? received;
    await tester.pumpWidget(
      _wrap(GradeButtons(onGrade: (g) => received = g)),
    );
    await tester.tap(find.text('Easy'));
    expect(received, SrsGrade.easy);
  });
}
