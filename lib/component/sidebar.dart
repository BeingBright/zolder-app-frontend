import 'package:flutter/material.dart';

import '../page/loginPage.dart';
import '../service/authService.dart';

class Sidebar extends StatelessWidget {
  final String title;

  Sidebar({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.

      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: theme.primaryColor,
            ),
            child: Text(title),
          ),
          ListTile(
            title: const Text('Log out'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const LoginPage()));
              AuthService().clearToken();
            },
          ),
        ],
      ),
    );
  }
}
