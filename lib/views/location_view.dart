import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zolder_app/components/book_table.dart';
import 'package:zolder_app/components/location/location_item.dart';
import 'package:zolder_app/components/location/location_modal.dart';
import 'package:zolder_app/components/toast_manager.dart';
import 'package:zolder_app/controller/location_command.dart';
import 'package:zolder_app/mixins/get_provided.dart';
import 'package:zolder_app/models/location.dart';
import 'package:zolder_app/models/location_model.dart';
import 'package:zolder_app/models/user_token_model.dart';

class LocationView extends StatefulWidget {
  const LocationView({Key? key, required this.sidebar}) : super(key: key);

  final Widget sidebar;

  @override
  State<LocationView> createState() => _LocationViewState();
}

class _LocationViewState extends State<LocationView> with provider {
  List<LocationItem> locationItems = [];

  void _onRefresh() {
    _getLocations();
  }

  void _onAddLocation() {
    var addLocationModal = showDialog(
      context: context,
      builder: (context) => LocationModal(),
    );

    addLocationModal.then((loc) => _addLocation(loc));
  }

  void _addLocation(Location? location) {
    if (location == null) return;
    Future result = LocationCommand().addLocation(location);
    result.then((value) => _getLocations());
    result.onError((error, stackTrace) => {
          ToastManager.show(context,
              "Location: '${location.inventoryLocation}' already exists")
        });
  }

  void _onSearch() {}

  @override
  void initState() {
    super.initState();
    _getLocations();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: locationItems.length,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Location"),
          actions: [
            IconButton(
              onPressed: _onRefresh,
              icon: const Icon(Icons.refresh),
            ),
            IconButton(
              onPressed: _onSearch,
              icon: const Icon(Icons.search),
            ),
            if (Provider.of<UserTokenModel>(context).userToken.role == "ADMIN")
              IconButton(
                onPressed: _onAddLocation,
                icon: const Icon(Icons.add),
              )
          ],
          bottom: TabBar(
            padding: const EdgeInsets.all(8),
            tabs: locationItems.map((locationItem) {
              return locationItem.title;
            }).toList(),
          ),
        ),
        drawer: widget.sidebar,
        body: Consumer<LocationModel>(
          builder: (context, locationModel, child) {
            return TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              children: locationItems.map((locationItem) {
                return locationItem.body;
              }).toList(),
            );
          },
        ),
      ),
    );
  }

  Future _getLocations() {
    return LocationCommand().getLocationsByBuilding("Celc").then((locations) {
      getProvided<LocationModel>(context).setLocations(locations);
      setState(() {
        locationItems = locations.map((loc) {
          return LocationItem(
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(loc.inventoryLocation!),
              ),
              _buildTabBody(loc));
        }).toList();
      });
    });
  }

  Widget _buildTabBody(Location location) {
    return BookTable(location: location);
  }
}
