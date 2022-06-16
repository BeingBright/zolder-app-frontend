class User {
  String? id;
  String? username;
  String? password;
  String? type;

  User(this.id, this.username, this.password, this.type);

  User.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        username = json['username'],
        password = json['password'],
        type = json['type'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'username': username,
        'password': password,
        'type': type,
      };

  @override
  String toString() {
    return 'User{id: $id, username: $username, password: $password, type: $type}';
  }
}
