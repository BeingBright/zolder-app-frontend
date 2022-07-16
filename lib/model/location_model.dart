import 'package:flutter/material.dart';
import 'package:zolder_app/model/location.dart';

class LocationModel extends ChangeNotifier {
  List<Location> locations = [];

  void setLocations(List<Location> locations) {
    this.locations = locations;
    notifyListeners();
  }
}
