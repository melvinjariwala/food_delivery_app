// ignore_for_file: avoid_unnecessary_containers, deprecated_member_use, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery_app/blocs/basket/basket_bloc.dart';
import 'package:food_delivery_app/models/models.dart';
import 'package:food_delivery_app/screens/basket.dart';
import 'package:food_delivery_app/widgets/restaurant_info.dart';

class RestaurantDetailsScreen extends StatelessWidget {
  static const String routeName = '/restaurant_details';

  static Route route({required Restaurant restaurant}) {
    return MaterialPageRoute(
        builder: (_) => RestaurantDetailsScreen(restaurant: restaurant),
        settings: const RouteSettings(name: routeName));
  }

  final Restaurant restaurant;

  const RestaurantDetailsScreen({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    print("Restaurant : ${restaurant.priceCategory}");
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        bottomNavigationBar: BottomAppBar(
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 50),
                        backgroundColor: Theme.of(context).primaryColor),
                    onPressed: () {
                      Navigator.pushNamed(context, BasketScreen.routeName);
                    },
                    child: const Text("Basket",
                        style: TextStyle(color: Colors.black)))
              ],
            ),
          ),
        ),
        extendBodyBehindAppBar: true,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 250,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.vertical(
                        bottom: Radius.elliptical(
                            MediaQuery.of(context).size.width, 50)),
                    image: DecorationImage(
                        image: NetworkImage(
                          restaurant.imgUrl,
                        ),
                        fit: BoxFit.cover)),
              ),
              RestaurantInfo(restaurant: restaurant),
              ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: restaurant.categories.length,
                  itemBuilder: (context, index) {
                    return _buildMenuItems(context, restaurant, index);
                  })
            ],
          ),
        ));
  }
}

Widget _buildMenuItems(BuildContext context, Restaurant restaurant, int index) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: Text(restaurant.categories[index].name,
            style: Theme.of(context).textTheme.headline3),
      ),
      Column(
        children: restaurant.products
            .where((product) =>
                product.category == restaurant.categories[index].name)
            .map((product) => Column(
                  children: [
                    Container(
                      color: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: ListTile(
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        title: Text(product.name,
                            style: Theme.of(context).textTheme.headline4),
                        subtitle: Text(product.description,
                            style: Theme.of(context).textTheme.bodyText1),
                        trailing: SizedBox(
                          width: 100,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Flexible(
                                child: Text(
                                  "\$${product.price}",
                                  style: Theme.of(context).textTheme.bodyText1,
                                  overflow: TextOverflow.visible,
                                ),
                              ),
                              BlocBuilder<BasketBloc, BasketState>(
                                builder: (context, state) {
                                  return IconButton(
                                      onPressed: () {
                                        context
                                            .read<BasketBloc>()
                                            .add(AddProduct(product));
                                      },
                                      icon: Icon(Icons.add_circle,
                                          color:
                                              Theme.of(context).primaryColor));
                                },
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    const Divider(height: 2)
                  ],
                ))
            .toList(),
      )
    ],
  );
}
