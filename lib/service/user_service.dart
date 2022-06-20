import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:zolder_app_frontend/model/User.dart';

import '../config/api_config.dart';
import '../model/server_exception.dart';
import 'auth-service.dart';

class UserService {
  Future<List<User>?> getUsers() async {
    String token = (await AuthService().getToken()).token;
    try {
      var url = Uri.parse(APIConfig.user);
      var response = await http.get(url, headers: {"token": token});
      if (response.statusCode == 200) {
        List<User> _model = userModelFromJson(response.body);
        return _model;
      } else {
        ServerException model =
            ServerException.fromJson(jsonDecode(response.body));
        throw model;
      }
    } catch (e) {
      throw ServerException(e.toString(), "500", 500);
    }
  }

  Future<User?> addUsers(User user) async {
    String token = (await AuthService().getToken()).token;
    try {
      var url = Uri.parse(APIConfig.user);
      var response = await http.post(url,
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            "token": token,
          },
          body: jsonEncode(user));
      if (response.statusCode == 200) {
        User model = User.fromJson(jsonDecode(response.body));
        return model;
      } else {
        ServerException model =
            ServerException.fromJson(jsonDecode(response.body));
        throw model;
      }
    } catch (e) {
      throw ServerException(e.toString(), "500", 500);
    }
  }

  Future<ServerException> removeUsers(User user) async {
    String token = (await AuthService().getToken()).token;
    try {
      var url = Uri.parse(APIConfig.user);
      var response = await http.delete(url,
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            "token": token,
          },
          body: jsonEncode(user));

      ServerException model =
          ServerException.fromJson(jsonDecode(response.body));
      return model;
    } catch (e) {
      rethrow;
    }
  }

  List<User> userModelFromJson(String str) =>
      List<User>.from(json.decode(str).map((x) => User.fromJson(x)));
}
