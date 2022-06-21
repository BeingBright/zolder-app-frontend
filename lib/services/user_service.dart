import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:zolder_app/configuration/api_configuration.dart';
import 'package:zolder_app/models/server_exception.dart';
import 'package:zolder_app/models/user.dart';
import 'package:zolder_app/services/auth_service.dart';

class UserService {
  static final _instance = UserService._newInstance();

  UserService._newInstance();

  factory UserService() => _instance;

  Future<List<User>> getUsers() async {
    var uri = Uri.parse(APIConfiguration.user);
    var response = await http.get(uri,
        headers: {HttpHeaders.authorizationHeader: AuthService().token.token});

    if (response.statusCode == 200) {
      return usersFromJson(response.body);
    }
    throw ServerException.fromJson(jsonDecode(response.body));
  }

  Future addUser(User user) async {
    var uri = Uri.parse(APIConfiguration.user);
    var response = await http.post(
      uri,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: AuthService().token.token
      },
      body: jsonEncode(user),
    );

    if (response.statusCode == 200) {
      return;
    }
    throw ServerException.fromJson(jsonDecode(response.body));
  }

  Future removeUser(User user) async {
    var uri = Uri.parse(APIConfiguration.user);
    user.isActive = !user.isActive;
    var response = await http.put(
      uri,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: AuthService().token.token
      },
      body: jsonEncode(user),
    );

    if (response.statusCode == 200) {
      return;
    }
    throw ServerException.fromJson(jsonDecode(response.body));
  }

  Future updateUser(User user) async {
    var uri = Uri.parse(APIConfiguration.user);
    var response = await http.post(
      uri,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: AuthService().token.token
      },
      body: jsonEncode(user),
    );

    if (response.statusCode == 200) {
      return;
    }
    throw ServerException.fromJson(jsonDecode(response.body));
  }

  List<User> usersFromJson(String str) =>
      List<User>.from(json.decode(str).map((x) => User.fromJson(x)));
}
