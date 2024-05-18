// ignore_for_file: file_names

class UserModel {
  String? id;
  final String? email;
  final String? password;
  final String? birhtday;
  UserModel({
    this.id,
    required this.email,
    required this.password,
    required this.birhtday,
  });

  toJson() {
    return {
      'id': id,
      'email': email,
      'password': password,
      'birhtday': birhtday,
    };
  }
}
