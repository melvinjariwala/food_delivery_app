import 'package:food_delivery_app/models/place_model.dart';
import 'package:hive/hive.dart';

abstract class BaseLocalStorageRepository {
  Future<Box> openBox();
  Place? getPlace(Box box);
  Future<void> addPlace(Box box, Place place);
  Future<void> clearBox(Box box);
}
