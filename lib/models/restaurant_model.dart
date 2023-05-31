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

  Restaurant(
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
        tags: ['North Indian', 'South Indian', 'Fast Food'],
        menuItems: Item.MenuItem.menuItems
            .where((menuItem) => menuItem.restaurantId == '1')
            .toList(),
        deliveryTime: 30,
        deliveryFee: 2.99,
        distance: 0.1),
    Restaurant(
        id: 2,
        name: 'Geetha Restaurant',
        imgUrl:
            "https://lh5.googleusercontent.com/p/AF1QipOlOWdqWhzm99NEXDo2PlbLOA6DBYa9EQj3JWim=w325-h218-n-k-no",
        tags: ['North Indian', 'South Indian', 'Fast Food'],
        menuItems: Item.MenuItem.menuItems
            .where((menuItem) => menuItem.restaurantId == '1')
            .toList(),
        deliveryTime: 30,
        deliveryFee: 2.99,
        distance: 0.1),
    Restaurant(
        id: 3,
        name: 'Geetha Restaurant',
        imgUrl:
            "https://lh5.googleusercontent.com/p/AF1QipOlOWdqWhzm99NEXDo2PlbLOA6DBYa9EQj3JWim=w325-h218-n-k-no",
        tags: ['North Indian', 'South Indian', 'Fast Food'],
        menuItems: Item.MenuItem.menuItems
            .where((menuItem) => menuItem.restaurantId == '1')
            .toList(),
        deliveryTime: 30,
        deliveryFee: 2.99,
        distance: 0.1),
    Restaurant(
        id: 4,
        name: 'Geetha Restaurant',
        imgUrl:
            "https://lh5.googleusercontent.com/p/AF1QipOlOWdqWhzm99NEXDo2PlbLOA6DBYa9EQj3JWim=w325-h218-n-k-no",
        tags: ['North Indian', 'South Indian', 'Fast Food'],
        menuItems: Item.MenuItem.menuItems
            .where((menuItem) => menuItem.restaurantId == '1')
            .toList(),
        deliveryTime: 30,
        deliveryFee: 2.99,
        distance: 0.1),
    Restaurant(
        id: 5,
        name: 'Geetha Restaurant',
        imgUrl:
            "https://lh5.googleusercontent.com/p/AF1QipOlOWdqWhzm99NEXDo2PlbLOA6DBYa9EQj3JWim=w325-h218-n-k-no",
        tags: ['North Indian', 'South Indian', 'Fast Food'],
        menuItems: Item.MenuItem.menuItems
            .where((menuItem) => menuItem.restaurantId == '1')
            .toList(),
        deliveryTime: 30,
        deliveryFee: 2.99,
        distance: 0.1),
  ];
}
