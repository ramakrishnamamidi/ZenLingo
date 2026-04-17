# Phase 1 — Foundation Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Build ZenLingo's database layer, SRS algorithms, vocabulary seeding, and app shell — the reactive spine everything else builds on.

**Architecture:** Drift SQLite with platform-aware connection factory; FSRS-4.5 + SM-2 algorithms behind a shared interface; Riverpod providers wire DB into state tree; VocabularyLoader seeds N5 JSON on first open.

**Tech Stack:** Flutter 3.3+, Dart 3.3+, drift 2.20, flutter_riverpod 2.5, sqlite3_flutter_libs, path_provider, path, shared_preferences

---

## File Map

| File | Action | Responsibility |
|------|--------|----------------|
| `zenlingo/pubspec.yaml` | Modify | Add all Phase 1 deps, upgrade SDK constraint |
| `zenlingo/lib/main.dart` | Modify | ProviderScope root, ZenApp with ZenTheme, stub nav shell |
| `zenlingo/lib/core/theme/zen_theme.dart` | Create | Full ThemeData (Japan Red dark theme) |
| `zenlingo/lib/core/config/app_config.dart` | Create | Feature flags + algorithm thresholds |
| `zenlingo/lib/core/srs/srs_algorithm.dart` | Create | Abstract `SrsAlgorithm` + `SrsGrade` enum |
| `zenlingo/lib/core/srs/sm2_algorithm.dart` | Create | SM-2 scheduling logic |
| `zenlingo/lib/core/srs/fsrs_algorithm.dart` | Create | FSRS-4.5 scheduling logic |
| `zenlingo/lib/data/database/tables/vocabulary_cards.dart` | Create | Drift table definition |
| `zenlingo/lib/data/database/tables/review_sessions.dart` | Create | Drift table definition |
| `zenlingo/lib/data/database/tables/stroke_templates.dart` | Create | Drift table definition (stub) |
| `zenlingo/lib/data/database/tables/chat_history.dart` | Create | Drift table definition (stub) |
| `zenlingo/lib/data/database/daos/srs_dao.dart` | Create | watchDueCards stream + updateCard |
| `zenlingo/lib/data/database/daos/session_dao.dart` | Create | insertSession + getLast365Days |
| `zenlingo/lib/data/database/daos/chat_dao.dart` | Create | Stub DAO |
| `zenlingo/lib/data/database/daos/stroke_dao.dart` | Create | Stub DAO |
| `zenlingo/lib/data/database/app_database.dart` | Create | @DriftDatabase + platform-aware openConnection() |
| `zenlingo/lib/data/loaders/vocabulary_loader.dart` | Create | Parse JSON asset → DB insert |
| `zenlingo/lib/core/providers/database_provider.dart` | Create | databaseProvider, srsDaoProvider, sessionDaoProvider |
| `zenlingo/lib/core/providers/srs_algorithm_provider.dart` | Create | srsAlgorithmProvider (FSRS or SM-2 based on AppConfig) |
| `zenlingo/assets/data/jp_n5.json` | Create | JLPT N5 vocabulary seed data |
| `zenlingo/test/core/srs/sm2_algorithm_test.dart` | Create | SM-2 unit tests |
| `zenlingo/test/core/srs/fsrs_algorithm_test.dart` | Create | FSRS unit tests |
| `zenlingo/test/data/database/srs_dao_test.dart` | Create | DAO tests with in-memory DB |
| `zenlingo/test/data/loaders/vocabulary_loader_test.dart` | Create | Loader tests with mock DB |

---

## Task 1: Upgrade pubspec.yaml

**Files:**
- Modify: `zenlingo/pubspec.yaml`

- [ ] **Step 1: Replace pubspec.yaml**

```yaml
name: zenlingo
description: Minimalist local-first Japanese language learning app
publish_to: 'none'
version: 0.1.0+1

environment:
  sdk: '>=3.3.0 <4.0.0'
  flutter: '>=3.22.0'

dependencies:
  flutter:
    sdk: flutter
  flutter_localizations:
    sdk: flutter
  # State
  flutter_riverpod: ^2.5.1
  riverpod_annotation: ^2.3.5
  # Database
  drift: ^2.20.0
  sqlite3_flutter_libs: ^0.5.0
  path_provider: ^2.1.0
  path: ^1.9.0
  # Utils
  intl: ^0.19.0
  shared_preferences: ^2.2.0

dev_dependencies:
  flutter_test:
    sdk: flutter
  drift_dev: ^2.20.0
  build_runner: ^2.4.0
  riverpod_generator: ^2.4.0
  riverpod_lint: ^2.3.0
  flutter_lints: ^4.0.0

flutter:
  uses-material-design: true
  generate: true
  assets:
    - assets/data/
  fonts:
    - family: NotoSansJP
      fonts:
        - asset: assets/fonts/NotoSansJP-Regular.ttf
```

- [ ] **Step 2: Run pub get**

```bash
cd zenlingo
flutter pub get
```

Expected: No errors. Packages resolve successfully.

- [ ] **Step 3: Commit**

```bash
git add zenlingo/pubspec.yaml zenlingo/pubspec.lock
git commit -m "build: upgrade SDK to Dart 3.3+, add drift/riverpod dependencies"
```

---

## Task 2: Create Directory Skeleton + Asset Placeholders

**Files:**
- Create directories and stub asset files

- [ ] **Step 1: Create all directories**

```bash
mkdir -p zenlingo/lib/core/theme
mkdir -p zenlingo/lib/core/config
mkdir -p zenlingo/lib/core/srs
mkdir -p zenlingo/lib/core/providers
mkdir -p zenlingo/lib/data/database/tables
mkdir -p zenlingo/lib/data/database/daos
mkdir -p zenlingo/lib/data/loaders
mkdir -p zenlingo/assets/data
mkdir -p zenlingo/assets/fonts
mkdir -p zenlingo/test/core/srs
mkdir -p zenlingo/test/data/database
mkdir -p zenlingo/test/data/loaders
```

- [ ] **Step 2: Commit**

```bash
git add zenlingo/
git commit -m "build: create directory skeleton for Phase 1"
```

---

## Task 3: ZenTheme + AppConfig

**Files:**
- Create: `zenlingo/lib/core/theme/zen_theme.dart`
- Create: `zenlingo/lib/core/config/app_config.dart`

- [ ] **Step 1: Create zen_theme.dart**

```dart
// lib/core/theme/zen_theme.dart
import 'package:flutter/material.dart';

class ZenTheme {
  static const Color accentRed = Color(0xFFBC002D);
  static const Color bgBlack = Color(0xFF0D0D0D);
  static const Color bgSurface = Color(0xFF1A1A1A);
  static const Color textPrimary = Color(0xFFF5F5F0);
  static const Color textSecondary = Color(0xFF8A8A8A);
  static const Color strokeCorrect = Color(0xFF4CAF50);
  static const Color strokeIncorrect = Color(0xFFE53935);
  static const Color heatmapMin = Color(0xFF2A1A1A);
  static const Color heatmapMax = accentRed;

  static ThemeData get dark => ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: bgBlack,
    colorScheme: const ColorScheme.dark(
      primary: accentRed,
      surface: bgSurface,
      onPrimary: Color(0xFFF5F5F0),
    ),
    fontFamily: 'NotoSansJP',
    textTheme: const TextTheme(
      displayLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.w300, letterSpacing: -0.5),
      titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
      bodyMedium: TextStyle(fontSize: 16, height: 1.6),
      labelSmall: TextStyle(fontSize: 11, letterSpacing: 1.2, color: Color(0xFF8A8A8A)),
    ),
    cardTheme: const CardTheme(
      color: bgSurface,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: bgBlack,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        letterSpacing: 2.0,
        color: Color(0xFFF5F5F0),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: accentRed,
        foregroundColor: Colors.white,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
        minimumSize: const Size(double.infinity, 52),
      ),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      filled: true,
      fillColor: bgSurface,
      border: OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xFF2A2A2A)),
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: accentRed),
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
    ),
  );
}
```

- [ ] **Step 2: Create app_config.dart**

```dart
// lib/core/config/app_config.dart
class AppConfig {
  static bool useFsrs = true;
  static bool aiChatEnabled = false;
  static String activeLanguage = 'ja';
  static double strokeCorrectThreshold = 0.75;
  static int dailyNewCardLimit = 20;
  static int dailyReviewCardLimit = 150;
}
```

- [ ] **Step 3: Commit**

```bash
git add zenlingo/lib/core/theme/ zenlingo/lib/core/config/
git commit -m "feat: add ZenTheme dark theme and AppConfig feature flags"
```

---

## Task 4: Drift Table Definitions

**Files:**
- Create: `zenlingo/lib/data/database/tables/vocabulary_cards.dart`
- Create: `zenlingo/lib/data/database/tables/review_sessions.dart`
- Create: `zenlingo/lib/data/database/tables/stroke_templates.dart`
- Create: `zenlingo/lib/data/database/tables/chat_history.dart`

- [ ] **Step 1: Create vocabulary_cards.dart**

```dart
// lib/data/database/tables/vocabulary_cards.dart
import 'package:drift/drift.dart';

class VocabularyCards extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get word => text().withLength(min: 1, max: 50)();
  TextColumn get reading => text()();
  TextColumn get meaning => text()();
  TextColumn get exampleSentence => text().nullable()();
  IntColumn get jlptLevel => integer().withDefault(const Constant(5))();
  TextColumn get languageCode => text().withDefault(const Constant('ja'))();

  // FSRS fields
  RealColumn get stability => real().withDefault(const Constant(1.0))();
  RealColumn get difficulty => real().withDefault(const Constant(5.0))();
  RealColumn get retrievability => real().withDefault(const Constant(1.0))();
  IntColumn get reps => integer().withDefault(const Constant(0))();

  // SM-2 fallback fields
  RealColumn get easinessFactor => real().withDefault(const Constant(2.5))();
  IntColumn get interval => integer().withDefault(const Constant(1))();

  DateTimeColumn get nextReviewDate =>
      dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get lastReviewDate => dateTime().nullable()();
  TextColumn get tags => text().withDefault(const Constant('[]'))();
}
```

- [ ] **Step 2: Create review_sessions.dart**

```dart
// lib/data/database/tables/review_sessions.dart
import 'package:drift/drift.dart';

class ReviewSessions extends Table {
  IntColumn get id => integer().autoIncrement()();
  DateTimeColumn get sessionDate => dateTime()();
  IntColumn get cardsReviewed => integer()();
  IntColumn get correctCount => integer()();
  IntColumn get aiConversationSeconds =>
      integer().withDefault(const Constant(0))();
  IntColumn get writingPracticeCount =>
      integer().withDefault(const Constant(0))();
  TextColumn get languageCode =>
      text().withDefault(const Constant('ja'))();
}
```

- [ ] **Step 3: Create stroke_templates.dart**

```dart
// lib/data/database/tables/stroke_templates.dart
import 'package:drift/drift.dart';

class StrokeTemplates extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get character => text()();
  TextColumn get scriptType => text()(); // hiragana, katakana, kanji
  TextColumn get strokesJson => text()(); // JSON serialized strokes array
  IntColumn get strokeCount => integer()();
}
```

- [ ] **Step 4: Create chat_history.dart**

```dart
// lib/data/database/tables/chat_history.dart
import 'package:drift/drift.dart';

class ChatHistory extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get role => text()(); // user | assistant
  TextColumn get content => text()();
  DateTimeColumn get timestamp => dateTime()();
  TextColumn get languageCode =>
      text().withDefault(const Constant('ja'))();
}
```

- [ ] **Step 5: Commit**

```bash
git add zenlingo/lib/data/database/tables/
git commit -m "feat: define all four Drift table schemas"
```

---

## Task 5: DAOs

**Files:**
- Create: `zenlingo/lib/data/database/daos/srs_dao.dart`
- Create: `zenlingo/lib/data/database/daos/session_dao.dart`
- Create: `zenlingo/lib/data/database/daos/stroke_dao.dart`
- Create: `zenlingo/lib/data/database/daos/chat_dao.dart`

- [ ] **Step 1: Create srs_dao.dart**

```dart
// lib/data/database/daos/srs_dao.dart
import 'package:drift/drift.dart';
import '../app_database.dart';
import '../tables/vocabulary_cards.dart';

part 'srs_dao.g.dart';

@DriftAccessor(tables: [VocabularyCards])
class SrsDao extends DatabaseAccessor<AppDatabase> with _$SrsDaoMixin {
  SrsDao(super.db);

  Stream<List<VocabularyCard>> watchDueCards() {
    return (select(vocabularyCards)
          ..where((c) => c.nextReviewDate.isSmallerOrEqualValue(DateTime.now()))
          ..orderBy([(c) => OrderingTerm(expression: c.nextReviewDate)])
          ..limit(50))
        .watch();
  }

  Future<List<VocabularyCard>> getDueCards() {
    return (select(vocabularyCards)
          ..where((c) => c.nextReviewDate.isSmallerOrEqualValue(DateTime.now()))
          ..orderBy([(c) => OrderingTerm(expression: c.nextReviewDate)])
          ..limit(50))
        .get();
  }

  Future<void> updateCard(VocabularyCard card) {
    return (update(vocabularyCards)..where((c) => c.id.equals(card.id))).write(
      VocabularyCardsCompanion(
        stability: Value(card.stability),
        difficulty: Value(card.difficulty),
        retrievability: Value(card.retrievability),
        reps: Value(card.reps),
        interval: Value(card.interval),
        easinessFactor: Value(card.easinessFactor),
        nextReviewDate: Value(card.nextReviewDate),
        lastReviewDate: Value(card.lastReviewDate),
      ),
    );
  }

  Future<int> insertCard(VocabularyCardsCompanion card) {
    return into(vocabularyCards).insert(card);
  }

  Future<int> countAllCards() async {
    final count = vocabularyCards.id.count();
    final query = selectOnly(vocabularyCards)..addColumns([count]);
    final row = await query.getSingle();
    return row.read(count) ?? 0;
  }
}
```

- [ ] **Step 2: Create session_dao.dart**

```dart
// lib/data/database/daos/session_dao.dart
import 'package:drift/drift.dart';
import '../app_database.dart';
import '../tables/review_sessions.dart';

part 'session_dao.g.dart';

@DriftAccessor(tables: [ReviewSessions])
class SessionDao extends DatabaseAccessor<AppDatabase> with _$SessionDaoMixin {
  SessionDao(super.db);

  Future<int> insertSession(ReviewSessionsCompanion session) {
    return into(reviewSessions).insert(session);
  }

  Future<List<ReviewSession>> getLast365Days() {
    final cutoff = DateTime.now().subtract(const Duration(days: 365));
    return (select(reviewSessions)
          ..where((s) => s.sessionDate.isBiggerOrEqualValue(cutoff))
          ..orderBy([(s) => OrderingTerm(expression: s.sessionDate)]))
        .get();
  }
}
```

- [ ] **Step 3: Create stroke_dao.dart**

```dart
// lib/data/database/daos/stroke_dao.dart
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
```

- [ ] **Step 4: Create chat_dao.dart**

```dart
// lib/data/database/daos/chat_dao.dart
import 'package:drift/drift.dart';
import '../app_database.dart';
import '../tables/chat_history.dart';

part 'chat_dao.g.dart';

@DriftAccessor(tables: [ChatHistory])
class ChatDao extends DatabaseAccessor<AppDatabase> with _$ChatDaoMixin {
  ChatDao(super.db);

  Future<int> insertMessage(ChatHistoryCompanion message) {
    return into(chatHistory).insert(message);
  }

  Future<List<ChatHistoryData>> getRecentMessages({int limit = 20}) {
    return (select(chatHistory)
          ..orderBy([(m) => OrderingTerm.desc(m.timestamp)])
          ..limit(limit))
        .get();
  }
}
```

- [ ] **Step 5: Commit**

```bash
git add zenlingo/lib/data/database/daos/
git commit -m "feat: add SrsDao, SessionDao, StrokeDao, ChatDao"
```

---

## Task 6: AppDatabase + Code Generation

**Files:**
- Create: `zenlingo/lib/data/database/app_database.dart`

- [ ] **Step 1: Create app_database.dart**

```dart
// lib/data/database/app_database.dart
import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import 'tables/vocabulary_cards.dart';
import 'tables/review_sessions.dart';
import 'tables/stroke_templates.dart';
import 'tables/chat_history.dart';
import 'daos/srs_dao.dart';
import 'daos/session_dao.dart';
import 'daos/stroke_dao.dart';
import 'daos/chat_dao.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [VocabularyCards, ReviewSessions, StrokeTemplates, ChatHistory],
  daos: [SrsDao, SessionDao, StrokeDao, ChatDao],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase(super.e);

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onUpgrade: (m, from, to) async {
      // All new columns must be nullable to avoid breaking existing records
    },
    beforeOpen: (details) async {
      if (details.wasCreated) {
        await VocabularyLoader(this).seedFromAssets();
      }
    },
  );
}

QueryExecutor openConnection() {
  if (kIsWeb) {
    // Web: WASM + IndexedDB — configured in Phase 5
    throw UnimplementedError('Web support added in Phase 5');
  }
  return LazyDatabase(() async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File(p.join(dir.path, 'zenlingo.db'));
    return NativeDatabase(file);
  });
}
```

> Note: `VocabularyLoader` import added after Task 8. Leave import commented out until then to avoid compile error:
> `// import '../../loaders/vocabulary_loader.dart';`
> Replace the `beforeOpen` body with `// TODO: seed` until Task 8 complete.

- [ ] **Step 2: Run code generation**

```bash
cd zenlingo
dart run build_runner build --delete-conflicting-outputs
```

Expected output: Creates `app_database.g.dart`, `srs_dao.g.dart`, `session_dao.g.dart`, `stroke_dao.g.dart`, `chat_dao.g.dart`.

If error `part 'xxx.g.dart' has no matching 'part of'` — check each DAO file has `part 'xxx.g.dart';` exactly matching filename.

- [ ] **Step 3: Verify compilation**

```bash
flutter analyze lib/data/
```

Expected: No errors.

- [ ] **Step 4: Commit**

```bash
git add zenlingo/lib/data/database/app_database.dart zenlingo/lib/data/database/**/*.g.dart
git commit -m "feat: AppDatabase with Drift codegen, platform-aware connection factory"
```

---

## Task 7: SRS Algorithm Abstraction + SM-2 (TDD)

**Files:**
- Create: `zenlingo/lib/core/srs/srs_algorithm.dart`
- Create: `zenlingo/lib/core/srs/sm2_algorithm.dart`
- Test: `zenlingo/test/core/srs/sm2_algorithm_test.dart`

- [ ] **Step 1: Create srs_algorithm.dart**

```dart
// lib/core/srs/srs_algorithm.dart
import '../../data/database/app_database.dart';

enum SrsGrade { again, hard, good, easy }

abstract class SrsAlgorithm {
  /// Returns updated card with new scheduling fields.
  VocabularyCard schedule(VocabularyCard card, SrsGrade grade);
}
```

- [ ] **Step 2: Write failing SM-2 tests**

```dart
// test/core/srs/sm2_algorithm_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:zenlingo/core/srs/srs_algorithm.dart';
import 'package:zenlingo/core/srs/sm2_algorithm.dart';
import 'package:zenlingo/data/database/app_database.dart';
import 'package:drift/native.dart';

VocabularyCard makeCard({
  int reps = 0,
  double easinessFactor = 2.5,
  int interval = 1,
  DateTime? lastReview,
}) {
  final db = AppDatabase(NativeDatabase.memory());
  // Build a minimal card using the generated companion
  return VocabularyCard(
    id: 1,
    word: 'テスト',
    reading: 'てすと',
    meaning: 'test',
    exampleSentence: null,
    jlptLevel: 5,
    languageCode: 'ja',
    stability: 1.0,
    difficulty: 5.0,
    retrievability: 1.0,
    reps: reps,
    easinessFactor: easinessFactor,
    interval: interval,
    nextReviewDate: DateTime.now(),
    lastReviewDate: lastReview,
    tags: '[]',
  );
}

void main() {
  late Sm2Algorithm algo;

  setUp(() {
    algo = Sm2Algorithm();
  });

  group('new card (reps == 0)', () {
    test('again resets interval to 1', () {
      final card = makeCard(reps: 0);
      final result = algo.schedule(card, SrsGrade.again);
      expect(result.interval, 1);
      expect(result.reps, 0);
    });

    test('good sets interval to 1', () {
      final card = makeCard(reps: 0);
      final result = algo.schedule(card, SrsGrade.good);
      expect(result.interval, 1);
      expect(result.reps, 1);
    });

    test('easy sets interval to 4', () {
      final card = makeCard(reps: 0);
      final result = algo.schedule(card, SrsGrade.easy);
      expect(result.interval, 4);
      expect(result.reps, 1);
    });
  });

  group('second review (reps == 1)', () {
    test('good sets interval to 6', () {
      final card = makeCard(
        reps: 1,
        interval: 1,
        lastReview: DateTime.now().subtract(const Duration(days: 1)),
      );
      final result = algo.schedule(card, SrsGrade.good);
      expect(result.interval, 6);
      expect(result.reps, 2);
    });
  });

  group('subsequent reviews (reps >= 2)', () {
    test('good multiplies interval by EF', () {
      final card = makeCard(
        reps: 2,
        easinessFactor: 2.5,
        interval: 6,
        lastReview: DateTime.now().subtract(const Duration(days: 6)),
      );
      final result = algo.schedule(card, SrsGrade.good);
      expect(result.interval, 15); // 6 * 2.5 = 15
    });

    test('again resets reps and interval', () {
      final card = makeCard(
        reps: 5,
        easinessFactor: 2.5,
        interval: 30,
        lastReview: DateTime.now().subtract(const Duration(days: 30)),
      );
      final result = algo.schedule(card, SrsGrade.again);
      expect(result.reps, 0);
      expect(result.interval, 1);
    });

    test('EF decreases with hard grade', () {
      final card = makeCard(reps: 3, easinessFactor: 2.5, interval: 10);
      final result = algo.schedule(card, SrsGrade.hard);
      expect(result.easinessFactor, lessThan(2.5));
      expect(result.easinessFactor, greaterThanOrEqualTo(1.3));
    });

    test('EF increases with easy grade', () {
      final card = makeCard(reps: 3, easinessFactor: 2.5, interval: 10);
      final result = algo.schedule(card, SrsGrade.easy);
      expect(result.easinessFactor, greaterThan(2.5));
    });

    test('EF never drops below 1.3', () {
      final card = makeCard(reps: 10, easinessFactor: 1.3, interval: 5);
      final result = algo.schedule(card, SrsGrade.hard);
      expect(result.easinessFactor, greaterThanOrEqualTo(1.3));
    });
  });

  test('nextReviewDate is in the future', () {
    final card = makeCard(reps: 0);
    final result = algo.schedule(card, SrsGrade.good);
    expect(result.nextReviewDate.isAfter(DateTime.now()), isTrue);
  });
}
```

- [ ] **Step 3: Run tests — verify they fail**

```bash
cd zenlingo
flutter test test/core/srs/sm2_algorithm_test.dart
```

Expected: FAIL — `Sm2Algorithm` not found.

- [ ] **Step 4: Implement sm2_algorithm.dart**

```dart
// lib/core/srs/sm2_algorithm.dart
import 'dart:math';
import '../../data/database/app_database.dart';
import 'srs_algorithm.dart';

class Sm2Algorithm implements SrsAlgorithm {
  // Maps SrsGrade to SM-2 quality score (0–5)
  static const Map<SrsGrade, int> _qualityMap = {
    SrsGrade.again: 1,
    SrsGrade.hard: 3,
    SrsGrade.good: 4,
    SrsGrade.easy: 5,
  };

  @override
  VocabularyCard schedule(VocabularyCard card, SrsGrade grade) {
    final q = _qualityMap[grade]!;

    if (q < 3) {
      // Forgot — reset repetitions
      return card.copyWith(
        reps: 0,
        interval: 1,
        lastReviewDate: Value(DateTime.now()),
        nextReviewDate: DateTime.now().add(const Duration(days: 1)),
      );
    }

    // EF' = max(1.3, EF + 0.1 - (5-q)(0.08 + (5-q)*0.02))
    final newEf = max(
      1.3,
      card.easinessFactor +
          0.1 -
          (5 - q) * (0.08 + (5 - q) * 0.02),
    );

    final newReps = card.reps + 1;
    final int newInterval;

    if (newReps == 1) {
      newInterval = grade == SrsGrade.easy ? 4 : 1;
    } else if (newReps == 2) {
      newInterval = 6;
    } else {
      newInterval = (card.interval * newEf).round();
    }

    return card.copyWith(
      reps: newReps,
      easinessFactor: newEf,
      interval: newInterval,
      lastReviewDate: Value(DateTime.now()),
      nextReviewDate: DateTime.now().add(Duration(days: newInterval)),
    );
  }
}
```

> Note: `card.copyWith(lastReviewDate: Value(DateTime.now()))` — Drift-generated `copyWith` uses `Value<T>` wrapper for nullable fields. Non-nullable fields use plain value.

- [ ] **Step 5: Run tests — verify pass**

```bash
flutter test test/core/srs/sm2_algorithm_test.dart
```

Expected: All tests PASS.

- [ ] **Step 6: Commit**

```bash
git add zenlingo/lib/core/srs/ zenlingo/test/core/srs/sm2_algorithm_test.dart
git commit -m "feat: SRS algorithm abstraction + SM-2 implementation with tests"
```

---

## Task 8: FSRS-4.5 Algorithm (TDD)

**Files:**
- Create: `zenlingo/lib/core/srs/fsrs_algorithm.dart`
- Test: `zenlingo/test/core/srs/fsrs_algorithm_test.dart`

- [ ] **Step 1: Write failing FSRS tests**

```dart
// test/core/srs/fsrs_algorithm_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:zenlingo/core/srs/srs_algorithm.dart';
import 'package:zenlingo/core/srs/fsrs_algorithm.dart';
import 'package:zenlingo/data/database/app_database.dart';

VocabularyCard makeCard({
  int reps = 0,
  double stability = 1.0,
  double difficulty = 5.0,
  double retrievability = 1.0,
  int interval = 1,
  DateTime? lastReview,
}) =>
    VocabularyCard(
      id: 1,
      word: 'テスト',
      reading: 'てすと',
      meaning: 'test',
      exampleSentence: null,
      jlptLevel: 5,
      languageCode: 'ja',
      stability: stability,
      difficulty: difficulty,
      retrievability: retrievability,
      reps: reps,
      easinessFactor: 2.5,
      interval: interval,
      nextReviewDate: DateTime.now(),
      lastReviewDate: lastReview,
      tags: '[]',
    );

void main() {
  late FsrsAlgorithm algo;

  setUp(() {
    algo = FsrsAlgorithm();
  });

  group('new card (reps == 0)', () {
    test('again: low stability (~0.4 days)', () {
      final result = algo.schedule(makeCard(), SrsGrade.again);
      expect(result.stability, closeTo(0.41, 0.1));
      expect(result.interval, 1);
      expect(result.reps, 1);
    });

    test('good: medium stability (~3.1 days)', () {
      final result = algo.schedule(makeCard(), SrsGrade.good);
      expect(result.stability, closeTo(3.1, 0.5));
      expect(result.interval, greaterThanOrEqualTo(3));
    });

    test('easy: high stability (~15 days)', () {
      final result = algo.schedule(makeCard(), SrsGrade.easy);
      expect(result.stability, closeTo(15.5, 2.0));
      expect(result.interval, greaterThanOrEqualTo(12));
    });

    test('difficulty initialized from grade', () {
      final goodResult = algo.schedule(makeCard(), SrsGrade.good);
      final easyResult = algo.schedule(makeCard(), SrsGrade.easy);
      // Good grade → harder initial difficulty than easy grade
      expect(goodResult.difficulty, greaterThan(easyResult.difficulty));
    });
  });

  group('review card (reps > 0)', () {
    test('good review increases stability', () {
      final card = makeCard(
        reps: 3,
        stability: 10.0,
        difficulty: 5.0,
        lastReview: DateTime.now().subtract(const Duration(days: 10)),
      );
      final result = algo.schedule(card, SrsGrade.good);
      expect(result.stability, greaterThan(card.stability));
    });

    test('again review decreases stability', () {
      final card = makeCard(
        reps: 3,
        stability: 10.0,
        difficulty: 5.0,
        lastReview: DateTime.now().subtract(const Duration(days: 10)),
      );
      final result = algo.schedule(card, SrsGrade.again);
      expect(result.stability, lessThan(card.stability));
    });

    test('easy review produces longer interval than good', () {
      final card = makeCard(
        reps: 2,
        stability: 5.0,
        difficulty: 5.0,
        lastReview: DateTime.now().subtract(const Duration(days: 5)),
      );
      final goodResult = algo.schedule(card, SrsGrade.good);
      final easyResult = algo.schedule(card, SrsGrade.easy);
      expect(easyResult.interval, greaterThan(goodResult.interval));
    });

    test('nextReviewDate is in the future', () {
      final card = makeCard(
        reps: 1,
        stability: 3.0,
        lastReview: DateTime.now().subtract(const Duration(days: 3)),
      );
      final result = algo.schedule(card, SrsGrade.good);
      expect(result.nextReviewDate.isAfter(DateTime.now()), isTrue);
    });

    test('difficulty stays in range [1, 10]', () {
      // Hard grades push difficulty up
      var card = makeCard(reps: 1, stability: 2.0, difficulty: 9.5);
      for (int i = 0; i < 5; i++) {
        card = algo.schedule(card, SrsGrade.again);
      }
      expect(card.difficulty, lessThanOrEqualTo(10.0));
      expect(card.difficulty, greaterThanOrEqualTo(1.0));
    });
  });
}
```

- [ ] **Step 2: Run tests — verify fail**

```bash
flutter test test/core/srs/fsrs_algorithm_test.dart
```

Expected: FAIL — `FsrsAlgorithm` not found.

- [ ] **Step 3: Implement fsrs_algorithm.dart**

```dart
// lib/core/srs/fsrs_algorithm.dart
import 'dart:math';
import '../../data/database/app_database.dart';
import 'srs_algorithm.dart';

class FsrsAlgorithm implements SrsAlgorithm {
  // FSRS-4.5 default weights
  static const List<double> _w = [
    0.4072, 1.1829, 3.1262, 15.4722, // w0-w3: initial stability per grade
    7.2102, // w4: initial difficulty base
    0.5316, // w5: difficulty adjustment per grade step
    1.0651, 0.0589, // w6-w7 (unused in simplified)
    1.5330, 0.1544, 1.0012, // w8-w10: stability increase formula
    1.9395, 0.1100, 0.2900, 2.2700, // w11-w14: stability after failure
    0.2900, 2.9898, // w15-w16: hard/easy modifiers
  ];

  @override
  VocabularyCard schedule(VocabularyCard card, SrsGrade grade) {
    final gradeIdx = grade.index; // 0=again 1=hard 2=good 3=easy
    final fsrsGrade = gradeIdx + 1; // FSRS uses 1-based grades

    if (card.reps == 0) {
      return _scheduleNew(card, gradeIdx, fsrsGrade);
    }
    return _scheduleReview(card, gradeIdx, fsrsGrade);
  }

  VocabularyCard _scheduleNew(VocabularyCard card, int gradeIdx, int fsrsGrade) {
    final s = _w[gradeIdx]; // initial stability from weights
    final d = (_w[4] - _w[5] * (fsrsGrade - 3)).clamp(1.0, 10.0);
    final interval = max(1, s.round());

    return card.copyWith(
      stability: s,
      difficulty: d,
      retrievability: 1.0,
      reps: 1,
      interval: interval,
      lastReviewDate: Value(DateTime.now()),
      nextReviewDate: DateTime.now().add(Duration(days: interval)),
    );
  }

  VocabularyCard _scheduleReview(VocabularyCard card, int gradeIdx, int fsrsGrade) {
    final elapsed = card.lastReviewDate != null
        ? DateTime.now().difference(card.lastReviewDate!).inDays.toDouble()
        : 1.0;
    final r = exp(-elapsed / card.stability); // retrievability at review time

    final double newS;
    if (grade_isFailure(gradeIdx)) {
      // Forgot the card
      newS = _w[11] *
          pow(card.difficulty, -_w[12]) *
          (pow(card.stability + 1, _w[13]) - 1) *
          exp(_w[14] * (1 - r));
    } else {
      // Recalled — stability grows
      final hardMod = gradeIdx == 1 ? _w[15] : 1.0;
      final easyMod = gradeIdx == 3 ? _w[16] : 1.0;
      newS = card.stability *
          (exp(_w[8]) *
                  (11 - card.difficulty) *
                  pow(card.stability, -_w[9]) *
                  (exp(_w[10] * (1 - r)) - 1) *
                  hardMod *
                  easyMod +
              1);
    }

    final clampedS = newS.clamp(0.1, 365.0);
    final newD = (card.difficulty - _w[5] * (3 - fsrsGrade)).clamp(1.0, 10.0);
    final interval = max(1, clampedS.round());

    return card.copyWith(
      stability: clampedS,
      difficulty: newD,
      retrievability: exp(-1.0 / clampedS),
      reps: card.reps + 1,
      interval: interval,
      lastReviewDate: Value(DateTime.now()),
      nextReviewDate: DateTime.now().add(Duration(days: interval)),
    );
  }

  bool grade_isFailure(int gradeIdx) => gradeIdx == 0;
}
```

- [ ] **Step 4: Run tests — verify pass**

```bash
flutter test test/core/srs/fsrs_algorithm_test.dart
```

Expected: All PASS.

- [ ] **Step 5: Commit**

```bash
git add zenlingo/lib/core/srs/fsrs_algorithm.dart zenlingo/test/core/srs/fsrs_algorithm_test.dart
git commit -m "feat: FSRS-4.5 scheduling algorithm with unit tests"
```

---

## Task 9: Vocabulary Asset + Loader (TDD)

**Files:**
- Create: `zenlingo/assets/data/jp_n5.json`
- Create: `zenlingo/lib/data/loaders/vocabulary_loader.dart`
- Test: `zenlingo/test/data/loaders/vocabulary_loader_test.dart`

- [ ] **Step 1: Create jp_n5.json (representative N5 sample)**

```json
[
  {"word":"日本語","reading":"にほんご","meaning":"Japanese language","example_sentence":"日本語を勉強しています。","jlpt_level":5,"tags":["noun"]},
  {"word":"水","reading":"みず","meaning":"water","example_sentence":"水を飲みます。","jlpt_level":5,"tags":["noun"]},
  {"word":"食べる","reading":"たべる","meaning":"to eat","example_sentence":"ご飯を食べます。","jlpt_level":5,"tags":["verb","ichidan"]},
  {"word":"飲む","reading":"のむ","meaning":"to drink","example_sentence":"お茶を飲みます。","jlpt_level":5,"tags":["verb","godan"]},
  {"word":"見る","reading":"みる","meaning":"to see, to look","example_sentence":"テレビを見ます。","jlpt_level":5,"tags":["verb","ichidan"]},
  {"word":"聞く","reading":"きく","meaning":"to listen, to ask","example_sentence":"音楽を聞きます。","jlpt_level":5,"tags":["verb","godan"]},
  {"word":"大きい","reading":"おおきい","meaning":"big, large","example_sentence":"大きい犬がいます。","jlpt_level":5,"tags":["adjective","i-adj"]},
  {"word":"小さい","reading":"ちいさい","meaning":"small, little","example_sentence":"小さい猫が好きです。","jlpt_level":5,"tags":["adjective","i-adj"]},
  {"word":"新しい","reading":"あたらしい","meaning":"new","example_sentence":"新しい本を買いました。","jlpt_level":5,"tags":["adjective","i-adj"]},
  {"word":"古い","reading":"ふるい","meaning":"old (things)","example_sentence":"古い車を持っています。","jlpt_level":5,"tags":["adjective","i-adj"]},
  {"word":"駅","reading":"えき","meaning":"train station","example_sentence":"駅はどこですか？","jlpt_level":5,"tags":["noun"]},
  {"word":"学校","reading":"がっこう","meaning":"school","example_sentence":"学校に行きます。","jlpt_level":5,"tags":["noun"]},
  {"word":"電車","reading":"でんしゃ","meaning":"train","example_sentence":"電車で来ました。","jlpt_level":5,"tags":["noun"]},
  {"word":"友達","reading":"ともだち","meaning":"friend","example_sentence":"友達と遊びます。","jlpt_level":5,"tags":["noun"]},
  {"word":"先生","reading":"せんせい","meaning":"teacher","example_sentence":"先生は優しいです。","jlpt_level":5,"tags":["noun"]},
  {"word":"行く","reading":"いく","meaning":"to go","example_sentence":"学校に行きます。","jlpt_level":5,"tags":["verb","godan"]},
  {"word":"来る","reading":"くる","meaning":"to come","example_sentence":"明日来ますか？","jlpt_level":5,"tags":["verb","irregular"]},
  {"word":"する","reading":"する","meaning":"to do","example_sentence":"宿題をします。","jlpt_level":5,"tags":["verb","irregular"]},
  {"word":"分かる","reading":"わかる","meaning":"to understand","example_sentence":"日本語が分かりますか？","jlpt_level":5,"tags":["verb","godan"]},
  {"word":"話す","reading":"はなす","meaning":"to speak, to talk","example_sentence":"日本語で話します。","jlpt_level":5,"tags":["verb","godan"]},
  {"word":"今日","reading":"きょう","meaning":"today","example_sentence":"今日は月曜日です。","jlpt_level":5,"tags":["noun","temporal"]},
  {"word":"明日","reading":"あした","meaning":"tomorrow","example_sentence":"明日また会いましょう。","jlpt_level":5,"tags":["noun","temporal"]},
  {"word":"昨日","reading":"きのう","meaning":"yesterday","example_sentence":"昨日何をしましたか？","jlpt_level":5,"tags":["noun","temporal"]},
  {"word":"時間","reading":"じかん","meaning":"time","example_sentence":"時間がありますか？","jlpt_level":5,"tags":["noun"]},
  {"word":"何","reading":"なに","meaning":"what","example_sentence":"これは何ですか？","jlpt_level":5,"tags":["pronoun"]},
  {"word":"どこ","reading":"どこ","meaning":"where","example_sentence":"どこに行きますか？","jlpt_level":5,"tags":["pronoun"]},
  {"word":"いつ","reading":"いつ","meaning":"when","example_sentence":"いつ来ますか？","jlpt_level":5,"tags":["pronoun"]},
  {"word":"誰","reading":"だれ","meaning":"who","example_sentence":"誰ですか？","jlpt_level":5,"tags":["pronoun"]},
  {"word":"高い","reading":"たかい","meaning":"expensive, high","example_sentence":"この本は高いです。","jlpt_level":5,"tags":["adjective","i-adj"]},
  {"word":"安い","reading":"やすい","meaning":"cheap, inexpensive","example_sentence":"この店は安いです。","jlpt_level":5,"tags":["adjective","i-adj"]}
]
```

- [ ] **Step 2: Write failing loader test**

```dart
// test/data/loaders/vocabulary_loader_test.dart
import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:drift/native.dart';
import 'package:zenlingo/data/database/app_database.dart';
import 'package:zenlingo/data/loaders/vocabulary_loader.dart';

void main() {
  late AppDatabase db;
  late SrsDao srsDao;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    srsDao = db.srsDao;
  });

  tearDown(() async {
    await db.close();
  });

  test('parseEntries returns correct count from JSON string', () async {
    const json = '''[
      {"word":"水","reading":"みず","meaning":"water","jlpt_level":5,"tags":["noun"]},
      {"word":"火","reading":"ひ","meaning":"fire","jlpt_level":5,"tags":["noun"]}
    ]''';
    final loader = VocabularyLoader(db);
    final entries = loader.parseEntries(jsonDecode(json) as List<dynamic>);
    expect(entries.length, 2);
    expect(entries[0].word.value, '水');
    expect(entries[1].reading.value, 'ひ');
  });

  test('insertAll inserts cards into database', () async {
    const json = '''[
      {"word":"水","reading":"みず","meaning":"water","jlpt_level":5,"tags":["noun"]},
      {"word":"火","reading":"ひ","meaning":"fire","jlpt_level":5,"tags":["noun"]}
    ]''';
    final loader = VocabularyLoader(db);
    final entries = loader.parseEntries(jsonDecode(json) as List<dynamic>);
    await loader.insertAll(entries);
    final count = await srsDao.countAllCards();
    expect(count, 2);
  });

  test('insertAll skips duplicates (idempotent)', () async {
    const json = '''[{"word":"水","reading":"みず","meaning":"water","jlpt_level":5,"tags":["noun"]}]''';
    final loader = VocabularyLoader(db);
    final entries = loader.parseEntries(jsonDecode(json) as List<dynamic>);
    await loader.insertAll(entries);
    await loader.insertAll(entries); // second call
    final count = await srsDao.countAllCards();
    expect(count, 1); // no duplicate
  });
}
```

- [ ] **Step 3: Run test — verify fail**

```bash
flutter test test/data/loaders/vocabulary_loader_test.dart
```

Expected: FAIL — `VocabularyLoader` not found.

- [ ] **Step 4: Implement vocabulary_loader.dart**

```dart
// lib/data/loaders/vocabulary_loader.dart
import 'dart:convert';
import 'package:drift/drift.dart';
import 'package:flutter/services.dart';
import '../database/app_database.dart';

class VocabularyLoader {
  static const Map<String, String> _assetPaths = {
    'ja': 'assets/data/jp_n5.json',
  };

  final AppDatabase _db;

  VocabularyLoader(this._db);

  Future<void> seedFromAssets() async {
    for (final entry in _assetPaths.entries) {
      await _seedLanguage(entry.key, entry.value);
    }
  }

  Future<void> _seedLanguage(String langCode, String assetPath) async {
    final jsonStr = await rootBundle.loadString(assetPath);
    final rawList = jsonDecode(jsonStr) as List<dynamic>;
    final entries = parseEntries(rawList);
    await insertAll(entries);
  }

  List<VocabularyCardsCompanion> parseEntries(List<dynamic> rawList) {
    return rawList.map((e) {
      final map = e as Map<String, dynamic>;
      final tags = (map['tags'] as List<dynamic>?) ?? [];
      return VocabularyCardsCompanion(
        word: Value(map['word'] as String),
        reading: Value(map['reading'] as String),
        meaning: Value(map['meaning'] as String),
        exampleSentence: Value(map['example_sentence'] as String?),
        jlptLevel: Value(map['jlpt_level'] as int? ?? 5),
        languageCode: const Value('ja'),
        tags: Value(jsonEncode(tags)),
      );
    }).toList();
  }

  Future<void> insertAll(List<VocabularyCardsCompanion> entries) async {
    await _db.batch((batch) {
      batch.insertAllOnConflictUpdate(
        _db.vocabularyCards,
        entries,
      );
    });
  }
}
```

> Note: `insertAllOnConflictUpdate` requires `word` to be the unique key, but the Drift table uses autoincrement `id`. For idempotent seeding, add a unique constraint on `word + languageCode` to the table, OR use `insertAll` with `mode: InsertMode.insertOrIgnore`. Use the latter:
>
> Replace `insertAllOnConflictUpdate` with:
> ```dart
> for (final entry in entries) {
>   await _db.into(_db.vocabularyCards).insertOnConflictUpdate(entry);
> }
> ```
> This avoids needing a separate unique index. Drift's `insertOnConflictUpdate` uses the primary key (id) which won't help; instead use `insertOrIgnore`:
> ```dart
> batch.insertAll(_db.vocabularyCards, entries, mode: InsertMode.insertOrIgnore);
> ```
> But this requires a unique constraint. Simplest solution: check count before seeding.
>
> **Revised `insertAll`:**
> ```dart
> Future<void> insertAll(List<VocabularyCardsCompanion> entries) async {
>   for (final entry in entries) {
>     // Skip if word+languageCode already exists
>     final existing = await (_db.select(_db.vocabularyCards)
>           ..where((c) =>
>               c.word.equals(entry.word.value) &
>               c.languageCode.equals(entry.languageCode.value)))
>         .getSingleOrNull();
>     if (existing == null) {
>       await _db.into(_db.vocabularyCards).insert(entry);
>     }
>   }
> }
> ```

- [ ] **Step 5: Run tests — verify pass**

```bash
flutter test test/data/loaders/vocabulary_loader_test.dart
```

Expected: All PASS.

- [ ] **Step 6: Wire VocabularyLoader into AppDatabase.beforeOpen**

In `lib/data/database/app_database.dart`, add the import and uncomment the seeding call:

```dart
import '../../loaders/vocabulary_loader.dart';

// In beforeOpen:
beforeOpen: (details) async {
  if (details.wasCreated) {
    await VocabularyLoader(this).seedFromAssets();
  }
},
```

- [ ] **Step 7: Commit**

```bash
git add zenlingo/assets/data/jp_n5.json zenlingo/lib/data/loaders/ zenlingo/test/data/loaders/ zenlingo/lib/data/database/app_database.dart
git commit -m "feat: VocabularyLoader seeds jp_n5.json on first launch"
```

---

## Task 10: SRS DAO Tests

**Files:**
- Test: `zenlingo/test/data/database/srs_dao_test.dart`

- [ ] **Step 1: Write DAO tests**

```dart
// test/data/database/srs_dao_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:drift/native.dart';
import 'package:zenlingo/data/database/app_database.dart';
import 'package:zenlingo/core/srs/srs_algorithm.dart';
import 'package:zenlingo/core/srs/fsrs_algorithm.dart';

VocabularyCardsCompanion makeCompanion({
  required String word,
  DateTime? nextReview,
}) =>
    VocabularyCardsCompanion.insert(
      word: word,
      reading: 'てすと',
      meaning: 'test',
      nextReviewDate: Value(nextReview ?? DateTime.now().subtract(const Duration(hours: 1))),
    );

void main() {
  late AppDatabase db;
  late SrsDao dao;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    dao = db.srsDao;
  });

  tearDown(() async => db.close());

  test('watchDueCards emits due cards', () async {
    await dao.insertCard(makeCompanion(word: '水'));
    final cards = await dao.getDueCards();
    expect(cards.length, 1);
    expect(cards.first.word, '水');
  });

  test('watchDueCards excludes future cards', () async {
    await dao.insertCard(makeCompanion(
      word: '火',
      nextReview: DateTime.now().add(const Duration(days: 7)),
    ));
    final cards = await dao.getDueCards();
    expect(cards, isEmpty);
  });

  test('updateCard persists new scheduling data', () async {
    await dao.insertCard(makeCompanion(word: '水'));
    final before = (await dao.getDueCards()).first;

    final algo = FsrsAlgorithm();
    final updated = algo.schedule(before, SrsGrade.good);
    await dao.updateCard(updated);

    final after = await (db.select(db.vocabularyCards)
          ..where((c) => c.id.equals(before.id)))
        .getSingle();

    expect(after.stability, greaterThan(before.stability));
    expect(after.reps, 1);
    expect(after.nextReviewDate.isAfter(DateTime.now()), isTrue);
  });

  test('countAllCards returns correct count after inserts', () async {
    await dao.insertCard(makeCompanion(word: '水'));
    await dao.insertCard(makeCompanion(word: '火'));
    expect(await dao.countAllCards(), 2);
  });

  test('watchDueCards stream emits update after updateCard', () async {
    await dao.insertCard(makeCompanion(word: '水'));

    final stream = dao.watchDueCards();
    final first = await stream.first;
    expect(first.length, 1);

    // Grade and update — moves card to future
    final algo = FsrsAlgorithm();
    final updated = algo.schedule(first.first, SrsGrade.good);
    await dao.updateCard(updated);

    final second = await stream.first;
    expect(second, isEmpty); // card now scheduled in future
  });
}
```

- [ ] **Step 2: Run tests**

```bash
flutter test test/data/database/srs_dao_test.dart
```

Expected: All PASS.

- [ ] **Step 3: Commit**

```bash
git add zenlingo/test/data/database/srs_dao_test.dart
git commit -m "test: SrsDao integration tests with in-memory DB"
```

---

## Task 11: Riverpod Providers

**Files:**
- Create: `zenlingo/lib/core/providers/database_provider.dart`
- Create: `zenlingo/lib/core/providers/srs_algorithm_provider.dart`

- [ ] **Step 1: Create database_provider.dart**

```dart
// lib/core/providers/database_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/database/app_database.dart';

final databaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase(openConnection());
  ref.onDispose(db.close);
  return db;
});

final srsDaoProvider = Provider<SrsDao>((ref) {
  return ref.watch(databaseProvider).srsDao;
});

final sessionDaoProvider = Provider<SessionDao>((ref) {
  return ref.watch(databaseProvider).sessionDao;
});
```

- [ ] **Step 2: Create srs_algorithm_provider.dart**

```dart
// lib/core/providers/srs_algorithm_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../config/app_config.dart';
import '../srs/srs_algorithm.dart';
import '../srs/fsrs_algorithm.dart';
import '../srs/sm2_algorithm.dart';

final srsAlgorithmProvider = Provider<SrsAlgorithm>((ref) {
  return AppConfig.useFsrs ? FsrsAlgorithm() : Sm2Algorithm();
});
```

- [ ] **Step 3: Commit**

```bash
git add zenlingo/lib/core/providers/
git commit -m "feat: Riverpod providers for database and SRS algorithm"
```

---

## Task 12: Update main.dart

**Files:**
- Modify: `zenlingo/lib/main.dart`

- [ ] **Step 1: Replace main.dart**

```dart
// lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/theme/zen_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: ZenApp()));
}

class ZenApp extends StatelessWidget {
  const ZenApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ZenLingo',
      debugShowCheckedModeBanner: false,
      theme: ZenTheme.dark,
      home: const _NavShell(),
    );
  }
}

class _NavShell extends StatefulWidget {
  const _NavShell();

  @override
  State<_NavShell> createState() => _NavShellState();
}

class _NavShellState extends State<_NavShell> {
  int _index = 0;

  static const List<Widget> _pages = [
    _PlaceholderPage(label: '今日'),      // Phase 2: ReviewScreen
    _PlaceholderPage(label: '辞書'),      // Phase 2: DictionaryScreen
    _PlaceholderPage(label: '練習'),      // Phase 3: WritingScreen
    _PlaceholderPage(label: '私'),        // Phase 5: ProfileScreen
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_index],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (i) => setState(() => _index = i),
        backgroundColor: ZenTheme.bgBlack,
        destinations: const [
          NavigationDestination(icon: Icon(Icons.local_fire_department), label: ''),
          NavigationDestination(icon: Icon(Icons.book_outlined), label: ''),
          NavigationDestination(icon: Icon(Icons.edit_outlined), label: ''),
          NavigationDestination(icon: Icon(Icons.person_outline), label: ''),
        ],
      ),
    );
  }
}

class _PlaceholderPage extends StatelessWidget {
  const _PlaceholderPage({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(label, style: Theme.of(context).textTheme.displayLarge),
    );
  }
}
```

- [ ] **Step 2: Run app to verify it builds**

```bash
flutter run -d chrome
```

Expected: App launches with dark background, Japan Red nav bar, four tab icons, placeholder kanji labels.

If font error `NotoSansJP not found` — that's expected until font file added to `assets/fonts/`. It falls back to system font. Not blocking for Phase 1.

- [ ] **Step 3: Run all tests**

```bash
flutter test
```

Expected: All tests PASS.

- [ ] **Step 4: Final commit**

```bash
git add zenlingo/lib/main.dart
git commit -m "feat: ProviderScope root, ZenApp with dark theme, nav shell scaffold"
```

---

## Phase 1 Complete ✓

At this point the following is working and tested:
- All Drift tables defined and code-generated
- FSRS-4.5 + SM-2 algorithms with full unit test coverage
- SrsDao with reactive `watchDueCards()` stream — tested with in-memory DB
- VocabularyLoader seeding jp_n5.json on first launch
- Riverpod providers wiring DB into app state tree
- ZenTheme dark theme applied globally
- Navigation shell ready for Phase 2 screens

**Next:** Phase 2 — SRS Loop (FlashcardWidget, GradeButtons, ReviewScreen).
