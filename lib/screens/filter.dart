import 'package:flutter/material.dart';
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
