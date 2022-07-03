import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:zolder_app/component/book_table.dart';
import 'package:zolder_app/model/location_model.dart';
import 'package:zolder_app/model/user/auth_token.dart';
import 'package:zolder_app/model/user/user.dart';
import 'package:zolder_app/services/api_controller.dart';
import 'package:zolder_app/services/location_service.dart';

class LocationView extends StatefulWidget {
  const LocationView({Key? key}) : super(key: key);

  @override
  State<LocationView> createState() => _LocationViewState();
}

class _LocationViewState extends State<LocationView> {
  GetIt getIt = GetIt.instance;

  void _onRefresh() {
    _getLocation();
  }

  void _onAddLocation() {}

  void _onRemoveLocation() {}

  void _onUpdateLocation() {}

  void _onSearch() {}

  void _getLocation() async {
    var locFut = await getIt<LocationService>().getLocations();
    setState(() {
      getIt<LocationModel>().setLocations(locFut);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getLocation();
    getIt<APIController>().onLoc = _getLocation;
    getIt<APIController>().onBook = _getLocation;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: getIt<LocationModel>().locations.length,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
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
            if (getIt<AuthTokenModel>().authToken.role == UserRole.admin)
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
          bottom: (getIt<LocationModel>().locations.isEmpty)
              ? null
              : TabBar(
                  tabs: getIt<LocationModel>()
                      .locations
                      .map((e) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(e.inventoryLocation ?? ""),
                          ))
                      .toList(),
                ),
        ),
        body: TabBarView(
            physics: const NeverScrollableScrollPhysics(),
            children: getIt<LocationModel>()
                .locations
                .map((e) => BookTable(location: e))
                .toList()),
      ),
    );
  }
}
