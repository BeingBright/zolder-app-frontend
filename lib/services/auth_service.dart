import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:zolder_app/configuration/api_configuration.dart';
import 'package:zolder_app/models/server_exception.dart';

import '../models/user.dart';
import '../models/usertoken.dart';

class AuthService {
  static final _instance = AuthService._newInstance();

  factory AuthService() => _instance;

  AuthService._newInstance();

  Future<UserToken> loginUser(String username, String password) async {
    var response = await http.post(Uri.parse(APIConfiguration.auth),
        headers: APIConfiguration.baseHeader,
        body: jsonEncode(User(null, username, password, null)));
    if (response.statusCode == 200) {
      return UserToken.fromJson(jsonDecode(response.body));
    }
    throw ServerException.fromJson(jsonDecode(response.body));
  }

  Future logoutUser() {
    return Future.delayed(const Duration(seconds: 2));
  }
}
