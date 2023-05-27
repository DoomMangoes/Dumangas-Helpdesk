class User {
  String username;
  String password;
  bool isAdmin;

  User({required this.username, required this.password, required this.isAdmin});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      username: json['username'],
      password: json['password'],
      isAdmin: json['is_superuser'],
    );
  }

  Map<String, dynamic> toJson() => {
        'username': username,
        'password': password,
      };
}
