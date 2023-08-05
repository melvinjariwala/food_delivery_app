// ignore_for_file: depend_on_referenced_packages

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:food_delivery_app/models/place_model.dart';
import 'package:food_delivery_app/repositories/geolocation/geolocation_repository.dart';
import 'package:food_delivery_app/repositories/local_storage/local_storage_repository.dart';
import 'package:food_delivery_app/repositories/places/places_repository.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hive/hive.dart';

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  final PlacesRepository _placesRepository;
  final GeoLocationRepository _geoLocationRepository;
  final LocalStorageRepository _localStorageRepository;

  LocationBloc(
      {required PlacesRepository placesRepository,
      required GeoLocationRepository geoLocationRepository,
      required LocalStorageRepository localStorageRepository})
      : _placesRepository = placesRepository,
        _geoLocationRepository = geoLocationRepository,
        _localStorageRepository = localStorageRepository,
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
      emit(LocationLoaded(
          controller: event.controller,
          place: Place(lat: position.latitude, lng: position.longitude)));
    } else {
      emit(LocationLoaded(controller: event.controller, place: place));
    }
  }

  FutureOr<void> searchLocation(
      SearchLocation event, Emitter<LocationState> emit) async {
    final state = this.state as LocationLoaded;
    final Place place = await _placesRepository.getPlace(event.placeId);

    if (place == null) {
      emit(LocationLoaded(controller: state.controller, place: state.place));
    } else {
      Box box = await _localStorageRepository.openBox();
      _localStorageRepository.clearBox(box);
      _localStorageRepository.addPlace(box, place);

      state.controller!
          .animateCamera(CameraUpdate.newLatLng(LatLng(place.lat, place.lng)));
    }
  }
}
