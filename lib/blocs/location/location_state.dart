part of 'location_bloc.dart';

abstract class LocationState extends Equatable {
  const LocationState();

  @override
  List<Object> get props => [];
}

class LocationLoading extends LocationState {}

class LocationLoaded extends LocationState {
  final GoogleMapController? controller;
  final Place place;

  const LocationLoaded({this.controller, required this.place});

  @override
  List<Object> get props => [controller!, place];
}
