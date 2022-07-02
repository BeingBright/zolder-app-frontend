import 'package:flutter/material.dart';

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
    // SchedulerBinding.instance.addPostFrameCallback((_) {
    //   if (Provider.of<UserTokenModel>(context, listen: false).userToken.role !=
    //       "ADMIN") {
    //     Navigator.pushReplacementNamed(context, '/');
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Text("Admin Page");
  }
}
