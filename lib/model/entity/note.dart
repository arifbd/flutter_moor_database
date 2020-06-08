import 'package:moor/moor.dart';

@DataClassName("Note")
class Notes extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get description => text()();
}