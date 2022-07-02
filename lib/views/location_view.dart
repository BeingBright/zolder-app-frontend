import 'package:flutter/material.dart';

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
        automaticallyImplyLeading: false,
        title: const Text("Location"),
      ),
      body: FutureBuilder(
        future: Future.delayed(Duration(seconds: 2),() {
          return "";
        }),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const Text("data");
          } else if (snapshot.hasError) {
            return const Text("error");
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
