import 'package:cloud_firestore/cloud_firestore.dart';


import '../models/note.dart';
import '../models/process_response.dart';
import 'firebase_helper.dart';

class FbFireStoreController with FirebaseHelper {
  FbFireStoreController._();

  static FbFireStoreController? instance;

 final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  factory FbFireStoreController(){
    return instance ??= FbFireStoreController._();
  }

  Future<ProcessResponse> create(Note note) async {
    return _firestore
        .collection('Notes').doc(note.id).set(note.toMap())
        .then((e) => getResponse('Operation successfully '))
        .catchError((e) => getResponse('Operation failed',false));
  }

  Future<ProcessResponse> update(Note note) {
    return _firestore
        .collection('Notes')
        .doc(note.id).update(note.toMap()  )
        .then((e) => getResponse('Operation successfully '))
        .catchError((e) => getResponse('Operation failed',false));
  }

  Future<ProcessResponse> delete(String id) async {
    return _firestore
        .collection('Notes')
        .doc(id)
        .delete()
        .then((e) => getResponse('Operation successfully'))
        .catchError((e) => getResponse('Operation failed',false));
  }

  Future<List<Note>> read() async {
  return  _firestore
        .collection('Notes')
        .get()
        .then(( querySnapshot) => querySnapshot.docs.map((e)=>Note.fromMap(e.data())).toList());
  }





}