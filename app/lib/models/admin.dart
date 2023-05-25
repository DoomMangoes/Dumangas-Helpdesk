import 'user.dart';

class Admin extends User {
  @override
  Admin({
    required super.username,
    required super.password,
  }) {
    super.userType = "Admin";
  }
}
