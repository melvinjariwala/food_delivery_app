import 'package:equatable/equatable.dart';

class MenuItem extends Equatable {
  final int id;
  final int restaurantId;
  final String name;
  final String description;
  final double price;
  final String imgUrl;
  final String category;

  MenuItem({
    required this.id,
    required this.restaurantId,
    required this.name,
    required this.description,
    required this.price,
    required this.imgUrl,
    required this.category,
  });

  @override
  List<Object?> get props =>
      [id, restaurantId, name, description, price, imgUrl, category];

  static List<MenuItem> menuItems = [
    MenuItem(
        id: 1,
        restaurantId: 1,
        name: 'Pizza',
        description: 'Pizza with Tomatoes',
        price: 5.99,
        imgUrl: 'imgUrl',
        category: 'Pizza'),
    MenuItem(
        id: 2,
        restaurantId: 1,
        name: 'Coca Cola',
        description: 'A Cold Beverage',
        price: 1.99,
        imgUrl: 'imgUrl',
        category: 'Drink'),
    MenuItem(
        id: 3,
        restaurantId: 1,
        name: 'Burger',
        description: 'Burger with veg. patty',
        price: 2.99,
        imgUrl: 'imgUrl',
        category: 'Burger'),
    MenuItem(
        id: 3,
        restaurantId: 2,
        name: 'Pizza',
        description: 'Pizza with Tomatoes',
        price: 5.99,
        imgUrl: 'imgUrl',
        category: 'Pizza'),
    MenuItem(
        id: 5,
        restaurantId: 2,
        name: 'Coca Cola',
        description: 'A Cold Beverage',
        price: 1.99,
        imgUrl: 'imgUrl',
        category: 'Drink'),
    MenuItem(
        id: 6,
        restaurantId: 2,
        name: 'Burger',
        description: 'Burger with veg. patty',
        price: 2.99,
        imgUrl: 'imgUrl',
        category: 'Burger'),
  ];
}
