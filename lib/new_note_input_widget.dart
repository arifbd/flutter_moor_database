import 'package:flutter/material.dart';
import 'package:moordatabase/database/moor_database.dart';
import 'package:moordatabase/model/dao/note_dao.dart';
import 'package:provider/provider.dart';

class NewNoteInput extends StatefulWidget {
  const NewNoteInput({Key key,}) : super(key: key);

  @override
  _NewNoteInputState createState() => _NewNoteInputState();
}

class _NewNoteInputState extends State<NewNoteInput> {
  TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          _buildTextField(context),
        ],
      ),
    );
  }

  Expanded _buildTextField(BuildContext context) {
    return Expanded(
      child: TextField(
        controller: controller,
        decoration: InputDecoration(hintText: 'Write your Note here'),
        onSubmitted: (inputDescription) {
          final dao = Provider.of<NoteDao>(context);
          final note = Note(
            id:null,
            description: inputDescription,
          );
          dao.insertNote(note);
          resetValuesAfterSubmit();
        },
      ),
    );
  }

  void resetValuesAfterSubmit() {
    setState(() {
      controller.clear();
    });
  }
}