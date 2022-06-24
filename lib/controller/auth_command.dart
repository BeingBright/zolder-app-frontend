import 'package:flutter/material.dart';
import 'package:zolder_app/mixins/encryption.dart';
import 'package:zolder_app/mixins/get_provided.dart';
import 'package:zolder_app/models/user_token.dart';
import 'package:zolder_app/models/user_token_model.dart';
import 'package:zolder_app/services/auth_service.dart';

import '../components/toast-manager.dart';

class AuthCommand with provider, encryption {
  static final _instance = AuthCommand._internal();

  AuthService authService = AuthService();

  UserTokenModel? userTokenModel;

  factory AuthCommand() => _instance;

  AuthCommand._internal() {
    authService.onError(401, (body) {
      userTokenModel?.removeToken();
    });
  }

  setUserModel(BuildContext context) {
    userTokenModel = getProvided<UserTokenModel>(context);
  }

  Future<UserToken> loginUser(
      BuildContext context, String username, String password) {
    Future<UserToken> newToken =
        authService.loginUser(username, encrypt(password));
    newToken.then(
      (newToken) {
        getProvided<UserTokenModel>(context).setToken(newToken);
        ToastManager.show(
          context,
          "Logged In",
        );
      },
    );
    return newToken;
  }

  logoutUser(BuildContext context) {
    getProvided<UserTokenModel>(context).removeToken();
    authService.logoutUser().then(
      (response) {
        ToastManager.show(
          context,
          "Logged Out",
        );
      },
    );
  }

  void onError(int statusCode, Function callback) {}
}
