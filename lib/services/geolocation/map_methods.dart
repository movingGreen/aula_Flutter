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

  static double calculateHaversineDistance(
      double startLat, double startLng, double endLat, double endLng) {
    const int earthRadius = 6371000; // Radius of the Earth in meters

    // Convert latitude and longitude from degrees to radians
    double startLatRad = radians(startLat);
    double startLngRad = radians(startLng);
    double endLatRad = radians(endLat);
    double endLngRad = radians(endLng);

    // Calculate the change in coordinates
    double latDelta = endLatRad - startLatRad;
    double lngDelta = endLngRad - startLngRad;

    // Haversine formula
    double a = pow(sin(latDelta / 2), 2) +
        cos(startLatRad) * cos(endLatRad) * pow(sin(lngDelta / 2), 2);
    double c = 2 * atan2(sqrt(a), sqrt(1 - a));

    // Calculate the distance
    double distance = earthRadius * c;

    return distance;
  }
}
