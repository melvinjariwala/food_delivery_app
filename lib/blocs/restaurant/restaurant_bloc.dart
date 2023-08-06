// ignore_for_file: depend_on_referenced_packages

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:food_delivery_app/blocs/location/location_bloc.dart';
import 'package:food_delivery_app/models/place_model.dart';
import 'package:food_delivery_app/models/restaurant_model.dart';
import 'package:food_delivery_app/repositories/restaurant/restaurant_repository.dart';
import 'package:geolocator/geolocator.dart';

part 'restaurant_event.dart';
part 'restaurant_state.dart';

class RestaurantBloc extends Bloc<RestaurantEvent, RestaurantState> {
  final RestaurantRepository _restaurantRepository;
  final LocationBloc _locationBLoc;
  StreamSubscription? _restaurantSubscription;
  StreamSubscription? _locationSubscription;
  RestaurantBloc(
      {required RestaurantRepository restaurantRepository,
      required LocationBloc locationBloc})
      : _restaurantRepository = restaurantRepository,
        _locationBLoc = locationBloc,
        super(RestaurantLoading()) {
    on<LoadRestaurants>(loadRestaurants);

    _locationSubscription = _locationBLoc.stream.listen((state) {
      if (state is LocationLoaded) {
        final Place place = state.place;
        _restaurantSubscription =
            _restaurantRepository.getRestaurant().listen((restaurants) async {
          List<Restaurant> filteredRestaurants =
              await _getNearbyRestaurants(restaurants, place);
          add(LoadRestaurants(filteredRestaurants));
        });
      }
    });
  }

  FutureOr<void> loadRestaurants(
      LoadRestaurants event, Emitter<RestaurantState> emit) {
    emit(RestaurantLoaded(event.restaurants));
  }

  _getNearbyRestaurants(List<Restaurant> restaurants, Place place) async {
    return restaurants
        .where((restaurant) =>
            _getRestaurantDistance(restaurant.address, place) <= 15)
        .toList();
  }

  _getRestaurantDistance(Place address, Place place) {
    GeolocatorPlatform geolocatorPlatform = GeolocatorPlatform.instance;
    var distance = geolocatorPlatform.distanceBetween(
            address.lat.toDouble(),
            address.lng.toDouble(),
            place.lat.toDouble(),
            place.lng.toDouble()) ~/
        1000;
    return distance;
  }

  @override
  Future<void> close() async {
    _restaurantSubscription?.cancel();
    _locationSubscription?.cancel();
    super.close();
  }
}
