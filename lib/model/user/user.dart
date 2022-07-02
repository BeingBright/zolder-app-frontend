enum UserRole {
  admin,
  worker,
  office,
  none,
}

class User {
  String? id;
  String? username;
  String? password;
  UserRole role = UserRole.none;
  bool isActive = true;

  bool rememberMe = false;

  User(this.id, this.username, this.password, this.role, this.isActive);

  User.login(this.username, this.password, this.rememberMe);

  User.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        username = json['username'],
        password = json['password'],
        role = UserRole.values
            .firstWhere((e) => e.toString().toUpperCase() == json['role']),
        isActive = json['active'],
        rememberMe = json['rememberMe'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'username': username,
        'password': password,
        'role': role.name.toUpperCase(),
        'active': isActive,
        'rememberMe': rememberMe
      };

  static List<User> generateList(List json) {
    return List<User>.from(json.map((e) {
      return User.fromJson(e);
    }));
  }

  @override
  String toString() {
    return 'User{id: $id, username: $username, password: $password, role: $role, isActive: $isActive, rememberMe: $rememberMe}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is User &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          username == other.username &&
          role == other.role;

  @override
  int get hashCode => id.hashCode ^ username.hashCode ^ role.hashCode;
}
