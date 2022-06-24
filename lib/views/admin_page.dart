import 'package:flutter/material.dart';
import 'package:zolder_app/components/sidebar.dart';
import 'package:zolder_app/components/sidebar_tile.dart';
import 'package:zolder_app/views/location-view.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({Key? key}) : super(key: key);

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {

  @override
  Widget build(BuildContext context) {
    return LocationView(
      sidebar: Sidebar(
        children: [
          SidebarTile(
            title: "User",
            icons: Icons.person,
            callback: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return Text("User");
                },
              ));
            },
          ),
          SidebarTile(
            title: "Location",
            icons: Icons.inventory_2_outlined,
            callback: () {
              print("Location");
            },
          ),
        ],
      ),
    );
  }
}
