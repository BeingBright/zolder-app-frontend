import 'package:flutter/material.dart';
import 'package:zolder_app_frontend/component/sidebar.dart';

class WorkerPage extends StatefulWidget {
  const WorkerPage({Key? key}) : super(key: key);

  @override
  State<WorkerPage> createState() => _WorkerPageState();
}

class _WorkerPageState extends State<WorkerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: true,
      ),
      drawer: Sidebar(title: "Zolder app"),
    );
  }
}
