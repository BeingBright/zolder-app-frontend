import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zolder_app/components/location_item.dart';
import 'package:zolder_app/controller/location_command.dart';
import 'package:zolder_app/mixins/get_provided.dart';
import 'package:zolder_app/models/location_model.dart';

import '../models/book.dart';

class LocationView extends StatefulWidget {
  const LocationView({Key? key, required this.sidebar}) : super(key: key);

  final Widget sidebar;

  @override
  State<LocationView> createState() => _LocationViewState();
}

class _LocationViewState extends State<LocationView> with provider {
  List<LocationItem> locationItems = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getLocations();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Location"),
      ),
      drawer: widget.sidebar,
      body: Consumer<LocationModel>(
        builder: (context, locationModel, child) {
          return DefaultTabController(
            length: locationItems.length,
            child: Scaffold(
              primary: false,
              appBar: AppBar(
                automaticallyImplyLeading: false,
                title: TabBar(
                  padding: const EdgeInsets.all(8),
                  tabs: locationItems.map((locationItem) {
                    return locationItem.title;
                  }).toList(),
                ),
              ),
              body: TabBarView(
                children: locationItems.map((locationItem) {
                  return RefreshIndicator(
                    onRefresh: _getLocations,
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: locationItem.body,
                    ),
                  );
                }).toList(),
              ),
            ),
          );
        },
      ),
    );
  }

  Future _getLocations() {
    return LocationCommand().getLocationsByBuilding("Celc").then((locations) {
      getProvided<LocationModel>(context).setLocations(locations);
      setState(() {
        locationItems = locations.map((e) {
          return LocationItem(
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(e.inventoryLocation!),
              ),
              _buildTabBody(e.books));
        }).toList();
      });
    });
  }

  Widget _buildTabBody(List<Book> books) {
    return Text(books.toString() +
        books.toString() +
        books.toString() +
        books.toString() +
        books.toString() +
        books.toString());
  }
}
