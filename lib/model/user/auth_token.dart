import 'package:flutter/foundation.dart';
import 'package:zolder_app/model/user/user.dart';

class AuthToken {
  String token;
  String user;
  UserRole role;

  AuthToken(this.token, this.user, this.role);

  static AuthToken empty() => AuthToken("", "", UserRole.none);

  AuthToken.fromJson(Map<String, dynamic> json)
      : token = json['token'],
        user = json['username'],
        role = UserRole.values
            .firstWhere((e) => e.toString().toUpperCase().contains(json['role']));

  bool isEmpty() => token == "" && user == "" && role == "";

  Map<String, dynamic> toJson() => {
        'token': token,
        'user': user,
        'userType': role,
      };

  void clear() {
    token = "";
    user = "";
    role = UserRole.none;
  }

  @override
  String toString() {
    return 'UserToken{token: $token, user: $user, userType: $role}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AuthToken &&
          runtimeType == other.runtimeType &&
          token == other.token &&
          user == other.user &&
          role == other.role;

  @override
  int get hashCode => token.hashCode ^ user.hashCode ^ role.hashCode;
}

class AuthTokenModel extends ChangeNotifier {
  AuthToken authToken = AuthToken.empty();

  void setToken(AuthToken token) {
    authToken = token;
    notifyListeners();
  }

  void clearToken() {
    authToken.clear();
    notifyListeners();
  }
}
