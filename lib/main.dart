import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import 'package:zolder_app_frontend/page/loginPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    return const MaterialApp(
      title: 'Zolder App',
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}
