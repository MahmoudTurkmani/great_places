import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/providers/great_places.dart';
import 'package:provider/provider.dart';

import './add_place_screen.dart';

class PlacesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your places'),
        actions: [
          IconButton(
            onPressed: () =>
                Navigator.of(context).pushNamed(AddPlaceScreen.routeName),
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<GreatPlaces>(context, listen: false)
            .fetchAndSetPlaces(),
        builder: (ctx, currentSnapshot) {
          return currentSnapshot.connectionState == ConnectionState.waiting
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Consumer<GreatPlaces>(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('You don\'t have any places yet.\n'),
                        ElevatedButton(
                          onPressed: () => Navigator.of(context)
                              .pushNamed(AddPlaceScreen.routeName),
                          child: Text('Add place'),
                        ),
                      ],
                    ),
                  ),
                  builder: (ctx, greatPlaces, ch) {
                    return greatPlaces.items.length <= 0
                        ? ch
                        : ListView.builder(
                            itemCount: greatPlaces.items.length,
                            itemBuilder: (c, index) {
                              return ListTile(
                                leading: CircleAvatar(
                                  backgroundImage:
                                      FileImage(greatPlaces.items[index].image),
                                ),
                                title: Text(greatPlaces.items[index].title),
                              );
                            },
                          );
                  },
                );
        },
      ),
    );
  }
}
