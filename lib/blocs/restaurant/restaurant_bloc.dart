// ignore_for_file: depend_on_referenced_packages

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:food_delivery_app/blocs/location/location_bloc.dart';
import 'package:food_delivery_app/models/restaurant_model.dart';
import 'package:food_delivery_app/repositories/restaurant/restaurant_repository.dart';

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
        _restaurantSubscription =
            _restaurantRepository.getNearbyRestaurants(state.place).listen(
          (restaurants) {
            add(LoadRestaurants(restaurants));
          },
        );
      }
    });
  }

  FutureOr<void> loadRestaurants(
      LoadRestaurants event, Emitter<RestaurantState> emit) {
    emit(RestaurantLoaded(event.restaurants));
  }

  @override
  Future<void> close() async {
    _restaurantSubscription?.cancel();
    _locationSubscription?.cancel();
    super.close();
  }
}
