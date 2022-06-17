import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zolder_app_frontend/config/api_config.dart';
import 'package:zolder_app_frontend/model/user.dart';

import '../model/server_exception.dart';
import '../model/usertoken.dart';

class AuthService {
  var sharedPref = SharedPreferences.getInstance();

  Future<UserToken> loginUser(User user) async {
    var response = await http.post(
      Uri.parse('${APIConfig.baseURI}/auth'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(user),
    );
    if (response.statusCode == 200) {
      var token = UserToken.fromJson(jsonDecode(response.body));
      saveToken(token);
      return token;
    } else {
      throw ServerException.fromJson(jsonDecode(response.body));
    }
  }

  static String encrypt(String msg) {
    return sha512.convert(utf8.encode(msg)).toString();
  }

  void saveToken(UserToken token) async {
    var pref = await sharedPref;
    pref.setString("token", token.token);
    pref.setString("user", token.user);
    pref.setString("userType", token.userType);
  }

  void clearToken() async {
    var pref = await sharedPref;
    pref.setString("token", "");
    pref.setString("user", "");
    pref.setString("userType", "");
  }
}
