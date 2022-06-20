import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zolder_app/models/usertoken_model.dart';
import 'package:zolder_app/views/admin_page.dart';
import 'package:zolder_app/views/login_page.dart';
import 'package:zolder_app/views/office_page.dart';
import 'package:zolder_app/views/worker_page.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => UserTokenModel()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Zolder',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: Consumer<UserTokenModel>(
        builder: (context, userTokenModel, child) {
          return getPage(userTokenModel.userToken.userType);
        },
      ),
    );
  }

  Widget getPage(String type) {
    switch (type) {
      case "admin":
        return const AdminPage();

      case "worker":
        return const WorkerPage();

      case "office":
        return const OfficePage();

      default:
        return const LoginPage();
    }
  }
}
