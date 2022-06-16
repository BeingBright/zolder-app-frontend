import 'package:flutter/material.dart';
import 'package:zolder_app_frontend/page/office_page.dart';
import 'package:zolder_app_frontend/page/worker_page.dart';

import '../model/UserToken.dart';
import '../service/authService.dart';
import 'admin_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Future<UserToken>? token;

  var usernameController = TextEditingController();
  var passwordController = TextEditingController();

  var loading = false;

  String exception = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Zolder Login"),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Container(
          constraints: const BoxConstraints(
            maxWidth: 350,
          ),
          child: (loading)
              ? const CircularProgressIndicator()
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                        child: Text(exception),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                        child: TextField(
                          autofocus: true,
                          controller: usernameController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Username",
                          ),
                          onEditingComplete: () {
                            submit();
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                        child: TextField(
                          controller: passwordController,
                          obscureText: true,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Password",
                          ),
                          onEditingComplete: () {
                            submit();
                          },
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size.fromHeight(50),
                          padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                        ),
                        onPressed: () {
                          submit();
                        },
                        child: const Text("Login"),
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }

  void submit() {
    token = AuthService().loginUser(
        usernameController.value.text, passwordController.value.text);
    if (token != null) {
      token!
          .then((tok) => {
                setState(() {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              moveToPagePerRole(tok.userType)));
                })
              })
          .onError((error, stackTrace) => {
                setState(() {
                  exception = error.toString();
                })
              });
    }

    // Navigator.pushReplacement(
    //     context,
    //     MaterialPageRoute(
    //         builder: (context) =>
    //             moveToPagePerRole("office")));
  }

  Widget moveToPagePerRole(String role) {
    switch (role) {
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
