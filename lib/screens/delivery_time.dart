// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery_app/blocs/basket/basket_bloc.dart';
import 'package:food_delivery_app/models/deliver_time_model.dart';

class DeliveryTimeScreen extends StatelessWidget {
  const DeliveryTimeScreen({super.key});
  static const String routeName = '/delivery_time';

  static Route route() {
    return MaterialPageRoute(
        builder: (_) => const DeliveryTimeScreen(),
        settings: const RouteSettings(name: routeName));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Delivery Time",
            style: Theme.of(context)
                .textTheme
                .headline3!
                .copyWith(color: Colors.black),
          ),
          leading: const BackButton(color: Colors.black),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        bottomNavigationBar: BottomAppBar(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 90.0),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor),
                onPressed: () {
                  Navigator.pop(context);
                },
                child:
                    const Text("Apply", style: TextStyle(color: Colors.black))),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Choose a Date",
                style: Theme.of(context)
                    .textTheme
                    .headline4!
                    .copyWith(color: Theme.of(context).primaryColorDark),
              ),
              Container(
                margin: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: Row(
                  children: [
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(context).primaryColor),
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text("Delivery is set for Today!")));
                        },
                        child: const Text("Today",
                            style: TextStyle(color: Colors.black))),
                    const SizedBox(width: 10.0),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(context).primaryColor),
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content:
                                      Text("Delivery is set for Tomorrow!")));
                        },
                        child: const Text("Tomorrow",
                            style: TextStyle(color: Colors.black)))
                  ],
                ),
              ),
              Text(
                "Choose the Time",
                style: Theme.of(context)
                    .textTheme
                    .headline4!
                    .copyWith(color: Theme.of(context).primaryColorDark),
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3, childAspectRatio: 2.5),
                      itemCount: DeliveryTime.deliveryTimes.length,
                      itemBuilder: (context, index) {
                        return BlocBuilder<BasketBloc, BasketState>(
                          builder: (context, state) {
                            return Card(
                                color: Theme.of(context).primaryColor,
                                child: TextButton(
                                  style: TextButton.styleFrom(
                                      primary: Theme.of(context).primaryColor),
                                  onPressed: () {
                                    context.read<BasketBloc>().add(
                                        SelectDeliveryTime(
                                            DeliveryTime.deliveryTimes[index]));
                                  },
                                  child: Text(
                                      DeliveryTime.deliveryTimes[index].value,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline6!
                                          .copyWith(color: Colors.black)),
                                ));
                          },
                        );
                      }),
                ),
              )
            ],
          ),
        ));
  }
}
