import 'package:food_delivery_app/models/basket_model.dart';

abstract class BaseBasketRepository {
  Future<Basket> getBasket();
  Future<void> saveBasket(Basket basket);
}
