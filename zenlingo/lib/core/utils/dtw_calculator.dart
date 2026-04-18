import 'dart:math';
import 'package:flutter/painting.dart';

class DtwCalculator {
  /// Resamples [points] to exactly [count] evenly-spaced points along the path.
  static List<Offset> resample(List<Offset> points, {int count = 32}) {
    if (points.length < 2) {
      return List.filled(count, points.isEmpty ? Offset.zero : points.first);
    }
    final lengths = <double>[0.0];
    for (int i = 1; i < points.length; i++) {
      lengths.add(lengths.last + (points[i] - points[i - 1]).distance);
    }
    final totalLength = lengths.last;
    if (totalLength == 0) return List.filled(count, points.first);

    final result = <Offset>[points.first];
    int j = 1;
    for (int i = 1; i < count - 1; i++) {
      final target = i * totalLength / (count - 1);
      while (j < lengths.length - 1 && lengths[j] < target) {
        j++;
      }
      final span = lengths[j] - lengths[j - 1];
      final t = span == 0 ? 0.0 : (target - lengths[j - 1]) / span;
      result.add(Offset.lerp(points[j - 1], points[j], t)!);
    }
    result.add(points.last);
    return result;
  }

  /// Normalises [points] to [0,1] range given [canvasSize].
  static List<Offset> normalize(List<Offset> points, {required Size canvasSize}) {
    return points
        .map((p) => Offset(p.dx / canvasSize.width, p.dy / canvasSize.height))
        .toList();
  }

  /// Dynamic Time Warping distance between two sequences, divided by
  /// max(n, m) so longer strokes don't dominate. Lower = more similar.
  static double compute(List<Offset> seq1, List<Offset> seq2) {
    final n = seq1.length;
    final m = seq2.length;
    if (n == 0 || m == 0) return double.infinity;

    final dp = List.generate(n + 1, (_) => List.filled(m + 1, double.infinity));
    dp[0][0] = 0.0;

    for (int i = 1; i <= n; i++) {
      for (int j = 1; j <= m; j++) {
        final cost = (seq1[i - 1] - seq2[j - 1]).distance;
        dp[i][j] = cost + [dp[i - 1][j], dp[i][j - 1], dp[i - 1][j - 1]].reduce(min);
      }
    }
    return dp[n][m] / max(n, m);
  }
}
