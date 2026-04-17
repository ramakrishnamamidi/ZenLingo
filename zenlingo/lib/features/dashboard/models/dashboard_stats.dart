import '../../../data/database/app_database.dart';

class DashboardStats {
  final int streakDays;
  final double masteryPercent;
  final Map<String, int> heatmapData; // 'YYYY-MM-DD' -> total cards reviewed
  final int totalCards;
  final int masteredCards;

  const DashboardStats({
    required this.streakDays,
    required this.masteryPercent,
    required this.heatmapData,
    required this.totalCards,
    required this.masteredCards,
  });

  factory DashboardStats.fromData({
    required List<ReviewSession> sessions,
    required int totalCards,
    required int masteredCards,
  }) {
    // Build heatmap: sum cards per calendar day
    final heatmapData = <String, int>{};
    for (final s in sessions) {
      final key =
          '${s.sessionDate.year}-${s.sessionDate.month.toString().padLeft(2, '0')}-${s.sessionDate.day.toString().padLeft(2, '0')}';
      heatmapData[key] = (heatmapData[key] ?? 0) + s.cardsReviewed;
    }

    // Compute streak: consecutive days backward from today
    int streak = 0;
    var day = DateTime.now();
    for (int i = 0; i < 365; i++) {
      final key =
          '${day.year}-${day.month.toString().padLeft(2, '0')}-${day.day.toString().padLeft(2, '0')}';
      if ((heatmapData[key] ?? 0) > 0) {
        streak++;
        day = day.subtract(const Duration(days: 1));
      } else {
        break;
      }
    }

    return DashboardStats(
      streakDays: streak,
      masteryPercent: totalCards > 0 ? masteredCards / totalCards : 0.0,
      heatmapData: heatmapData,
      totalCards: totalCards,
      masteredCards: masteredCards,
    );
  }
}
