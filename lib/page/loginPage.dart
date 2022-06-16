import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:zolder_app_frontend/page/model/User.dart';
import 'package:zolder_app_frontend/service/authService.dart';

import 'model/UserToken.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var usernameController = TextEditingController();
  var passwordController = TextEditingController();
  Future<UserToken>? token;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Zolder Login"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: usernameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Username",
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Password",
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                var password =
                    sha512.convert(utf8.encode(passwordController.value.text));
                User user = User(
                    "", usernameController.value.text, password.toString(), "");
                token = authService().loginUser(user);
                print(token);
              },
              child: Text("Login"),
            ),
            buildFutureBuilder(),
          ],
        ),
      ),
    );
  }

  FutureBuilder<UserToken> buildFutureBuilder() {
    return FutureBuilder<UserToken>(
      future: token,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Text(snapshot.data!.token);
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        return const CircularProgressIndicator();
      },
    );
  }
}
