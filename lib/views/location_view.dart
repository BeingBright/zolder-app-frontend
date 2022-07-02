import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:zolder_app/services/user_service.dart';

class LocationView extends StatefulWidget {
  const LocationView({Key? key}) : super(key: key);

  @override
  State<LocationView> createState() => _LocationViewState();
}

class _LocationViewState extends State<LocationView> {
  GetIt getIt = GetIt.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Location"),
      ),
      body: FutureBuilder(
        future: getIt<UserService>().getUsers(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Text(snapshot.data.toString());
          } else if (snapshot.hasError) {
            return const Text("error");
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
