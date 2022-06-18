import 'package:flutter/material.dart';

class UserOverviewPage extends StatefulWidget {
  const UserOverviewPage({Key? key}) : super(key: key);

  @override
  State<UserOverviewPage> createState() => _UserOverviewPageState();
}

class _UserOverviewPageState extends State<UserOverviewPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("USER PAGE"),
    );
  }
}
