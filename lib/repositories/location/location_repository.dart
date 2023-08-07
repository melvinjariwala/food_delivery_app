import 'package:food_delivery_app/datasources/local_datasource.dart';
import 'package:food_delivery_app/datasources/places_api.dart';
import 'package:food_delivery_app/models/place_model.dart';
import 'package:food_delivery_app/repositories/location/base_location_repository.dart';
import 'package:hive/hive.dart';

class LocationRepository extends BaseLocationRepository {
  final LocalDatasource localDatasource;
  final PlacesAPI placesAPI;

  LocationRepository({required this.localDatasource, required this.placesAPI});
  @override
  Future<List<Place>> getAutocomplete(String searchInput) {
    return placesAPI.getAutocomplete(searchInput);
  }

  @override
  Future<Place?> getPlace([String? placeId]) async {
    if (placeId == null) {
      Box box = await localDatasource.openBox('user_location');
      Place? place = localDatasource.getPlace(box);
      return place;
    } else {
      final Place place = await placesAPI.getPlace(placeId);
      Box box = await localDatasource.openBox('user_location');
      localDatasource.clearBox(box);
      localDatasource.addPlace(box, place);
      return place;
    }
  }
}
