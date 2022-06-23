class User {
  String? id;
  String? username;
  String? password;
  String? role;
  bool isActive = true;

  User(this.id, this.username, this.password, this.role, this.isActive);

  User.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        username = json['username'],
        password = json['password'],
        role = json['role'],
        isActive = json['active'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'username': username,
        'password': password,
        'role': role,
        'active': isActive
      };

  @override
  String toString() {
    return 'User{id: $id, username: $username, password: $password, type: $role}';
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
