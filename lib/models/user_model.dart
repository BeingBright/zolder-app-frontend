import 'package:flutter/material.dart';
import 'package:zolder_app/models/user.dart';

class UserModel extends ChangeNotifier {
  List<User> users = List.empty(growable: true);

  void setUsers(List<User> users) {
    this.users = users;
    notifyListeners();
  }
}
