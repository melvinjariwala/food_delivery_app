import 'package:food_delivery_app/datasources/local_datasource.dart';
import 'package:food_delivery_app/models/basket_model.dart';
import 'package:food_delivery_app/repositories/basket/base_basket_repository.dart';
import 'package:hive_flutter/hive_flutter.dart';

class BasketRepository extends BaseBasketRepository {
  final LocalDatasource localDatasource;

  BasketRepository({required this.localDatasource});

  @override
  Future<Basket> getBasket() async {
    Box box = await localDatasource.openBox('user_basket');
    Basket? basket = localDatasource.getBasket(box);

    basket ??= Basket.empty;

    return basket;
  }

  @override
  Future<void> saveBasket(Basket basket) async {
    Box box = await localDatasource.openBox('user_basket');
    localDatasource.clearBox(box);
    localDatasource.addBasket(box, basket);
  }
}
