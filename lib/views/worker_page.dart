import 'package:flutter/material.dart';

import '../components/sidebar.dart';
import 'location_view.dart';

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
        title: const Text("Location"),
      ),
      drawer: const Sidebar(children: []),
      body: const LocationView(),
    );
  }
}
