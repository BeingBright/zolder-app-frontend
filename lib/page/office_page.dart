import 'package:flutter/material.dart';

import '../widget/sidebar.dart';

const String locationRoute = "Locations";

class OfficePage extends StatefulWidget {
  const OfficePage({Key? key}) : super(key: key);

  @override
  State<OfficePage> createState() => _OfficePageState();
}

class _OfficePageState extends State<OfficePage> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  String currentPage = locationRoute;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Center(
          child: Text(currentPage),
        ),
      ),
      drawer: Sidebar(title: "Office Page", username: "username", buttons: [
        ListTile(
            title: Row(
              children: const [
                Icon(Icons.work_outline),
                Spacer(),
                Text(locationRoute),
                Spacer(),
                Icon(Icons.work_outline, color: Colors.transparent),
              ],
            ),
            onTap: () {
              moveToScreen(context, locationRoute);
            }),
      ]),
      body: Navigator(
        key: _navigatorKey,
        initialRoute: locationRoute,
        onGenerateRoute: getCurrentPage,
      ),
    );
  }

  void moveToScreen(BuildContext context, String route) {
    _navigatorKey.currentState!.pushNamed(route);
    Navigator.pop(context);
    setState(() {
      currentPage = route;
    });
  }

  Route getCurrentPage(RouteSettings settings) {
    late Widget page;
    switch (settings.name) {
      case locationRoute:
        page = Text("data");
        break;
      default:
        page = Text("OOPS");
        break;
    }

    return MaterialPageRoute<Widget>(
      builder: (context) => page,
      settings: settings,
    );
  }
}
