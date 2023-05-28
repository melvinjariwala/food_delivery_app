import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery_app/blocs/geolocation/geolocation_bloc.dart';
import 'package:food_delivery_app/config/app_router.dart';
import 'package:food_delivery_app/repositories/geolocation/geolocation_repository.dart';
import 'package:food_delivery_app/screens/home_screen.dart';
import 'package:food_delivery_app/screens/location_screen.dart';

import 'config/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<GeoLocationRepository>(
          create: (_) => GeoLocationRepository(),
        )
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<GeolocationBloc>(
              create: (context) => GeolocationBloc(
                  geoLocationRepository: context.read<GeoLocationRepository>())
                ..add(LoadGeolocation()))
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Food Delivery',
          theme: theme(),
          onGenerateRoute: AppRouter.onGenerateRoute,
          initialRoute: HomeScreen.routeName,
        ),
      ),
    );
  }
}
