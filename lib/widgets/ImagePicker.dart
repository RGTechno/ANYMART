import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImgPicker extends StatefulWidget {
  final void Function(File pickedImage) imagePicker;

  ImgPicker(this.imagePicker);

  @override
  _ImgPickerState createState() => _ImgPickerState();
}

class _ImgPickerState extends State<ImgPicker> {
  File _pickedImage;

  void _getFromGallery() async {
    final picker = ImagePicker();
    final pickedImageFile = await picker.getImage(
      source: ImageSource.gallery,
      imageQuality: 50,
      maxWidth: 200,
      maxHeight: 200,
    );
    if (pickedImageFile != null) {
      setState(() {
        _pickedImage = File(pickedImageFile.path);
      });
      widget.imagePicker(_pickedImage);
    }
  }

  void _getFromCamera() async {
    final picker = ImagePicker();
    final pickedImageFile = await picker.getImage(
      source: ImageSource.camera,
      imageQuality: 50,
      maxWidth: 200,
      maxHeight: 200,
    );
    if (pickedImageFile != null) {
      setState(() {
        _pickedImage = File(pickedImageFile.path);
      });
      widget.imagePicker(_pickedImage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: _getFromCamera,
          child: CircleAvatar(
            radius: 37,
            backgroundColor: Colors.black12,
            backgroundImage:
                _pickedImage != null ? FileImage(_pickedImage) : null,
            child: Icon(
              Icons.camera_alt_outlined,
              color: Colors.black,
            ),
          ),
        ),
        TextButton.icon(
          onPressed: _getFromGallery,
          icon: Icon(Icons.image),
          label: Text("Upload Image"),
        ),
      ],
    );
  }
}
