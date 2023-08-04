// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery_app/blocs/restaurant/restaurant_bloc.dart';
import 'package:food_delivery_app/models/category_model.dart';
import 'package:food_delivery_app/models/restaurant_model.dart';
import 'package:food_delivery_app/screens/restaurant_listing.dart';

class CategoryBox extends StatelessWidget {
  final Category category;
  const CategoryBox({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    // List<Restaurant> restaurants = Restaurant.restaurants
    //     .where((restaurant) => restaurant.tags.contains(category.name))
    //     .toList();
    List<Restaurant> restaurants = context.select((RestaurantBloc bloc) {
      if (bloc.state is RestaurantLoaded) {
        return (bloc.state as RestaurantLoaded).restaurants;
      } else {
        return <Restaurant>[];
      }
    });

    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, RestaurantListingScreen.routeName,
            arguments: restaurants);
      },
      child: Container(
        padding: const EdgeInsets.all(5.0),
        //margin: const EdgeInsets.only(right: 5.0),
        child: Material(
          elevation: 3,
          borderRadius: BorderRadius.circular(12.0),
          child: Container(
            width: 80,
            //margin: const EdgeInsets.only(right: 5.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                color: Theme.of(context).primaryColor),
            child: Stack(
              children: [
                Positioned(
                  top: 10,
                  left: 10,
                  child: Container(
                    height: 50,
                    width: 60,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.white),
                    child: Image.asset(category.imageUrl),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      category.name,
                      style: Theme.of(context)
                          .textTheme
                          .headline5!
                          .copyWith(color: Colors.black),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
