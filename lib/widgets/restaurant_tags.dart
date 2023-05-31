// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:food_delivery_app/models/restaurant_model.dart';

class RestaurantTags extends StatelessWidget {
  const RestaurantTags({
    Key? key,
    required this.restaurant,
  }) : super(key: key);

  final Restaurant restaurant;

  @override
  Widget build(BuildContext context) {
    print('Restaurant Tags length : ${restaurant.tags.length}');
    return Row(
        children: restaurant.tags
            .map((tag) =>
                restaurant.tags.indexOf(tag) == restaurant.tags.length - 1
                    ? Text(tag,
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(color: Colors.black))
                    : Text(
                        "$tag, ",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(color: Colors.black),
                      ))
            .toList());
  }
}
