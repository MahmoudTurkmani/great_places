import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspath;

class ImageInput extends StatefulWidget {
  final Function setPickedImage;

  ImageInput(this.setPickedImage);

  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File _image;

  Future<void> pickImage() async {
    final _imagePicker = ImagePicker();
    final _pickedImage =
        await _imagePicker.getImage(source: ImageSource.camera, maxWidth: 600);
    if (_pickedImage == null) {
      return;
    }

    _image = File(_pickedImage.path);
    final docsPath = await syspath.getApplicationDocumentsDirectory();
    _image.copy(path.join(docsPath.path, path.basename(_image.path)));
    widget.setPickedImage(_image);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: 150,
          height: 100,
          decoration: BoxDecoration(
            border: Border.all(width: 1),
          ),
          child: _image != null
              ? Image.file(
                  _image,
                  fit: BoxFit.cover,
                )
              : Center(
                  child: Text(
                    'No Picture Taken',
                    textAlign: TextAlign.center,
                  ),
                ),
        ),
        Expanded(
          child: TextButton.icon(
            onPressed: pickImage,
            icon: Icon(Icons.camera),
            label: Text('Take Picture'),
          ),
        ),
      ],
    );
  }
}
