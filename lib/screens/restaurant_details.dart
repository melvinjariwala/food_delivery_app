import 'package:flutter/material.dart';
import 'package:food_delivery_app/models/models.dart';
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
                    onPressed: () {},
                    child: const Text("Basket"))
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
                  itemCount: restaurant.tags.length,
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
        child: Text(restaurant.tags[index],
            style: Theme.of(context).textTheme.headline3),
      ),
      Column(
        children: restaurant.menuItems
            .where((menuItem) => menuItem.category == restaurant.tags[index])
            .map((menuItem) => Column(
                  children: [
                    Container(
                      color: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: ListTile(
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        title: Text(menuItem.name,
                            style: Theme.of(context).textTheme.headline5),
                        subtitle: Text(menuItem.description,
                            style: Theme.of(context).textTheme.bodyText1),
                        trailing: SizedBox(
                          width: 85,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text("\$${menuItem.price}",
                                  style: Theme.of(context).textTheme.bodyText1),
                              IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.add_circle,
                                      color: Theme.of(context).primaryColor))
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
