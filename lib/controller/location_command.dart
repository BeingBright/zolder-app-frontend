import 'package:zolder_app/mixins/get_provided.dart';
import 'package:zolder_app/services/location_service.dart';

import '../models/location.dart';

class LocationCommand with provider {
  static final _instance = LocationCommand._internal();

  LocationCommand._internal();

  factory LocationCommand() => _instance;

  final LocationService locationService = LocationService();

  Future<List<Location>> getLocations() {
    return locationService.getLocations();
  }

  Future<List<Location>> getLocationsByBuilding(String buildingLoc) {
    return locationService.getLocationsByBuilding(buildingLoc);
  }
}
