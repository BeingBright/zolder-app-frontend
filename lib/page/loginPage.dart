import 'package:flutter/material.dart';
import 'package:zolder_app_frontend/page/locationOverviewPage.dart';
import 'package:zolder_app_frontend/page/office/rapportPage.dart';

import '../model/UserToken.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Future<UserToken>? token;

  var usernameController = TextEditingController();
  var passwordController = TextEditingController();

  var loggingIn = false;

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
          child: (loggingIn)
              ? const CircularProgressIndicator()
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
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
                        padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
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
                          padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                        ),
                        onPressed: () {
                          // setState(
                          //   () {
                          //     loggingIn = true;
                          //     token = authService().loginUser(
                          //         usernameController.value.text,
                          //         passwordController.value.text);
                          //     if (token != null) {
                          //       token!.then((tok) => {
                          //             setState(() {
                          //               loggingIn = false;
                          //               Navigator.pushReplacement(
                          //                   context,
                          //                   MaterialPageRoute(
                          //                       builder: (context) =>
                          //                           moveToPagePerRole(
                          //                               tok.userType)));
                          //             })
                          //           });
                          //     }
                          //   },
                          // );
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      moveToPagePerRole("admin")));
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

  Widget moveToPagePerRole(String role) {
    switch (role) {
      case "admin":
        return const LocationOverviewPage();

      case "worker":
        return const LocationOverviewPage();

      case "office":
        return const RapportPage();

      default:
        return const LoginPage();
    }
  }
}
