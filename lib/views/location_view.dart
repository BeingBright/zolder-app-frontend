import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:zolder_app/component/book_table.dart';
import 'package:zolder_app/component/location_add_modal.dart';
import 'package:zolder_app/component/sidebar.dart';
import 'package:zolder_app/model/location_model.dart';
import 'package:zolder_app/model/user/auth_token.dart';
import 'package:zolder_app/model/user/user.dart';
import 'package:zolder_app/services/api_controller.dart';
import 'package:zolder_app/services/location_service.dart';

class LocationView extends StatefulWidget {
  LocationView({Key? key, this.children}) : super(key: key);

  final List<Widget>? children;

  final GetIt getIt = GetIt.instance;

  @override
  State<LocationView> createState() => _LocationViewState();
}

class _LocationViewState extends State<LocationView> {
  String searchTerm = "";

  bool openSearch = false;

  void _onRefresh() {
    _getLocation();
  }

  void _onAddLocation() {
    var addLocationModal = showDialog(
      context: context,
      builder: (context) => LocationAddModal(),
    );

    addLocationModal.then((loc) {
      if (loc == null) return;
      Future result = widget.getIt<LocationService>().addLocation(loc);
      result.onError((error, stackTrace) => {});
    });
  }

  void _onRemoveLocation() {}

  void _onUpdateLocation() {}

  void _onSearch(String term) {
    setState(() {
      searchTerm = term;
    });
  }

  void _getLocation() async {
    var locFut = await widget.getIt<LocationService>().getLocations();
    setState(() {
      widget.getIt<LocationModel>().setLocations(locFut);
    });
  }

  @override
  void initState() {
    _getLocation();
    widget.getIt<APIController>().onLoc = _getLocation;
    widget.getIt<APIController>().onBook = _getLocation;
    widget.getIt<APIController>().onUser = null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: widget.getIt<LocationModel>().locations.length,
      child: Scaffold(
        drawer: Sidebar(children: widget.children),
        appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: true,
          title: (!openSearch)
              ? const Text("Location")
              : Center(
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      label: Text("Book ID"),
                    ),
                    onChanged: _onSearch,
                  ),
                ),
          actions: [
            IconButton(
              onPressed: () {
                setState(() {
                  openSearch = !openSearch;
                  if (!openSearch) {
                    searchTerm = "";
                  }
                });
              },
              icon: const Icon(Icons.search),
            ),
            if (!openSearch)
              IconButton(
                onPressed: _onRefresh,
                icon: const Icon(Icons.refresh),
              ),
            if (!openSearch)
              if (widget.getIt<AuthTokenModel>().authToken.role ==
                  UserRole.admin)
                PopupMenuButton(
                  onSelected: (choise) {
                    switch (choise) {
                      case 'Add':
                        _onAddLocation();
                        break;
                      case 'Update':
                        _onUpdateLocation();
                        break;
                      case 'Remove':
                        _onRemoveLocation();
                        break;
                      default:
                        break;
                    }
                  },
                  itemBuilder: (context) => [
                    const PopupMenuItem(
                      value: "Add",
                      child: ListTile(
                        title: Text("Add Location"),
                        leading: Icon(Icons.add),
                      ),
                    ),
                    const PopupMenuItem(
                      value: "Update",
                      child: ListTile(
                        title: Text("Update Location"),
                        leading: Icon(Icons.mode),
                      ),
                    ),
                    const PopupMenuItem(
                      value: "Remove",
                      child: ListTile(
                        title: Text("Remove Location"),
                        leading: Icon(Icons.delete),
                      ),
                    )
                  ],
                ),
          ],
          bottom: (widget.getIt<LocationModel>().locations.isEmpty)
              ? null
              : TabBar(
                  tabs: widget
                      .getIt<LocationModel>()
                      .locations
                      .map((e) => Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(e.inventoryLocation ?? ""),
                          ))
                      .toList(),
                ),
        ),
        body: TabBarView(
            physics: const NeverScrollableScrollPhysics(),
            children: widget
                .getIt<LocationModel>()
                .locations
                .map((e) => BookTable(
                      location: e,
                      searchTerm: searchTerm,
                    ))
                .toList()),
      ),
    );
  }
}
