// ignore_for_file: library_prefixes

import 'package:equatable/equatable.dart';
import 'menu_item_model.dart' as Item;

class Basket extends Equatable {
  final List<Item.MenuItem> items;
  final bool cutlery;

  Basket({this.items = const <Item.MenuItem>[], this.cutlery = false});

  Basket copyWith({List<Item.MenuItem>? items, bool? cutlery}) {
    return Basket(items: items ?? this.items, cutlery: cutlery ?? this.cutlery);
  }

  @override
  List<Object?> get props => [items, cutlery];

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
    return subtotal + 5;
  }

  String get subtotalToString => subtotal.toStringAsFixed(2);

  String get totalToString => total(subtotal).toStringAsFixed(2);
}
