import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
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
  var isChecking = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Zolder Login"),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          constraints: BoxConstraints(
            maxWidth: 350,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0,8,0,8),
                  child: TextField(
                    autofocus: true,
                    controller: usernameController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Username",
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0,8,0,8),
                  child: TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Password",
                    ),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                    padding: const EdgeInsets.fromLTRB(0,8,0,8),
                  ),
                  onPressed: () {
                    
                    Toast.show(msg)
                    
                    setState(
                      () {
                        isChecking = true;
                        token = authService().loginUser(
                            usernameController.value.text,
                            passwordController.value.text);
                      },
                    );
                  },
                  child: Text("Login"),
                ),
                (isChecking) ? buildFutureBuilder() : Text(""),
              ],
            ),
          ),
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
