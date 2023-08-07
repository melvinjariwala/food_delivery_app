import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:food_delivery_app/models/place_model.dart';

abstract class BasePlacesAPI {
  Future<List<Place>> getAutocomplete(String searchInput);
  Future<Place> getPlace(String placeId);
}

class PlacesAPI extends BasePlacesAPI {
  final String key = '';
  final String types = 'geocode';

  static const baseUrl = 'https://maps.googleapis.com/maps/api/place';

  @override
  Future<List<Place>> getAutocomplete(String searchInput) async {
    final String url =
        '$baseUrl/autocomplete/json?input=$searchInput&types=$types&key=$key';
    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var json = convert.jsonDecode(response.body);
      var result = json['predictions'] as List;
      return result.map((place) => Place.fromJSON(place)).toList();
    } else {
      throw Exception();
    }
  }

  @override
  Future<Place> getPlace(String placeId) async {
    final String url = '$baseUrl/details/json?place_id=$placeId&key=$key';
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var json = convert.jsonDecode(response.body);
      var result = json['result'] as Map<String, dynamic>;
      return Place.fromJSON(result);
    } else {
      throw Exception();
    }
  }
}
