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
  String currentRoute = "Users";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(currentRoute),
      ),
      drawer: Sidebar(
        children: [
          Theme(
            data: getTheme(context, "Users"),
            child: SidebarTile(
              title: "Users",
              icons: Icons.person,
              callback: () {
                setPage("Users");
              },
            ),
          ),
          Theme(
            data: getTheme(context, "Location"),
            child: SidebarTile(
              title: "Location",
              icons: Icons.inventory_2_outlined,
              callback: () {
                setPage("Location");
              },
            ),
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

  ThemeData getTheme(BuildContext context, String route) {
    return (currentRoute == route)
        ? ThemeData(
            listTileTheme: ListTileThemeData(
              tileColor: Theme.of(context).indicatorColor,
            ),
          )
        : Theme.of(context);
  }

  void setPage(String route) {
    if (currentRoute != route) {
      _navigatorKey.currentState!.pushNamed(route);
      setState(() {
        currentRoute = route;
      });
    }
    Navigator.pop(context);
  }

  Route _onGenerateRoute(RouteSettings settings) {
    late Widget page;

    switch (settings.name) {
      case "Users":
        page = const UserView();

        break;
      case "Location":
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
