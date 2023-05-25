import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:helpdesk/screens/homePage.dart';
import 'package:provider/provider.dart';

import '../models/admin.dart';
import '../models/user.dart';
import '../providers/helpDeskProvider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final TextEditingController _usernameController;
  late final TextEditingController _passwordController;

  @override
  void initState() {
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  User findUser(UnmodifiableListView<User> users, String user, String pass) {
    User match = users.firstWhere((item) => item.username == user, orElse: () {
      return User(username: "", password: "");
    });

    return match;
  }

  Admin findAdmin(UnmodifiableListView<Admin> users, String user, String pass) {
    Admin match = users.firstWhere((item) => item.username == user, orElse: () {
      return Admin(username: "", password: "");
    });

    return match;
  }

  void login(UnmodifiableListView<User> users) {
    final user = _usernameController.text;
    final pass = _passwordController.text;

    if (user != "" && pass != "") {
      User match = findUser(users, user, pass);

      if (match.username != "") {
        if (match.username == user && match.password == pass) {
          context
              .read<HelpDeskProvider>()
              .login(match.username, match.userType);
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => HomePage()));
        } else {
          alert("Username and password do not match");
        }
      } else {
        alert("User not found");
      }
    } else {
      alert("All fields must be filled!");
    }
  }

  void adminLogin(UnmodifiableListView<Admin> admins) {
    final user = _usernameController.text;
    final pass = _passwordController.text;

    if (user != "" && pass != "") {
      Admin match = findAdmin(admins, user, pass);

      if (match.username != "") {
        if (match.username == user && match.password == pass) {
          context
              .read<HelpDeskProvider>()
              .login(match.username, match.userType);

          Navigator.push(
              context, MaterialPageRoute(builder: (context) => HomePage()));
        } else {
          alert("Username and password do not match");
        }
      } else {
        alert("Admin not found");
      }
    } else {
      alert("All fields must be filled!");
    }
  }

  void register(UnmodifiableListView<User> users) {
    final user = _usernameController.text;
    final pass = _passwordController.text;

    User match = findUser(users, user, pass);

    if (user != "" && pass != "") {
      if (match.username == "") {
        final newUser = User(username: user, password: pass);
        context.read<HelpDeskProvider>().register(newUser);

        alert("You have been successfully registered!");
      } else {
        alert("Username is taken");
      }
    } else {
      alert("All fields must be filled!");
    }
  }

  void alert(String message) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text(message, textAlign: TextAlign.center),
              actions: <Widget>[
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        Navigator.of(context).pop();
                      });
                    },
                    child: Center(child: Text("Back"))),
              ]);
        });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<HelpDeskProvider>(context);
    final UnmodifiableListView<User> users = provider.users;
    final UnmodifiableListView<Admin> admins = provider.admins;

    return Scaffold(
      appBar: AppBar(
        // The title text which will be shown on the action bar
        title: Text("Helpdesk"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 200,
              child: TextField(
                maxLines: 1,
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: "Username:",
                ),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Container(
              width: 200,
              child: TextField(
                maxLines: 1,
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "Password:",
                ),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Container(
              width: 200,
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        login(users);
                      },
                      child: Text("Login"),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        register(users);
                      },
                      child: Text("Register"),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              width: 200,
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        adminLogin(admins);
                      },
                      child: Text("Admin Login"),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
