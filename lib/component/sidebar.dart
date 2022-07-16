import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:zolder_app/model/user/auth_token.dart';
import 'package:zolder_app/services/auth_service.dart';

class Sidebar extends StatelessWidget {
  Sidebar({Key? key, this.children}) : super(key: key);

  final GetIt getIt = GetIt.instance;

  final List<Widget>? children;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Drawer(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
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
                children: [
                  DrawerHeader(
                    decoration: BoxDecoration(
                      color: theme.primaryColor,
                    ),
                    child: Column(
                      children: [
                        Text(
                          getIt<AuthTokenModel>().authToken.user,
                          style: theme.primaryTextTheme.headline4,
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          getIt<AuthTokenModel>()
                              .authToken
                              .role
                              .name
                              .toLowerCase(),
                          textAlign: TextAlign.center,
                          style: theme.primaryTextTheme.headline6,
                        ),
                      ],
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: children ?? [],
                  )
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
                      var t = getIt<AuthService>().logout();
                      t.then((value) =>
                          Navigator.pushReplacementNamed(context, '/'));
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
