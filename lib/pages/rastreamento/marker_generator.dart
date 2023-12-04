import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:prog_app/models/cart/cart_item.dart';
import 'package:prog_app/services/geolocation/map_methods.dart';
import 'package:prog_app/services/pedidos/pedidos_service.dart';

class MarkerGenerator {
  static List<Marker> generateMarkers(LatLng userLocation,
      PedidosService pedidosService, BuildContext context) {
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

    // Dynamically generate other markers for cart items
    for (CartItem cartItem in pedidosService.pedidos) {
      LatLng itemLocation = LatLng(cartItem.latitude!, cartItem.longitude!);

      double distanceFromUser = MapMethods.calculateHaversineDistance(
          userLocation.latitude,
          userLocation.longitude,
          itemLocation.latitude,
          itemLocation.longitude);

      var timeDelivery = (distanceFromUser.truncate() / 2000).truncate();

      markers.add(
        Marker(
          width: 30,
          height: 30,
          point: itemLocation,
          child: GestureDetector(
            onTap: () => showDialog<String>(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: Text('Tempo de entrega - ${cartItem.name}'),
                content: Text(
                    "O pedido ${cartItem.name} está a ${distanceFromUser.truncate() / 100} km de distancia. \nTempo estimado para entrega de $timeDelivery dias!"),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.pop(context, 'OK'),
                    child: const Text('OK'),
                  ),
                ],
              ),
            ),
            child: Icon(Icons.shopping_bag, size: 30),
          ),
        ),
      );
    }

    return markers;
  }
}
