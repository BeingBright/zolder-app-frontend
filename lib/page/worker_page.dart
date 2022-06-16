import 'package:flutter/material.dart';
import 'package:zolder_app_frontend/component/sidebar.dart';

import '../model/UserToken.dart';

class WorkerPage extends StatefulWidget {
  const WorkerPage({Key? key, required this.token}) : super(key: key);

  final UserToken token;

  @override
  State<WorkerPage> createState() => _WorkerPageState();
}

class _WorkerPageState extends State<WorkerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
      ),
      drawer: Sidebar(title: "Zolder app",username: widget.token.user),
    );
  }
}
