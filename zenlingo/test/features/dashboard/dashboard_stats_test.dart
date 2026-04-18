import 'package:flutter_test/flutter_test.dart';
import 'package:zenlingo/data/database/app_database.dart';
import 'package:zenlingo/features/dashboard/models/dashboard_stats.dart';

ReviewSession _session({required DateTime date, required int cards}) =>
    ReviewSession(
      id: 1,
      sessionDate: date,
      cardsReviewed: cards,
      correctCount: cards,
      aiConversationSeconds: 0,
      writingPracticeCount: 0,
      languageCode: 'ja',
    );

void main() {
  group('DashboardStats.fromData', () {
    test('streak is 0 when no sessions', () {
      final stats = DashboardStats.fromData(
        sessions: [],
        totalCards: 10,
        masteredCards: 5,
      );
      expect(stats.streakDays, 0);
    });

    test('streak counts consecutive days from today', () {
      final today = DateTime.now();
      final stats = DashboardStats.fromData(
        sessions: [
          _session(date: today, cards: 10),
          _session(date: today.subtract(const Duration(days: 1)), cards: 5),
          _session(date: today.subtract(const Duration(days: 2)), cards: 8),
        ],
        totalCards: 30,
        masteredCards: 10,
      );
      expect(stats.streakDays, 3);
    });

    test('streak breaks on gap day', () {
      final today = DateTime.now();
      final stats = DashboardStats.fromData(
        sessions: [
          _session(date: today, cards: 10),
          // day 1 missing — gap
          _session(date: today.subtract(const Duration(days: 2)), cards: 8),
        ],
        totalCards: 30,
        masteredCards: 10,
      );
      expect(stats.streakDays, 1); // only today counts
    });

    test('masteryPercent is correct fraction', () {
      final stats = DashboardStats.fromData(
        sessions: [],
        totalCards: 20,
        masteredCards: 5,
      );
      expect(stats.masteryPercent, closeTo(0.25, 0.001));
    });

    test('masteryPercent is 0.0 when totalCards is 0', () {
      final stats = DashboardStats.fromData(
        sessions: [],
        totalCards: 0,
        masteredCards: 0,
      );
      expect(stats.masteryPercent, 0.0);
    });

    test('streak survives overnight when no session today yet', () {
      final today = DateTime.now();
      final stats = DashboardStats.fromData(
        sessions: [
          // yesterday and the day before — no session today
          _session(date: today.subtract(const Duration(days: 1)), cards: 10),
          _session(date: today.subtract(const Duration(days: 2)), cards: 8),
        ],
        totalCards: 30,
        masteredCards: 10,
      );
      expect(stats.streakDays, 2); // streak still 2, not 0
    });

    test('heatmapData groups sessions by date key', () {
      final today = DateTime.now();
      final stats = DashboardStats.fromData(
        sessions: [
          _session(date: today, cards: 10),
          _session(date: today, cards: 5), // same day — should sum
        ],
        totalCards: 10,
        masteredCards: 3,
      );
      final key =
          '${today.year}-${today.month.toString().padLeft(2, '0')}-${today.day.toString().padLeft(2, '0')}';
      expect(stats.heatmapData[key], 15); // 10 + 5
    });
  });
}
