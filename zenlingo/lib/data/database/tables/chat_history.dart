import 'package:drift/drift.dart';

class ChatHistory extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get role => text()(); // user | assistant
  TextColumn get content => text()();
  DateTimeColumn get timestamp => dateTime()();
  TextColumn get languageCode =>
      text().withDefault(const Constant('ja'))();
}
