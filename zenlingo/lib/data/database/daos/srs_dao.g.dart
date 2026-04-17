// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'srs_dao.dart';

// ignore_for_file: type=lint
mixin _$SrsDaoMixin on DatabaseAccessor<AppDatabase> {
  $VocabularyCardsTable get vocabularyCards => attachedDatabase.vocabularyCards;
  SrsDaoManager get managers => SrsDaoManager(this);
}

class SrsDaoManager {
  final _$SrsDaoMixin _db;
  SrsDaoManager(this._db);
  $$VocabularyCardsTableTableManager get vocabularyCards =>
      $$VocabularyCardsTableTableManager(
          _db.attachedDatabase, _db.vocabularyCards);
}
