import 'dart:io';

import 'package:zolder_app/models/location.dart';

import '../configuration/api_configuration.dart';
import 'api_controller.dart';

class LocationService {
  static final _instance = LocationService._newInstance();
  final APIController controller = APIController();

  LocationService._newInstance();

  factory LocationService() => _instance;

  Future<Location> getLocation(String buildingLoc, String inventoryLoc) async {
    return Location.fromJson(await controller.get(
      "${APIConfiguration.location}/location/$buildingLoc/$inventoryLoc",
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: "5df703e6-520d-4701-9bae-b8ab47bf9441"
      },
    ));
  }

  Future<List<Location>> getLocations() async {
    return locationFromJson(await controller.get(
      APIConfiguration.location,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: "5df703e6-520d-4701-9bae-b8ab47bf9441"
      },
    ));
  }

  Future<List<Location>> getLocationsByBuilding(String buildingLoc) async {
    return locationFromJson(await controller.get(
      "${APIConfiguration.location}/location/$buildingLoc",
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: "5df703e6-520d-4701-9bae-b8ab47bf9441"
      },
    ));
  }

  List<Location> locationFromJson(List json) {
    return List<Location>.from(json.map((e) {
      return Location.fromJson(e);
    }));
  }
}
