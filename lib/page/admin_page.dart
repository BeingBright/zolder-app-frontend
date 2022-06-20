import 'package:flutter/material.dart';
import 'package:zolder_app_frontend/model/usertoken.dart';
import 'package:zolder_app_frontend/page/location_page.dart';
import 'package:zolder_app_frontend/page/user_page.dart';
import 'package:zolder_app_frontend/service/auth-service.dart';
import 'package:zolder_app_frontend/widget/sidebar.dart';

const String userRoute = "Users";
const String locationRoute = "Locations";

class AdminPage extends StatefulWidget {
  const AdminPage({Key? key}) : super(key: key);

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  String currentPage = userRoute;

  UserToken userToken = UserToken.empty();

  @override
  Widget build(BuildContext context) {
    AuthService().getToken().then((value) {
      setState(() {
        userToken = value;
      });
    });

    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(currentPage),
        ),
      ),
      drawer: Sidebar(title: userToken.user, username: "Admin Page", buttons: [
        ListTile(
          title: Row(
            children: const [
              Icon(Icons.account_circle_outlined),
              Spacer(),
              Text(userRoute),
              Spacer(),
              Icon(Icons.account_circle_outlined, color: Colors.transparent),
            ],
          ),
          onTap: () {
            moveToScreen(context, userRoute);
          },
        ),
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
        initialRoute: userRoute,
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
      case userRoute:
        page = UserOverviewPage();
        break;
      case locationRoute:
        page = LocationPage();
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
