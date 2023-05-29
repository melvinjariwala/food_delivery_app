// ignore_for_file: avoid_print

import 'package:food_delivery_app/repositories/geolocation/base_geolocation_repository.dart';
import 'package:geolocator/geolocator.dart';

class GeoLocationRepository extends BaseGeoloacationRepository {
  GeoLocationRepository();

  @override
  Future<Position> getCurrentLocation() async {
    try {
      final Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      print('Current position : $position');
      return position;
    } catch (e) {
      print("Error fetching current location : $e");
      rethrow;
    }
  }
}
