import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:prog_app/services/users/users_services.dart';
import 'package:provider/provider.dart';
import '';

class RastreamentoPage extends StatefulWidget {
  const RastreamentoPage({super.key});

  @override
  State<RastreamentoPage> createState() => _RastreamentoPageState();
}

class _RastreamentoPageState extends State<RastreamentoPage> {
  Future _positionUser = determinePosition();

  @override
  Widget build(BuildContext context) {
    return Consumer<UsersServices>(builder: (context, userServices, _) {
      return Stack(
        children: [
          FlutterMap(
            options: MapOptions(
              initialCenter: userServices.determinePosition().then((position) => {
                new LatLng(position.latitude, position.longitude);
              }),
              initialZoom: 3.2,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.app',
              ),
              RichAttributionWidget(attributions: [
                TextSourceAttribution(
                  'OpenStreetMap contributors',
                  onTap: () => {},
                ),
              ])
            ],
          ),
        ],
      );
    });
  }
}
