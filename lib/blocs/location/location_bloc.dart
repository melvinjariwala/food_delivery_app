// ignore_for_file: depend_on_referenced_packages

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:food_delivery_app/models/place_model.dart';
import 'package:food_delivery_app/repositories/geolocation/geolocation_repository.dart';
import 'package:food_delivery_app/repositories/places/places_repository.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  final PlacesRepository _placesRepository;
  final GeoLocationRepository _geoLocationRepository;
  LocationBloc(
      {required PlacesRepository placesRepository,
      required GeoLocationRepository geoLocationRepository})
      : _placesRepository = placesRepository,
        _geoLocationRepository = geoLocationRepository,
        super(LocationLoading()) {
    on<LoadMap>(loadMap);
    on<SearchLocation>(searchLocation);
  }

  FutureOr<void> loadMap(LoadMap event, Emitter<LocationState> emit) async {
    final Position position = await _geoLocationRepository.getCurrentLocation();
    emit(LocationLoaded(lat: position.latitude, lng: position.longitude));
  }

  FutureOr<void> searchLocation(
      SearchLocation event, Emitter<LocationState> emit) async {
    final state = this.state as LocationLoaded;
    final Place place = await _placesRepository.getPlace(event.placeId);
    state.controller!
        .animateCamera(CameraUpdate.newLatLng(LatLng(place.lat, place.lng)));
  }
}
