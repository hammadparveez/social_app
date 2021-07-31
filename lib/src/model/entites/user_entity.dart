class UserEntity {
  String userName, email, password;

  UserEntity(
      {required this.userName, required this.email, required this.password});

  Map<String, String> toMap() {
    return {
      "username": this.userName,
      "email": this.email,
      "password": this.password,
    };
  }

  UserEntity toJson(Map json) {
    return UserEntity(
      userName: json["username"],
      email: json["email"],
      password: json["password"],
    );
  }
}
