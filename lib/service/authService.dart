import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../page/model/User.dart';
import '../page/model/UserToken.dart';

class authService {
  Future<UserToken> loginUser(String username, String password) async {
    var response = await http.post(
      Uri.parse('http://localhost:3000/zolder/auth'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(User(null, username,
          sha512.convert(utf8.encode(password)).toString(), null)),
    );

    if (response.statusCode == 200) {
      var token = UserToken.fromJson(jsonDecode(response.body));
      var pref = await SharedPreferences.getInstance();
      pref.setString("token", token.token);
      pref.setString("user", token.user);
      pref.setString("userType", token.userType);
      return token;
    } else {
      throw Exception("Can not login user");
    }
  }
}

//final responce = await http.get(
//         Uri.parse("http://localhost:3000/zolder/auth"));
//     if (responce.statusCode == 200) {
//       return UserToken.fromJson(jsonDecode(responce.body));
//     } else {
//       throw Exception("Failed to ge");
//     }
