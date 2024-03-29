// ignore_for_file: library_prefixes

import 'package:equatable/equatable.dart';
import 'package:food_delivery_app/models/deliver_time_model.dart';
import 'package:food_delivery_app/models/product_model.dart';
import 'package:food_delivery_app/models/voucher_model.dart';
import 'package:hive/hive.dart';

part 'basket_model.g.dart';

@HiveType(typeId: 1)
class Basket extends Equatable {
  @HiveField(0)
  final List<Product> products;
  @HiveField(1)
  final bool cutlery;
  @HiveField(2)
  final Voucher? voucher;
  @HiveField(3)
  final DeliveryTime? deliveryTime;

  const Basket(
      {this.products = const <Product>[],
      this.cutlery = false,
      this.voucher,
      this.deliveryTime});

  static const empty = Basket();

  Basket copyWith(
      {List<Product>? products,
      bool? cutlery,
      Voucher? voucher,
      DeliveryTime? deliveryTime}) {
    return Basket(
        products: products ?? this.products,
        cutlery: cutlery ?? this.cutlery,
        voucher: voucher ?? this.voucher,
        deliveryTime: deliveryTime ?? this.deliveryTime);
  }

  @override
  List<Object?> get props => [products, cutlery, voucher, deliveryTime];

  Map itemQuantity(products) {
    var quantity = {};

    products.forEach((product) {
      if (!quantity.containsKey(product)) {
        quantity[product] = 1;
      } else {
        quantity[product] += 1;
      }
    });
    return quantity;
  }

  double get subtotal =>
      products.fold(0, (total, current) => total + current.price);

  double total(subtotal) {
    return voucher == null ? subtotal + 2.99 : subtotal + 2.99 - voucher!.value;
  }

  String get subtotalToString => subtotal.toStringAsFixed(2);

  String get totalToString => total(subtotal).toStringAsFixed(2);
}
