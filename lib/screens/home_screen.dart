// ignore_for_file: deprecated_member_use, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery_app/blocs/authentication/authentication_bloc.dart';
import 'package:food_delivery_app/blocs/location/location_bloc.dart';
import 'package:food_delivery_app/blocs/restaurant/restaurant_bloc.dart';
import 'package:food_delivery_app/models/models.dart';
import 'package:food_delivery_app/models/promo_model.dart';
import 'package:food_delivery_app/screens/location_screen.dart';
import 'package:food_delivery_app/screens/restaurant_details.dart';
import 'package:food_delivery_app/widgets/category_box.dart';
import 'package:food_delivery_app/widgets/food_search_box.dart';
import 'package:food_delivery_app/widgets/promo_box.dart';
import 'package:food_delivery_app/widgets/restaurant_tags.dart';
//import 'package:flutter/src/widgets/container.dart';
//import 'package:flutter/src/widgets/framework.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  static const String routeName = '/home-screen';

  static Route route() {
    return MaterialPageRoute(
        builder: (_) => const HomeScreen(),
        settings: const RouteSettings(name: routeName));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: const CustomAppBar(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: SizedBox(
                height: 100,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: Category.categories.length,
                    itemBuilder: (context, index) {
                      return CategoryBox(category: Category.categories[index]);
                    }),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: SizedBox(
                height: 125,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: Promo.promos.length,
                    itemBuilder: (context, index) {
                      return PromotionBox(promo: Promo.promos[index]);
                    }),
              ),
            ),
            const FoodSearchBox(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Top Rated",
                  style: Theme.of(context).textTheme.headline4,
                ),
              ),
            ),
            BlocBuilder<RestaurantBloc, RestaurantState>(
              builder: (context, state) {
                if (state is RestaurantLoading) {
                  return Center(
                      child: CircularProgressIndicator(
                    color: Theme.of(context).primaryColor,
                  ));
                } else if (state is RestaurantLoaded) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: state.restaurants.length,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          return RestaurantCard(
                              restaurant: state.restaurants[index]);
                        }),
                  );
                }
                return const Center(
                  child: Text("Something went wrong!"),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}

class RestaurantCard extends StatelessWidget {
  final Restaurant restaurant;
  const RestaurantCard({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Material(
        elevation: 3,
        borderRadius: BorderRadius.circular(12.0),
        //color: Theme.of(context).primaryColorLight,
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () {
              Navigator.pushNamed(context, RestaurantDetailsScreen.routeName,
                  arguments: restaurant);
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 150,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                        image: DecorationImage(
                            image: NetworkImage(restaurant.imgUrl),
                            fit: BoxFit.cover)),
                  ),
                  Positioned(
                    top: 10,
                    right: 10,
                    child: Container(
                        width: 60,
                        height: 30,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12.0)),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            "${restaurant.deliveryTime} min",
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        )),
                  )
                ]),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(restaurant.name,
                          style: Theme.of(context).textTheme.headline4),
                      const SizedBox(height: 5.0),
                      RestaurantTags(restaurant: restaurant),
                      const SizedBox(height: 5.0),
                      Text(
                        "${restaurant.distance} Km - \$${restaurant.deliveryFee} Delivery fee",
                        style: Theme.of(context).textTheme.bodyText1,
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

mixin AppBarMixin implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class CustomAppBar extends StatelessWidget with AppBarMixin {
  const CustomAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).primaryColor,
      leading: IconButton(
          onPressed: () {
            context
                .read<AuthenticationBloc>()
                .add(AuthenticationLogoutRequest());
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.person),
          color: Colors.black),
      title: BlocBuilder<LocationBloc, LocationState>(
        builder: (context, state) {
          if (state is LocationLoading) {
            print("LocationLoading");
            return SizedBox(
              height: 50,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Current Location",
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(color: Colors.black),
                  ),
                  Text(
                    "Loading...",
                    style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .copyWith(color: Colors.black),
                  )
                ],
              ),
            );
          }
          if (state is LocationLoaded) {
            print("Appbar LocationLoaded");
            print("state.place.name : ${state.place.name}");
            return InkWell(
              onTap: () {
                Navigator.pushNamed(context, LocationScreen.routeName);
              },
              child: SizedBox(
                height: 50,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Current Location",
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(color: Colors.black),
                    ),
                    Text(
                      state.place.name,
                      style: Theme.of(context)
                          .textTheme
                          .headline6!
                          .copyWith(color: Colors.black),
                    )
                  ],
                ),
              ),
            );
          }
          return const Text("Something went wrong");
        },
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
}
