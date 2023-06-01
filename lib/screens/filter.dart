import 'package:flutter/material.dart';
import 'package:food_delivery_app/models/category_model.dart';
import 'package:food_delivery_app/models/price_model.dart';

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
              CustomPriceFilter(prices: Price.prices),
              Text("Category",
                  style: Theme.of(context)
                      .textTheme
                      .headline4!
                      .copyWith(color: Theme.of(context).primaryColorDark)),
              CustomCategoryFilter(categories: Category.categories)
            ],
          ),
        ));
  }
}

class CustomCategoryFilter extends StatelessWidget {
  final List<Category> categories;
  const CustomCategoryFilter({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: categories.length,
      itemBuilder: (context, index) {
        return Container(
          width: double.infinity,
          margin: const EdgeInsets.only(top: 10),
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10.0)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                categories[index].name,
                style: Theme.of(context).textTheme.headline5,
              ),
              SizedBox(
                  height: 25,
                  child: Checkbox(value: false, onChanged: (bool? newValue) {}))
            ],
          ),
        );
      },
    );
  }
}

class CustomPriceFilter extends StatelessWidget {
  final List<Price> prices;
  const CustomPriceFilter({super.key, required this.prices});

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: prices
            .map((price) => InkWell(
                  onTap: () {},
                  child: Container(
                    margin: const EdgeInsets.only(top: 10, bottom: 10),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.white),
                    child: Text(price.price,
                        style: Theme.of(context).textTheme.headline5),
                  ),
                ))
            .toList());
  }
}
