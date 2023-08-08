// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery_app/blocs/autocomplete/autocomplete_bloc.dart';
import 'package:food_delivery_app/blocs/basket/basket_bloc.dart';
import 'package:food_delivery_app/blocs/filters/filters_bloc.dart';
import 'package:food_delivery_app/blocs/geolocation/geolocation_bloc.dart';
import 'package:food_delivery_app/blocs/location/location_bloc.dart';
import 'package:food_delivery_app/blocs/place/place_bloc.dart';
import 'package:food_delivery_app/blocs/restaurant/restaurant_bloc.dart';
import 'package:food_delivery_app/blocs/voucher/voucher_bloc.dart';
import 'package:food_delivery_app/config/app_router.dart';
import 'package:food_delivery_app/datasources/local_datasource.dart';
import 'package:food_delivery_app/datasources/places_api.dart';
import 'package:food_delivery_app/models/basket_model.dart';
import 'package:food_delivery_app/models/deliver_time_model.dart';
import 'package:food_delivery_app/models/place_model.dart';
import 'package:food_delivery_app/models/product_model.dart';
import 'package:food_delivery_app/models/voucher_model.dart';
import 'package:food_delivery_app/repositories/basket/basket_repository.dart';
import 'package:food_delivery_app/repositories/geolocation/geolocation_repository.dart';
import 'package:food_delivery_app/repositories/local_storage/local_storage_repository.dart';
import 'package:food_delivery_app/repositories/location/location_repository.dart';
import 'package:food_delivery_app/repositories/places/places_repository.dart';
import 'package:food_delivery_app/repositories/voucher/voucher_repository.dart';
import 'package:food_delivery_app/screens/home_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'config/theme.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'repositories/restaurant/restaurant_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Hive.initFlutter();
  Hive
    ..registerAdapter(PlaceAdapter())
    ..registerAdapter(ProductAdapter())
    ..registerAdapter(VoucherAdapter())
    ..registerAdapter(DeliveryTimeAdapter())
    ..registerAdapter(BasketAdapter());

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
        RepositoryProvider<RestaurantRepository>(
          create: (_) => RestaurantRepository(),
        ),
        RepositoryProvider<LocalStorageRepository>(
          create: (_) => LocalStorageRepository(),
        ),
        RepositoryProvider<LocationRepository>(
            create: (_) => LocationRepository(
                localDatasource: LocalDatasource(), placesAPI: PlacesAPI())),
        RepositoryProvider<BasketRepository>(
            create: (_) => BasketRepository(localDatasource: LocalDatasource()))
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<GeolocationBloc>(
              create: (context) => GeolocationBloc(
                  geoLocationRepository: context.read<GeoLocationRepository>())
                ..add(const LoadGeolocation())),
          BlocProvider<LocationBloc>(
              create: (context) => LocationBloc(
                  geoLocationRepository: context.read<GeoLocationRepository>(),
                  restaurantRepository: context.read<RestaurantRepository>(),
                  locationRepository: context.read<LocationRepository>())
                ..add(const LoadMap())),
          BlocProvider<AutocompleteBloc>(
              create: (context) => AutocompleteBloc(
                  locationRepository: context.read<LocationRepository>())
                ..add(const LoadAutocomplete())),
          BlocProvider<PlaceBloc>(
              create: (context) => PlaceBloc(
                  placesRepository: context.read<PlacesRepository>())),
          BlocProvider(
              create: (context) => RestaurantBloc(
                  restaurantRepository: context.read<RestaurantRepository>(),
                  locationBloc: context.read<LocationBloc>())),
          BlocProvider<FiltersBloc>(
              create: (context) => FiltersBloc(
                  restaurantBloc: BlocProvider.of<RestaurantBloc>(context))
                ..add(FilterLoad())),
          BlocProvider<VoucherBloc>(
              create: (context) =>
                  VoucherBloc(voucherRespository: VoucherRespository())
                    ..add(LoadVouchers())),
          BlocProvider<BasketBloc>(
              create: (context) => BasketBloc(
                  voucherBloc: BlocProvider.of<VoucherBloc>(context),
                  basketRepository: context.read<BasketRepository>())
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
