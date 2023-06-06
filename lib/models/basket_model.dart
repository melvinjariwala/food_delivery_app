// ignore_for_file: library_prefixes

import 'package:equatable/equatable.dart';
import 'package:food_delivery_app/models/deliver_time_model.dart';
import 'package:food_delivery_app/models/voucher_model.dart';
import 'menu_item_model.dart' as Item;

class Basket extends Equatable {
  final List<Item.MenuItem> items;
  final bool cutlery;
  final Voucher? voucher;
  final DeliveryTime? deliveryTime;

  const Basket(
      {this.items = const <Item.MenuItem>[],
      this.cutlery = false,
      this.voucher,
      this.deliveryTime});

  Basket copyWith(
      {List<Item.MenuItem>? items,
      bool? cutlery,
      Voucher? voucher,
      DeliveryTime? deliveryTime}) {
    return Basket(
        items: items ?? this.items,
        cutlery: cutlery ?? this.cutlery,
        voucher: voucher ?? this.voucher,
        deliveryTime: deliveryTime ?? this.deliveryTime);
  }

  @override
  List<Object?> get props => [items, cutlery, voucher, deliveryTime];

  Map itemQuantity(items) {
    var quantity = {};

    items.forEach((item) {
      if (!quantity.containsKey(item)) {
        quantity[item] = 1;
      } else {
        quantity[item] += 1;
      }
    });
    return quantity;
  }

  double get subtotal =>
      items.fold(0, (total, current) => total + current.price);

  double total(subtotal) {
    return voucher == null ? subtotal + 2.99 : subtotal + 2.99 - voucher!.value;
  }

  String get subtotalToString => subtotal.toStringAsFixed(2);

  String get totalToString => total(subtotal).toStringAsFixed(2);
}
