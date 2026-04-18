import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zenlingo/features/writing/widgets/drawing_canvas.dart';

Widget _wrap(Widget child) => MaterialApp(home: Scaffold(body: child));

void main() {
  testWidgets('renders without errors with empty strokes', (tester) async {
    await tester.pumpWidget(_wrap(
      DrawingCanvas(
        completedStrokes: const [],
        currentStroke: const [],
        canvasSize: const Size(280, 280),
        onPanUpdate: (_) {},
        onStrokeEnd: (_) {},
      ),
    ));
    expect(find.byType(DrawingCanvas), findsOneWidget);
  });

  testWidgets('calls onPanUpdate during pan gesture', (tester) async {
    final captured = <Offset>[];
    await tester.pumpWidget(_wrap(
      SizedBox(
        width: 280,
        height: 280,
        child: DrawingCanvas(
          completedStrokes: const [],
          currentStroke: const [],
          canvasSize: const Size(280, 280),
          onPanUpdate: captured.add,
          onStrokeEnd: (_) {},
        ),
      ),
    ));
    await tester.drag(find.byType(DrawingCanvas), const Offset(50, 50));
    expect(captured, isNotEmpty);
  });

  testWidgets('calls onStrokeEnd when pan gesture ends', (tester) async {
    List<Offset>? endedStroke;
    await tester.pumpWidget(_wrap(
      SizedBox(
        width: 280,
        height: 280,
        child: DrawingCanvas(
          completedStrokes: const [],
          currentStroke: const [Offset(10, 10), Offset(50, 50)],
          canvasSize: const Size(280, 280),
          onPanUpdate: (_) {},
          onStrokeEnd: (s) => endedStroke = s,
        ),
      ),
    ));
    // Simulate pan end
    final gesture = await tester.startGesture(const Offset(10, 10));
    await gesture.moveTo(const Offset(50, 50));
    await gesture.up();
    await tester.pump();
    expect(endedStroke, isNotNull);
  });
}
