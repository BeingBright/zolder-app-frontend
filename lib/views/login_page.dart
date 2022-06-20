import 'package:flutter/material.dart';
import 'package:zolder_app/models/user_token.dart';

import '../commands/auth_command.dart';

class LoginPage extends StatefulWidget {
  final double? mainPadding;

  final double? elementPadding;

  const LoginPage({Key? key, this.mainPadding, this.elementPadding})
      : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _errorMessage = "";

  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  double _mainPadding = 16;
  double _elementPadding = 16;

  @override
  void initState() {
    super.initState();
    _mainPadding = (widget.mainPadding) ?? _mainPadding;
    _elementPadding = (widget.elementPadding) ?? _elementPadding;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(_mainPadding),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.all(_elementPadding),
              child: Center(
                child: Text("Zolder app",
                    style: Theme.of(context).textTheme.headline3),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(_elementPadding),
              child: Center(
                child: Text(
                  "Login Page",
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
            ),
            AutofillGroup(
              key: _formKey,
              onDisposeAction: AutofillContextAction.commit,
              child: Form(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.all(_elementPadding),
                    child: TextFormField(
                      autofocus: true,
                      controller: _usernameController,
                      autofillHints: const [AutofillHints.username],
                      keyboardType: TextInputType.name,
                      onTap: () => _usernameController.selection =
                          TextSelection(
                              baseOffset: 0,
                              extentOffset:
                                  _usernameController.value.text.length),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Username",
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(_elementPadding),
                    child: TextFormField(
                      controller: _passwordController,
                      autofillHints: const [AutofillHints.password],
                      obscureText: true,
                      keyboardType: TextInputType.visiblePassword,
                      onTap: () => _passwordController.selection =
                          TextSelection(
                              baseOffset: 0,
                              extentOffset:
                                  _passwordController.value.text.length),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Password",
                      ),
                    ),
                  ),
                ],
              )),
            ),
            Padding(
              padding: const EdgeInsets.all(0),
              child: Center(
                child: Text(_errorMessage,
                    style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .copyWith(color: Colors.red)),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(_elementPadding),
              child: ElevatedButton(
                onPressed: () => AuthCommand()
                    .loginUser(context, _usernameController.text,
                        _passwordController.text)
                    .onError((error, stackTrace) {
                  setState(() {
                    _errorMessage = "Invalid User";
                  });
                  return UserToken.empty();
                }),
                child: Padding(
                  padding: EdgeInsets.all(_elementPadding),
                  child: const Text("Log in"),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
