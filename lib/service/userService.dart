import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:zolder_app_frontend/config/APIConfig.dart';
import 'package:zolder_app_frontend/model/ServerException.dart';
import 'package:zolder_app_frontend/model/User.dart';
import 'package:zolder_app_frontend/service/authService.dart';

class UserService {
  Future<List<User>?> getUsers() async {
    try {
      var url = Uri.parse("${APIConfig.baseURI}/user");
      var response =
          await http.get(url, headers: {"token": AuthService.token!.token});
      if (response.statusCode == 200) {
        List<User> _model = userModelFromJson(response.body);
        return _model;
      }
    } catch (e) {
      print(e.toString());
    }
    return null;
  }

  Future<User?> addUsers(User user) async {
    try {
      var url = Uri.parse("${APIConfig.baseURI}/user");
      var response = await http.post(url,
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            "token": AuthService.token!.token,
          },
          body: jsonEncode(user));
      if (response.statusCode == 200) {
        User model = User.fromJson(jsonDecode(response.body));
        return model;
      }
    } catch (e) {
      print(e.toString());
    }
    return null;
  }

  Future<ServerException?> removeUsers(User user) async {
    try {
      var url = Uri.parse("${APIConfig.baseURI}/user");
      var response = await http.delete(url,
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            "token": AuthService.token!.token,
          },
          body: jsonEncode(user));

      if (response.statusCode == 200) {
        ServerException model =
            ServerException.fromJson(jsonDecode(response.body));
        return model;
      }
    } catch (e) {
      print(e.toString());
    }
    return null;
  }

  List<User> userModelFromJson(String str) =>
      List<User>.from(json.decode(str).map((x) => User.fromJson(x)));
}
