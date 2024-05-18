class Users {
  final String id;
  final String name;
  final String username;
  final String email;

  Users({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
  });
  factory Users.fromJson(Map<String, dynamic> json) {
    return Users(
      id: json['id'],
      name: json['name'],
      username: json['username'],
      email: json['email'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'username': username,
      'email': email,
    };
  }
}
