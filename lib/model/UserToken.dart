class UserToken {
  final String token;
  final String user;
  final String userType;

  UserToken(this.token, this.user, this.userType);

  UserToken.fromJson(Map<String, dynamic> json)
      : token = json['token'],
        user = json['user'],
        userType = json['userType'];

  Map<String, dynamic> toJson() => {
        'token': token,
        'user': user,
        'userType': userType,
      };
}
