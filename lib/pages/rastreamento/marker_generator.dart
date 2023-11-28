import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:prog_app/models/cart/cart_item.dart';
import 'package:prog_app/models/produtc/product_services.dart';
import 'package:prog_app/services/cart/cart_service.dart';
import 'package:prog_app/services/geolocation/calculate_destination_point.dart';
import 'package:provider/provider.dart';

class MarkerGenerator {
  static List<Marker> generateMarkers(
    CartService cartService,
    BuildContext context,
    LatLng userLocation,
    int numberOfMarkers,
  ) {
    List<Marker> markers = [];

    // Add user's location marker
    markers.add(
      Marker(
        width: 30,
        height: 30,
        point: userLocation,
        child: GestureDetector(
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Localização do usuário'),
                  content: Text(
                      'Lat = ${userLocation.latitude} // Long = ${userLocation.longitude}'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('OK'),
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );

    // List<CartItem> cartItens = cartService.getItems();

    for (int i = 1; i <= numberOfMarkers; i++) {
      LatLng randomLocation = _generateRandomLocation(userLocation, 100);
      markers.add(
        Marker(
          width: 30,
          height: 30,
          point: randomLocation,
          child: GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Localização do pedido'),
                    content: Text(
                        'Lat = ${randomLocation.latitude} // Long = ${randomLocation.longitude}'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('OK'),
                      ),
                    ],
                  );
                },
              );
            },
          ),
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
