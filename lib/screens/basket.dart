import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BasketScreen extends StatelessWidget {
  const BasketScreen({super.key});
  static const String routeName = '/basket';

  static Route route() {
    return MaterialPageRoute(
        builder: (_) => const BasketScreen(),
        settings: const RouteSettings(name: routeName));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          centerTitle: true,
          title: Text("Basktet",
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
            onPressed: () {},
            child: const Text("Checkout"),
          ),
        )),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Cutlery",
                style: Theme.of(context)
                    .textTheme
                    .headline4!
                    .copyWith(color: Theme.of(context).primaryColorDark),
              ),
              Container(
                width: double.infinity,
                margin: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(9.0)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text("Add Cutlery?",
                          style: Theme.of(context).textTheme.headline6),
                    ),
                    SizedBox(
                      width: 100,
                      child: SwitchListTile(
                        dense: false,
                        value: false,
                        onChanged: (bool? newValue) {},
                      ),
                    )
                  ],
                ),
              ),
              Text(
                "Items",
                style: Theme.of(context)
                    .textTheme
                    .headline4!
                    .copyWith(color: Theme.of(context).primaryColorDark),
              ),
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: 4,
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
                          Text("1x",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6!
                                  .copyWith(
                                      color:
                                          Theme.of(context).primaryColorDark)),
                          const SizedBox(width: 20),
                          Expanded(
                            child: Text("Pizza",
                                style: Theme.of(context).textTheme.headline6),
                          ),
                          Text("\$4.99",
                              style: Theme.of(context).textTheme.headline6),
                        ],
                      ),
                    );
                  }),
              Container(
                width: double.infinity,
                height: 100,
                margin: const EdgeInsets.only(top: 5),
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(9.0)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SvgPicture.asset('assets/delivery_time.svg'),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 20),
                        Text("Delivery in 20 minutes",
                            style: Theme.of(context).textTheme.headline6),
                        TextButton(
                            onPressed: () {},
                            child: Text("Change",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6!
                                    .copyWith(
                                        color: Theme.of(context)
                                            .primaryColorDark)))
                      ],
                    )
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                height: 100,
                margin: const EdgeInsets.only(top: 5),
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(9.0)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 20),
                        Text("Do you have a voucher?",
                            style: Theme.of(context).textTheme.headline6),
                        TextButton(
                            onPressed: () {},
                            child: Text("Apply",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6!
                                    .copyWith(
                                        color: Theme.of(context)
                                            .primaryColorDark))),
                      ],
                    ),
                    SvgPicture.asset('assets/delivery_time.svg'),
                  ],
                ),
              ),
              Container(
                  width: double.infinity,
                  height: 100,
                  margin: const EdgeInsets.only(top: 5),
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(9.0)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Subtotal",
                              style: Theme.of(context).textTheme.headline6),
                          Text("\$19.96",
                              style: Theme.of(context).textTheme.headline6),
                        ],
                      ),
                      const SizedBox(height: 5.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Delivery Fee",
                              style: Theme.of(context).textTheme.headline6),
                          Text("\$2.99",
                              style: Theme.of(context).textTheme.headline6),
                        ],
                      ),
                      const SizedBox(height: 5.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Total",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline5!
                                  .copyWith(
                                      color:
                                          Theme.of(context).primaryColorDark)),
                          Text("\$22.95",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline5!
                                  .copyWith(
                                      color:
                                          Theme.of(context).primaryColorDark)),
                        ],
                      )
                    ],
                  ))
            ],
          ),
        ));
  }
}
