import 'package:food_delivery_app/models/place_model.dart';

abstract class BaseLocationRepository {
  Future<List<Place>> getAutocomplete(String searchInput);
  Future<Place?> getPlace(String? placeId);
}
