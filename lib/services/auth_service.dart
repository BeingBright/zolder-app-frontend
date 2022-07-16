import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zolder_app/configuration/api_configuration.dart';
import 'package:zolder_app/model/user/auth_token.dart';
import 'package:zolder_app/model/user/user.dart';
import 'package:zolder_app/services/api_controller.dart';

class AuthService {
  GetIt getIt = GetIt.instance;

  late final SharedPreferences sharedPrefs;

  AuthService() {
    SharedPreferences.getInstance().then((value) {
      sharedPrefs = value;
    });
  }

  Future<AuthToken> login(
      String username, String password, bool remember) async {
    var token = AuthToken.fromJson(
      await getIt<APIController>().post(
        '${APIConfiguration.auth}/login',
        body: User.login(username, encrypt(password), remember),
        headers: APIConfiguration.baseHeader,
      ),
    );
    getIt<AuthTokenModel>().setToken(token);
    saveToken(token);
    return token;
  }

  Future<AuthToken> logout() async {
    await getIt<APIController>().post(
      '${APIConfiguration.auth}/logout',
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: getIt<AuthTokenModel>().authToken.token
      },
    );
    AuthTokenModel tm = getIt<AuthTokenModel>();
    clearToken();
    tm.clearToken();
    return tm.authToken;
  }

  Future<AuthToken> loadToken() async {
    if (sharedPrefs.getBool('saved') == null ||
        sharedPrefs.getBool('saved') == false) {
      return AuthToken.empty();
    }

    var token = AuthToken(
      sharedPrefs.getString('token')!,
      sharedPrefs.getString('user')!,
      UserRole.values.firstWhere(
          (element) => element.toString() == sharedPrefs.getString('role')),
    );

    AuthTokenModel tm = getIt<AuthTokenModel>();
    tm.setToken(token);
    return tm.authToken;
  }

  Future saveToken(AuthToken token) async {
    await clearToken();
    sharedPrefs.setBool('saved', true);
    sharedPrefs.setString('token', token.token);
    sharedPrefs.setString('user', token.user);
    sharedPrefs.setString('role', token.role.toString());
  }

  Future clearToken() async {
    sharedPrefs.setBool('saved', false);
    sharedPrefs.setString('token', '');
    sharedPrefs.setString('user', '');
    sharedPrefs.setString('role', '');
  }

  String encrypt(String msg) {
    return sha512.convert(utf8.encode(msg)).toString();
  }
}
