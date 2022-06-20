class UserToken {
  String token;
  String user;
  String userType;

  UserToken(this.token, this.user, this.userType);

  static UserToken empty() => UserToken("", "", "");

  UserToken.fromJson(Map<String, dynamic> json)
      : token = json['token'],
        user = json['user'],
        userType = json['userType'];

  bool isEmpty() => token == "" && user == "" && userType == "";

  Map<String, dynamic> toJson() => {
        'token': token,
        'user': user,
        'userType': userType,
      };

  @override
  String toString() {
    return 'UserToken{token: $token, user: $user, userType: $userType}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserToken &&
          runtimeType == other.runtimeType &&
          token == other.token &&
          user == other.user &&
          userType == other.userType;

  @override
  int get hashCode => token.hashCode ^ user.hashCode ^ userType.hashCode;
}
