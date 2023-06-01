import 'package:flutter/material.dart';
import 'package:food_delivery_app/screens/filter.dart';

class FoodSearchBox extends StatelessWidget {
  const FoodSearchBox({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Material(
                elevation: 3,
                borderRadius: BorderRadius.circular(32),
                child: TextField(
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Search your desired food',
                      suffixIcon: Icon(
                        Icons.search,
                        color: Theme.of(context).primaryColor,
                      ),
                      contentPadding: const EdgeInsets.only(
                          top: 20, bottom: 5, right: 5, left: 15),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(32),
                          borderSide: const BorderSide(color: Colors.white)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(32),
                          borderSide: const BorderSide(color: Colors.white))),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Material(
              elevation: 3,
              borderRadius: BorderRadius.circular(12.0),
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.0)),
                child: IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, FilterScreen.routeName);
                    },
                    icon: Icon(Icons.menu,
                        color: Theme.of(context).primaryColor)),
              ),
            ),
          )
        ],
      ),
    );
  }
}
