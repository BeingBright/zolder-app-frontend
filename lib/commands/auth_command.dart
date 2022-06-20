import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:zolder_app/mixins/get_provided.dart';
import 'package:zolder_app/models/usertoken.dart';
import 'package:zolder_app/models/usertoken_model.dart';
import 'package:zolder_app/services/auth_service.dart';

class AuthCommand with provider {
  static final _instance = AuthCommand._internal();

  AuthService authService = AuthService();

  factory AuthCommand() => _instance;

  AuthCommand._internal();

  Future<UserToken> loginUser(
      BuildContext context, String username, String password) {
    Future<UserToken> newToken = authService.loginUser(username, password);
    newToken.then(
      (newToken) => getProvided<UserTokenModel>(context).setToken(newToken),
    );
    return newToken;
  }

  logoutUser(BuildContext context) {
    authService.logoutUser().then(
          (response) => getProvided<UserTokenModel>(context).removeToken(),
        );
  }

  String encrypt(String msg) {
    return sha512.convert(utf8.encode(msg)).toString();
  }
}
