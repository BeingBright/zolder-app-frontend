import 'package:flutter/material.dart';
import 'package:zolder_app/models/user_token.dart';

class UserTokenModel extends ChangeNotifier {
  UserToken userToken = UserToken.empty();

  void setToken(UserToken newToken) {
    userToken = newToken;
    notifyListeners();
  }

  void removeToken() {
    userToken = UserToken.empty();
    notifyListeners();
  }
}
