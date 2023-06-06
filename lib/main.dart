import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery_app/blocs/autocomplete/autocomplete_bloc.dart';
import 'package:food_delivery_app/blocs/basket/basket_bloc.dart';
import 'package:food_delivery_app/blocs/filters/filters_bloc.dart';
import 'package:food_delivery_app/blocs/geolocation/geolocation_bloc.dart';
import 'package:food_delivery_app/blocs/place/place_bloc.dart';
import 'package:food_delivery_app/blocs/voucher/voucher_bloc.dart';
import 'package:food_delivery_app/config/app_router.dart';
import 'package:food_delivery_app/repositories/geolocation/geolocation_repository.dart';
import 'package:food_delivery_app/repositories/places/places_repository.dart';
import 'package:food_delivery_app/repositories/voucher/voucher_repository.dart';
import 'package:food_delivery_app/screens/home_screen.dart';

import 'config/theme.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
        ),
        RepositoryProvider<PlacesRepository>(
          create: (_) => PlacesRepository(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<GeolocationBloc>(
              create: (context) => GeolocationBloc(
                  geoLocationRepository: context.read<GeoLocationRepository>())
                ..add(const LoadGeolocation())),
          BlocProvider<AutocompleteBloc>(
              create: (context) => AutocompleteBloc(
                  placesRepository: context.read<PlacesRepository>())
                ..add(const LoadAutocomplete())),
          BlocProvider<PlaceBloc>(
              create: (context) => PlaceBloc(
                  placesRepository: context.read<PlacesRepository>())),
          BlocProvider<FiltersBloc>(
              create: (context) => FiltersBloc()..add(FilterLoad())),
          BlocProvider<VoucherBloc>(
              create: (context) =>
                  VoucherBloc(voucherRespository: VoucherRespository())
                    ..add(LoadVouchers())),
          BlocProvider<BasketBloc>(
              create: (context) =>
                  BasketBloc(voucherBloc: BlocProvider.of<VoucherBloc>(context))
                    ..add(StartBasket())),
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
