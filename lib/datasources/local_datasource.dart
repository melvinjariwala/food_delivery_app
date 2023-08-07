// ignore_for_file: prefer_is_empty

import 'package:food_delivery_app/models/basket_model.dart';
import 'package:food_delivery_app/models/place_model.dart';
import 'package:hive/hive.dart';

abstract class BaseLocalDatasource {
  Future<Box> openBox(String boxName);
  Future<void> clearBox(Box box);

  Place? getPlace(Box box);
  Future<void> addPlace(Box box, Place place);

  Basket? getBasket(Box box);
  Future<void> addBasket(Box box, Basket basket);
}

class LocalDatasource extends BaseLocalDatasource {
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
    } else {
      return null;
    }
  }

  @override
  Future<Box> openBox(String boxName) async {
    Box box = await Hive.openBox(boxName);
    return box;
  }

  @override
  Future<void> addBasket(Box box, Basket basket) async {
    await box.add(basket);
  }

  @override
  Basket? getBasket(Box box) {
    if (box.values.length < 0) {
      return box.values.first as Basket;
    } else {
      return null;
    }
  }
}
