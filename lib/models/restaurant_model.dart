// ignore_for_file: library_prefixes

import 'package:equatable/equatable.dart';
import 'menu_item_model.dart' as Item;

class Restaurant extends Equatable {
  final int id;
  final String name;
  final String imgUrl;
  final List<String> tags;
  final List<Item.MenuItem> menuItems;
  final int deliveryTime;
  final double deliveryFee;
  final double distance;

  const Restaurant(
      {required this.id,
      required this.name,
      required this.imgUrl,
      required this.tags,
      required this.menuItems,
      required this.deliveryTime,
      required this.deliveryFee,
      required this.distance});

  @override
  List<Object?> get props =>
      [id, name, imgUrl, tags, menuItems, deliveryTime, deliveryFee, distance];

  static List<Restaurant> restaurants = [
    Restaurant(
        id: 1,
        name: 'Geetha Restaurant',
        imgUrl:
            "https://lh5.googleusercontent.com/p/AF1QipOlOWdqWhzm99NEXDo2PlbLOA6DBYa9EQj3JWim=w325-h218-n-k-no",
        tags: Item.MenuItem.menuItems
            .where((menuItem) => menuItem.restaurantId == 1)
            .map((menuItem) => menuItem.category)
            .toSet()
            .toList(),
        menuItems: Item.MenuItem.menuItems
            .where((menuItem) => menuItem.restaurantId == 1)
            .toList(),
        deliveryTime: 30,
        deliveryFee: 2.99,
        distance: 0.1),
    Restaurant(
        id: 2,
        name: 'Geetha Restaurant',
        imgUrl:
            "https://lh5.googleusercontent.com/p/AF1QipOlOWdqWhzm99NEXDo2PlbLOA6DBYa9EQj3JWim=w325-h218-n-k-no",
        tags: Item.MenuItem.menuItems
            .where((menuItem) => menuItem.restaurantId == 2)
            .map((menuItem) => menuItem.category)
            .toSet()
            .toList(),
        menuItems: Item.MenuItem.menuItems
            .where((menuItem) => menuItem.restaurantId == 1)
            .toList(),
        deliveryTime: 30,
        deliveryFee: 2.99,
        distance: 0.1),
    Restaurant(
        id: 3,
        name: 'Geetha Restaurant',
        imgUrl:
            "https://lh5.googleusercontent.com/p/AF1QipOlOWdqWhzm99NEXDo2PlbLOA6DBYa9EQj3JWim=w325-h218-n-k-no",
        tags: Item.MenuItem.menuItems
            .where((menuItem) => menuItem.restaurantId == 3)
            .map((menuItem) => menuItem.category)
            .toSet()
            .toList(),
        menuItems: Item.MenuItem.menuItems
            .where((menuItem) => menuItem.restaurantId == 3)
            .toList(),
        deliveryTime: 30,
        deliveryFee: 2.99,
        distance: 0.1),
    Restaurant(
        id: 4,
        name: 'Geetha Restaurant',
        imgUrl:
            "https://lh5.googleusercontent.com/p/AF1QipOlOWdqWhzm99NEXDo2PlbLOA6DBYa9EQj3JWim=w325-h218-n-k-no",
        tags: Item.MenuItem.menuItems
            .where((menuItem) => menuItem.restaurantId == 4)
            .map((menuItem) => menuItem.category)
            .toSet()
            .toList(),
        menuItems: Item.MenuItem.menuItems
            .where((menuItem) => menuItem.restaurantId == 4)
            .toList(),
        deliveryTime: 30,
        deliveryFee: 2.99,
        distance: 0.1),
    Restaurant(
        id: 5,
        name: 'Geetha Restaurant',
        imgUrl:
            "https://lh5.googleusercontent.com/p/AF1QipOlOWdqWhzm99NEXDo2PlbLOA6DBYa9EQj3JWim=w325-h218-n-k-no",
        tags: Item.MenuItem.menuItems
            .where((menuItem) => menuItem.restaurantId == 5)
            .map((menuItem) => menuItem.category)
            .toSet()
            .toList(),
        menuItems: Item.MenuItem.menuItems
            .where((menuItem) => menuItem.restaurantId == 5)
            .toList(),
        deliveryTime: 30,
        deliveryFee: 2.99,
        distance: 0.1),
  ];
}
