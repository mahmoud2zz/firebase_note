import 'package:firebase_note_provider/utils/context_extention.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../../models/note.dart';
import '../../models/process_response.dart';
import '../../providers/note_provider.dart';

class NoteScreen extends StatefulWidget {
final  Note? note;

  NoteScreen({super.key, this.note});

  @override
  State<NoteScreen> createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  late TextEditingController _titleController;
  late TextEditingController _infoController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.note?.title ?? '');
    _infoController = TextEditingController(text: widget.note?.title ?? '');
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _titleController.dispose();
    _infoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Note Screen'),
      ),
      body: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.title),
                hintText: 'title',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            TextField(
              controller: _infoController,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.info),
                hintText: 'info',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade800,
                    minimumSize: Size(double.infinity, 40),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    )),
                onPressed: () => _performSave(),
                child: Text(
                  'Save',
                  style: TextStyle(color: Colors.white),
                )),
          ],
        ),
      ),
    );
  }

  void _performSave() {
    if (checkData()) {
      _save();
    }
  }

  bool checkData() {
    if (_titleController.text.isNotEmpty && _infoController.text.isNotEmpty) {
      return true;
    } else {
      context.showSnackBar(message: 'Enter required data!', error: true);

      return false;
    }
  }

  void _save() async {
    ProcessResponse processResponse = isNewNode
        ?await  Provider.of<NoteProvider>(context, listen: false)
            .update(note)
        : await Provider.of<NoteProvider>(context, listen: false).create(note);
    if (processResponse.success) {
      isNewNode?Navigator.pop(context):_clear();

    }
    context.showSnackBar(
        message: processResponse.message, error: !processResponse.success);
  }

  _clear() {
    _titleController.clear();
    _infoController.clear();
  }

  bool get isNewNode => widget.note != null;

  Note get note {
    Note note = Note();
    note.title = _titleController.text;
    note.info = _infoController.text;
  note.id   = isNewNode? widget.note!.id  :const Uuid().v4();
    return note;
  }
}
