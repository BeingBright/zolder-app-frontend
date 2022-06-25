import 'package:zolder_app/configuration/api_configuration.dart';

import 'api_controller.dart';
import '../models/user.dart';
import '../models/user_token.dart';

class AuthService {
  static final _instance = AuthService._newInstance();
  final APIController controller = APIController();

  factory AuthService() => _instance;

  AuthService._newInstance();

  UserToken token = UserToken.empty();

  Future<UserToken> loginUser(String username, String password) async {
    token = UserToken.fromJson(
      await controller.post(
        '${APIConfiguration.auth}/login',
        body: User(null, username, password, null, true),
        headers: APIConfiguration.baseHeader,
      ),
    );
    return token;
  }

  Future<UserToken> logoutUser() async {
    await controller.post(
      '${APIConfiguration.auth}/logout',
      headers: APIConfiguration.getHeadersWithToken(token.token),
    );
    return UserToken.empty();
  }

  void onError(int statusCode, Function(String body) callback) {
    controller.addOnStatusCallback(statusCode, callback);
  }
}
