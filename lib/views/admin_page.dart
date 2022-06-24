import 'package:flutter/material.dart';
import 'package:zolder_app/views/location-view.dart';
import 'package:zolder_app/views/user_view.dart';

import '../components/sidebar.dart';
import '../components/sidebar_tile.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({Key? key}) : super(key: key);

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  final _navigatorKey = GlobalKey<NavigatorState>();
  String currentRoute = "USER";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Users"),
      ),
      drawer: Sidebar(
        children: [
          SidebarTile(
            title: "User",
            icons: Icons.person,
            callback: () {
              _navigatorKey.currentState!.pushNamed("USER");
              Navigator.pop(context);
            },
          ),
          SidebarTile(
            title: "Location",
            icons: Icons.inventory_2_outlined,
            callback: () {
              _navigatorKey.currentState!.pushNamed("LOCATION");
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Navigator(
        key: _navigatorKey,
        initialRoute: currentRoute,
        onGenerateRoute: _onGenerateRoute,
      ), // const UserView(),
    );
  }

  Route _onGenerateRoute(RouteSettings settings) {
    late Widget page;

    switch (settings.name) {
      case "USER":
        page = const UserView();

        break;
      case "LOCATION":
        page = const LocationView();
        break;

      default:
        page = const UserView();
        break;
    }

    return MaterialPageRoute<dynamic>(
      builder: (context) {
        return page;
      },
      settings: settings,
    );
  }
}
