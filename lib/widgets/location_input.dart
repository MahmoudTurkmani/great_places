import 'package:flutter/material.dart';
import 'package:location/location.dart';

class LocationInput extends StatefulWidget {
  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String _previewImageUrl;

  Future<void> getCurrentLocation() async {
    final currentLocation = await Location().getLocation();
    print('Latitude: ${currentLocation.latitude}');
    print('Longitude: ${currentLocation.longitude}');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          width: double.infinity,
          height: 200,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Colors.grey,
            ),
          ),
          child: _previewImageUrl == null
              ? Center(
                  child: Text('No Location Chosen'),
                )
              : Image.network(
                  _previewImageUrl,
                  fit: BoxFit.cover,
                ),
        ),
        SizedBox(
          height: 5,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            ElevatedButton.icon(
              icon: Icon(Icons.location_on),
              onPressed: getCurrentLocation,
              label: Text('Use Current Location'),
            ),
            ElevatedButton.icon(
              onPressed: () {},
              icon: Icon(Icons.map),
              label: Text('Open Maps'),
            ),
          ],
        ),
      ],
    );
  }
}
