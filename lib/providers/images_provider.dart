import 'package:firebase_note_provider/models/process_response.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';

import '../firebase/fb_storage_controller.dart';

class ImagesProvider extends ChangeNotifier {
  List<Reference> reference = [];

  FbStorageController fbStorageController = FbStorageController();

  read() async {
    reference = await fbStorageController.read();
    notifyListeners();
  }

  Future<ProcessResponse> upload(String path) async {
    ProcessResponse<UploadTask> upload =
        fbStorageController.upload(path);
    if (upload.success) {
      reference.add(upload.uploadTask.snapshot.ref);
      notifyListeners();
      return ProcessResponse(upload.message);
    }

    return ProcessResponse('something wrong! try again', false);
  }

   Future<ProcessResponse> delete(int index)async{
    ProcessResponse deleted =await fbStorageController.delete(reference[index].fullPath);
    if(deleted.success){
      reference.removeAt(index);
      notifyListeners();
      return ProcessResponse(deleted.message);
    }
    return ProcessResponse('something wrong! try again', false);

  }

}
