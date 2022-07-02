import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:get_it/get_it.dart';
import 'package:zolder_app/configuration/api_configuration.dart';
import 'package:zolder_app/model/user/auth_token.dart';
import 'package:zolder_app/model/user/user.dart';
import 'package:zolder_app/services/api_controller.dart';

class AuthService {
  GetIt getIt = GetIt.instance;

  Future<AuthToken> login(String username, String password) async {
    var token = AuthToken.fromJson(
      await getIt<APIController>().post(
        '${APIConfiguration.auth}/login',
        body: User.login(username, encrypt(password)),
        headers: APIConfiguration.baseHeader,
      ),
    );
    getIt<AuthTokenModel>().setToken(token);
    return token;
  }

  Future<AuthToken> logout() async {
    await getIt<APIController>().post(
      '${APIConfiguration.auth}/logout',
      headers: APIConfiguration.baseHeader,
    );
    AuthTokenModel tm = getIt<AuthTokenModel>();
    tm.clearToken();
    return tm.authToken;
  }

  String encrypt(String msg) {
    return sha512.convert(utf8.encode(msg)).toString();
  }
}
