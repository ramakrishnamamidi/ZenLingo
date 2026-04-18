import 'package:flutter/painting.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zenlingo/core/config/app_config.dart';
import 'package:zenlingo/features/writing/validators/stroke_validator.dart';

const _canvasSize = Size(280, 280);

SvgStrokeTemplate _hLine() => const SvgStrokeTemplate(
      char: 'test',
      order: 1,
      normalizedPoints: [Offset(0.2, 0.5), Offset(0.5, 0.5), Offset(0.8, 0.5)],
    );

void main() {
  const validator = DtwStrokeValidator();

  test('perfect match scores >= strokeCorrectThreshold', () {
    // User draws the same points as the template (in canvas coords)
    final userStroke = [
      const Offset(0.2 * 280, 0.5 * 280),
      const Offset(0.5 * 280, 0.5 * 280),
      const Offset(0.8 * 280, 0.5 * 280),
    ];
    final score = validator.validate(userStroke, _hLine(), _canvasSize);
    expect(score, greaterThanOrEqualTo(AppConfig.strokeCorrectThreshold));
    expect(validator.isCorrect(score), isTrue);
  });

  test('completely wrong stroke scores below threshold', () {
    // User draws a vertical line, template is horizontal
    final userStroke = [
      const Offset(0.5 * 280, 0.1 * 280),
      const Offset(0.5 * 280, 0.9 * 280),
    ];
    final score = validator.validate(userStroke, _hLine(), _canvasSize);
    expect(validator.isCorrect(score), isFalse);
  });

  test('single-point stroke returns 0.0', () {
    final score = validator.validate(
      [const Offset(100, 100)],
      _hLine(),
      _canvasSize,
    );
    expect(score, 0.0);
  });

  test('isCorrect returns true when score >= threshold', () {
    expect(validator.isCorrect(AppConfig.strokeCorrectThreshold), isTrue);
    expect(validator.isCorrect(AppConfig.strokeCorrectThreshold - 0.01), isFalse);
  });
}
