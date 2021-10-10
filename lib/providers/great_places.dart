import 'dart:io';

import 'package:flutter/material.dart';

import '../models/place.dart';
import '../helpers/db_helper.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  void addPlace(String title, File pickedImage) {
    final Place newPlace = Place(
      id: DateTime.now().toString(),
      image: pickedImage,
      location: null,
      title: title,
    );
    _items.add(newPlace);
    notifyListeners();
    DBHelper.insert(
      'user_places',
      {
        'id': newPlace.id,
        'title': newPlace.title,
        'image': newPlace.image.path,
      },
    );
  }

  Future<void> fetchAndSetPlaces() async {
    final placesMap = await DBHelper.getData('user_places');
    _items = placesMap
        .map(
          (place) => Place(
            id: place['id'],
            image: File(place['image'] as String),
            location: null,
            title: place['title'],
          ),
        )
        .toList();
  }
}
