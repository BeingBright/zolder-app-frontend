import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import 'package:zolder_app/models/user_token.dart';

import '../components/toast-manager.dart';
import '../controller/auth_command.dart';

class LoginPage extends StatefulWidget {
  final double? mainPadding;

  final double? elementPadding;

  final double? elementSize;

  const LoginPage(
      {Key? key, this.mainPadding, this.elementPadding, this.elementSize})
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
  double _elementSize = 350;

  @override
  void initState() {
    super.initState();
    _mainPadding = (widget.mainPadding) ?? _mainPadding;
    _elementPadding = (widget.elementPadding) ?? _elementPadding;
    _elementSize = (widget.elementSize) ?? _elementSize;

  }

  @override
  Widget build(BuildContext context) {
    AuthCommand().setUserModel(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints:
              BoxConstraints(minHeight: MediaQuery.of(context).size.height),
          child: Padding(
            padding: EdgeInsets.all(_mainPadding),
            child: Center(
              child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  if (constraints.maxWidth > _elementSize) {
                    return SizedBox(
                      width: _elementSize,
                      child: Card(child: loginForm(context)),
                    );
                  } else {
                    return loginForm(context);
                  }
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget loginForm(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
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
                  textInputAction: TextInputAction.next,
                  autofocus: true,
                  controller: _usernameController,
                  autofillHints: const [AutofillHints.username],
                  keyboardType: TextInputType.name,
                  onTap: () => _usernameController.selection = TextSelection(
                      baseOffset: 0,
                      extentOffset: _usernameController.value.text.length),
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Username",
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(_elementPadding),
                child: TextFormField(
                  textInputAction: TextInputAction.done,
                  controller: _passwordController,
                  autofillHints: const [AutofillHints.password],
                  obscureText: true,
                  keyboardType: TextInputType.visiblePassword,
                  onTap: () => _passwordController.selection = TextSelection(
                      baseOffset: 0,
                      extentOffset: _passwordController.value.text.length),
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Password",
                  ),
                  onEditingComplete: () => loginUser(),
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
            onPressed: () => loginUser(),
            child: Padding(
              padding: EdgeInsets.all(_elementPadding),
              child: const Text("Log in"),
            ),
          ),
        )
      ],
    );
  }

  void loginUser() {
    AuthCommand()
        .loginUser(context, _usernameController.text, _passwordController.text)
        .onError((error, stackTrace) {
      setState(() {
        _errorMessage = "Invalid User";
        ToastManager.show(context,_errorMessage);
      });
      return UserToken.empty();
    });
  }
}
