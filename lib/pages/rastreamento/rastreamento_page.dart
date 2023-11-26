import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:prog_app/pages/rastreamento/marker_generator.dart';
import 'package:prog_app/services/users/users_services.dart';
import 'package:provider/provider.dart';
import '../../services/geolocation/calculate_destination_point.dart';

class RastreamentoPage extends StatefulWidget {
  const RastreamentoPage({super.key});

  @override
  State<RastreamentoPage> createState() => _RastreamentoPageState();
}

class _RastreamentoPageState extends State<RastreamentoPage> {
  late LatLng _userLocation;
  late List<Marker> _markers;

  @override
  void initState() {
    super.initState();
    _markers = [];
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UsersServices>(builder: (context, userServices, _) {
      return FutureBuilder<Position>(
        future: userServices.determinePosition(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Display a loading indicator while waiting for the user's position
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            // Handle any errors that occurred while getting the user's position
            return Text('Error: ${snapshot.error}');
          } else if (!snapshot.hasData) {
            // Handle the case where the future is null
            return Text('No data available');
          }

          LatLng _userLocation =
              LatLng(snapshot.data!.latitude, snapshot.data!.longitude);

          _markers = MarkerGenerator.generateMarkers(_userLocation, 2);

          return Stack(
            children: [
              FlutterMap(
                options: MapOptions(
                  initialCenter: _userLocation,
                  initialZoom: 15,
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                        'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    userAgentPackageName: 'com.example.app',
                  ),
                  RichAttributionWidget(attributions: [
                    TextSourceAttribution(
                      'OpenStreetMap contributors',
                      onTap: () => {},
                    ),
                  ]),
                  MarkerLayer(markers: _markers)
                ],
              ),
            ],
          );
        },
      );
    });
  }
}
