// ignore_for_file: depend_on_referenced_packages

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:food_delivery_app/blocs/restaurant/restaurant_bloc.dart';
import 'package:food_delivery_app/models/category_filter_model.dart';
import 'package:food_delivery_app/models/filter_model.dart';
import 'package:food_delivery_app/models/models.dart';
import 'package:food_delivery_app/models/price_filter_model.dart';

part 'filters_event.dart';
part 'filters_state.dart';

class FiltersBloc extends Bloc<FiltersEvent, FiltersState> {
  final RestaurantBloc _restaurantBloc;
  FiltersBloc({required RestaurantBloc restaurantBloc})
      : _restaurantBloc = restaurantBloc,
        super(FiltersLoading()) {
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

      var categories = updatedCategoryFilters
          .where((filter) => filter.value)
          .map((filter) => filter.category)
          .toList();

      var prices = state.filter.priceFilters
          .where((filter) => filter.value)
          .map((filter) => filter.price.price)
          .toList();

      List<Restaurant> filteredRestaurants =
          _getFilteredRestaurants(categories, prices);

      // print(
      //     "categories : $categories\nprices : $prices\nfilteredRestaurants : $filteredRestaurants\n");

      emit(FiltersLoaded(
          filter: Filter(
              categoryFilters: updatedCategoryFilters,
              priceFilters: state.filter.priceFilters),
          filteredRestaurants: filteredRestaurants));
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

      var categories = state.filter.categoryFilters
          .where((filter) => filter.value)
          .map((filter) => filter.category)
          .toList();

      var prices = updatedPriceFilters
          .where((filter) => filter.value)
          .map((filter) => filter.price.price)
          .toList();

      List<Restaurant> filteredRestaurants =
          _getFilteredRestaurants(categories, prices);

      emit(FiltersLoaded(
          filter: Filter(
              categoryFilters: state.filter.categoryFilters,
              priceFilters: updatedPriceFilters),
          filteredRestaurants: filteredRestaurants));
    }
  }

  List<Restaurant> _getFilteredRestaurants(
      List<Category> categories, List<String> prices) {
    List<Restaurant> filteredRestaurant =
        (_restaurantBloc.state as RestaurantLoaded)
            .restaurants
            .where((restaurant) => categories
                .any((category) => restaurant.categories.contains(category)))
            .where((restaurant) =>
                prices.any((price) => restaurant.priceCategory.contains(price)))
            .toList();
    // print(
    //     "prices:$prices\ncategories:$categories\n Restaurant : $filteredRestaurant");
    return filteredRestaurant;
  }
}
