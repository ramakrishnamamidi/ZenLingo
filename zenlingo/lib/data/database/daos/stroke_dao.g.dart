// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stroke_dao.dart';

// ignore_for_file: type=lint
mixin _$StrokeDaoMixin on DatabaseAccessor<AppDatabase> {
  $StrokeTemplatesTable get strokeTemplates => attachedDatabase.strokeTemplates;
  StrokeDaoManager get managers => StrokeDaoManager(this);
}

class StrokeDaoManager {
  final _$StrokeDaoMixin _db;
  StrokeDaoManager(this._db);
  $$StrokeTemplatesTableTableManager get strokeTemplates =>
      $$StrokeTemplatesTableTableManager(
          _db.attachedDatabase, _db.strokeTemplates);
}
