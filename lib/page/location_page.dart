import 'package:flutter/material.dart';
import 'package:zolder_app_frontend/service/location_service.dart';

import '../model/location.dart';

class LocationPage extends StatefulWidget {
  const LocationPage({Key? key}) : super(key: key);

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  List<Location> _locationModel = <Location>[];

  @override
  void initState() {
    super.initState();
    _getLocations();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const TabBar(
            tabs: [
              Tab(text: "Bn"),
              Tab(text: "Bg"),
              Tab(text: "V"),
            ],
          ),
        ),
        body: const TabBarView(children: [
          Tab(text: "Bn"),
          Tab(text: "Bg"),
          Tab(text: "V"),
        ]),
      ),
    );
  }

  _getLocations() {
    LocationService().getLocations().then((value) {
      setState(() {
        _locationModel = value;
      });
    });
  }
}
