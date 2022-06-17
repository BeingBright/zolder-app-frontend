import 'package:zolder_app_frontend/model/user.dart';

import '../model/usertoken.dart';

class AuthService {
  Future<UserToken> loginUser(User user) async {
    Future.delayed(
      const Duration(seconds: 2),
      () {
        return UserToken("token", "user", "userType");
      },
    );
    return UserToken.empty();
  }
}
