import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/providers/database_provider.dart';
import '../validators/stroke_validator.dart';

// Characters available for practice — pulled from seeded stroke templates
const _practiceChars = ['あ', 'い', 'う', 'え', 'お'];

class PracticeCharIndex extends Notifier<int> {
  @override
  int build() => 0;

  void update(int Function(int) updater) {
    state = updater(state);
  }
}

final practiceCharIndexProvider = NotifierProvider<PracticeCharIndex, int>(
  PracticeCharIndex.new,
);

final currentPracticeCharProvider = Provider<String>((ref) {
  final idx = ref.watch(practiceCharIndexProvider);
  return _practiceChars[idx % _practiceChars.length];
});

// Loads stroke templates for the current practice character
final strokeTemplatesProvider = FutureProvider<List<SvgStrokeTemplate>>((ref) async {
  final char = ref.watch(currentPracticeCharProvider);
  final dao = ref.watch(strokeDaoProvider);
  final template = await dao.findByCharacter(char);
  if (template == null) return [];

  final strokes = jsonDecode(template.strokesJson) as List<dynamic>;
  return strokes
      .map((s) => SvgStrokeTemplate.fromJson(char, s as Map<String, dynamic>))
      .toList()
    ..sort((a, b) => a.order.compareTo(b.order));
});
