// ignore_for_file: annotate_overrides

part of 'filters_bloc.dart';

abstract class FiltersState extends Equatable {
  const FiltersState();

  @override
  List<Object> get props => [];

  get filter => null;
}

class FiltersLoading extends FiltersState {}

class FiltersLoaded extends FiltersState {
  final Filter filter;
  final List<Restaurant>? filteredRestaurants;

  const FiltersLoaded(
      {this.filteredRestaurants = const <Restaurant>[],
      this.filter = const Filter()});

  @override
  List<Object> get props => [filter, filteredRestaurants!];
}
