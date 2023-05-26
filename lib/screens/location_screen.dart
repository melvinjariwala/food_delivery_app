import 'package:flutter/material.dart';
import 'package:food_delivery_app/screens/home_screen.dart';
//import 'package:flutter/src/widgets/container.dart';
//import 'package:flutter/src/widgets/framework.dart';

class LocationScreen extends StatelessWidget {
  const LocationScreen({super.key});
  static const String routeName = '/location';

  static Route route() {
    return MaterialPageRoute(
        builder: (_) => const LocationScreen(),
        settings: const RouteSettings(name: routeName));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Location"),
      ),
      body: ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, HomeScreen.routeName);
          },
          child: const Text("Home")),
    );
  }
}
