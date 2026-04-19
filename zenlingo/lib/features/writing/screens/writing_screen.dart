import 'package:drift/drift.dart' hide Column;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/providers/database_provider.dart';
import '../../../core/theme/zen_theme.dart';
import '../../../data/database/app_database.dart';
import '../providers/writing_provider.dart';
import '../validators/stroke_validator.dart';
import '../widgets/drawing_canvas.dart';

class WritingScreen extends ConsumerStatefulWidget {
  const WritingScreen({super.key});

  @override
  ConsumerState<WritingScreen> createState() => _WritingScreenState();
}

class _WritingScreenState extends ConsumerState<WritingScreen> {
  final List<List<Offset>> _completedStrokes = [];
  List<Offset> _currentStroke = [];
  Color? _flashColor;
  int _currentStrokeIndex = 0;
  bool _isComplete = false;

  static const _canvasSize = Size(280, 280);
  static const _validator = DtwStrokeValidator();

  void _onPanUpdate(Offset point) {
    setState(() => _currentStroke = [..._currentStroke, point]);
  }

  Future<void> _onStrokeEnd(
    List<Offset> stroke,
    List<SvgStrokeTemplate> templates,
  ) async {
    if (_currentStrokeIndex >= templates.length || _isComplete) return;

    final template = templates[_currentStrokeIndex];
    final score = _validator.validate(stroke, template, _canvasSize);
    final correct = _validator.isCorrect(score);

    if (correct) {
      HapticFeedback.lightImpact();
      setState(() {
        _completedStrokes.add(stroke);
        _currentStroke = [];
        _flashColor = ZenTheme.strokeCorrect;
        _currentStrokeIndex++;
      });
      await Future.delayed(const Duration(milliseconds: 300));
      setState(() => _flashColor = null);

      if (_currentStrokeIndex >= templates.length) {
        HapticFeedback.mediumImpact();
        setState(() => _isComplete = true);
        await _recordPractice();
      }
    } else {
      HapticFeedback.heavyImpact();
      setState(() {
        _currentStroke = [];
        _flashColor = ZenTheme.strokeIncorrect;
      });
      await Future.delayed(const Duration(milliseconds: 200));
      setState(() => _flashColor = null);
    }
  }

  Future<void> _recordPractice() async {
    await ref.read(sessionDaoProvider).insertSession(
          ReviewSessionsCompanion.insert(
            sessionDate: DateTime.now(),
            cardsReviewed: 0,
            correctCount: 0,
            writingPracticeCount: const Value(1),
          ),
        );
  }

  void _nextCharacter() {
    ref.read(practiceCharIndexProvider.notifier).update((i) => i + 1);
    setState(() {
      _completedStrokes.clear();
      _currentStroke = [];
      _currentStrokeIndex = 0;
      _isComplete = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final char = ref.watch(currentPracticeCharProvider);
    final asyncTemplates = ref.watch(strokeTemplatesProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('WRITING')),
      body: asyncTemplates.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (templates) => Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Text(char, style: Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 64)),
              const SizedBox(height: 8),
              Text(
                templates.isEmpty
                    ? 'No template available'
                    : _isComplete
                        ? 'Complete!'
                        : 'Stroke ${_currentStrokeIndex + 1} of ${templates.length}',
                style: Theme.of(context).textTheme.labelSmall,
              ),
              const SizedBox(height: 24),
              DrawingCanvas(
                completedStrokes: _completedStrokes,
                currentStroke: _currentStroke,
                canvasSize: _canvasSize,
                onPanUpdate: _onPanUpdate,
                onStrokeEnd: (s) => _onStrokeEnd(s, templates),
                flashColor: _flashColor,
              ),
              const SizedBox(height: 24),
              if (_isComplete)
                ElevatedButton(
                  onPressed: _nextCharacter,
                  child: const Text('Next Character'),
                )
              else if (templates.isNotEmpty)
                TextButton(
                  onPressed: () => setState(() {
                    _completedStrokes.clear();
                    _currentStroke = [];
                    _currentStrokeIndex = 0;
                  }),
                  child: Text(
                    'Clear',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
