import 'package:flutter/material.dart';
import 'package:food_delivery_app/models/models.dart';
import 'package:food_delivery_app/screens/home_screen.dart';
import 'package:food_delivery_app/screens/location_screen.dart';
//import 'package:flutter/src/widgets/container.dart';
//import 'package:flutter/src/widgets/framework.dart';

class RestaurantListingScreen extends StatelessWidget {
  static const String routeName = '/restaurant_lsiting';

  static Route route({required List<Restaurant> restaurants}) {
    return MaterialPageRoute(
        builder: (_) => RestaurantListingScreen(restaurants: restaurants),
        settings: const RouteSettings(name: routeName));
  }

  final List<Restaurant> restaurants;
  const RestaurantListingScreen({super.key, required this.restaurants});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Restaurants",
            style: Theme.of(context)
                .textTheme
                .headline3!
                .copyWith(color: Colors.black),
          ),
          backgroundColor: Theme.of(context).primaryColor,
          leading: const BackButton(color: Colors.black),
        ),
        body: ListView.builder(
            itemCount: restaurants.length,
            itemBuilder: (context, index) {
              return RestaurantCard(restaurant: restaurants[index]);
            }));
  }
}
