import 'package:drift/drift.dart';
import '../app_database.dart';
import '../tables/stroke_templates.dart';

part 'stroke_dao.g.dart';

@DriftAccessor(tables: [StrokeTemplates])
class StrokeDao extends DatabaseAccessor<AppDatabase> with _$StrokeDaoMixin {
  StrokeDao(super.db);

  Future<StrokeTemplate?> findByCharacter(String character) {
    return (select(strokeTemplates)
          ..where((t) => t.character.equals(character)))
        .getSingleOrNull();
  }
}
