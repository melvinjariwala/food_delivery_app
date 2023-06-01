part of 'geolocation_bloc.dart';

abstract class GeolocationState extends Equatable {
  const GeolocationState();

  @override
  List<Object?> get props => [];
}

class GeolocationLoading extends GeolocationState {}

class GeolocationLoaded extends GeolocationState {
  final GoogleMapController? controller;
  final double lat;
  final double lng;

  const GeolocationLoaded(
      {this.controller, required this.lat, required this.lng});

  @override
  List<Object?> get props => [controller, lat, lng];
}

class GeolocationError extends GeolocationState {}
