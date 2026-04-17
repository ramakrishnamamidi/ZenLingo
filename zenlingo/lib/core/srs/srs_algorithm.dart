import '../../data/database/app_database.dart';

enum SrsGrade { again, hard, good, easy }

abstract class SrsAlgorithm {
  VocabularyCard schedule(VocabularyCard card, SrsGrade grade);
}
