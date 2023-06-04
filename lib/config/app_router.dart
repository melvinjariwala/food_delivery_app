//import 'package:flutter/cupertino.dart';
// ignore_for_file: avoid_print, no_duplicate_case_values

import 'package:flutter/material.dart';
import 'package:food_delivery_app/models/models.dart';
import 'package:food_delivery_app/screens/basket.dart';
import 'package:food_delivery_app/screens/checkout.dart';
import 'package:food_delivery_app/screens/delivery_time.dart';
import 'package:food_delivery_app/screens/edit_basket.dart';
import 'package:food_delivery_app/screens/filter.dart';
import 'package:food_delivery_app/screens/home_screen.dart';
import 'package:food_delivery_app/screens/location_screen.dart';
import 'package:food_delivery_app/screens/restaurant_details.dart';
import 'package:food_delivery_app/screens/restaurant_listing.dart';
import 'package:food_delivery_app/screens/voucher.dart';

class AppRouter {
  static Route onGenerateRoute(RouteSettings settings) {
    print('The route is : ${settings.name}');
    switch (settings.name) {
      case '/':
        return HomeScreen.route();
      case HomeScreen.routeName:
        return HomeScreen.route();
      case LocationScreen.routeName:
        return LocationScreen.route();
      case BasketScreen.routeName:
        return BasketScreen.route();
      case CheckoutScreen.routeName:
        return CheckoutScreen.route();
      case DeliveryTime.routeName:
        return DeliveryTime.route();
      case EditBasketScreen.routeName:
        return EditBasketScreen.route();
      case FilterScreen.routeName:
        return FilterScreen.route();
      case RestaurantDetailsScreen.routeName:
        return RestaurantDetailsScreen.route(
            restaurant: settings.arguments as Restaurant);
      case RestaurantListingScreen.routeName:
        return RestaurantListingScreen.route(
            restaurants: settings.arguments as List<Restaurant>);
      case VoucherScreen.routeName:
        return VoucherScreen.route();
      default:
        return _errorRoute();
    }
  }

  static Route _errorRoute() {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
              appBar: AppBar(
                title: const Text('Error'),
              ),
            ),
        settings: const RouteSettings(name: '/error'));
  }
}
