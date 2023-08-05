import 'package:food_delivery_app/models/place_model.dart';
import 'package:food_delivery_app/repositories/local_storage/base_local_storage_repository.dart';
import 'package:hive/hive.dart';

class LocalStorageRepository extends BaseLocalStorageRepository {
  String boxName = 'user_location';
  Type boxType = Place;

  @override
  Future<void> addPlace(Box box, Place place) async {
    await box.put(place.placeId, place);
  }

  @override
  Future<void> clearBox(Box box) async {
    await box.clear();
  }

  @override
  Place? getPlace(Box box) {
    if (box.values.length > 0) {
      return box.values.first as Place;
    }
  }

  @override
  Future<Box> openBox() async {
    Box box = await Hive.openBox<Place>(boxName);
    return box;
  }
}
