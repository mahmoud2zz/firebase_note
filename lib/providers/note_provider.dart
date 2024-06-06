import 'package:flutter/material.dart';

import '../firebase/fb_firestore_controller.dart';
import '../models/note.dart';
import '../models/process_response.dart';

class NoteProvider extends ChangeNotifier {
  List<Note> notes = <Note>[];
  bool  loading=false;

final  FbFireStoreController _controller = FbFireStoreController();

    void read() async {
    loading=true;
    notes = await _controller.read();
    loading=false;
    notifyListeners();
  }

  Future<ProcessResponse> create(Note note) async {
    ProcessResponse processResponse = await _controller.create(note);
    if (processResponse.success) {
      notes.add(note);
      notifyListeners();
    }
    return processResponse;
  }

  Future<ProcessResponse> update(Note note) async {
      print('0');
    ProcessResponse updated = await _controller.update(note);
    if (updated.success) {
      print('2');
      int index = notes.indexWhere((e) => e.id == note.id);
      if (index != -1) {
        notes[index] = note;
        print('4');
        notifyListeners();
      }
    }
    return updated;
  }

Future<ProcessResponse>  delete(String id) async {
    ProcessResponse deleted = await _controller.delete(id);
    if (deleted.success) {
      int index = notes.indexWhere((e) => e.id == id);
      if (index != -1) {
        notes.removeAt(index);
       notifyListeners();
      }
    }
    return deleted;
  }
}
