import 'package:flutter/material.dart';
import 'package:zolder_app/model/user/user.dart';

class UserModel extends ChangeNotifier {
  List<User> users = [];

  void setUsers(List<User> users) {
    this.users = users;
    notifyListeners();
  }
}
