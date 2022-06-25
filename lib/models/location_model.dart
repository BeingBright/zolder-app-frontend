import 'package:flutter/material.dart';
import 'package:zolder_app/models/location.dart';

class LocationModel extends ChangeNotifier {
  List<Location> locations = List.empty();

  void setLocations(List<Location> locations) {
    this.locations = locations;
  }
}
