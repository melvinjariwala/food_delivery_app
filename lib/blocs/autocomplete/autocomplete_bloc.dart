// ignore_for_file: avoid_print, depend_on_referenced_packages

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:food_delivery_app/models/place_model.dart';
import 'package:food_delivery_app/repositories/location/location_repository.dart';

part 'autocomplete_event.dart';
part 'autocomplete_state.dart';

class AutocompleteBloc extends Bloc<AutocompleteEvent, AutocompleteState> {
  final LocationRepository _locationRepository;

  AutocompleteBloc({required LocationRepository locationRepository})
      : _locationRepository = locationRepository,
        super(AutocompleteLoading()) {
    on<LoadAutocomplete>(loadAutocomplete);
    on<ClearAutocomplete>(clearAutocomplete);
  }

  FutureOr<void> loadAutocomplete(
      LoadAutocomplete event, Emitter<AutocompleteState> emit) async {
    try {
      final List<Place> autocomplete =
          await _locationRepository.getAutocomplete(event.searchInput);
      emit(AutocompleteLoaded(autocomplete: autocomplete));
    } catch (e) {
      print("Error occured in AutocompleteBloc : $e");
    }
  }

  FutureOr<void> clearAutocomplete(
      ClearAutocomplete event, Emitter<AutocompleteState> emit) async {
    emit(AutocompleteLoaded(autocomplete: List.empty()));
  }
}
