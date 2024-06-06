import 'dart:io';

import 'package:firebase_note_provider/firebase/firebase_helper.dart';
import 'package:firebase_note_provider/models/process_response.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FbStorageController with FirebaseHelper {
   FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

 ProcessResponse<UploadTask> upload(String path)  {
   UploadTask uploadTask = _firebaseStorage.ref('images/image_${DateTime.now().microsecondsSinceEpoch}').putFile(File(path));
   ProcessResponse<UploadTask> processResponse=ProcessResponse<UploadTask>('image upload successfully',true);
     processResponse .uploadTask=uploadTask;
      return processResponse;

  }

  Future<List<Reference>> read() async {
    ListResult listResult = await _firebaseStorage.ref('images').listAll();
    if (listResult.items.isNotEmpty) {
      return listResult.items;
    }
    return [];
  }

  Future<ProcessResponse> delete(String path) async {
    return _firebaseStorage
        .ref()
        .delete()
        .then((e) => getResponse('image deleted successfully'))
        .catchError((e) => getResponse('image deleted failed'));
  }
}
