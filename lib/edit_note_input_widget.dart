import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:moordatabase/database/moor_database.dart';
import 'package:moordatabase/model/dao/note_dao.dart';
import 'package:provider/provider.dart';

class EditNoteInput extends StatefulWidget {
  Note note;

  EditNoteInput({Key key, @required this.note}) : super(key: key);

  @override
  _EditNoteInputState createState() => _EditNoteInputState(note);
}

class _EditNoteInputState extends State<EditNoteInput> {
  Note note;

  _EditNoteInputState(this.note);

  TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: note.description);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Edit Note')),
      body: Container(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            _buildTextField(context),
          ],
        ),
      ),
    );
  }

  Expanded _buildTextField(BuildContext context) {
    return Expanded(
      child: TextField(
        autofocus: true,
        controller: controller,
        decoration: InputDecoration(
          hintText: 'write text here',
        ),
        onSubmitted: (inputDescription) {
          final dao = Provider.of<NoteDao>(context);
          final updatedNote = note.copyWith(description: inputDescription);
          dao.updateNote(updatedNote);
          resetValuesAndNavigateBackToListAfterSubmit();
        },
      ),
    );
  }

  void resetValuesAndNavigateBackToListAfterSubmit() {
    setState(() {
      controller.clear();
      if (Navigator.canPop(context)) {
        Navigator.pop(context);
      } else {
        SystemNavigator.pop();
      }
    });
  }
}
