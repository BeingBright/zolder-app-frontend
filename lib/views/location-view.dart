import 'package:flutter/material.dart';

class LocationView extends StatefulWidget {
  const LocationView({Key? key, required this.sidebar}) : super(key: key);

  final Widget sidebar;

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
      drawer: widget.sidebar,
    );
  }
}
