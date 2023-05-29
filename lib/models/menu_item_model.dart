import 'package:equatable/equatable.dart';

class MenuItem extends Equatable {
  final int id;
  final int restaurantId;
  final String name;
  final String description;
  final double price;
  final String imgUrl;

  MenuItem(
      {required this.id,
      required this.restaurantId,
      required this.name,
      required this.description,
      required this.price,
      required this.imgUrl});

  @override
  List<Object?> get props =>
      [id, restaurantId, name, description, price, imgUrl];

  static List<MenuItem> menuItems = [
    MenuItem(
        id: 1,
        restaurantId: 1,
        name: 'Pizza',
        description: 'Pizza with Tomatoes',
        price: 5.99,
        imgUrl: 'imgUrl'),
    MenuItem(
        id: 2,
        restaurantId: 1,
        name: 'Coca Cola',
        description: 'A Cold Beverage',
        price: 1.99,
        imgUrl: 'imgUrl'),
  ];
}
