class Place {
  final String placeId;
  final String name;
  final double lat;
  final double lng;

  Place(
      {this.placeId = '',
      this.name = '',
      required this.lat,
      required this.lng});

  factory Place.fromJSON(Map<String, dynamic> json) {
    return Place(
        placeId: json["place_id"],
        name: json["formatted_address"],
        lat: json["geometry"]["location"]["lat"],
        lng: json["geometry"]["location"]["lng"]);
  }
}
