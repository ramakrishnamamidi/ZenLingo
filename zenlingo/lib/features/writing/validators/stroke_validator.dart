import 'package:flutter/painting.dart';
import '../../../core/config/app_config.dart';
import '../../../core/utils/dtw_calculator.dart';

class SvgStrokeTemplate {
  final String char;
  final int order;
  final List<Offset> normalizedPoints; // pre-normalised to [0,1]

  const SvgStrokeTemplate({
    required this.char,
    required this.order,
    required this.normalizedPoints,
  });

  factory SvgStrokeTemplate.fromJson(String char, Map<String, dynamic> json) {
    final rawPoints = (json['points'] as List<dynamic>)
        .map((p) => Offset((p[0] as num).toDouble(), (p[1] as num).toDouble()))
        .toList();
    return SvgStrokeTemplate(
      char: char,
      order: json['order'] as int,
      normalizedPoints: rawPoints,
    );
  }
}

abstract class StrokeValidator {
  /// Returns score 0.0–1.0. 1.0 = perfect match.
  double validate(List<Offset> userStroke, SvgStrokeTemplate template, Size canvasSize);
  bool isCorrect(double score);
}

class DtwStrokeValidator implements StrokeValidator {
  const DtwStrokeValidator();

  @override
  double validate(List<Offset> userStroke, SvgStrokeTemplate template, Size canvasSize) {
    if (userStroke.length < 2) return 0.0;
    final normalised = DtwCalculator.normalize(userStroke, canvasSize: canvasSize);
    final resampled = DtwCalculator.resample(normalised);
    final templateResampled = DtwCalculator.resample(template.normalizedPoints);
    final dtwDist = DtwCalculator.compute(resampled, templateResampled);
    return (1.0 - dtwDist).clamp(0.0, 1.0);
  }

  @override
  bool isCorrect(double score) => score >= AppConfig.strokeCorrectThreshold;
}
