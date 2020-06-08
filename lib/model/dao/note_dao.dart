import 'package:moor/moor.dart';
import 'package:moordatabase/model/entity/note.dart';
import 'package:moordatabase/database/moor_database.dart';

part 'note_dao.g.dart';

@UseDao(tables: [Notes])
class NoteDao extends DatabaseAccessor<MyMoorDatabase> with _$NoteDaoMixin {
  final MyMoorDatabase db;

  NoteDao(this.db) : super(db);

  Future<List<Note>> getAllNotes() => select(notes).get();
  Stream<List<Note>> watchAllNotes() => select(notes).watch();
  Future insertNote(Note note) => into(notes).insert(note);
  Future updateNote(Note note) => update(notes).replace(note);
  Future deleteNote(Note note) => delete(notes).delete(note);
}