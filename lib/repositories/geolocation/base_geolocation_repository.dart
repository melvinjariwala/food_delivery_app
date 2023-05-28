import 'package:geolocator/geolocator.dart';

abstract class BaseGeoloacationRepository {
  Future<Position?> getCurrentLocation() async {}
}
