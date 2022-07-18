import 'dart:io';

import 'package:get_it/get_it.dart';
import 'package:zolder_app/configuration/api_configuration.dart';
import 'package:zolder_app/model/location.dart';
import 'package:zolder_app/model/user/auth_token.dart';
import 'package:zolder_app/services/api_controller.dart';

class LocationService {
  GetIt getIt = GetIt.instance;

  Future<List<Location>> getLocations() async {
    var json = await getIt<APIController>().get(
      APIConfiguration.location,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: getIt<AuthTokenModel>().authToken.token
      },
    );
    if (json == null) return List.empty(growable: false);
    return Location.generateList(json);
  }

  Future<List<Location>> getLocationByBuilding(String buildingLoc) async {
    var json = await getIt<APIController>().get(
      "${APIConfiguration.location}/location/$buildingLoc",
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: getIt<AuthTokenModel>().authToken.token
      },
    );
    if (json == null) return List.empty(growable: false);
    return Location.generateList(json);
  }

  Future<Location> getLocationByBuildingAndInventory(
      String buildingLoc, String inventoryLoc) async {
    var json = await getIt<APIController>().get(
      "${APIConfiguration.location}/location/$buildingLoc/$inventoryLoc",
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: getIt<AuthTokenModel>().authToken.token
      },
    );
    if (json == null) return Location.empty();
    return Location.fromJson(json);
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
