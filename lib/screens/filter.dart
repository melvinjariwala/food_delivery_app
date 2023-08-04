// ignore_for_file: avoid_print, avoid_unnecessary_containers, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery_app/blocs/filters/filters_bloc.dart';

import 'package:food_delivery_app/screens/restaurant_listing.dart';
import 'package:food_delivery_app/widgets/custom_category_filter.dart';
import 'package:food_delivery_app/widgets/custom_price_filter.dart';

class FilterScreen extends StatelessWidget {
  const FilterScreen({super.key});
  static const String routeName = '/filter';

  static Route route() {
    return MaterialPageRoute(
        builder: (_) => const FilterScreen(),
        settings: const RouteSettings(name: routeName));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          centerTitle: true,
          title: Text("Filter",
              style: Theme.of(context)
                  .textTheme
                  .headline3!
                  .copyWith(color: Colors.black)),
          backgroundColor: Theme.of(context).primaryColor,
          leading: const BackButton(color: Colors.black),
        ),
        bottomNavigationBar: BottomAppBar(
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BlocBuilder<FiltersBloc, FiltersState>(
                  builder: (context, state) {
                    if (state is FiltersLoading) {
                      return Center(
                          child: CircularProgressIndicator(
                              color: Theme.of(context).primaryColor));
                    }
                    if (state is FiltersLoaded) {
                      return ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 50),
                              backgroundColor: Theme.of(context).primaryColor),
                          onPressed: () {
                            print(
                                "filteredRestaurant : ${state.filteredRestaurants}");
                            Navigator.pushNamed(
                                context, RestaurantListingScreen.routeName,
                                arguments: state.filteredRestaurants);
                          },
                          child: const Text("Apply"));
                    }
                    return const Center(child: Text("Something went wrong!"));
                  },
                )
              ],
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Price",
                  style: Theme.of(context)
                      .textTheme
                      .headline4!
                      .copyWith(color: Theme.of(context).primaryColorDark)),
              const CustomPriceFilter(),
              Text("Category",
                  style: Theme.of(context)
                      .textTheme
                      .headline4!
                      .copyWith(color: Theme.of(context).primaryColorDark)),
              const CustomCategoryFilter()
            ],
          ),
        ));
  }
}
