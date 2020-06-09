import 'package:flutter/material.dart';
import 'package:moordatabase/edit_note_input_widget.dart';
import 'package:moordatabase/model/dao/note_dao.dart';
import 'package:moordatabase/new_note_input_widget.dart';
import 'package:provider/provider.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:moordatabase/database/moor_database.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Notes'),
        ),
        body: Column(
          children: <Widget>[
            Expanded(child: _buildNoteList(context)),
            NewNoteInput(),
          ],
        ));
  }

  StreamBuilder<List<Note>> _buildNoteList(BuildContext context) {
    final dao = Provider.of<NoteDao>(context);
    return StreamBuilder(
      stream: dao.watchAllNotes(),
      builder: (context, AsyncSnapshot<List<Note>> snapshot) {
        final notes = snapshot.data ?? List();

        return ListView.builder(
          itemCount: notes.length,
          itemBuilder: (_, index) {
            final itemNote = notes[index];
            return _buildListItem(itemNote, dao);
          },
        );
      },
    );
  }

  Widget _buildListItem(Note itemNote, NoteDao dao) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      secondaryActions: <Widget>[
        IconSlideAction(
          caption: 'Delete',
          color: Colors.red,
          icon: Icons.delete,
          onTap: () => dao.deleteNote(itemNote),
        )
      ],
      child: ListTile(
        title: Text(itemNote.description),
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => EditNoteInput(note: itemNote)))
      ),
    );
  }
}
