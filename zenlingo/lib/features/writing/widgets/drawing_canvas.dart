import 'package:flutter/material.dart';
import '../../../core/theme/zen_theme.dart';

class DrawingCanvas extends StatelessWidget {
  final List<List<Offset>> completedStrokes;
  final List<Offset> currentStroke;
  final Size canvasSize;
  final void Function(Offset point) onPanUpdate;
  final void Function(List<Offset> stroke) onStrokeEnd;
  final Color? flashColor; // null = no flash; Color = flash border overlay

  const DrawingCanvas({
    super.key,
    required this.completedStrokes,
    required this.currentStroke,
    required this.canvasSize,
    required this.onPanUpdate,
    required this.onStrokeEnd,
    this.flashColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (d) => onPanUpdate(d.localPosition),
      onPanEnd: (_) => onStrokeEnd(List.unmodifiable(currentStroke)),
      child: Container(
        width: canvasSize.width,
        height: canvasSize.height,
        decoration: BoxDecoration(
          color: ZenTheme.bgSurface,
          borderRadius: BorderRadius.circular(12),
          border: flashColor != null
              ? Border.all(color: flashColor!, width: 3)
              : Border.all(color: const Color(0xFF2A2A2A)),
        ),
        child: CustomPaint(
          painter: _StrokePainter(
            completedStrokes: completedStrokes,
            currentStroke: currentStroke,
          ),
        ),
      ),
    );
  }
}

class _StrokePainter extends CustomPainter {
  final List<List<Offset>> completedStrokes;
  final List<Offset> currentStroke;

  const _StrokePainter({
    required this.completedStrokes,
    required this.currentStroke,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final donePaint = Paint()
      ..color = ZenTheme.textSecondary
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..style = PaintingStyle.stroke;

    final activePaint = Paint()
      ..color = ZenTheme.textPrimary
      ..strokeWidth = 5
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..style = PaintingStyle.stroke;

    for (final stroke in completedStrokes) {
      _drawStroke(canvas, stroke, donePaint);
    }
    _drawStroke(canvas, currentStroke, activePaint);
  }

  void _drawStroke(Canvas canvas, List<Offset> points, Paint paint) {
    if (points.length < 2) return;
    final path = Path()..moveTo(points.first.dx, points.first.dy);
    for (int i = 1; i < points.length; i++) {
      path.lineTo(points[i].dx, points[i].dy);
    }
    canvas.drawPath(path, paint);
  }

  // Uses reference equality — parent must provide new list instances on each change.
  @override
  bool shouldRepaint(_StrokePainter old) =>
      old.completedStrokes != completedStrokes ||
      old.currentStroke != currentStroke;
}
