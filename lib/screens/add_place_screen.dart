import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/providers/great_places.dart';
import 'package:provider/provider.dart';

import '../widgets/image_input.dart';
import '../widgets/location_input.dart';

class AddPlaceScreen extends StatefulWidget {
  static const routeName = 'add-place';
  @override
  _AddPlaceScreenState createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  TextEditingController titleController = TextEditingController();
  File _pickedImage;

  void setPickedImage(File pickedImage) {
    _pickedImage = pickedImage;
    setState(() {});
  }

  void addLocation() {
    if (titleController.text == null || _pickedImage == null) {
      return;
    }
    Provider.of<GreatPlaces>(context, listen: false)
        .addPlace(titleController.text, _pickedImage);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add a place'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  TextField(
                    decoration: InputDecoration(labelText: 'Title'),
                    controller: titleController,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ImageInput(setPickedImage),
                  SizedBox(
                    height: 10,
                  ),
                  LocationInput(),
                ],
              ),
            ),
          ),
          ElevatedButton.icon(
            onPressed: addLocation,
            icon: Icon(Icons.add),
            label: Text('Add Place'),
            style: ButtonStyle(),
          ),
        ],
      ),
    );
  }
}
