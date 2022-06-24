import 'package:flutter/material.dart';
import 'package:zolder_app/mixins/encryption.dart';
import 'package:zolder_app/mixins/get_provided.dart';
import 'package:zolder_app/models/user.dart';
import 'package:zolder_app/models/user_model.dart';
import 'package:zolder_app/services/user_service.dart';

import '../components/toast-manager.dart';

class UserCommand with provider, encryption {
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
      ToastManager.show(
        context,
        "User '${toRemove.username}' ${(toRemove.isActive) ? "Enabled" : "Disabled"}",
      );
    });
    return res;
  }

  Future addUser(BuildContext context, User user) {
    user.password = encrypt(user.password!);
    Future result = userService.addUser(user);
    result.then((_) {
      getUsers(context);
      ToastManager.show(
        context,
        "Added User: '${user.username}'",
      );
    });
    return result;
  }

  Future updateUser(BuildContext context, User user) {
    user.password = encrypt(user.password!);
    Future result = userService.updateUser(user);
    result.then((_) {
      getUsers(context);
      ToastManager.show(
        context,
        "User: '${user.username}' Updated",
      );
    });
    return result;
  }
}
