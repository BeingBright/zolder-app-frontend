import 'dart:convert';

import 'package:http/http.dart' as http;

import '../config/APIConfig.dart';
import '../model/Location.dart';
import 'authService.dart';

class LocationService {
  Future<List<Location>?> getLocations(String location) async {
    try {
      var url = Uri.parse("${APIConfig.baseURI}/location");
      var response =
          await http.get(url, headers: {"token": AuthService.token!.token});
      if (response.statusCode == 200) {
        List<Location> loc = locationModelFromJson(response.body);
        return loc;
      }
    } catch (e) {
      print(e.toString());
    }
  }

  List<Location> locationModelFromJson(String str) =>
    List<Location>.from(json.decode(str).map((x) => Location.fromJson(x)));
}
