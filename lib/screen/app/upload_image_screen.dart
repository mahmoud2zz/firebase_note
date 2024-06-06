import 'dart:io';
import 'package:firebase_note_provider/models/process_response.dart';
import 'package:firebase_note_provider/utils/context_extention.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../providers/images_provider.dart';

class UploadImageScreen extends StatefulWidget {
  const UploadImageScreen({super.key});

  @override
  State<UploadImageScreen> createState() => _UploadImageScreenState();
}

class _UploadImageScreenState extends State<UploadImageScreen> {
  late ImagePicker _imagePicker;
  XFile? _pickedImage;
  double? _progressValue = 0.0;

  @override
  void initState() {
    super.initState();
    _imagePicker = ImagePicker();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Image'),
      ),
      body: Column(
        children: [
          LinearProgressIndicator(
            minHeight: 8,
            value: _progressValue,
            color: Colors.blue.shade400,
            backgroundColor: Colors.green.shade400,
          ),
          Expanded(
            child: _pickedImage != null
                ? Image.file(File(_pickedImage!.path))
                : IconButton(
                    onPressed: () async => await _pickImage(),
                    icon: Icon(
                      Icons.camera,
                    ),
                    iconSize: 48,
                  ),
          ),
          ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                minimumSize: Size(double.infinity, 50),
                backgroundColor: Colors.blue,
                iconColor: Colors.white,
              ),
              onPressed: () => _performUpload(),
              label: Text(
                'UPLOUD',
                style: TextStyle(color: Colors.white),
              ),
              icon: Icon(Icons.cloud_upload)),
        ],
      ),
    );
  }

  Future<void> _pickImage() async {
    XFile? imageFile = await _imagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 100);
    if (imageFile != null) {
      setState(() {
        _pickedImage = imageFile;
      });
    }
  }

  _performUpload() {
    if (_checkData()) {
      _upload();
    }
  }

  _checkData() {
    if (_pickedImage != null) {
      return true;
    }
    context.showSnackBar(message: 'Pick image to upload', error: true);
    return false;
  }

  _upload() async {
_updateProgressValue(1);
    ProcessResponse processResponse =
    await Provider.of<ImagesProvider>(context, listen: false).upload(
        _pickedImage!.path);
_updateProgressValue(processResponse.success?0:1);

context.showSnackBar(
        message: processResponse.message, error: !processResponse.success);

    _clear();
  }


  _updateProgressValue([double? value]) {
    setState(() {
      _progressValue=value;
    });
  }
  _clear(){
    setState(() {
      _pickedImage=null;
    });
  }
  }

