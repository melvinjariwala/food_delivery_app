// ignore_for_file: depend_on_referenced_packages, unnecessary_null_comparison

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:food_delivery_app/models/place_model.dart';
import 'package:food_delivery_app/models/restaurant_model.dart';
import 'package:food_delivery_app/repositories/geolocation/geolocation_repository.dart';
import 'package:food_delivery_app/repositories/local_storage/local_storage_repository.dart';
import 'package:food_delivery_app/repositories/places/places_repository.dart';
import 'package:food_delivery_app/repositories/restaurant/restaurant_repository.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hive/hive.dart';

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  final PlacesRepository _placesRepository;
  final GeoLocationRepository _geoLocationRepository;
  final LocalStorageRepository _localStorageRepository;
  final RestaurantRepository _restaurantRepository;

  LocationBloc(
      {required PlacesRepository placesRepository,
      required GeoLocationRepository geoLocationRepository,
      required LocalStorageRepository localStorageRepository,
      required RestaurantRepository restaurantRepository})
      : _placesRepository = placesRepository,
        _geoLocationRepository = geoLocationRepository,
        _localStorageRepository = localStorageRepository,
        _restaurantRepository = restaurantRepository,
        super(LocationLoading()) {
    on<LoadMap>(loadMap);
    on<SearchLocation>(searchLocation);
  }

  FutureOr<void> loadMap(LoadMap event, Emitter<LocationState> emit) async {
    Box box = await _localStorageRepository.openBox();
    Place? place = _localStorageRepository.getPlace(box);

    if (place == null) {
      final Position position =
          await _geoLocationRepository.getCurrentLocation();

      place = Place(lat: position.latitude, lng: position.longitude);
    }
    List<Restaurant> restaurants = await _getNearbyRestaurants(place);
    emit(LocationLoaded(
        controller: event.controller, place: place, restaurants: restaurants));
  }

  FutureOr<void> searchLocation(
      SearchLocation event, Emitter<LocationState> emit) async {
    final state = this.state as LocationLoaded;
    final Place place = await _placesRepository.getPlace(event.placeId);

    Box box = await _localStorageRepository.openBox();
    _localStorageRepository.clearBox(box);
    _localStorageRepository.addPlace(box, place);

    state.controller!
        .animateCamera(CameraUpdate.newLatLng(LatLng(place.lat, place.lng)));
    List<Restaurant> restaurants = await _getNearbyRestaurants(place);
    emit(LocationLoaded(
        controller: state.controller, place: place, restaurants: restaurants));
  }

  _getNearbyRestaurants(Place place) async {
    List<Restaurant> restaurants =
        await _restaurantRepository.getRestaurant().first;
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
}
