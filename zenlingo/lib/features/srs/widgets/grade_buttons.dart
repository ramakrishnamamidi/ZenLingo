import 'package:flutter/material.dart';

import '../../../core/srs/srs_algorithm.dart';

class GradeButtons extends StatelessWidget {
  final void Function(SrsGrade grade) onGrade;

  const GradeButtons({super.key, required this.onGrade});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _Btn(label: 'Again', color: const Color(0xFFE53935), grade: SrsGrade.again, onGrade: onGrade),
        const SizedBox(width: 8),
        _Btn(label: 'Hard', color: const Color(0xFFFB8C00), grade: SrsGrade.hard, onGrade: onGrade),
        const SizedBox(width: 8),
        _Btn(label: 'Good', color: const Color(0xFF4CAF50), grade: SrsGrade.good, onGrade: onGrade),
        const SizedBox(width: 8),
        _Btn(label: 'Easy', color: const Color(0xFF1E88E5), grade: SrsGrade.easy, onGrade: onGrade),
      ],
    );
  }
}

class _Btn extends StatelessWidget {
  final String label;
  final Color color;
  final SrsGrade grade;
  final void Function(SrsGrade) onGrade;

  const _Btn({
    required this.label,
    required this.color,
    required this.grade,
    required this.onGrade,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 14),
        ),
        onPressed: () => onGrade(grade),
        child: Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
      ),
    );
  }
}
