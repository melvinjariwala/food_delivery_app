// ignore_for_file: avoid_print, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery_app/blocs/basket/basket_bloc.dart';

class EditBasketScreen extends StatelessWidget {
  const EditBasketScreen({super.key});
  static const String routeName = '/edit-basket';

  static Route route() {
    return MaterialPageRoute(
        builder: (_) => const EditBasketScreen(),
        settings: const RouteSettings(name: routeName));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          centerTitle: true,
          title: Text("Edit Basktet",
              style: Theme.of(context)
                  .textTheme
                  .headline3!
                  .copyWith(color: Colors.black)),
          backgroundColor: Theme.of(context).primaryColor,
          leading: const BackButton(color: Colors.black),
          actions: [
            IconButton(
                onPressed: () {},
                icon: const Icon(Icons.edit, color: Colors.black))
          ],
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
            child: const Text("Done", style: TextStyle(color: Colors.black)),
          ),
        )),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Items",
                style: Theme.of(context)
                    .textTheme
                    .headline4!
                    .copyWith(color: Theme.of(context).primaryColorDark),
              ),
              BlocBuilder<BasketBloc, BasketState>(
                builder: (context, state) {
                  if (state is BasketLoading) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: Theme.of(context).primaryColor,
                      ),
                    );
                  } else if (state is BasketLoaded) {
                    print("State : Basket Loaded");
                    print("${state.basket.products.length}");
                    return state.basket.products.isEmpty
                        ? Container(
                            width: double.infinity,
                            margin: const EdgeInsets.only(top: 5.0),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30.0, vertical: 10.0),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5.0)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("No items in the basket.",
                                    textAlign: TextAlign.left,
                                    style:
                                        Theme.of(context).textTheme.headline6)
                              ],
                            ),
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            itemCount: state.basket
                                .itemQuantity(state.basket.products)
                                .keys
                                .length,
                            itemBuilder: (context, index) {
                              return Container(
                                width: double.infinity,
                                margin: const EdgeInsets.only(top: 5),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 30.0, vertical: 10.0),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(9.0)),
                                child: Row(
                                  children: [
                                    Text(
                                        "${state.basket.itemQuantity(state.basket.products).entries.elementAt(index).value}x",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6!
                                            .copyWith(
                                                color: Theme.of(context)
                                                    .primaryColorDark)),
                                    const SizedBox(width: 20),
                                    Expanded(
                                      child: Text(
                                          "${state.basket.itemQuantity(state.basket.products).keys.elementAt(index).name}",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline6),
                                    ),
                                    IconButton(
                                        visualDensity: VisualDensity.compact,
                                        onPressed: () {
                                          context.read<BasketBloc>().add(
                                              RemoveAllProduct(state.basket
                                                  .itemQuantity(
                                                      state.basket.products)
                                                  .keys
                                                  .elementAt(index)));
                                        },
                                        icon: Icon(
                                          Icons.delete,
                                          color: Theme.of(context).primaryColor,
                                        )),
                                    IconButton(
                                        visualDensity: VisualDensity.compact,
                                        onPressed: () {
                                          context.read<BasketBloc>().add(
                                              RemoveProduct(state.basket
                                                  .itemQuantity(
                                                      state.basket.products)
                                                  .keys
                                                  .elementAt(index)));
                                        },
                                        icon: Icon(
                                          Icons.remove_circle,
                                          color: Theme.of(context).primaryColor,
                                        )),
                                    IconButton(
                                        visualDensity: VisualDensity.compact,
                                        onPressed: () {
                                          context.read<BasketBloc>().add(
                                              AddProduct(state.basket
                                                  .itemQuantity(
                                                      state.basket.products)
                                                  .keys
                                                  .elementAt(index)));
                                        },
                                        icon: Icon(
                                          Icons.add_circle,
                                          color: Theme.of(context).primaryColor,
                                        ))
                                  ],
                                ),
                              );
                            });
                  }
                  return const Center(child: Text("Something went wrong!"));
                },
              ),
            ],
          ),
        ));
  }
}
