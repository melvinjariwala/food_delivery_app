// ignore_for_file: depend_on_referenced_packages, unnecessary_null_comparison

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:food_delivery_app/models/place_model.dart';
import 'package:food_delivery_app/models/restaurant_model.dart';
import 'package:food_delivery_app/repositories/geolocation/geolocation_repository.dart';
import 'package:food_delivery_app/repositories/location/location_repository.dart';
import 'package:food_delivery_app/repositories/restaurant/restaurant_repository.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  final LocationRepository _locationRepository;
  final GeoLocationRepository _geoLocationRepository;
  final RestaurantRepository _restaurantRepository;

  LocationBloc(
      {required LocationRepository locationRepository,
      required GeoLocationRepository geoLocationRepository,
      required RestaurantRepository restaurantRepository})
      : _locationRepository = locationRepository,
        _geoLocationRepository = geoLocationRepository,
        _restaurantRepository = restaurantRepository,
        super(LocationLoading()) {
    on<LoadMap>(loadMap);
    on<SearchLocation>(searchLocation);
  }

  FutureOr<void> loadMap(LoadMap event, Emitter<LocationState> emit) async {
    Place? place = await _locationRepository.getPlace();

    if (place == null) {
      final Position position =
          await _geoLocationRepository.getCurrentLocation();

      place = Place(lat: position.latitude, lng: position.longitude);
    }
    List<Restaurant> restaurants =
        await _restaurantRepository.getNearbyRestaurants(place).first;
    emit(LocationLoaded(
        controller: event.controller, place: place, restaurants: restaurants));
  }

  FutureOr<void> searchLocation(
      SearchLocation event, Emitter<LocationState> emit) async {
    final state = this.state as LocationLoaded;
    final Place place =
        await _locationRepository.getPlace(event.placeId) ?? Place.empty;

    state.controller!
        .animateCamera(CameraUpdate.newLatLng(LatLng(place.lat, place.lng)));
    List<Restaurant> restaurants =
        await _restaurantRepository.getNearbyRestaurants(place).first;
    emit(LocationLoaded(
        controller: state.controller, place: place, restaurants: restaurants));
  }
}
