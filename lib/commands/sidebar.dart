import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/user_token_model.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Drawer(
      child: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
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
                      .userType
                      .toLowerCase(),
                  textAlign: TextAlign.center,
                  style: theme.primaryTextTheme.headline6,
                )
              ],
            ),
          )
        ],
      )),
    );
  }
}
