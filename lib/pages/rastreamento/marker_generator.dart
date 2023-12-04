import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:prog_app/services/geolocation/map_methods.dart';

class MarkerGenerator {
  static List<Marker> generateMarkers(
      LatLng userLocation, int numberOfMarkers, BuildContext context) {
    List<Marker> markers = [];

    // Add user's location marker
    markers.add(
      Marker(
        width: 30,
        height: 30,
        point: userLocation,
        child: Icon(Icons.person, size: 30),
      ),
    );

    // Dynamically generate other markers within a range of 100 meters
    for (int i = 1; i <= numberOfMarkers; i++) {
      LatLng randomLocation = _generateRandomLocation(userLocation, 10000);
      double distanceFromUser = MapMethods.calculateHaversineDistance(
          userLocation.latitude,
          userLocation.longitude,
          randomLocation.latitude,
          randomLocation.longitude);
      var timeDelivery = (distanceFromUser.truncate() / 500).truncate();
      markers.add(
        Marker(
          width: 30,
          height: 30,
          point: randomLocation,
          child: GestureDetector(
              onTap: () => showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: const Text('Tempo de entrega'),
                      content: Text(
                          "O pedido está a ${distanceFromUser.truncate()} metros de distancia. \n$timeDelivery dias para entrega!"),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.pop(context, 'OK'),
                          child: const Text('OK'),
                        ),
                      ],
                    ),
                  ),
              child: Icon(Icons.shopping_bag, size: 30)),
        ),
      );
    }

    return markers;
  }

  static LatLng _generateRandomLocation(
      LatLng userLocation, double maxDistanceMeters) {
    double randomBearing =
        Random().nextDouble() * 360; // Random bearing in degrees
    return MapMethods.calculateDestinationPoint(
        userLocation, maxDistanceMeters, randomBearing);
  }
}
