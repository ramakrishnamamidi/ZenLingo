import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers/database_provider.dart';
import '../models/dashboard_stats.dart';

final dashboardStatsProvider = FutureProvider<DashboardStats>((ref) async {
  final sessionDao = ref.watch(sessionDaoProvider);
  final srsDao = ref.watch(srsDaoProvider);

  final sessions = await sessionDao.getLast365Days();
  final totalCards = await srsDao.countAllCards();
  final masteredCards = await srsDao.countMasteredCards();

  return DashboardStats.fromData(
    sessions: sessions,
    totalCards: totalCards,
    masteredCards: masteredCards,
  );
});
