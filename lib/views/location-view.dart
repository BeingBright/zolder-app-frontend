import 'package:flutter/material.dart';

import '../components/sidebar.dart';

class LocationView extends StatefulWidget {
  const LocationView({Key? key}) : super(key: key);

  @override
  State<LocationView> createState() => _LocationViewState();
}

class _LocationViewState extends State<LocationView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Location"),
      ),
      drawer: const Sidebar(
        children: [],
      ),
      body: const LocationView(),
    );
  }
}
