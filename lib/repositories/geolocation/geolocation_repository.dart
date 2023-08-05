// ignore_for_file: avoid_print

import 'package:food_delivery_app/repositories/geolocation/base_geolocation_repository.dart';
import 'package:geolocator/geolocator.dart';

class GeoLocationRepository extends BaseGeoloacationRepository {
  GeoLocationRepository();

  @override
  Future<Position> getCurrentLocation() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error("Location not available");
    } else {
      return await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
    }
  }
}
