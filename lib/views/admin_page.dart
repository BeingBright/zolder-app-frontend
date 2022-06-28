import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:zolder_app/components/sidebar.dart';
import 'package:zolder_app/components/sidebar_tile.dart';
import 'package:zolder_app/models/user_token_model.dart';
import 'package:zolder_app/views/location_view.dart';
import 'package:zolder_app/views/user_view.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({Key? key}) : super(key: key);

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  String currentPage = "location";

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      if (Provider.of<UserTokenModel>(context, listen: false).userToken.role !=
          "ADMIN") {
        Navigator.pushReplacementNamed(context, '/');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget sidebar = Sidebar(children: [
      SidebarTile(
          title: "Locations",
          icons: Icons.person,
          callback: () {
            _setCurrentPage("location");
          }),
      SidebarTile(
          title: "Users",
          icons: Icons.person,
          callback: () {
            _setCurrentPage("user");
          })
    ]);

    return _getCurrentPage(currentPage, sidebar);
  }

  void _setCurrentPage(String page) {
    setState(() {
      currentPage = page;
    });
  }

  Widget _getCurrentPage(String page, Widget sidebar) {
    switch (page) {
      case 'user':
        return UserView(sidebar: sidebar);
      case 'location':
        return LocationView(sidebar: sidebar);
      default:
        return Center(
          child: Text("OOPS"),
        );
        break;
    }
  }
}
