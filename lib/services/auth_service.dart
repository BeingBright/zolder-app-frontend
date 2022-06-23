import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:zolder_app/configuration/api_configuration.dart';
import 'package:zolder_app/models/server_exception.dart';

import '../models/user.dart';
import '../models/user_token.dart';

class AuthService {
  static final _instance = AuthService._newInstance();

  factory AuthService() => _instance;

  AuthService._newInstance();

  UserToken token = UserToken.empty();

  Future<UserToken> loginUser(String username, String password) async {
    var response = await http.post(Uri.parse('${APIConfiguration.auth}/login'),
        headers: APIConfiguration.baseHeader,
        body: jsonEncode(User(null, username, password, null, true)));
    if (response.statusCode == 200) {
      token = UserToken.fromJson(jsonDecode(response.body));
      return token;
    }
    throw ServerException.fromJson(jsonDecode(response.body));
  }

  Future<UserToken> logoutUser() async {
    var response = await http.post(
      Uri.parse('${APIConfiguration.auth}/logout'),
      headers: APIConfiguration.getHeadersWithToken(token.token),
    );
    if (response.statusCode == 200) {
      token = UserToken.fromJson(jsonDecode(response.body));
      return UserToken.empty();

    }
    throw ServerException.fromJson(jsonDecode(response.body));
  }
}
