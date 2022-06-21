class User {
  String? id;
  String? username;
  String? password;
  String? type;
  bool isActive = true;

  User(this.id, this.username, this.password, this.type, this.isActive);

  User.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        username = json['username'],
        password = json['password'],
        type = json['type'],
        isActive = json['active'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'username': username,
        'password': password,
        'type': type,
        'active': isActive
      };

  @override
  String toString() {
    return 'User{id: $id, username: $username, password: $password, type: $type}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is User &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          username == other.username &&
          type == other.type;

  @override
  int get hashCode => id.hashCode ^ username.hashCode ^ type.hashCode;
}
