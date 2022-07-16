import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get_it/get_it.dart';
import 'package:zolder_app/component/sidebar_item.dart';
import 'package:zolder_app/model/user/auth_token.dart';
import 'package:zolder_app/model/user/user.dart';
import 'package:zolder_app/views/location_view.dart';
import 'package:zolder_app/views/user_view.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({Key? key}) : super(key: key);

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  final String locationRoute = "location";
  final String userRoute = "user";
  String currentPage = "";
  final GetIt getIt = GetIt.instance;

  void _setCurrentPage(String page) {
    setState(() {
      currentPage = page;
    });
  }

  @override
  void initState() {
    super.initState();
    currentPage = userRoute;
    SchedulerBinding.instance.addPostFrameCallback((_) {
      if (getIt<AuthTokenModel>().authToken.role != UserRole.admin) {
        Navigator.pushReplacementNamed(context, '/');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> sidebarItems = [
      SidebarItem(
          title: "Location",
          icons: Icons.inventory_2_outlined,
          callback: () {
            _setCurrentPage(locationRoute);
          }),
      SidebarItem(
          title: "User",
          icons: Icons.person,
          callback: () {
            _setCurrentPage(userRoute);
          })
    ];

    switch (currentPage) {
      case 'user':
        return UserView(children: sidebarItems);
      case 'location':
        return LocationView(children: sidebarItems);
      default:
        return const Center(
          child: Text("OOPS"),
        );
    }
  }
}
