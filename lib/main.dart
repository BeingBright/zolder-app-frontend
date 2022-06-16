import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import 'package:zolder_app_frontend/page/loginPage.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    return MaterialApp(
      title: 'Zolder App',
      debugShowCheckedModeBanner: false,
      home: const LoginPage(),
      theme: ThemeData(
        colorScheme: const ColorScheme(
          primary: Colors.blue,
          onPrimary: Colors.white,
          error: Colors.white,
          onError: Colors.red,
          secondary: Colors.blueGrey,
          onSecondary: Colors.white70,
          surface: Colors.blue,
          onSurface: Colors.black,
          background: Colors.white,
          onBackground: Colors.black,
          brightness: Brightness.light,
        ),
      ),
    );
  }
}
