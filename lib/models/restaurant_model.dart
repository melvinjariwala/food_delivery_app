// ignore_for_file: library_prefixes

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:food_delivery_app/models/category_model.dart';
import 'package:food_delivery_app/models/opening_hour_model.dart';
import 'package:food_delivery_app/models/product_model.dart';

class Restaurant extends Equatable {
  final String id;
  final String name;
  final String imgUrl;
  final String description;
  final List<String> tags;
  final List<Category> categories;
  final List<Product> products;
  final List<OpeningHours> openingHours;
  final int deliveryTime;
  final String priceCategory;
  final double deliveryFee;
  final double distance;

  const Restaurant(
      {required this.id,
      required this.name,
      required this.imgUrl,
      required this.description,
      required this.tags,
      required this.categories,
      required this.products,
      required this.openingHours,
      this.deliveryTime = 15,
      this.priceCategory = '\$',
      this.deliveryFee = 2.99,
      this.distance = 15});

  @override
  List<Object?> get props => [
        id,
        name,
        imgUrl,
        description,
        tags,
        categories,
        products,
        openingHours,
        deliveryTime,
        priceCategory,
        deliveryFee,
        distance
      ];

  factory Restaurant.fromSnapshot(DocumentSnapshot snap) {
    return Restaurant(
        id: snap.id,
        name: snap['name'],
        imgUrl: snap['imgUrl'],
        description: snap['description'],
        //priceCategory: snap['priceCategory'],
        tags: (snap['tags'] as List).map((tag) {
          return tag as String;
        }).toList(),
        categories: (snap['categories'] as List).map((category) {
          return Category.fromSnapshot(category);
        }).toList(),
        products: (snap['products'] as List).map((product) {
          return Product.fromSnapshot(product);
        }).toList(),
        openingHours: (snap['openingHours'] as List).map((openingHour) {
          return OpeningHours.fromSnapshot(openingHour);
        }).toList());
  }
}
