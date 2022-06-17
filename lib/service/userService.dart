import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:zolder_app_frontend/config/APIConfig.dart';
import 'package:zolder_app_frontend/model/User.dart';

class UserService {
  Future<List<User>?> getUsers(String token) async {
    try {
      var url = Uri.parse("${APIConfig.baseURI}/user");
      var response =
          await http.get(url, headers: {"token": token});
      if (response.statusCode == 200) {
        List<User> _model = userModelFromJson(response.body);
        return _model;
      }
    } catch (e) {
      print(e.toString());
    }
  }

  List<User> userModelFromJson(String str) =>
      List<User>.from(json.decode(str).map((x) => User.fromJson(x)));
}
