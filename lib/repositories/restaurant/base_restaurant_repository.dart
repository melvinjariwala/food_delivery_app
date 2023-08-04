import 'package:food_delivery_app/models/restaurant_model.dart';

abstract class BaseRestaurantRepository {
  Stream<List<Restaurant>> getRestaurant();
}
