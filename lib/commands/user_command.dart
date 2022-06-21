import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import 'package:zolder_app/mixins/get_provided.dart';
import 'package:zolder_app/models/user.dart';
import 'package:zolder_app/models/user_model.dart';
import 'package:zolder_app/services/user_service.dart';

class UserCommand with provider {
  static final _instance = UserCommand._internal();

  UserCommand._internal();

  factory UserCommand() => _instance;

  final UserService userService = UserService();

  Future<List<User>> getUsers(BuildContext context) {
    Future<List<User>> users = userService.getUsers();
    users.then((users) => getProvided<UserModel>(context).setUsers(users));
    return users;
  }

  Future removeUsers(BuildContext context, User toRemove) {
    Future res = userService.removeUser(toRemove);
    res.then((_) {
      getUsers(context);
      Toast.show(
        "User '${toRemove.username}' ${(toRemove.isActive) ? "Enabled" : "Disabled"}",
        duration: Toast.lengthLong,
        gravity: Toast.top,
      );
    });
    return res;
  }
}
