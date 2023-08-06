import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'place_model.g.dart';

@HiveType(typeId: 0)
class Place extends Equatable {
  @HiveField(0)
  final String placeId;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final double lat;
  @HiveField(3)
  final double lng;

  const Place(
      {this.placeId = '',
      this.name = '',
      required this.lat,
      required this.lng});

  factory Place.fromJSON(Map<String, dynamic> json) {
    return Place(
        placeId: json["placeId"],
        name: json["name"],
        lat: json["geometry"]["location"]["lat"],
        lng: json["geometry"]["location"]["lng"]);
  }

  @override
  List<Object?> get props => [placeId, name, lat, lng];
}
