import 'package:flutter/material.dart';
import 'package:zolder_app_frontend/model/server_exception.dart';
import 'package:zolder_app_frontend/model/user.dart';
import 'package:zolder_app_frontend/service/auth-service.dart';
import 'package:zolder_app_frontend/widget/snack-message.dart';

import '../model/usertoken.dart';
import 'admin_page.dart';
import 'office_page.dart';
import 'worker_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text("Zolder App"),
        ),
      ),
      body: Center(
        child: Card(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 350),
            child: AutofillGroup(
              child: Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          backgroundBlendMode: BlendMode.darken),
                      child: Padding(
                        padding: const EdgeInsets.all(32.0),
                        child: Center(
                          child: Text("Log in",
                              style: Theme.of(context)
                                  .textTheme
                                  .displaySmall!
                                  .copyWith(color: Colors.white)),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 32, 8, 8),
                      child: SizedBox(
                        height: 70,
                        child: TextFormField(
                          autofocus: true,
                          controller: usernameController,
                          autofillHints: const [AutofillHints.username],
                          keyboardType: TextInputType.name,
                          onTap: () => usernameController.selection =
                              TextSelection(
                                  baseOffset: 0,
                                  extentOffset:
                                      usernameController.value.text.length),
                          obscureText: false,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "Username"),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Username is required";
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: 70,
                        child: TextFormField(
                          controller: passwordController,
                          autofillHints: const [AutofillHints.password],
                          keyboardType: TextInputType.visiblePassword,
                          onTap: () => passwordController.selection =
                              TextSelection(
                                  baseOffset: 0,
                                  extentOffset:
                                      passwordController.value.text.length),
                          obscureText: true,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Password",
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Username is required";
                            }
                            return null;
                          },
                          expands: false,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size.fromHeight(50),
                          padding: const EdgeInsets.fromLTRB(0, 16, 0, 16),
                        ),
                        child: const Text("Log in"),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            var result = AuthService().loginUser(User(
                                null,
                                usernameController.text,
                                AuthService.encrypt(passwordController.text),
                                null));
                            result.catchError((error, stackTrace) => {
                                  SnackMessage.show(context, SnackType.danger,
                                      (error as ServerException).message)
                                });
                            result.then((value) => {
                                  SnackMessage.show(
                                      context, SnackType.success, "Loggin In")
                                });
                          }
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget moveToPagePerRole(UserToken token) {
    switch (token.userType) {
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
