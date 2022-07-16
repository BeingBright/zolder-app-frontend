import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:get_it/get_it.dart';
import 'package:zolder_app/configuration/api_configuration.dart';
import 'package:zolder_app/model/user/auth_token.dart';
import 'package:zolder_app/model/user/user.dart';
import 'package:zolder_app/services/api_controller.dart';

class UserService {
  GetIt getIt = GetIt.instance;

  Future<List<User>> getUsers() async {
    return User.generateList(await getIt<APIController>().get(
      APIConfiguration.user,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: getIt<AuthTokenModel>().authToken.token
      },
    ));
  }

  Future<User> getUser(String username) async {
    return User.fromJson(await getIt<APIController>().get(
      "${APIConfiguration.user}/$username",
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: getIt<AuthTokenModel>().authToken.token
      },
    ));
  }

  Future<User> addUser(User user) async {
    user.password = encrypt(user.password ?? "");
    return User.fromJson(await getIt<APIController>().post(
      APIConfiguration.user,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: getIt<AuthTokenModel>().authToken.token
      },
      body: user,
    ));
  }

  Future<User> updateUser(User user) async {
    user.password = encrypt(user.password ?? "");
    return User.fromJson(await getIt<APIController>().put(
      APIConfiguration.user,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: getIt<AuthTokenModel>().authToken.token
      },
      body: user,
    ));
  }

  Future removeUser(User user) async {
    return User.fromJson(await getIt<APIController>().delete(
      APIConfiguration.user,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: getIt<AuthTokenModel>().authToken.token
      },
      body: user,
    ));
  }

  String encrypt(String msg) {
    return sha512.convert(utf8.encode(msg)).toString();
  }
}
