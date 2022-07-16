import 'dart:io';

import 'package:get_it/get_it.dart';
import 'package:zolder_app/configuration/api_configuration.dart';
import 'package:zolder_app/model/location.dart';
import 'package:zolder_app/model/user/auth_token.dart';
import 'package:zolder_app/services/api_controller.dart';

class LocationService {
  GetIt getIt = GetIt.instance;

  Future<List<Location>> getLocations() async {
    return Location.generateList(await getIt<APIController>().get(
      APIConfiguration.location,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: getIt<AuthTokenModel>().authToken.token
      },
    ));
  }

  Future<List<Location>> getLocationByBuilding(String buildingLoc) async {
    return Location.generateList(await getIt<APIController>().get(
      "${APIConfiguration.location}/location/$buildingLoc",
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: getIt<AuthTokenModel>().authToken.token
      },
    ));
  }

  Future<Location> getLocationByBuildingAndInventory(
      String buildingLoc, String inventoryLoc) async {
    return Location.fromJson(await getIt<APIController>().get(
      "${APIConfiguration.location}/location/$buildingLoc/$inventoryLoc",
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: getIt<AuthTokenModel>().authToken.token
      },
    ));
  }

  Future<Location> getLocationById(String id) async {
    return Location.fromJson(await getIt<APIController>().get(
      "${APIConfiguration.location}/$id",
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: getIt<AuthTokenModel>().authToken.token
      },
    ));
  }

  Future addLocation(Location location) async {
    return await getIt<APIController>().post(APIConfiguration.location,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          HttpHeaders.authorizationHeader:
              getIt<AuthTokenModel>().authToken.token,
        },
        body: location);
  }

  Future updateLocation(Location location) async {
    return await getIt<APIController>().put(APIConfiguration.location,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          HttpHeaders.authorizationHeader:
              getIt<AuthTokenModel>().authToken.token,
        },
        body: location);
  }

  Future removeLocation(Location location) async {
    return await getIt<APIController>().delete(APIConfiguration.location,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          HttpHeaders.authorizationHeader:
              getIt<AuthTokenModel>().authToken.token,
        },
        body: location);
  }
}
