import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controller/auth_command.dart';
import '../models/user_token_model.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({Key? key, required this.children}) : super(key: key);

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Drawer(
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Container(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                // mainAxisSize: MainAxisSize.max,
                children: [
                  DrawerHeader(
                    decoration: BoxDecoration(
                      color: theme.primaryColor,
                    ),
                    child: Column(
                      children: [
                        Text(
                          Provider.of<UserTokenModel>(context).userToken.user,
                          style: theme.primaryTextTheme.headline4,
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          Provider.of<UserTokenModel>(context)
                              .userToken
                              .role
                              .toLowerCase(),
                          textAlign: TextAlign.center,
                          style: theme.primaryTextTheme.headline6,
                        ),
                      ],
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: children,
                  ),
                ],
              ),
              Column(
                children: [
                  const Divider(),
                  ListTile(
                    title: Row(
                      children: const [
                        Icon(Icons.logout),
                        Spacer(),
                        Text("Log out"),
                        Spacer(),
                        Icon(
                          Icons.logout,
                          color: Colors.transparent,
                        ),
                      ],
                    ),
                    onTap: () {
                      AuthCommand().logoutUser(context);
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

/*

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Drawer(
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          // mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              constraints: BoxConstraints.expand(
                  height: MediaQuery.of(context).size.height),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  DrawerHeader(
                    decoration: BoxDecoration(
                      color: theme.primaryColor,
                    ),
                    child: Column(
                      children: [
                        Text(
                          Provider.of<UserTokenModel>(context).userToken.user,
                          style: theme.primaryTextTheme.headline4,
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          Provider.of<UserTokenModel>(context)
                              .userToken
                              .role
                              .toLowerCase(),
                          textAlign: TextAlign.center,
                          style: theme.primaryTextTheme.headline6,
                        ),
                      ],
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: children,
                  ),
                  const Spacer(),
                  const Divider(),
                  ListTile(
                    title: Row(
                      children: const [
                        Icon(Icons.logout),
                        Spacer(),
                        Text("Log out"),
                        Spacer(),
                        Icon(
                          Icons.logout,
                          color: Colors.transparent,
                        ),
                      ],
                    ),
                    onTap: () {
                      AuthCommand().logoutUser(context);
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

 */
