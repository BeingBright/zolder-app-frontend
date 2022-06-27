import 'package:flutter/material.dart';
import 'package:zolder_app/views/location_view.dart';
import 'package:zolder_app/views/user_view.dart';

import '../components/sidebar.dart';
import '../components/sidebar_tile.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({Key? key}) : super(key: key);

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  String currentRoute = "Location";

  @override
  Widget build(BuildContext context) {
    return _onGenerateRoute(currentRoute);
  }

  Sidebar _buildSidebar() {
    return Sidebar(
      children: [
        Theme(
          data: getTheme(context, "Location"),
          child: SidebarTile(
            title: "Location",
            icons: Icons.inventory_2_outlined,
            callback: () {
              setPage("Location");

              Navigator.push(context, _buildRoute(LocationView(sidebar: _buildSidebar())));

            },
          ),
        ),
        Theme(
          data: getTheme(context, "Users"),
          child: SidebarTile(
            title: "Users",
            icons: Icons.person,
            callback: () {
              setPage("Users");

              Navigator.push(context, _buildRoute(UserView(sidebar: _buildSidebar())));
            },
          ),
        ),
      ],
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
    setState(() {
      currentRoute = route;
    });
  }

  Widget _onGenerateRoute(String routeName) {
    late Widget page;

    switch (routeName) {
      case "Users":
        page = UserView(sidebar: _buildSidebar());

        break;
      case "Location":
        page = LocationView(sidebar: _buildSidebar());
        break;

      default:
        page = UserView(sidebar: _buildSidebar());
        break;
    }

    return page;
  }

  Route _buildRoute(Widget page) {
    return MaterialPageRoute(
      builder: (context) => page,
    );
  }
}
