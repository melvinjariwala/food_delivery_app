// ignore_for_file: body_might_complete_normally_nullable

import 'package:food_delivery_app/models/place_model.dart';

import '../../models/place_autocomplete_model.dart';

abstract class BasePlacesRepository {
  Future<List<PlaceAutocomplete>?> getAutocomplete(String searchInput) async {}

  Future<Place?> getPlace(String placeId) async {}
}
