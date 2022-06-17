import 'package:flutter/material.dart';
import 'package:zolder_app_frontend/service/userService.dart';

class UserOverviewPage extends StatefulWidget {
  const UserOverviewPage({Key? key}) : super(key: key);

  @override
  State<UserOverviewPage> createState() => _UserOverviewPageState();
}

class _UserOverviewPageState extends State<UserOverviewPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Admin - User overview page"),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
    );
  }
}
