part of 'geolocation_bloc.dart';

abstract class GeolocationEvent extends Equatable {
  const GeolocationEvent();

  @override
  List<Object?> get props => [];
}

class LoadGeolocation extends GeolocationEvent {
  final GoogleMapController? controller;

  const LoadGeolocation({this.controller});

  @override
  List<Object?> get props => [controller];
}

class SearchGeolocation extends GeolocationEvent {
  final String placeId;

  const SearchGeolocation({required this.placeId});

  @override
  List<Object?> get props => [placeId];
}
