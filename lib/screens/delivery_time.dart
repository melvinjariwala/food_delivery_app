import 'package:flutter/material.dart';
import 'package:food_delivery_app/screens/location_screen.dart';
//import 'package:flutter/src/widgets/container.dart';
//import 'package:flutter/src/widgets/framework.dart';

class DeliveryTime extends StatelessWidget {
  const DeliveryTime({super.key});
  static const String routeName = '/delivery_time';

  static Route route() {
    return MaterialPageRoute(
        builder: (_) => const DeliveryTime(),
        settings: const RouteSettings(name: routeName));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Home"),
      ),
      body: ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, LocationScreen.routeName);
          },
          child: const Text("Location Screen")),
    );
  }
}
