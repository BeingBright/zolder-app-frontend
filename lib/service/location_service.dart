import 'dart:convert';

import 'package:http/http.dart' as http;

import '../config/api_config.dart';
import '../model/location.dart';
import '../model/server_exception.dart';
import 'auth-service.dart';

class LocationService {
  Future<List<Location>> getLocations() async {
    String token = (await AuthService().getToken()).token;

    try {
      var url = Uri.parse(APIConfig.location);
      var response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          "token": token,
        },
      );
      if (response.statusCode == 200) {
        return locationModelFromJson(response.body);
      } else {
        throw ServerException.fromJson(jsonDecode(response.body));
        ;
      }
    } catch (e) {
      throw ServerException(e.toString(), "500", 500);
    }
  }

  Future<List<Location>> getLocationsByInventory(String inventory) async {
    String token = (await AuthService().getToken()).token;

    try {
      var url = Uri.parse(APIConfig.location);
      var response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          "token": token,
        },
      );
      if (response.statusCode == 200) {
        return locationModelFromJson(response.body);
      } else {
        throw ServerException.fromJson(jsonDecode(response.body));
        ;
      }
    } catch (e) {
      throw ServerException(e.toString(), "500", 500);
    }
  }

  Future<ServerException> removeLocation(Location loc) async {
    String token = (await AuthService().getToken()).token;

    try {
      var url = Uri.parse(APIConfig.location);
      var response = await http.delete(url,
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            "token": token,
          },
          body: jsonEncode(loc));
      return ServerException.fromJson(jsonDecode(response.body));
    } catch (e) {
      throw ServerException(e.toString(), "500", 500);
    }
  }

  Future<Location> addLocation(Location loc) async {
    String token = (await AuthService().getToken()).token;

    try {
      var url = Uri.parse(APIConfig.location);
      var response = await http.post(url,
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            "token": token,
          },
          body: jsonEncode(loc));
      if (response.statusCode == 200) {
        Location model = Location.fromJson(jsonDecode(response.body));
        return model;
      } else {
        throw ServerException.fromJson(jsonDecode(response.body));
        ;
      }
    } catch (e) {
      throw ServerException(e.toString(), "500", 500);
    }
  }

  List<Location> locationModelFromJson(String str) =>
      List<Location>.from(json.decode(str).map((x) => Location.fromJson(x)));
}
