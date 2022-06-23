class UserToken {
  String token;
  String user;
  String role;

  UserToken(this.token, this.user, this.role);

  static UserToken empty() => UserToken("", "", "");

  UserToken.fromJson(Map<String, dynamic> json)
      : token = json['token'],
        user = json['username'],
        role = json['role'];

  bool isEmpty() => token == "" && user == "" && role == "";

  Map<String, dynamic> toJson() => {
        'token': token,
        'user': user,
        'userType': role,
      };

  @override
  String toString() {
    return 'UserToken{token: $token, user: $user, userType: $role}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserToken &&
          runtimeType == other.runtimeType &&
          token == other.token &&
          user == other.user &&
          role == other.role;

  @override
  int get hashCode => token.hashCode ^ user.hashCode ^ role.hashCode;
}
