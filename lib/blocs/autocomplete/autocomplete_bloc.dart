// ignore_for_file: avoid_print, depend_on_referenced_packages

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:food_delivery_app/models/place_autocomplete_model.dart';
import 'package:food_delivery_app/repositories/places/places_repository.dart';

part 'autocomplete_event.dart';
part 'autocomplete_state.dart';

class AutocompleteBloc extends Bloc<AutocompleteEvent, AutocompleteState> {
  final PlacesRepository _placesRepository;
  //StreamSubscription? _placesSubscription;
  AutocompleteBloc({required PlacesRepository placesRepository})
      : _placesRepository = placesRepository,
        super(AutocompleteLoading()) {
    on<LoadAutocomplete>(loadAutocomplete);
  }

  FutureOr<void> loadAutocomplete(
      LoadAutocomplete event, Emitter<AutocompleteState> emit) async {
    try {
      final List<PlaceAutocomplete> autocomplete =
          await _placesRepository.getAutocomplete(event.searchInput);
      emit(AutocompleteLoaded(autocomplete: autocomplete));
    } catch (e) {
      print("Error occured in bloc : $e");
    }
  }
}
