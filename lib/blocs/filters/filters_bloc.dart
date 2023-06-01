import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:food_delivery_app/models/category_filter_model.dart';
import 'package:food_delivery_app/models/filter_model.dart';
import 'package:food_delivery_app/models/price_filter_model.dart';

part 'filters_event.dart';
part 'filters_state.dart';

class FiltersBloc extends Bloc<FiltersEvent, FiltersState> {
  FiltersBloc() : super(FiltersLoading()) {
    on<FilterLoad>(filterLoad);
    on<CategoryFilterUpdated>(categoryFilterUpdated);
    on<PriceFilterUpdated>(priceFilterUpdated);
  }

  FutureOr<void> filterLoad(FilterLoad event, Emitter<FiltersState> emit) {
    emit(FiltersLoaded(
        filter: Filter(
            categoryFilters: CategoryFilter.filters,
            priceFilters: PriceFilter.filters)));
  }

  FutureOr<void> categoryFilterUpdated(
      CategoryFilterUpdated event, Emitter<FiltersState> emit) async {
    final state = this.state;
    if (state is FiltersLoaded) {
      final List<CategoryFilter> updatedCategoryFilters =
          state.filter.categoryFilters.map((categoryFilter) {
        return categoryFilter.id == event.categoryFilter.id
            ? event.categoryFilter
            : categoryFilter;
      }).toList();

      emit(FiltersLoaded(
          filter: Filter(
              categoryFilters: updatedCategoryFilters,
              priceFilters: state.filter.priceFilters)));
    }
  }

  FutureOr<void> priceFilterUpdated(
      PriceFilterUpdated event, Emitter<FiltersState> emit) async {
    final state = this.state;
    if (state is FiltersLoaded) {
      final List<PriceFilter> updatedPriceFilters =
          state.filter.priceFilters.map((priceFilter) {
        return priceFilter.id == event.priceFilter.id
            ? event.priceFilter
            : priceFilter;
      }).toList();

      emit(FiltersLoaded(
          filter: Filter(
              categoryFilters: state.filter.categoryFilters,
              priceFilters: updatedPriceFilters)));
    }
  }
}
