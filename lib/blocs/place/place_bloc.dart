// ignore_for_file: avoid_print, depend_on_referenced_packages

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:food_delivery_app/models/place_model.dart';
import 'package:food_delivery_app/repositories/places/places_repository.dart';

part 'place_event.dart';
part 'place_state.dart';

class PlaceBloc extends Bloc<PlaceEvent, PlaceState> {
  final PlacesRepository _placesRepository;
  //StreamSubscription? _placesSubscription;
  PlaceBloc({required PlacesRepository placesRepository})
      : _placesRepository = placesRepository,
        super(PlaceLoading()) {
    on<LoadPlace>(loadPlace);
  }

  FutureOr<void> loadPlace(LoadPlace event, Emitter<PlaceState> emit) async {
    emit(PlaceLoading());
    try {
      final Place place =
          await _placesRepository.getPlace(event.placeId.toString());
      emit(PlaceLoaded(place: place));
    } catch (e) {
      print("Error in loadPlace in bloc : $e");
    }
  }
}
