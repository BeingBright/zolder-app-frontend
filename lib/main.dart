import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import 'package:zolder_app_frontend/page/login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    return MaterialApp(
      title: 'Zolder App',
      debugShowCheckedModeBanner: false,
      home: const LoginPage(),
      theme: ThemeData.light(),
      // darkTheme: ThemeData.dark(),
    );
  }
}
