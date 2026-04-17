import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers/database_provider.dart';
import '../../../core/srs/srs_algorithm.dart';
import '../../../core/theme/zen_theme.dart';
import '../../../data/database/app_database.dart';
import '../providers/srs_provider.dart';
import '../widgets/flashcard_widget.dart';
import '../widgets/grade_buttons.dart';

class ReviewScreen extends ConsumerStatefulWidget {
  const ReviewScreen({super.key});

  @override
  ConsumerState<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends ConsumerState<ReviewScreen> {
  bool _isFlipped = false;
  int _cardsReviewed = 0;
  int _correctCount = 0;
  bool _sessionRecorded = false;

  Future<void> _onGrade(VocabularyCard card, SrsGrade grade) async {
    setState(() {
      _cardsReviewed++;
      if (grade != SrsGrade.again) _correctCount++;
      _isFlipped = false;
    });
    await ref.read(srsReviewSessionProvider.notifier).gradeCard(card, grade);
  }

  Future<void> _recordSession() async {
    if (_sessionRecorded || _cardsReviewed == 0) return;
    _sessionRecorded = true;
    await ref.read(sessionDaoProvider).insertSession(
          ReviewSessionsCompanion.insert(
            sessionDate: DateTime.now(),
            cardsReviewed: _cardsReviewed,
            correctCount: _correctCount,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    final asyncCards = ref.watch(srsReviewSessionProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('REVIEW')),
      body: asyncCards.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (cards) {
          if (cards.isEmpty) {
            WidgetsBinding.instance.addPostFrameCallback((_) => _recordSession());
            return _AllDoneView(cardsReviewed: _cardsReviewed);
          }
          final card = cards.first;
          return Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Text(
                    '${cards.length} remaining',
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                ),
                Expanded(
                  child: FlashcardWidget(
                    card: card,
                    isFlipped: _isFlipped,
                    onTap: () {
                      if (!_isFlipped) setState(() => _isFlipped = true);
                    },
                  ),
                ),
                const SizedBox(height: 16),
                if (_isFlipped)
                  GradeButtons(onGrade: (g) => _onGrade(card, g))
                else
                  Text(
                    'Tap card to reveal',
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _AllDoneView extends StatelessWidget {
  final int cardsReviewed;
  const _AllDoneView({required this.cardsReviewed});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.check_circle_outline,
            size: 72,
            color: ZenTheme.strokeCorrect,
          ),
          const SizedBox(height: 20),
          Text('All done!', style: Theme.of(context).textTheme.displayLarge),
          const SizedBox(height: 8),
          Text(
            '$cardsReviewed cards reviewed',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
