// ignore_for_file: depend_on_referenced_packages

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:food_delivery_app/repositories/geolocation/geolocation_repository.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'geolocation_event.dart';
part 'geolocation_state.dart';

class GeolocationBloc extends Bloc<GeolocationEvent, GeolocationState> {
  final GeoLocationRepository _geoLocationRepository;
  //StreamSubscription? _geolocationSubscription;

  GeolocationBloc({required GeoLocationRepository geoLocationRepository})
      : _geoLocationRepository = geoLocationRepository,
        super(GeolocationLoading()) {
    on<LoadGeolocation>(loadGeolocation);
  }

  FutureOr<void> loadGeolocation(
      LoadGeolocation event, Emitter<GeolocationState> emit) async {
    final Position position = await _geoLocationRepository.getCurrentLocation();

    emit(GeolocationLoaded(lat: position.latitude, lng: position.longitude));
  }
}
