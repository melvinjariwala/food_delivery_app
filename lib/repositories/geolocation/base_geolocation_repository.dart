// ignore_for_file: body_might_complete_normally_nullable

import 'package:geolocator/geolocator.dart';

abstract class BaseGeoloacationRepository {
  Future<Position?> getCurrentLocation();
}
