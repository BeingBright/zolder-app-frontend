import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import 'package:zolder_app/mixins/get_provided.dart';
import 'package:zolder_app/models/user_token.dart';
import 'package:zolder_app/models/user_token_model.dart';
import 'package:zolder_app/services/auth_service.dart';

class AuthCommand with provider {
  static final _instance = AuthCommand._internal();

  AuthService authService = AuthService();

  factory AuthCommand() => _instance;

  AuthCommand._internal();

  Future<UserToken> loginUser(
      BuildContext context, String username, String password) {
    Future<UserToken> newToken =
        authService.loginUser(username, encrypt(password));
    newToken.then(
      (newToken) {
        getProvided<UserTokenModel>(context).setToken(newToken);
        Toast.show(
          "Logged In",
          duration: Toast.lengthLong,
          gravity: Toast.top,
        );
      },
    );
    return newToken;
  }

  logoutUser(BuildContext context) {
    authService.logoutUser().then(
      (response) {
        getProvided<UserTokenModel>(context).removeToken();
        Toast.show(
          "Logged Out",
          duration: Toast.lengthLong,
          gravity: Toast.top,
        );
      },
    );
  }

  String encrypt(String msg) {
    return sha512.convert(utf8.encode(msg)).toString();
  }
}
