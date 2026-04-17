import 'dart:math';

import 'package:flutter/material.dart';

import '../../../core/theme/zen_theme.dart';
import '../../../data/database/app_database.dart';

class FlashcardWidget extends StatelessWidget {
  final VocabularyCard card;
  final bool isFlipped;
  final VoidCallback onTap;

  const FlashcardWidget({
    super.key,
    required this.card,
    required this.isFlipped,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: TweenAnimationBuilder<double>(
        tween: Tween(begin: 0.0, end: isFlipped ? pi : 0.0),
        duration: const Duration(milliseconds: 300),
        builder: (context, angle, _) {
          final showBack = angle > pi / 2;
          Widget face = showBack ? _BackFace(card: card) : _FrontFace(card: card);
          if (showBack) {
            face = Transform(
              transform: Matrix4.rotationY(pi),
              alignment: Alignment.center,
              child: face,
            );
          }
          return Transform(
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..rotateY(angle),
            alignment: Alignment.center,
            child: face,
          );
        },
      ),
    );
  }
}

class _FrontFace extends StatelessWidget {
  final VocabularyCard card;
  const _FrontFace({required this.card});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              card.word,
              style: Theme.of(context).textTheme.displayLarge,
            ),
            const SizedBox(height: 12),
            Text(
              card.reading,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: ZenTheme.textSecondary,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BackFace extends StatelessWidget {
  final VocabularyCard card;
  const _BackFace({required this.card});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(card.word, style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 4),
              Text(
                card.reading,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: ZenTheme.textSecondary,
                    ),
              ),
              const Divider(height: 32),
              Text(card.meaning, style: Theme.of(context).textTheme.titleLarge),
              if (card.exampleSentence != null) ...[
                const SizedBox(height: 16),
                Text(
                  card.exampleSentence!,
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
