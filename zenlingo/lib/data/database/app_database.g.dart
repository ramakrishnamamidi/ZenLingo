// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $VocabularyCardsTable extends VocabularyCards
    with TableInfo<$VocabularyCardsTable, VocabularyCard> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $VocabularyCardsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _wordMeta = const VerificationMeta('word');
  @override
  late final GeneratedColumn<String> word = GeneratedColumn<String>(
      'word', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 50),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _readingMeta =
      const VerificationMeta('reading');
  @override
  late final GeneratedColumn<String> reading = GeneratedColumn<String>(
      'reading', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _meaningMeta =
      const VerificationMeta('meaning');
  @override
  late final GeneratedColumn<String> meaning = GeneratedColumn<String>(
      'meaning', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _exampleSentenceMeta =
      const VerificationMeta('exampleSentence');
  @override
  late final GeneratedColumn<String> exampleSentence = GeneratedColumn<String>(
      'example_sentence', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _jlptLevelMeta =
      const VerificationMeta('jlptLevel');
  @override
  late final GeneratedColumn<int> jlptLevel = GeneratedColumn<int>(
      'jlpt_level', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(5));
  static const VerificationMeta _languageCodeMeta =
      const VerificationMeta('languageCode');
  @override
  late final GeneratedColumn<String> languageCode = GeneratedColumn<String>(
      'language_code', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('ja'));
  static const VerificationMeta _stabilityMeta =
      const VerificationMeta('stability');
  @override
  late final GeneratedColumn<double> stability = GeneratedColumn<double>(
      'stability', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(1.0));
  static const VerificationMeta _difficultyMeta =
      const VerificationMeta('difficulty');
  @override
  late final GeneratedColumn<double> difficulty = GeneratedColumn<double>(
      'difficulty', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(5.0));
  static const VerificationMeta _retrievabilityMeta =
      const VerificationMeta('retrievability');
  @override
  late final GeneratedColumn<double> retrievability = GeneratedColumn<double>(
      'retrievability', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(1.0));
  static const VerificationMeta _repsMeta = const VerificationMeta('reps');
  @override
  late final GeneratedColumn<int> reps = GeneratedColumn<int>(
      'reps', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _easinessFactorMeta =
      const VerificationMeta('easinessFactor');
  @override
  late final GeneratedColumn<double> easinessFactor = GeneratedColumn<double>(
      'easiness_factor', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(2.5));
  static const VerificationMeta _intervalMeta =
      const VerificationMeta('interval');
  @override
  late final GeneratedColumn<int> interval = GeneratedColumn<int>(
      'interval', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(1));
  static const VerificationMeta _nextReviewDateMeta =
      const VerificationMeta('nextReviewDate');
  @override
  late final GeneratedColumn<DateTime> nextReviewDate =
      GeneratedColumn<DateTime>('next_review_date', aliasedName, false,
          type: DriftSqlType.dateTime,
          requiredDuringInsert: false,
          defaultValue: currentDateAndTime);
  static const VerificationMeta _lastReviewDateMeta =
      const VerificationMeta('lastReviewDate');
  @override
  late final GeneratedColumn<DateTime> lastReviewDate =
      GeneratedColumn<DateTime>('last_review_date', aliasedName, true,
          type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _tagsMeta = const VerificationMeta('tags');
  @override
  late final GeneratedColumn<String> tags = GeneratedColumn<String>(
      'tags', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('[]'));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        word,
        reading,
        meaning,
        exampleSentence,
        jlptLevel,
        languageCode,
        stability,
        difficulty,
        retrievability,
        reps,
        easinessFactor,
        interval,
        nextReviewDate,
        lastReviewDate,
        tags
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'vocabulary_cards';
  @override
  VerificationContext validateIntegrity(Insertable<VocabularyCard> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('word')) {
      context.handle(
          _wordMeta, word.isAcceptableOrUnknown(data['word']!, _wordMeta));
    } else if (isInserting) {
      context.missing(_wordMeta);
    }
    if (data.containsKey('reading')) {
      context.handle(_readingMeta,
          reading.isAcceptableOrUnknown(data['reading']!, _readingMeta));
    } else if (isInserting) {
      context.missing(_readingMeta);
    }
    if (data.containsKey('meaning')) {
      context.handle(_meaningMeta,
          meaning.isAcceptableOrUnknown(data['meaning']!, _meaningMeta));
    } else if (isInserting) {
      context.missing(_meaningMeta);
    }
    if (data.containsKey('example_sentence')) {
      context.handle(
          _exampleSentenceMeta,
          exampleSentence.isAcceptableOrUnknown(
              data['example_sentence']!, _exampleSentenceMeta));
    }
    if (data.containsKey('jlpt_level')) {
      context.handle(_jlptLevelMeta,
          jlptLevel.isAcceptableOrUnknown(data['jlpt_level']!, _jlptLevelMeta));
    }
    if (data.containsKey('language_code')) {
      context.handle(
          _languageCodeMeta,
          languageCode.isAcceptableOrUnknown(
              data['language_code']!, _languageCodeMeta));
    }
    if (data.containsKey('stability')) {
      context.handle(_stabilityMeta,
          stability.isAcceptableOrUnknown(data['stability']!, _stabilityMeta));
    }
    if (data.containsKey('difficulty')) {
      context.handle(
          _difficultyMeta,
          difficulty.isAcceptableOrUnknown(
              data['difficulty']!, _difficultyMeta));
    }
    if (data.containsKey('retrievability')) {
      context.handle(
          _retrievabilityMeta,
          retrievability.isAcceptableOrUnknown(
              data['retrievability']!, _retrievabilityMeta));
    }
    if (data.containsKey('reps')) {
      context.handle(
          _repsMeta, reps.isAcceptableOrUnknown(data['reps']!, _repsMeta));
    }
    if (data.containsKey('easiness_factor')) {
      context.handle(
          _easinessFactorMeta,
          easinessFactor.isAcceptableOrUnknown(
              data['easiness_factor']!, _easinessFactorMeta));
    }
    if (data.containsKey('interval')) {
      context.handle(_intervalMeta,
          interval.isAcceptableOrUnknown(data['interval']!, _intervalMeta));
    }
    if (data.containsKey('next_review_date')) {
      context.handle(
          _nextReviewDateMeta,
          nextReviewDate.isAcceptableOrUnknown(
              data['next_review_date']!, _nextReviewDateMeta));
    }
    if (data.containsKey('last_review_date')) {
      context.handle(
          _lastReviewDateMeta,
          lastReviewDate.isAcceptableOrUnknown(
              data['last_review_date']!, _lastReviewDateMeta));
    }
    if (data.containsKey('tags')) {
      context.handle(
          _tagsMeta, tags.isAcceptableOrUnknown(data['tags']!, _tagsMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  VocabularyCard map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return VocabularyCard(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      word: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}word'])!,
      reading: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}reading'])!,
      meaning: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}meaning'])!,
      exampleSentence: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}example_sentence']),
      jlptLevel: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}jlpt_level'])!,
      languageCode: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}language_code'])!,
      stability: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}stability'])!,
      difficulty: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}difficulty'])!,
      retrievability: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}retrievability'])!,
      reps: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}reps'])!,
      easinessFactor: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}easiness_factor'])!,
      interval: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}interval'])!,
      nextReviewDate: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}next_review_date'])!,
      lastReviewDate: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}last_review_date']),
      tags: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tags'])!,
    );
  }

  @override
  $VocabularyCardsTable createAlias(String alias) {
    return $VocabularyCardsTable(attachedDatabase, alias);
  }
}

class VocabularyCard extends DataClass implements Insertable<VocabularyCard> {
  final int id;
  final String word;
  final String reading;
  final String meaning;
  final String? exampleSentence;
  final int jlptLevel;
  final String languageCode;
  final double stability;
  final double difficulty;
  final double retrievability;
  final int reps;
  final double easinessFactor;
  final int interval;
  final DateTime nextReviewDate;
  final DateTime? lastReviewDate;
  final String tags;
  const VocabularyCard(
      {required this.id,
      required this.word,
      required this.reading,
      required this.meaning,
      this.exampleSentence,
      required this.jlptLevel,
      required this.languageCode,
      required this.stability,
      required this.difficulty,
      required this.retrievability,
      required this.reps,
      required this.easinessFactor,
      required this.interval,
      required this.nextReviewDate,
      this.lastReviewDate,
      required this.tags});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['word'] = Variable<String>(word);
    map['reading'] = Variable<String>(reading);
    map['meaning'] = Variable<String>(meaning);
    if (!nullToAbsent || exampleSentence != null) {
      map['example_sentence'] = Variable<String>(exampleSentence);
    }
    map['jlpt_level'] = Variable<int>(jlptLevel);
    map['language_code'] = Variable<String>(languageCode);
    map['stability'] = Variable<double>(stability);
    map['difficulty'] = Variable<double>(difficulty);
    map['retrievability'] = Variable<double>(retrievability);
    map['reps'] = Variable<int>(reps);
    map['easiness_factor'] = Variable<double>(easinessFactor);
    map['interval'] = Variable<int>(interval);
    map['next_review_date'] = Variable<DateTime>(nextReviewDate);
    if (!nullToAbsent || lastReviewDate != null) {
      map['last_review_date'] = Variable<DateTime>(lastReviewDate);
    }
    map['tags'] = Variable<String>(tags);
    return map;
  }

  VocabularyCardsCompanion toCompanion(bool nullToAbsent) {
    return VocabularyCardsCompanion(
      id: Value(id),
      word: Value(word),
      reading: Value(reading),
      meaning: Value(meaning),
      exampleSentence: exampleSentence == null && nullToAbsent
          ? const Value.absent()
          : Value(exampleSentence),
      jlptLevel: Value(jlptLevel),
      languageCode: Value(languageCode),
      stability: Value(stability),
      difficulty: Value(difficulty),
      retrievability: Value(retrievability),
      reps: Value(reps),
      easinessFactor: Value(easinessFactor),
      interval: Value(interval),
      nextReviewDate: Value(nextReviewDate),
      lastReviewDate: lastReviewDate == null && nullToAbsent
          ? const Value.absent()
          : Value(lastReviewDate),
      tags: Value(tags),
    );
  }

  factory VocabularyCard.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return VocabularyCard(
      id: serializer.fromJson<int>(json['id']),
      word: serializer.fromJson<String>(json['word']),
      reading: serializer.fromJson<String>(json['reading']),
      meaning: serializer.fromJson<String>(json['meaning']),
      exampleSentence: serializer.fromJson<String?>(json['exampleSentence']),
      jlptLevel: serializer.fromJson<int>(json['jlptLevel']),
      languageCode: serializer.fromJson<String>(json['languageCode']),
      stability: serializer.fromJson<double>(json['stability']),
      difficulty: serializer.fromJson<double>(json['difficulty']),
      retrievability: serializer.fromJson<double>(json['retrievability']),
      reps: serializer.fromJson<int>(json['reps']),
      easinessFactor: serializer.fromJson<double>(json['easinessFactor']),
      interval: serializer.fromJson<int>(json['interval']),
      nextReviewDate: serializer.fromJson<DateTime>(json['nextReviewDate']),
      lastReviewDate: serializer.fromJson<DateTime?>(json['lastReviewDate']),
      tags: serializer.fromJson<String>(json['tags']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'word': serializer.toJson<String>(word),
      'reading': serializer.toJson<String>(reading),
      'meaning': serializer.toJson<String>(meaning),
      'exampleSentence': serializer.toJson<String?>(exampleSentence),
      'jlptLevel': serializer.toJson<int>(jlptLevel),
      'languageCode': serializer.toJson<String>(languageCode),
      'stability': serializer.toJson<double>(stability),
      'difficulty': serializer.toJson<double>(difficulty),
      'retrievability': serializer.toJson<double>(retrievability),
      'reps': serializer.toJson<int>(reps),
      'easinessFactor': serializer.toJson<double>(easinessFactor),
      'interval': serializer.toJson<int>(interval),
      'nextReviewDate': serializer.toJson<DateTime>(nextReviewDate),
      'lastReviewDate': serializer.toJson<DateTime?>(lastReviewDate),
      'tags': serializer.toJson<String>(tags),
    };
  }

  VocabularyCard copyWith(
          {int? id,
          String? word,
          String? reading,
          String? meaning,
          Value<String?> exampleSentence = const Value.absent(),
          int? jlptLevel,
          String? languageCode,
          double? stability,
          double? difficulty,
          double? retrievability,
          int? reps,
          double? easinessFactor,
          int? interval,
          DateTime? nextReviewDate,
          Value<DateTime?> lastReviewDate = const Value.absent(),
          String? tags}) =>
      VocabularyCard(
        id: id ?? this.id,
        word: word ?? this.word,
        reading: reading ?? this.reading,
        meaning: meaning ?? this.meaning,
        exampleSentence: exampleSentence.present
            ? exampleSentence.value
            : this.exampleSentence,
        jlptLevel: jlptLevel ?? this.jlptLevel,
        languageCode: languageCode ?? this.languageCode,
        stability: stability ?? this.stability,
        difficulty: difficulty ?? this.difficulty,
        retrievability: retrievability ?? this.retrievability,
        reps: reps ?? this.reps,
        easinessFactor: easinessFactor ?? this.easinessFactor,
        interval: interval ?? this.interval,
        nextReviewDate: nextReviewDate ?? this.nextReviewDate,
        lastReviewDate:
            lastReviewDate.present ? lastReviewDate.value : this.lastReviewDate,
        tags: tags ?? this.tags,
      );
  VocabularyCard copyWithCompanion(VocabularyCardsCompanion data) {
    return VocabularyCard(
      id: data.id.present ? data.id.value : this.id,
      word: data.word.present ? data.word.value : this.word,
      reading: data.reading.present ? data.reading.value : this.reading,
      meaning: data.meaning.present ? data.meaning.value : this.meaning,
      exampleSentence: data.exampleSentence.present
          ? data.exampleSentence.value
          : this.exampleSentence,
      jlptLevel: data.jlptLevel.present ? data.jlptLevel.value : this.jlptLevel,
      languageCode: data.languageCode.present
          ? data.languageCode.value
          : this.languageCode,
      stability: data.stability.present ? data.stability.value : this.stability,
      difficulty:
          data.difficulty.present ? data.difficulty.value : this.difficulty,
      retrievability: data.retrievability.present
          ? data.retrievability.value
          : this.retrievability,
      reps: data.reps.present ? data.reps.value : this.reps,
      easinessFactor: data.easinessFactor.present
          ? data.easinessFactor.value
          : this.easinessFactor,
      interval: data.interval.present ? data.interval.value : this.interval,
      nextReviewDate: data.nextReviewDate.present
          ? data.nextReviewDate.value
          : this.nextReviewDate,
      lastReviewDate: data.lastReviewDate.present
          ? data.lastReviewDate.value
          : this.lastReviewDate,
      tags: data.tags.present ? data.tags.value : this.tags,
    );
  }

  @override
  String toString() {
    return (StringBuffer('VocabularyCard(')
          ..write('id: $id, ')
          ..write('word: $word, ')
          ..write('reading: $reading, ')
          ..write('meaning: $meaning, ')
          ..write('exampleSentence: $exampleSentence, ')
          ..write('jlptLevel: $jlptLevel, ')
          ..write('languageCode: $languageCode, ')
          ..write('stability: $stability, ')
          ..write('difficulty: $difficulty, ')
          ..write('retrievability: $retrievability, ')
          ..write('reps: $reps, ')
          ..write('easinessFactor: $easinessFactor, ')
          ..write('interval: $interval, ')
          ..write('nextReviewDate: $nextReviewDate, ')
          ..write('lastReviewDate: $lastReviewDate, ')
          ..write('tags: $tags')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      word,
      reading,
      meaning,
      exampleSentence,
      jlptLevel,
      languageCode,
      stability,
      difficulty,
      retrievability,
      reps,
      easinessFactor,
      interval,
      nextReviewDate,
      lastReviewDate,
      tags);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is VocabularyCard &&
          other.id == this.id &&
          other.word == this.word &&
          other.reading == this.reading &&
          other.meaning == this.meaning &&
          other.exampleSentence == this.exampleSentence &&
          other.jlptLevel == this.jlptLevel &&
          other.languageCode == this.languageCode &&
          other.stability == this.stability &&
          other.difficulty == this.difficulty &&
          other.retrievability == this.retrievability &&
          other.reps == this.reps &&
          other.easinessFactor == this.easinessFactor &&
          other.interval == this.interval &&
          other.nextReviewDate == this.nextReviewDate &&
          other.lastReviewDate == this.lastReviewDate &&
          other.tags == this.tags);
}

class VocabularyCardsCompanion extends UpdateCompanion<VocabularyCard> {
  final Value<int> id;
  final Value<String> word;
  final Value<String> reading;
  final Value<String> meaning;
  final Value<String?> exampleSentence;
  final Value<int> jlptLevel;
  final Value<String> languageCode;
  final Value<double> stability;
  final Value<double> difficulty;
  final Value<double> retrievability;
  final Value<int> reps;
  final Value<double> easinessFactor;
  final Value<int> interval;
  final Value<DateTime> nextReviewDate;
  final Value<DateTime?> lastReviewDate;
  final Value<String> tags;
  const VocabularyCardsCompanion({
    this.id = const Value.absent(),
    this.word = const Value.absent(),
    this.reading = const Value.absent(),
    this.meaning = const Value.absent(),
    this.exampleSentence = const Value.absent(),
    this.jlptLevel = const Value.absent(),
    this.languageCode = const Value.absent(),
    this.stability = const Value.absent(),
    this.difficulty = const Value.absent(),
    this.retrievability = const Value.absent(),
    this.reps = const Value.absent(),
    this.easinessFactor = const Value.absent(),
    this.interval = const Value.absent(),
    this.nextReviewDate = const Value.absent(),
    this.lastReviewDate = const Value.absent(),
    this.tags = const Value.absent(),
  });
  VocabularyCardsCompanion.insert({
    this.id = const Value.absent(),
    required String word,
    required String reading,
    required String meaning,
    this.exampleSentence = const Value.absent(),
    this.jlptLevel = const Value.absent(),
    this.languageCode = const Value.absent(),
    this.stability = const Value.absent(),
    this.difficulty = const Value.absent(),
    this.retrievability = const Value.absent(),
    this.reps = const Value.absent(),
    this.easinessFactor = const Value.absent(),
    this.interval = const Value.absent(),
    this.nextReviewDate = const Value.absent(),
    this.lastReviewDate = const Value.absent(),
    this.tags = const Value.absent(),
  })  : word = Value(word),
        reading = Value(reading),
        meaning = Value(meaning);
  static Insertable<VocabularyCard> custom({
    Expression<int>? id,
    Expression<String>? word,
    Expression<String>? reading,
    Expression<String>? meaning,
    Expression<String>? exampleSentence,
    Expression<int>? jlptLevel,
    Expression<String>? languageCode,
    Expression<double>? stability,
    Expression<double>? difficulty,
    Expression<double>? retrievability,
    Expression<int>? reps,
    Expression<double>? easinessFactor,
    Expression<int>? interval,
    Expression<DateTime>? nextReviewDate,
    Expression<DateTime>? lastReviewDate,
    Expression<String>? tags,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (word != null) 'word': word,
      if (reading != null) 'reading': reading,
      if (meaning != null) 'meaning': meaning,
      if (exampleSentence != null) 'example_sentence': exampleSentence,
      if (jlptLevel != null) 'jlpt_level': jlptLevel,
      if (languageCode != null) 'language_code': languageCode,
      if (stability != null) 'stability': stability,
      if (difficulty != null) 'difficulty': difficulty,
      if (retrievability != null) 'retrievability': retrievability,
      if (reps != null) 'reps': reps,
      if (easinessFactor != null) 'easiness_factor': easinessFactor,
      if (interval != null) 'interval': interval,
      if (nextReviewDate != null) 'next_review_date': nextReviewDate,
      if (lastReviewDate != null) 'last_review_date': lastReviewDate,
      if (tags != null) 'tags': tags,
    });
  }

  VocabularyCardsCompanion copyWith(
      {Value<int>? id,
      Value<String>? word,
      Value<String>? reading,
      Value<String>? meaning,
      Value<String?>? exampleSentence,
      Value<int>? jlptLevel,
      Value<String>? languageCode,
      Value<double>? stability,
      Value<double>? difficulty,
      Value<double>? retrievability,
      Value<int>? reps,
      Value<double>? easinessFactor,
      Value<int>? interval,
      Value<DateTime>? nextReviewDate,
      Value<DateTime?>? lastReviewDate,
      Value<String>? tags}) {
    return VocabularyCardsCompanion(
      id: id ?? this.id,
      word: word ?? this.word,
      reading: reading ?? this.reading,
      meaning: meaning ?? this.meaning,
      exampleSentence: exampleSentence ?? this.exampleSentence,
      jlptLevel: jlptLevel ?? this.jlptLevel,
      languageCode: languageCode ?? this.languageCode,
      stability: stability ?? this.stability,
      difficulty: difficulty ?? this.difficulty,
      retrievability: retrievability ?? this.retrievability,
      reps: reps ?? this.reps,
      easinessFactor: easinessFactor ?? this.easinessFactor,
      interval: interval ?? this.interval,
      nextReviewDate: nextReviewDate ?? this.nextReviewDate,
      lastReviewDate: lastReviewDate ?? this.lastReviewDate,
      tags: tags ?? this.tags,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (word.present) {
      map['word'] = Variable<String>(word.value);
    }
    if (reading.present) {
      map['reading'] = Variable<String>(reading.value);
    }
    if (meaning.present) {
      map['meaning'] = Variable<String>(meaning.value);
    }
    if (exampleSentence.present) {
      map['example_sentence'] = Variable<String>(exampleSentence.value);
    }
    if (jlptLevel.present) {
      map['jlpt_level'] = Variable<int>(jlptLevel.value);
    }
    if (languageCode.present) {
      map['language_code'] = Variable<String>(languageCode.value);
    }
    if (stability.present) {
      map['stability'] = Variable<double>(stability.value);
    }
    if (difficulty.present) {
      map['difficulty'] = Variable<double>(difficulty.value);
    }
    if (retrievability.present) {
      map['retrievability'] = Variable<double>(retrievability.value);
    }
    if (reps.present) {
      map['reps'] = Variable<int>(reps.value);
    }
    if (easinessFactor.present) {
      map['easiness_factor'] = Variable<double>(easinessFactor.value);
    }
    if (interval.present) {
      map['interval'] = Variable<int>(interval.value);
    }
    if (nextReviewDate.present) {
      map['next_review_date'] = Variable<DateTime>(nextReviewDate.value);
    }
    if (lastReviewDate.present) {
      map['last_review_date'] = Variable<DateTime>(lastReviewDate.value);
    }
    if (tags.present) {
      map['tags'] = Variable<String>(tags.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('VocabularyCardsCompanion(')
          ..write('id: $id, ')
          ..write('word: $word, ')
          ..write('reading: $reading, ')
          ..write('meaning: $meaning, ')
          ..write('exampleSentence: $exampleSentence, ')
          ..write('jlptLevel: $jlptLevel, ')
          ..write('languageCode: $languageCode, ')
          ..write('stability: $stability, ')
          ..write('difficulty: $difficulty, ')
          ..write('retrievability: $retrievability, ')
          ..write('reps: $reps, ')
          ..write('easinessFactor: $easinessFactor, ')
          ..write('interval: $interval, ')
          ..write('nextReviewDate: $nextReviewDate, ')
          ..write('lastReviewDate: $lastReviewDate, ')
          ..write('tags: $tags')
          ..write(')'))
        .toString();
  }
}

class $ReviewSessionsTable extends ReviewSessions
    with TableInfo<$ReviewSessionsTable, ReviewSession> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ReviewSessionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _sessionDateMeta =
      const VerificationMeta('sessionDate');
  @override
  late final GeneratedColumn<DateTime> sessionDate = GeneratedColumn<DateTime>(
      'session_date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _cardsReviewedMeta =
      const VerificationMeta('cardsReviewed');
  @override
  late final GeneratedColumn<int> cardsReviewed = GeneratedColumn<int>(
      'cards_reviewed', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _correctCountMeta =
      const VerificationMeta('correctCount');
  @override
  late final GeneratedColumn<int> correctCount = GeneratedColumn<int>(
      'correct_count', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _aiConversationSecondsMeta =
      const VerificationMeta('aiConversationSeconds');
  @override
  late final GeneratedColumn<int> aiConversationSeconds = GeneratedColumn<int>(
      'ai_conversation_seconds', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _writingPracticeCountMeta =
      const VerificationMeta('writingPracticeCount');
  @override
  late final GeneratedColumn<int> writingPracticeCount = GeneratedColumn<int>(
      'writing_practice_count', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _languageCodeMeta =
      const VerificationMeta('languageCode');
  @override
  late final GeneratedColumn<String> languageCode = GeneratedColumn<String>(
      'language_code', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('ja'));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        sessionDate,
        cardsReviewed,
        correctCount,
        aiConversationSeconds,
        writingPracticeCount,
        languageCode
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'review_sessions';
  @override
  VerificationContext validateIntegrity(Insertable<ReviewSession> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('session_date')) {
      context.handle(
          _sessionDateMeta,
          sessionDate.isAcceptableOrUnknown(
              data['session_date']!, _sessionDateMeta));
    } else if (isInserting) {
      context.missing(_sessionDateMeta);
    }
    if (data.containsKey('cards_reviewed')) {
      context.handle(
          _cardsReviewedMeta,
          cardsReviewed.isAcceptableOrUnknown(
              data['cards_reviewed']!, _cardsReviewedMeta));
    } else if (isInserting) {
      context.missing(_cardsReviewedMeta);
    }
    if (data.containsKey('correct_count')) {
      context.handle(
          _correctCountMeta,
          correctCount.isAcceptableOrUnknown(
              data['correct_count']!, _correctCountMeta));
    } else if (isInserting) {
      context.missing(_correctCountMeta);
    }
    if (data.containsKey('ai_conversation_seconds')) {
      context.handle(
          _aiConversationSecondsMeta,
          aiConversationSeconds.isAcceptableOrUnknown(
              data['ai_conversation_seconds']!, _aiConversationSecondsMeta));
    }
    if (data.containsKey('writing_practice_count')) {
      context.handle(
          _writingPracticeCountMeta,
          writingPracticeCount.isAcceptableOrUnknown(
              data['writing_practice_count']!, _writingPracticeCountMeta));
    }
    if (data.containsKey('language_code')) {
      context.handle(
          _languageCodeMeta,
          languageCode.isAcceptableOrUnknown(
              data['language_code']!, _languageCodeMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ReviewSession map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ReviewSession(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      sessionDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}session_date'])!,
      cardsReviewed: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}cards_reviewed'])!,
      correctCount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}correct_count'])!,
      aiConversationSeconds: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}ai_conversation_seconds'])!,
      writingPracticeCount: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}writing_practice_count'])!,
      languageCode: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}language_code'])!,
    );
  }

  @override
  $ReviewSessionsTable createAlias(String alias) {
    return $ReviewSessionsTable(attachedDatabase, alias);
  }
}

class ReviewSession extends DataClass implements Insertable<ReviewSession> {
  final int id;
  final DateTime sessionDate;
  final int cardsReviewed;
  final int correctCount;
  final int aiConversationSeconds;
  final int writingPracticeCount;
  final String languageCode;
  const ReviewSession(
      {required this.id,
      required this.sessionDate,
      required this.cardsReviewed,
      required this.correctCount,
      required this.aiConversationSeconds,
      required this.writingPracticeCount,
      required this.languageCode});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['session_date'] = Variable<DateTime>(sessionDate);
    map['cards_reviewed'] = Variable<int>(cardsReviewed);
    map['correct_count'] = Variable<int>(correctCount);
    map['ai_conversation_seconds'] = Variable<int>(aiConversationSeconds);
    map['writing_practice_count'] = Variable<int>(writingPracticeCount);
    map['language_code'] = Variable<String>(languageCode);
    return map;
  }

  ReviewSessionsCompanion toCompanion(bool nullToAbsent) {
    return ReviewSessionsCompanion(
      id: Value(id),
      sessionDate: Value(sessionDate),
      cardsReviewed: Value(cardsReviewed),
      correctCount: Value(correctCount),
      aiConversationSeconds: Value(aiConversationSeconds),
      writingPracticeCount: Value(writingPracticeCount),
      languageCode: Value(languageCode),
    );
  }

  factory ReviewSession.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ReviewSession(
      id: serializer.fromJson<int>(json['id']),
      sessionDate: serializer.fromJson<DateTime>(json['sessionDate']),
      cardsReviewed: serializer.fromJson<int>(json['cardsReviewed']),
      correctCount: serializer.fromJson<int>(json['correctCount']),
      aiConversationSeconds:
          serializer.fromJson<int>(json['aiConversationSeconds']),
      writingPracticeCount:
          serializer.fromJson<int>(json['writingPracticeCount']),
      languageCode: serializer.fromJson<String>(json['languageCode']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'sessionDate': serializer.toJson<DateTime>(sessionDate),
      'cardsReviewed': serializer.toJson<int>(cardsReviewed),
      'correctCount': serializer.toJson<int>(correctCount),
      'aiConversationSeconds': serializer.toJson<int>(aiConversationSeconds),
      'writingPracticeCount': serializer.toJson<int>(writingPracticeCount),
      'languageCode': serializer.toJson<String>(languageCode),
    };
  }

  ReviewSession copyWith(
          {int? id,
          DateTime? sessionDate,
          int? cardsReviewed,
          int? correctCount,
          int? aiConversationSeconds,
          int? writingPracticeCount,
          String? languageCode}) =>
      ReviewSession(
        id: id ?? this.id,
        sessionDate: sessionDate ?? this.sessionDate,
        cardsReviewed: cardsReviewed ?? this.cardsReviewed,
        correctCount: correctCount ?? this.correctCount,
        aiConversationSeconds:
            aiConversationSeconds ?? this.aiConversationSeconds,
        writingPracticeCount: writingPracticeCount ?? this.writingPracticeCount,
        languageCode: languageCode ?? this.languageCode,
      );
  ReviewSession copyWithCompanion(ReviewSessionsCompanion data) {
    return ReviewSession(
      id: data.id.present ? data.id.value : this.id,
      sessionDate:
          data.sessionDate.present ? data.sessionDate.value : this.sessionDate,
      cardsReviewed: data.cardsReviewed.present
          ? data.cardsReviewed.value
          : this.cardsReviewed,
      correctCount: data.correctCount.present
          ? data.correctCount.value
          : this.correctCount,
      aiConversationSeconds: data.aiConversationSeconds.present
          ? data.aiConversationSeconds.value
          : this.aiConversationSeconds,
      writingPracticeCount: data.writingPracticeCount.present
          ? data.writingPracticeCount.value
          : this.writingPracticeCount,
      languageCode: data.languageCode.present
          ? data.languageCode.value
          : this.languageCode,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ReviewSession(')
          ..write('id: $id, ')
          ..write('sessionDate: $sessionDate, ')
          ..write('cardsReviewed: $cardsReviewed, ')
          ..write('correctCount: $correctCount, ')
          ..write('aiConversationSeconds: $aiConversationSeconds, ')
          ..write('writingPracticeCount: $writingPracticeCount, ')
          ..write('languageCode: $languageCode')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, sessionDate, cardsReviewed, correctCount,
      aiConversationSeconds, writingPracticeCount, languageCode);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ReviewSession &&
          other.id == this.id &&
          other.sessionDate == this.sessionDate &&
          other.cardsReviewed == this.cardsReviewed &&
          other.correctCount == this.correctCount &&
          other.aiConversationSeconds == this.aiConversationSeconds &&
          other.writingPracticeCount == this.writingPracticeCount &&
          other.languageCode == this.languageCode);
}

class ReviewSessionsCompanion extends UpdateCompanion<ReviewSession> {
  final Value<int> id;
  final Value<DateTime> sessionDate;
  final Value<int> cardsReviewed;
  final Value<int> correctCount;
  final Value<int> aiConversationSeconds;
  final Value<int> writingPracticeCount;
  final Value<String> languageCode;
  const ReviewSessionsCompanion({
    this.id = const Value.absent(),
    this.sessionDate = const Value.absent(),
    this.cardsReviewed = const Value.absent(),
    this.correctCount = const Value.absent(),
    this.aiConversationSeconds = const Value.absent(),
    this.writingPracticeCount = const Value.absent(),
    this.languageCode = const Value.absent(),
  });
  ReviewSessionsCompanion.insert({
    this.id = const Value.absent(),
    required DateTime sessionDate,
    required int cardsReviewed,
    required int correctCount,
    this.aiConversationSeconds = const Value.absent(),
    this.writingPracticeCount = const Value.absent(),
    this.languageCode = const Value.absent(),
  })  : sessionDate = Value(sessionDate),
        cardsReviewed = Value(cardsReviewed),
        correctCount = Value(correctCount);
  static Insertable<ReviewSession> custom({
    Expression<int>? id,
    Expression<DateTime>? sessionDate,
    Expression<int>? cardsReviewed,
    Expression<int>? correctCount,
    Expression<int>? aiConversationSeconds,
    Expression<int>? writingPracticeCount,
    Expression<String>? languageCode,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (sessionDate != null) 'session_date': sessionDate,
      if (cardsReviewed != null) 'cards_reviewed': cardsReviewed,
      if (correctCount != null) 'correct_count': correctCount,
      if (aiConversationSeconds != null)
        'ai_conversation_seconds': aiConversationSeconds,
      if (writingPracticeCount != null)
        'writing_practice_count': writingPracticeCount,
      if (languageCode != null) 'language_code': languageCode,
    });
  }

  ReviewSessionsCompanion copyWith(
      {Value<int>? id,
      Value<DateTime>? sessionDate,
      Value<int>? cardsReviewed,
      Value<int>? correctCount,
      Value<int>? aiConversationSeconds,
      Value<int>? writingPracticeCount,
      Value<String>? languageCode}) {
    return ReviewSessionsCompanion(
      id: id ?? this.id,
      sessionDate: sessionDate ?? this.sessionDate,
      cardsReviewed: cardsReviewed ?? this.cardsReviewed,
      correctCount: correctCount ?? this.correctCount,
      aiConversationSeconds:
          aiConversationSeconds ?? this.aiConversationSeconds,
      writingPracticeCount: writingPracticeCount ?? this.writingPracticeCount,
      languageCode: languageCode ?? this.languageCode,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (sessionDate.present) {
      map['session_date'] = Variable<DateTime>(sessionDate.value);
    }
    if (cardsReviewed.present) {
      map['cards_reviewed'] = Variable<int>(cardsReviewed.value);
    }
    if (correctCount.present) {
      map['correct_count'] = Variable<int>(correctCount.value);
    }
    if (aiConversationSeconds.present) {
      map['ai_conversation_seconds'] =
          Variable<int>(aiConversationSeconds.value);
    }
    if (writingPracticeCount.present) {
      map['writing_practice_count'] = Variable<int>(writingPracticeCount.value);
    }
    if (languageCode.present) {
      map['language_code'] = Variable<String>(languageCode.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ReviewSessionsCompanion(')
          ..write('id: $id, ')
          ..write('sessionDate: $sessionDate, ')
          ..write('cardsReviewed: $cardsReviewed, ')
          ..write('correctCount: $correctCount, ')
          ..write('aiConversationSeconds: $aiConversationSeconds, ')
          ..write('writingPracticeCount: $writingPracticeCount, ')
          ..write('languageCode: $languageCode')
          ..write(')'))
        .toString();
  }
}

class $StrokeTemplatesTable extends StrokeTemplates
    with TableInfo<$StrokeTemplatesTable, StrokeTemplate> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StrokeTemplatesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _characterMeta =
      const VerificationMeta('character');
  @override
  late final GeneratedColumn<String> character = GeneratedColumn<String>(
      'character', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _scriptTypeMeta =
      const VerificationMeta('scriptType');
  @override
  late final GeneratedColumn<String> scriptType = GeneratedColumn<String>(
      'script_type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _strokesJsonMeta =
      const VerificationMeta('strokesJson');
  @override
  late final GeneratedColumn<String> strokesJson = GeneratedColumn<String>(
      'strokes_json', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _strokeCountMeta =
      const VerificationMeta('strokeCount');
  @override
  late final GeneratedColumn<int> strokeCount = GeneratedColumn<int>(
      'stroke_count', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, character, scriptType, strokesJson, strokeCount];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'stroke_templates';
  @override
  VerificationContext validateIntegrity(Insertable<StrokeTemplate> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('character')) {
      context.handle(_characterMeta,
          character.isAcceptableOrUnknown(data['character']!, _characterMeta));
    } else if (isInserting) {
      context.missing(_characterMeta);
    }
    if (data.containsKey('script_type')) {
      context.handle(
          _scriptTypeMeta,
          scriptType.isAcceptableOrUnknown(
              data['script_type']!, _scriptTypeMeta));
    } else if (isInserting) {
      context.missing(_scriptTypeMeta);
    }
    if (data.containsKey('strokes_json')) {
      context.handle(
          _strokesJsonMeta,
          strokesJson.isAcceptableOrUnknown(
              data['strokes_json']!, _strokesJsonMeta));
    } else if (isInserting) {
      context.missing(_strokesJsonMeta);
    }
    if (data.containsKey('stroke_count')) {
      context.handle(
          _strokeCountMeta,
          strokeCount.isAcceptableOrUnknown(
              data['stroke_count']!, _strokeCountMeta));
    } else if (isInserting) {
      context.missing(_strokeCountMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  StrokeTemplate map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StrokeTemplate(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      character: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}character'])!,
      scriptType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}script_type'])!,
      strokesJson: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}strokes_json'])!,
      strokeCount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}stroke_count'])!,
    );
  }

  @override
  $StrokeTemplatesTable createAlias(String alias) {
    return $StrokeTemplatesTable(attachedDatabase, alias);
  }
}

class StrokeTemplate extends DataClass implements Insertable<StrokeTemplate> {
  final int id;
  final String character;
  final String scriptType;
  final String strokesJson;
  final int strokeCount;
  const StrokeTemplate(
      {required this.id,
      required this.character,
      required this.scriptType,
      required this.strokesJson,
      required this.strokeCount});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['character'] = Variable<String>(character);
    map['script_type'] = Variable<String>(scriptType);
    map['strokes_json'] = Variable<String>(strokesJson);
    map['stroke_count'] = Variable<int>(strokeCount);
    return map;
  }

  StrokeTemplatesCompanion toCompanion(bool nullToAbsent) {
    return StrokeTemplatesCompanion(
      id: Value(id),
      character: Value(character),
      scriptType: Value(scriptType),
      strokesJson: Value(strokesJson),
      strokeCount: Value(strokeCount),
    );
  }

  factory StrokeTemplate.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StrokeTemplate(
      id: serializer.fromJson<int>(json['id']),
      character: serializer.fromJson<String>(json['character']),
      scriptType: serializer.fromJson<String>(json['scriptType']),
      strokesJson: serializer.fromJson<String>(json['strokesJson']),
      strokeCount: serializer.fromJson<int>(json['strokeCount']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'character': serializer.toJson<String>(character),
      'scriptType': serializer.toJson<String>(scriptType),
      'strokesJson': serializer.toJson<String>(strokesJson),
      'strokeCount': serializer.toJson<int>(strokeCount),
    };
  }

  StrokeTemplate copyWith(
          {int? id,
          String? character,
          String? scriptType,
          String? strokesJson,
          int? strokeCount}) =>
      StrokeTemplate(
        id: id ?? this.id,
        character: character ?? this.character,
        scriptType: scriptType ?? this.scriptType,
        strokesJson: strokesJson ?? this.strokesJson,
        strokeCount: strokeCount ?? this.strokeCount,
      );
  StrokeTemplate copyWithCompanion(StrokeTemplatesCompanion data) {
    return StrokeTemplate(
      id: data.id.present ? data.id.value : this.id,
      character: data.character.present ? data.character.value : this.character,
      scriptType:
          data.scriptType.present ? data.scriptType.value : this.scriptType,
      strokesJson:
          data.strokesJson.present ? data.strokesJson.value : this.strokesJson,
      strokeCount:
          data.strokeCount.present ? data.strokeCount.value : this.strokeCount,
    );
  }

  @override
  String toString() {
    return (StringBuffer('StrokeTemplate(')
          ..write('id: $id, ')
          ..write('character: $character, ')
          ..write('scriptType: $scriptType, ')
          ..write('strokesJson: $strokesJson, ')
          ..write('strokeCount: $strokeCount')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, character, scriptType, strokesJson, strokeCount);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StrokeTemplate &&
          other.id == this.id &&
          other.character == this.character &&
          other.scriptType == this.scriptType &&
          other.strokesJson == this.strokesJson &&
          other.strokeCount == this.strokeCount);
}

class StrokeTemplatesCompanion extends UpdateCompanion<StrokeTemplate> {
  final Value<int> id;
  final Value<String> character;
  final Value<String> scriptType;
  final Value<String> strokesJson;
  final Value<int> strokeCount;
  const StrokeTemplatesCompanion({
    this.id = const Value.absent(),
    this.character = const Value.absent(),
    this.scriptType = const Value.absent(),
    this.strokesJson = const Value.absent(),
    this.strokeCount = const Value.absent(),
  });
  StrokeTemplatesCompanion.insert({
    this.id = const Value.absent(),
    required String character,
    required String scriptType,
    required String strokesJson,
    required int strokeCount,
  })  : character = Value(character),
        scriptType = Value(scriptType),
        strokesJson = Value(strokesJson),
        strokeCount = Value(strokeCount);
  static Insertable<StrokeTemplate> custom({
    Expression<int>? id,
    Expression<String>? character,
    Expression<String>? scriptType,
    Expression<String>? strokesJson,
    Expression<int>? strokeCount,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (character != null) 'character': character,
      if (scriptType != null) 'script_type': scriptType,
      if (strokesJson != null) 'strokes_json': strokesJson,
      if (strokeCount != null) 'stroke_count': strokeCount,
    });
  }

  StrokeTemplatesCompanion copyWith(
      {Value<int>? id,
      Value<String>? character,
      Value<String>? scriptType,
      Value<String>? strokesJson,
      Value<int>? strokeCount}) {
    return StrokeTemplatesCompanion(
      id: id ?? this.id,
      character: character ?? this.character,
      scriptType: scriptType ?? this.scriptType,
      strokesJson: strokesJson ?? this.strokesJson,
      strokeCount: strokeCount ?? this.strokeCount,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (character.present) {
      map['character'] = Variable<String>(character.value);
    }
    if (scriptType.present) {
      map['script_type'] = Variable<String>(scriptType.value);
    }
    if (strokesJson.present) {
      map['strokes_json'] = Variable<String>(strokesJson.value);
    }
    if (strokeCount.present) {
      map['stroke_count'] = Variable<int>(strokeCount.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StrokeTemplatesCompanion(')
          ..write('id: $id, ')
          ..write('character: $character, ')
          ..write('scriptType: $scriptType, ')
          ..write('strokesJson: $strokesJson, ')
          ..write('strokeCount: $strokeCount')
          ..write(')'))
        .toString();
  }
}

class $ChatHistoryTable extends ChatHistory
    with TableInfo<$ChatHistoryTable, ChatHistoryData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ChatHistoryTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _roleMeta = const VerificationMeta('role');
  @override
  late final GeneratedColumn<String> role = GeneratedColumn<String>(
      'role', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _contentMeta =
      const VerificationMeta('content');
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
      'content', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _timestampMeta =
      const VerificationMeta('timestamp');
  @override
  late final GeneratedColumn<DateTime> timestamp = GeneratedColumn<DateTime>(
      'timestamp', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _languageCodeMeta =
      const VerificationMeta('languageCode');
  @override
  late final GeneratedColumn<String> languageCode = GeneratedColumn<String>(
      'language_code', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('ja'));
  @override
  List<GeneratedColumn> get $columns =>
      [id, role, content, timestamp, languageCode];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'chat_history';
  @override
  VerificationContext validateIntegrity(Insertable<ChatHistoryData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('role')) {
      context.handle(
          _roleMeta, role.isAcceptableOrUnknown(data['role']!, _roleMeta));
    } else if (isInserting) {
      context.missing(_roleMeta);
    }
    if (data.containsKey('content')) {
      context.handle(_contentMeta,
          content.isAcceptableOrUnknown(data['content']!, _contentMeta));
    } else if (isInserting) {
      context.missing(_contentMeta);
    }
    if (data.containsKey('timestamp')) {
      context.handle(_timestampMeta,
          timestamp.isAcceptableOrUnknown(data['timestamp']!, _timestampMeta));
    } else if (isInserting) {
      context.missing(_timestampMeta);
    }
    if (data.containsKey('language_code')) {
      context.handle(
          _languageCodeMeta,
          languageCode.isAcceptableOrUnknown(
              data['language_code']!, _languageCodeMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ChatHistoryData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ChatHistoryData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      role: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}role'])!,
      content: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}content'])!,
      timestamp: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}timestamp'])!,
      languageCode: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}language_code'])!,
    );
  }

  @override
  $ChatHistoryTable createAlias(String alias) {
    return $ChatHistoryTable(attachedDatabase, alias);
  }
}

class ChatHistoryData extends DataClass implements Insertable<ChatHistoryData> {
  final int id;
  final String role;
  final String content;
  final DateTime timestamp;
  final String languageCode;
  const ChatHistoryData(
      {required this.id,
      required this.role,
      required this.content,
      required this.timestamp,
      required this.languageCode});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['role'] = Variable<String>(role);
    map['content'] = Variable<String>(content);
    map['timestamp'] = Variable<DateTime>(timestamp);
    map['language_code'] = Variable<String>(languageCode);
    return map;
  }

  ChatHistoryCompanion toCompanion(bool nullToAbsent) {
    return ChatHistoryCompanion(
      id: Value(id),
      role: Value(role),
      content: Value(content),
      timestamp: Value(timestamp),
      languageCode: Value(languageCode),
    );
  }

  factory ChatHistoryData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ChatHistoryData(
      id: serializer.fromJson<int>(json['id']),
      role: serializer.fromJson<String>(json['role']),
      content: serializer.fromJson<String>(json['content']),
      timestamp: serializer.fromJson<DateTime>(json['timestamp']),
      languageCode: serializer.fromJson<String>(json['languageCode']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'role': serializer.toJson<String>(role),
      'content': serializer.toJson<String>(content),
      'timestamp': serializer.toJson<DateTime>(timestamp),
      'languageCode': serializer.toJson<String>(languageCode),
    };
  }

  ChatHistoryData copyWith(
          {int? id,
          String? role,
          String? content,
          DateTime? timestamp,
          String? languageCode}) =>
      ChatHistoryData(
        id: id ?? this.id,
        role: role ?? this.role,
        content: content ?? this.content,
        timestamp: timestamp ?? this.timestamp,
        languageCode: languageCode ?? this.languageCode,
      );
  ChatHistoryData copyWithCompanion(ChatHistoryCompanion data) {
    return ChatHistoryData(
      id: data.id.present ? data.id.value : this.id,
      role: data.role.present ? data.role.value : this.role,
      content: data.content.present ? data.content.value : this.content,
      timestamp: data.timestamp.present ? data.timestamp.value : this.timestamp,
      languageCode: data.languageCode.present
          ? data.languageCode.value
          : this.languageCode,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ChatHistoryData(')
          ..write('id: $id, ')
          ..write('role: $role, ')
          ..write('content: $content, ')
          ..write('timestamp: $timestamp, ')
          ..write('languageCode: $languageCode')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, role, content, timestamp, languageCode);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ChatHistoryData &&
          other.id == this.id &&
          other.role == this.role &&
          other.content == this.content &&
          other.timestamp == this.timestamp &&
          other.languageCode == this.languageCode);
}

class ChatHistoryCompanion extends UpdateCompanion<ChatHistoryData> {
  final Value<int> id;
  final Value<String> role;
  final Value<String> content;
  final Value<DateTime> timestamp;
  final Value<String> languageCode;
  const ChatHistoryCompanion({
    this.id = const Value.absent(),
    this.role = const Value.absent(),
    this.content = const Value.absent(),
    this.timestamp = const Value.absent(),
    this.languageCode = const Value.absent(),
  });
  ChatHistoryCompanion.insert({
    this.id = const Value.absent(),
    required String role,
    required String content,
    required DateTime timestamp,
    this.languageCode = const Value.absent(),
  })  : role = Value(role),
        content = Value(content),
        timestamp = Value(timestamp);
  static Insertable<ChatHistoryData> custom({
    Expression<int>? id,
    Expression<String>? role,
    Expression<String>? content,
    Expression<DateTime>? timestamp,
    Expression<String>? languageCode,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (role != null) 'role': role,
      if (content != null) 'content': content,
      if (timestamp != null) 'timestamp': timestamp,
      if (languageCode != null) 'language_code': languageCode,
    });
  }

  ChatHistoryCompanion copyWith(
      {Value<int>? id,
      Value<String>? role,
      Value<String>? content,
      Value<DateTime>? timestamp,
      Value<String>? languageCode}) {
    return ChatHistoryCompanion(
      id: id ?? this.id,
      role: role ?? this.role,
      content: content ?? this.content,
      timestamp: timestamp ?? this.timestamp,
      languageCode: languageCode ?? this.languageCode,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (role.present) {
      map['role'] = Variable<String>(role.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (timestamp.present) {
      map['timestamp'] = Variable<DateTime>(timestamp.value);
    }
    if (languageCode.present) {
      map['language_code'] = Variable<String>(languageCode.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ChatHistoryCompanion(')
          ..write('id: $id, ')
          ..write('role: $role, ')
          ..write('content: $content, ')
          ..write('timestamp: $timestamp, ')
          ..write('languageCode: $languageCode')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $VocabularyCardsTable vocabularyCards =
      $VocabularyCardsTable(this);
  late final $ReviewSessionsTable reviewSessions = $ReviewSessionsTable(this);
  late final $StrokeTemplatesTable strokeTemplates =
      $StrokeTemplatesTable(this);
  late final $ChatHistoryTable chatHistory = $ChatHistoryTable(this);
  late final SrsDao srsDao = SrsDao(this as AppDatabase);
  late final SessionDao sessionDao = SessionDao(this as AppDatabase);
  late final StrokeDao strokeDao = StrokeDao(this as AppDatabase);
  late final ChatDao chatDao = ChatDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [vocabularyCards, reviewSessions, strokeTemplates, chatHistory];
}

typedef $$VocabularyCardsTableCreateCompanionBuilder = VocabularyCardsCompanion
    Function({
  Value<int> id,
  required String word,
  required String reading,
  required String meaning,
  Value<String?> exampleSentence,
  Value<int> jlptLevel,
  Value<String> languageCode,
  Value<double> stability,
  Value<double> difficulty,
  Value<double> retrievability,
  Value<int> reps,
  Value<double> easinessFactor,
  Value<int> interval,
  Value<DateTime> nextReviewDate,
  Value<DateTime?> lastReviewDate,
  Value<String> tags,
});
typedef $$VocabularyCardsTableUpdateCompanionBuilder = VocabularyCardsCompanion
    Function({
  Value<int> id,
  Value<String> word,
  Value<String> reading,
  Value<String> meaning,
  Value<String?> exampleSentence,
  Value<int> jlptLevel,
  Value<String> languageCode,
  Value<double> stability,
  Value<double> difficulty,
  Value<double> retrievability,
  Value<int> reps,
  Value<double> easinessFactor,
  Value<int> interval,
  Value<DateTime> nextReviewDate,
  Value<DateTime?> lastReviewDate,
  Value<String> tags,
});

class $$VocabularyCardsTableFilterComposer
    extends Composer<_$AppDatabase, $VocabularyCardsTable> {
  $$VocabularyCardsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get word => $composableBuilder(
      column: $table.word, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get reading => $composableBuilder(
      column: $table.reading, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get meaning => $composableBuilder(
      column: $table.meaning, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get exampleSentence => $composableBuilder(
      column: $table.exampleSentence,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get jlptLevel => $composableBuilder(
      column: $table.jlptLevel, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get languageCode => $composableBuilder(
      column: $table.languageCode, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get stability => $composableBuilder(
      column: $table.stability, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get difficulty => $composableBuilder(
      column: $table.difficulty, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get retrievability => $composableBuilder(
      column: $table.retrievability,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get reps => $composableBuilder(
      column: $table.reps, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get easinessFactor => $composableBuilder(
      column: $table.easinessFactor,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get interval => $composableBuilder(
      column: $table.interval, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get nextReviewDate => $composableBuilder(
      column: $table.nextReviewDate,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get lastReviewDate => $composableBuilder(
      column: $table.lastReviewDate,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get tags => $composableBuilder(
      column: $table.tags, builder: (column) => ColumnFilters(column));
}

class $$VocabularyCardsTableOrderingComposer
    extends Composer<_$AppDatabase, $VocabularyCardsTable> {
  $$VocabularyCardsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get word => $composableBuilder(
      column: $table.word, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get reading => $composableBuilder(
      column: $table.reading, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get meaning => $composableBuilder(
      column: $table.meaning, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get exampleSentence => $composableBuilder(
      column: $table.exampleSentence,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get jlptLevel => $composableBuilder(
      column: $table.jlptLevel, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get languageCode => $composableBuilder(
      column: $table.languageCode,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get stability => $composableBuilder(
      column: $table.stability, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get difficulty => $composableBuilder(
      column: $table.difficulty, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get retrievability => $composableBuilder(
      column: $table.retrievability,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get reps => $composableBuilder(
      column: $table.reps, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get easinessFactor => $composableBuilder(
      column: $table.easinessFactor,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get interval => $composableBuilder(
      column: $table.interval, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get nextReviewDate => $composableBuilder(
      column: $table.nextReviewDate,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get lastReviewDate => $composableBuilder(
      column: $table.lastReviewDate,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get tags => $composableBuilder(
      column: $table.tags, builder: (column) => ColumnOrderings(column));
}

class $$VocabularyCardsTableAnnotationComposer
    extends Composer<_$AppDatabase, $VocabularyCardsTable> {
  $$VocabularyCardsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get word =>
      $composableBuilder(column: $table.word, builder: (column) => column);

  GeneratedColumn<String> get reading =>
      $composableBuilder(column: $table.reading, builder: (column) => column);

  GeneratedColumn<String> get meaning =>
      $composableBuilder(column: $table.meaning, builder: (column) => column);

  GeneratedColumn<String> get exampleSentence => $composableBuilder(
      column: $table.exampleSentence, builder: (column) => column);

  GeneratedColumn<int> get jlptLevel =>
      $composableBuilder(column: $table.jlptLevel, builder: (column) => column);

  GeneratedColumn<String> get languageCode => $composableBuilder(
      column: $table.languageCode, builder: (column) => column);

  GeneratedColumn<double> get stability =>
      $composableBuilder(column: $table.stability, builder: (column) => column);

  GeneratedColumn<double> get difficulty => $composableBuilder(
      column: $table.difficulty, builder: (column) => column);

  GeneratedColumn<double> get retrievability => $composableBuilder(
      column: $table.retrievability, builder: (column) => column);

  GeneratedColumn<int> get reps =>
      $composableBuilder(column: $table.reps, builder: (column) => column);

  GeneratedColumn<double> get easinessFactor => $composableBuilder(
      column: $table.easinessFactor, builder: (column) => column);

  GeneratedColumn<int> get interval =>
      $composableBuilder(column: $table.interval, builder: (column) => column);

  GeneratedColumn<DateTime> get nextReviewDate => $composableBuilder(
      column: $table.nextReviewDate, builder: (column) => column);

  GeneratedColumn<DateTime> get lastReviewDate => $composableBuilder(
      column: $table.lastReviewDate, builder: (column) => column);

  GeneratedColumn<String> get tags =>
      $composableBuilder(column: $table.tags, builder: (column) => column);
}

class $$VocabularyCardsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $VocabularyCardsTable,
    VocabularyCard,
    $$VocabularyCardsTableFilterComposer,
    $$VocabularyCardsTableOrderingComposer,
    $$VocabularyCardsTableAnnotationComposer,
    $$VocabularyCardsTableCreateCompanionBuilder,
    $$VocabularyCardsTableUpdateCompanionBuilder,
    (
      VocabularyCard,
      BaseReferences<_$AppDatabase, $VocabularyCardsTable, VocabularyCard>
    ),
    VocabularyCard,
    PrefetchHooks Function()> {
  $$VocabularyCardsTableTableManager(
      _$AppDatabase db, $VocabularyCardsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$VocabularyCardsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$VocabularyCardsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$VocabularyCardsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> word = const Value.absent(),
            Value<String> reading = const Value.absent(),
            Value<String> meaning = const Value.absent(),
            Value<String?> exampleSentence = const Value.absent(),
            Value<int> jlptLevel = const Value.absent(),
            Value<String> languageCode = const Value.absent(),
            Value<double> stability = const Value.absent(),
            Value<double> difficulty = const Value.absent(),
            Value<double> retrievability = const Value.absent(),
            Value<int> reps = const Value.absent(),
            Value<double> easinessFactor = const Value.absent(),
            Value<int> interval = const Value.absent(),
            Value<DateTime> nextReviewDate = const Value.absent(),
            Value<DateTime?> lastReviewDate = const Value.absent(),
            Value<String> tags = const Value.absent(),
          }) =>
              VocabularyCardsCompanion(
            id: id,
            word: word,
            reading: reading,
            meaning: meaning,
            exampleSentence: exampleSentence,
            jlptLevel: jlptLevel,
            languageCode: languageCode,
            stability: stability,
            difficulty: difficulty,
            retrievability: retrievability,
            reps: reps,
            easinessFactor: easinessFactor,
            interval: interval,
            nextReviewDate: nextReviewDate,
            lastReviewDate: lastReviewDate,
            tags: tags,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String word,
            required String reading,
            required String meaning,
            Value<String?> exampleSentence = const Value.absent(),
            Value<int> jlptLevel = const Value.absent(),
            Value<String> languageCode = const Value.absent(),
            Value<double> stability = const Value.absent(),
            Value<double> difficulty = const Value.absent(),
            Value<double> retrievability = const Value.absent(),
            Value<int> reps = const Value.absent(),
            Value<double> easinessFactor = const Value.absent(),
            Value<int> interval = const Value.absent(),
            Value<DateTime> nextReviewDate = const Value.absent(),
            Value<DateTime?> lastReviewDate = const Value.absent(),
            Value<String> tags = const Value.absent(),
          }) =>
              VocabularyCardsCompanion.insert(
            id: id,
            word: word,
            reading: reading,
            meaning: meaning,
            exampleSentence: exampleSentence,
            jlptLevel: jlptLevel,
            languageCode: languageCode,
            stability: stability,
            difficulty: difficulty,
            retrievability: retrievability,
            reps: reps,
            easinessFactor: easinessFactor,
            interval: interval,
            nextReviewDate: nextReviewDate,
            lastReviewDate: lastReviewDate,
            tags: tags,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$VocabularyCardsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $VocabularyCardsTable,
    VocabularyCard,
    $$VocabularyCardsTableFilterComposer,
    $$VocabularyCardsTableOrderingComposer,
    $$VocabularyCardsTableAnnotationComposer,
    $$VocabularyCardsTableCreateCompanionBuilder,
    $$VocabularyCardsTableUpdateCompanionBuilder,
    (
      VocabularyCard,
      BaseReferences<_$AppDatabase, $VocabularyCardsTable, VocabularyCard>
    ),
    VocabularyCard,
    PrefetchHooks Function()>;
typedef $$ReviewSessionsTableCreateCompanionBuilder = ReviewSessionsCompanion
    Function({
  Value<int> id,
  required DateTime sessionDate,
  required int cardsReviewed,
  required int correctCount,
  Value<int> aiConversationSeconds,
  Value<int> writingPracticeCount,
  Value<String> languageCode,
});
typedef $$ReviewSessionsTableUpdateCompanionBuilder = ReviewSessionsCompanion
    Function({
  Value<int> id,
  Value<DateTime> sessionDate,
  Value<int> cardsReviewed,
  Value<int> correctCount,
  Value<int> aiConversationSeconds,
  Value<int> writingPracticeCount,
  Value<String> languageCode,
});

class $$ReviewSessionsTableFilterComposer
    extends Composer<_$AppDatabase, $ReviewSessionsTable> {
  $$ReviewSessionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get sessionDate => $composableBuilder(
      column: $table.sessionDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get cardsReviewed => $composableBuilder(
      column: $table.cardsReviewed, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get correctCount => $composableBuilder(
      column: $table.correctCount, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get aiConversationSeconds => $composableBuilder(
      column: $table.aiConversationSeconds,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get writingPracticeCount => $composableBuilder(
      column: $table.writingPracticeCount,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get languageCode => $composableBuilder(
      column: $table.languageCode, builder: (column) => ColumnFilters(column));
}

class $$ReviewSessionsTableOrderingComposer
    extends Composer<_$AppDatabase, $ReviewSessionsTable> {
  $$ReviewSessionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get sessionDate => $composableBuilder(
      column: $table.sessionDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get cardsReviewed => $composableBuilder(
      column: $table.cardsReviewed,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get correctCount => $composableBuilder(
      column: $table.correctCount,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get aiConversationSeconds => $composableBuilder(
      column: $table.aiConversationSeconds,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get writingPracticeCount => $composableBuilder(
      column: $table.writingPracticeCount,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get languageCode => $composableBuilder(
      column: $table.languageCode,
      builder: (column) => ColumnOrderings(column));
}

class $$ReviewSessionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ReviewSessionsTable> {
  $$ReviewSessionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get sessionDate => $composableBuilder(
      column: $table.sessionDate, builder: (column) => column);

  GeneratedColumn<int> get cardsReviewed => $composableBuilder(
      column: $table.cardsReviewed, builder: (column) => column);

  GeneratedColumn<int> get correctCount => $composableBuilder(
      column: $table.correctCount, builder: (column) => column);

  GeneratedColumn<int> get aiConversationSeconds => $composableBuilder(
      column: $table.aiConversationSeconds, builder: (column) => column);

  GeneratedColumn<int> get writingPracticeCount => $composableBuilder(
      column: $table.writingPracticeCount, builder: (column) => column);

  GeneratedColumn<String> get languageCode => $composableBuilder(
      column: $table.languageCode, builder: (column) => column);
}

class $$ReviewSessionsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ReviewSessionsTable,
    ReviewSession,
    $$ReviewSessionsTableFilterComposer,
    $$ReviewSessionsTableOrderingComposer,
    $$ReviewSessionsTableAnnotationComposer,
    $$ReviewSessionsTableCreateCompanionBuilder,
    $$ReviewSessionsTableUpdateCompanionBuilder,
    (
      ReviewSession,
      BaseReferences<_$AppDatabase, $ReviewSessionsTable, ReviewSession>
    ),
    ReviewSession,
    PrefetchHooks Function()> {
  $$ReviewSessionsTableTableManager(
      _$AppDatabase db, $ReviewSessionsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ReviewSessionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ReviewSessionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ReviewSessionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<DateTime> sessionDate = const Value.absent(),
            Value<int> cardsReviewed = const Value.absent(),
            Value<int> correctCount = const Value.absent(),
            Value<int> aiConversationSeconds = const Value.absent(),
            Value<int> writingPracticeCount = const Value.absent(),
            Value<String> languageCode = const Value.absent(),
          }) =>
              ReviewSessionsCompanion(
            id: id,
            sessionDate: sessionDate,
            cardsReviewed: cardsReviewed,
            correctCount: correctCount,
            aiConversationSeconds: aiConversationSeconds,
            writingPracticeCount: writingPracticeCount,
            languageCode: languageCode,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required DateTime sessionDate,
            required int cardsReviewed,
            required int correctCount,
            Value<int> aiConversationSeconds = const Value.absent(),
            Value<int> writingPracticeCount = const Value.absent(),
            Value<String> languageCode = const Value.absent(),
          }) =>
              ReviewSessionsCompanion.insert(
            id: id,
            sessionDate: sessionDate,
            cardsReviewed: cardsReviewed,
            correctCount: correctCount,
            aiConversationSeconds: aiConversationSeconds,
            writingPracticeCount: writingPracticeCount,
            languageCode: languageCode,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$ReviewSessionsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ReviewSessionsTable,
    ReviewSession,
    $$ReviewSessionsTableFilterComposer,
    $$ReviewSessionsTableOrderingComposer,
    $$ReviewSessionsTableAnnotationComposer,
    $$ReviewSessionsTableCreateCompanionBuilder,
    $$ReviewSessionsTableUpdateCompanionBuilder,
    (
      ReviewSession,
      BaseReferences<_$AppDatabase, $ReviewSessionsTable, ReviewSession>
    ),
    ReviewSession,
    PrefetchHooks Function()>;
typedef $$StrokeTemplatesTableCreateCompanionBuilder = StrokeTemplatesCompanion
    Function({
  Value<int> id,
  required String character,
  required String scriptType,
  required String strokesJson,
  required int strokeCount,
});
typedef $$StrokeTemplatesTableUpdateCompanionBuilder = StrokeTemplatesCompanion
    Function({
  Value<int> id,
  Value<String> character,
  Value<String> scriptType,
  Value<String> strokesJson,
  Value<int> strokeCount,
});

class $$StrokeTemplatesTableFilterComposer
    extends Composer<_$AppDatabase, $StrokeTemplatesTable> {
  $$StrokeTemplatesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get character => $composableBuilder(
      column: $table.character, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get scriptType => $composableBuilder(
      column: $table.scriptType, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get strokesJson => $composableBuilder(
      column: $table.strokesJson, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get strokeCount => $composableBuilder(
      column: $table.strokeCount, builder: (column) => ColumnFilters(column));
}

class $$StrokeTemplatesTableOrderingComposer
    extends Composer<_$AppDatabase, $StrokeTemplatesTable> {
  $$StrokeTemplatesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get character => $composableBuilder(
      column: $table.character, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get scriptType => $composableBuilder(
      column: $table.scriptType, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get strokesJson => $composableBuilder(
      column: $table.strokesJson, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get strokeCount => $composableBuilder(
      column: $table.strokeCount, builder: (column) => ColumnOrderings(column));
}

class $$StrokeTemplatesTableAnnotationComposer
    extends Composer<_$AppDatabase, $StrokeTemplatesTable> {
  $$StrokeTemplatesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get character =>
      $composableBuilder(column: $table.character, builder: (column) => column);

  GeneratedColumn<String> get scriptType => $composableBuilder(
      column: $table.scriptType, builder: (column) => column);

  GeneratedColumn<String> get strokesJson => $composableBuilder(
      column: $table.strokesJson, builder: (column) => column);

  GeneratedColumn<int> get strokeCount => $composableBuilder(
      column: $table.strokeCount, builder: (column) => column);
}

class $$StrokeTemplatesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $StrokeTemplatesTable,
    StrokeTemplate,
    $$StrokeTemplatesTableFilterComposer,
    $$StrokeTemplatesTableOrderingComposer,
    $$StrokeTemplatesTableAnnotationComposer,
    $$StrokeTemplatesTableCreateCompanionBuilder,
    $$StrokeTemplatesTableUpdateCompanionBuilder,
    (
      StrokeTemplate,
      BaseReferences<_$AppDatabase, $StrokeTemplatesTable, StrokeTemplate>
    ),
    StrokeTemplate,
    PrefetchHooks Function()> {
  $$StrokeTemplatesTableTableManager(
      _$AppDatabase db, $StrokeTemplatesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$StrokeTemplatesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$StrokeTemplatesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$StrokeTemplatesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> character = const Value.absent(),
            Value<String> scriptType = const Value.absent(),
            Value<String> strokesJson = const Value.absent(),
            Value<int> strokeCount = const Value.absent(),
          }) =>
              StrokeTemplatesCompanion(
            id: id,
            character: character,
            scriptType: scriptType,
            strokesJson: strokesJson,
            strokeCount: strokeCount,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String character,
            required String scriptType,
            required String strokesJson,
            required int strokeCount,
          }) =>
              StrokeTemplatesCompanion.insert(
            id: id,
            character: character,
            scriptType: scriptType,
            strokesJson: strokesJson,
            strokeCount: strokeCount,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$StrokeTemplatesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $StrokeTemplatesTable,
    StrokeTemplate,
    $$StrokeTemplatesTableFilterComposer,
    $$StrokeTemplatesTableOrderingComposer,
    $$StrokeTemplatesTableAnnotationComposer,
    $$StrokeTemplatesTableCreateCompanionBuilder,
    $$StrokeTemplatesTableUpdateCompanionBuilder,
    (
      StrokeTemplate,
      BaseReferences<_$AppDatabase, $StrokeTemplatesTable, StrokeTemplate>
    ),
    StrokeTemplate,
    PrefetchHooks Function()>;
typedef $$ChatHistoryTableCreateCompanionBuilder = ChatHistoryCompanion
    Function({
  Value<int> id,
  required String role,
  required String content,
  required DateTime timestamp,
  Value<String> languageCode,
});
typedef $$ChatHistoryTableUpdateCompanionBuilder = ChatHistoryCompanion
    Function({
  Value<int> id,
  Value<String> role,
  Value<String> content,
  Value<DateTime> timestamp,
  Value<String> languageCode,
});

class $$ChatHistoryTableFilterComposer
    extends Composer<_$AppDatabase, $ChatHistoryTable> {
  $$ChatHistoryTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get role => $composableBuilder(
      column: $table.role, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get content => $composableBuilder(
      column: $table.content, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get timestamp => $composableBuilder(
      column: $table.timestamp, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get languageCode => $composableBuilder(
      column: $table.languageCode, builder: (column) => ColumnFilters(column));
}

class $$ChatHistoryTableOrderingComposer
    extends Composer<_$AppDatabase, $ChatHistoryTable> {
  $$ChatHistoryTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get role => $composableBuilder(
      column: $table.role, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get content => $composableBuilder(
      column: $table.content, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get timestamp => $composableBuilder(
      column: $table.timestamp, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get languageCode => $composableBuilder(
      column: $table.languageCode,
      builder: (column) => ColumnOrderings(column));
}

class $$ChatHistoryTableAnnotationComposer
    extends Composer<_$AppDatabase, $ChatHistoryTable> {
  $$ChatHistoryTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get role =>
      $composableBuilder(column: $table.role, builder: (column) => column);

  GeneratedColumn<String> get content =>
      $composableBuilder(column: $table.content, builder: (column) => column);

  GeneratedColumn<DateTime> get timestamp =>
      $composableBuilder(column: $table.timestamp, builder: (column) => column);

  GeneratedColumn<String> get languageCode => $composableBuilder(
      column: $table.languageCode, builder: (column) => column);
}

class $$ChatHistoryTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ChatHistoryTable,
    ChatHistoryData,
    $$ChatHistoryTableFilterComposer,
    $$ChatHistoryTableOrderingComposer,
    $$ChatHistoryTableAnnotationComposer,
    $$ChatHistoryTableCreateCompanionBuilder,
    $$ChatHistoryTableUpdateCompanionBuilder,
    (
      ChatHistoryData,
      BaseReferences<_$AppDatabase, $ChatHistoryTable, ChatHistoryData>
    ),
    ChatHistoryData,
    PrefetchHooks Function()> {
  $$ChatHistoryTableTableManager(_$AppDatabase db, $ChatHistoryTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ChatHistoryTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ChatHistoryTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ChatHistoryTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> role = const Value.absent(),
            Value<String> content = const Value.absent(),
            Value<DateTime> timestamp = const Value.absent(),
            Value<String> languageCode = const Value.absent(),
          }) =>
              ChatHistoryCompanion(
            id: id,
            role: role,
            content: content,
            timestamp: timestamp,
            languageCode: languageCode,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String role,
            required String content,
            required DateTime timestamp,
            Value<String> languageCode = const Value.absent(),
          }) =>
              ChatHistoryCompanion.insert(
            id: id,
            role: role,
            content: content,
            timestamp: timestamp,
            languageCode: languageCode,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$ChatHistoryTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ChatHistoryTable,
    ChatHistoryData,
    $$ChatHistoryTableFilterComposer,
    $$ChatHistoryTableOrderingComposer,
    $$ChatHistoryTableAnnotationComposer,
    $$ChatHistoryTableCreateCompanionBuilder,
    $$ChatHistoryTableUpdateCompanionBuilder,
    (
      ChatHistoryData,
      BaseReferences<_$AppDatabase, $ChatHistoryTable, ChatHistoryData>
    ),
    ChatHistoryData,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$VocabularyCardsTableTableManager get vocabularyCards =>
      $$VocabularyCardsTableTableManager(_db, _db.vocabularyCards);
  $$ReviewSessionsTableTableManager get reviewSessions =>
      $$ReviewSessionsTableTableManager(_db, _db.reviewSessions);
  $$StrokeTemplatesTableTableManager get strokeTemplates =>
      $$StrokeTemplatesTableTableManager(_db, _db.strokeTemplates);
  $$ChatHistoryTableTableManager get chatHistory =>
      $$ChatHistoryTableTableManager(_db, _db.chatHistory);
}
