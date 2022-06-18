import 'package:flutter/material.dart';
import 'package:zolder_app_frontend/widget/snack-message.dart';

import '../page/login_page.dart';
import '../service/auth-service.dart';

class Sidebar extends StatelessWidget {
  final String title;
  final String username;
  final List<Widget> buttons;

  const Sidebar(
      {Key? key,
      required this.title,
      required this.username,
      required this.buttons})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    List<Widget> children = [];
    children.add(Container(
      constraints: const BoxConstraints(minWidth: double.infinity),
      child: DrawerHeader(
        decoration: BoxDecoration(
          color: theme.primaryColor,
        ),
        child: Column(
          children: [
            Text(
              title,
              style: theme.primaryTextTheme.headline5,
              textAlign: TextAlign.center,
            ),
            Text(
              username,
              style: theme.primaryTextTheme.headline6,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    ));
    children.addAll(buttons);
    children.add(Spacer());
    children.add(Divider());
    children.add(ListTile(
      title: Row(
        children: const [
          Icon(Icons.logout),
          Spacer(),
          Text('Log out'),
          Spacer(),
          Icon(Icons.logout, color: Colors.transparent),
        ],
      ),
      onTap: () {
        Navigator.pop(context);
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const LoginPage()));
        AuthService().clearToken();
        SnackMessage.show(context, SnackType.success, "Logged Out");
      },
    ));

    return Drawer(
      child: Column(
        // padding: EdgeInsets.zero,
        children: children,
      ),
    );
  }
}
