import '../models/usertoken.dart';

class AuthService {
  static final _instance = AuthService._newInstance();

  factory AuthService() => _instance;

  AuthService._newInstance();

  Future<UserToken> loginUser(String username, String password) {
    return Future.delayed(
      const Duration(seconds: 2),
      () {
        // throw Exception("OOPS");
        return UserToken("token", "user", "worker");
      },
    );
  }

  Future logoutUser() {
    return Future.delayed(const Duration(seconds: 2));
  }
}
