import 'package:flutter/painting.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zenlingo/core/utils/dtw_calculator.dart';

void main() {
  group('DtwCalculator.resample', () {
    test('returns exactly count points', () {
      final pts = [const Offset(0, 0), const Offset(1, 0), const Offset(2, 0)];
      final result = DtwCalculator.resample(pts, count: 5);
      expect(result.length, 5);
    });

    test('resampled endpoints match original', () {
      final pts = [const Offset(0, 0), const Offset(100, 0)];
      final result = DtwCalculator.resample(pts, count: 5);
      expect(result.first.dx, closeTo(0.0, 0.001));
      expect(result.last.dx, closeTo(100.0, 0.001));
    });
  });

  group('DtwCalculator.normalize', () {
    test('divides by canvas size', () {
      final pts = [const Offset(140, 70)];
      final result = DtwCalculator.normalize(pts, canvasSize: const Size(280, 280));
      expect(result.first.dx, closeTo(0.5, 0.001));
      expect(result.first.dy, closeTo(0.25, 0.001));
    });
  });

  group('DtwCalculator.compute', () {
    test('identical paths return 0.0', () {
      final path = [const Offset(0.0, 0.0), const Offset(0.5, 0.5), const Offset(1.0, 1.0)];
      expect(DtwCalculator.compute(path, path), closeTo(0.0, 0.001));
    });

    test('completely different paths return positive distance', () {
      final pathA = [const Offset(0, 0), const Offset(1, 0)];
      final pathB = [const Offset(0, 1), const Offset(1, 1)];
      expect(DtwCalculator.compute(pathA, pathB), greaterThan(0.3));
    });

    test('close paths return smaller distance than distant paths', () {
      final ref =   [const Offset(0.0, 0.0), const Offset(0.5, 0.0), const Offset(1.0, 0.0)];
      final close = [const Offset(0.0, 0.05), const Offset(0.5, 0.05), const Offset(1.0, 0.05)];
      final far =   [const Offset(0.0, 0.8), const Offset(0.5, 0.8), const Offset(1.0, 0.8)];
      expect(DtwCalculator.compute(ref, close), lessThan(DtwCalculator.compute(ref, far)));
    });
  });
}
