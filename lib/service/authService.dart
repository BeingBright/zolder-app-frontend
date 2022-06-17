import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zolder_app_frontend/config/APIConfig.dart';
import 'package:zolder_app_frontend/model/ServerException.dart';

import '../../model/User.dart';
import '../../model/UserToken.dart';
import '../../service/exception/InvalidUserEsception.dart';

class AuthService {
  var sharedPref = SharedPreferences.getInstance();

  Future<UserToken> loginUser(String username, String password) async {
    var response = await http.post(
      Uri.parse('${APIConfig.baseURI}/auth'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(User(null, username,
          sha512.convert(utf8.encode(password)).toString(), null)),
    );
    if (response.statusCode == 200) {
      var token = UserToken.fromJson(jsonDecode(response.body));
      saveToken(token);

      return token;
    } else {
      throw InvalidUserException(
          ServerException.fromJson(jsonDecode(response.body)).message);
    }
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
