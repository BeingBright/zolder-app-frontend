import 'dart:io';

import 'package:zolder_app/configuration/api_configuration.dart';
import 'package:zolder_app/models/user.dart';
import 'package:zolder_app/services/auth_service.dart';

import 'api_controller.dart';

class UserService {
  static final _instance = UserService._newInstance();
  final APIController controller = APIController();

  UserService._newInstance();

  factory UserService() => _instance;

  Future<List<User>> getUsers() async {
    return usersFromJson(await controller.get(
      APIConfiguration.user,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: AuthService().token.token
      },
    ));
  }

  Future addUser(User user) async {
    return await controller.post(APIConfiguration.user,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          HttpHeaders.authorizationHeader: AuthService().token.token,
        },
        body: user);
  }

  Future removeUser(User user) async {
    user.isActive = !user.isActive;
    return await controller.put(APIConfiguration.user,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          HttpHeaders.authorizationHeader: AuthService().token.token,
        },
        body: user);
  }

  Future updateUser(User user) async {
    return await controller.put(APIConfiguration.user,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          HttpHeaders.authorizationHeader: AuthService().token.token,
        },
        body: user);
  }

  List<User> usersFromJson(List json) {
    return List<User>.from(json.map((e) {
      return User.fromJson(e);
    }));
  }
}
