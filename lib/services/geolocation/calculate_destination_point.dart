import 'dart:math';
import 'package:latlong2/latlong.dart';

class MapMethods {
  static calculateDestinationPoint(
    LatLng start,
    double distanceMeters,
    double bearingDegrees,
  ) {
    const double radiusEarth = 6371000; // Radius of the Earth in meters

    double lat1 = radians(start.latitude);
    double lon1 = radians(start.longitude);
    double angularDistance = distanceMeters / radiusEarth;
    double bearingRadians = radians(bearingDegrees);

    double lat2 = asin(sin(lat1) * cos(angularDistance) +
        cos(lat1) * sin(angularDistance) * cos(bearingRadians));

    double lon2 = lon1 +
        atan2(sin(bearingRadians) * sin(angularDistance) * cos(lat1),
            cos(angularDistance) - sin(lat1) * sin(lat2));

    return LatLng(degrees(lat2), degrees(lon2));
  }

  static radians(double degrees) {
    return degrees * (pi / 180);
  }

  static degrees(double radians) {
    return radians * (180 / pi);
  }
}
