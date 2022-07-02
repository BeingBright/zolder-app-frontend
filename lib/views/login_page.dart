import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:zolder_app/model/user/user.dart';
import 'package:zolder_app/services/auth_service.dart';

import '../model/user/auth_token.dart';

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

  var rememberMe = false;

  double _mainPadding = 16;
  double _elementPadding = 16;
  double _elementSize = 350;
  GetIt getIt = GetIt.instance;

  void _loadPage(AuthToken token) {
    if (token.role == UserRole.none) {
    } else {
      Navigator.pushReplacementNamed(context, '/${token.role.name.toString()}');
    }
  }

  void _loginUser() {
    var t = getIt<AuthService>()
        .login(_usernameController.text, _passwordController.text, rememberMe);
    t.then((value) {
      _loadPage(value);
    });
    t.onError((error, stackTrace) {
      _errorMessage = "";
      return AuthToken.empty();
    });
  }

  @override
  void initState() {
    super.initState();
    _mainPadding = (widget.mainPadding) ?? _mainPadding;
    _elementPadding = (widget.elementPadding) ?? _elementPadding;
    _elementSize = (widget.elementSize) ?? _elementSize;
    getIt<AuthService>().loadToken().then((value) => _loadPage(value));
  }

  @override
  Widget build(BuildContext context) {
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
                    onEditingComplete: _loginUser,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: _elementPadding),
                  child: Row(
                    children: [
                      Checkbox(
                        activeColor:
                            Theme.of(context).buttonTheme.colorScheme?.primary,
                        value: rememberMe,
                        onChanged: (b) {
                          setState(() {
                            rememberMe = b!;
                          });
                        },
                      ),
                      const Text("Remember Me"),
                    ],
                  ),
                ),
              ],
            ),
          ),
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
            onPressed: _loginUser,
            child: Padding(
              padding: EdgeInsets.all(_elementPadding),
              child: const Text("Log in"),
            ),
          ),
        )
      ],
    );
  }
}
