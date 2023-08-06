import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_delivery_app/models/place_model.dart';
import 'package:food_delivery_app/models/restaurant_model.dart';
import 'package:food_delivery_app/repositories/restaurant/base_restaurant_repository.dart';
import 'package:geolocator/geolocator.dart';

class RestaurantRepository extends BaseRestaurantRepository {
  RestaurantRepository({FirebaseFirestore? firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firebaseFirestore;

  @override
  Stream<List<Restaurant>> getRestaurant() {
    return _firebaseFirestore
        .collection('restaurants')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => Restaurant.fromSnapshot(doc)).toList();
    });
  }

  @override
  Stream<List<Restaurant>> getNearbyRestaurants(Place selectedAddress) {
    Stream<List<Restaurant>> restaurants = getRestaurant();

    return restaurants.map((restaurant) {
      return restaurant
          .where((restaurant) =>
              _getRestaurantDistance(restaurant.address, selectedAddress) <= 15)
          .toList();
    });
  }

  _getRestaurantDistance(Place address, Place selectedAddress) {
    GeolocatorPlatform geolocatorPlatform = GeolocatorPlatform.instance;
    var distance = geolocatorPlatform.distanceBetween(
            address.lat.toDouble(),
            address.lng.toDouble(),
            selectedAddress.lat.toDouble(),
            selectedAddress.lng.toDouble()) ~/
        1000;
    return distance;
  }
}
