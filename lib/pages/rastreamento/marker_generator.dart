import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:prog_app/services/geolocation/calculate_destination_point.dart';

class MarkerGenerator {
  static List<Marker> generateMarkers(
      LatLng userLocation, int numberOfMarkers) {
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
      LatLng randomLocation = _generateRandomLocation(userLocation, 1000);
      markers.add(
        Marker(
          width: 30,
          height: 30,
          point: randomLocation,
          child: Icon(Icons.location_on, size: 30),
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
