import 'package:moor/moor.dart';
import 'package:moor_ffi/moor_ffi.dart';
import 'package:moordatabase/model/entity/note.dart';
import 'package:moordatabase/model/dao/note_dao.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'dart:io';

part 'moor_database.g.dart';

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'my_moor_db.sqlite'));
    return VmDatabase(file);
  });
}

@UseMoor(tables: [Notes], daos: [NoteDao])
class MyMoorDatabase extends _$MyMoorDatabase {
  MyMoorDatabase(QueryExecutor e) : super(_openConnection());

  @override
  int get schemaVersion => 1;
}
