import 'package:flutter/material.dart';
import 'package:food_delivery_app/models/models.dart';
import 'package:food_delivery_app/widgets/restaurant_tags.dart';

class RestaurantInfo extends StatelessWidget {
  final Restaurant restaurant;
  const RestaurantInfo({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            restaurant.name,
            style: Theme.of(context).textTheme.headline3,
          ),
          const SizedBox(height: 10),
          RestaurantTags(restaurant: restaurant),
          const SizedBox(height: 10),
          Text(
              "${restaurant.distance} Km - \$${restaurant.deliveryFee} Delivery Fee",
              style: Theme.of(context).textTheme.bodyText1),
          const SizedBox(height: 10),
          Text("Restaurant Information",
              style: Theme.of(context).textTheme.headline5),
          const SizedBox(height: 5),
          Text("Geetha Restaurant is your go to restaurant for Vegetarian food",
              style: Theme.of(context).textTheme.bodyText1),
        ],
      ),
    );
  }
}
