part of 'location_bloc.dart';

abstract class LocationState extends Equatable {
  const LocationState();

  @override
  List<Object> get props => [];
}

class LocationLoading extends LocationState {}

class LocationLoaded extends LocationState {
  final GoogleMapController? controller;
  final double lat;
  final double lng;

  const LocationLoaded({this.controller, required this.lat, required this.lng});

  @override
  List<Object> get props => [controller!, lat, lng];
}
