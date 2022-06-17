import 'package:flutter/material.dart';
import 'package:zolder_app_frontend/model/User.dart';
import 'package:zolder_app_frontend/service/authService.dart';
import 'package:zolder_app_frontend/service/userService.dart';

class UserModal extends StatefulWidget {
  const UserModal({Key? key}) : super(key: key);

  @override
  State<UserModal> createState() => _UserModalState();
}

class _UserModalState extends State<UserModal> {
  String dropdownValue = "worker";

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Add User"),
      contentPadding: EdgeInsets.all(25),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            obscureText: false,
            controller: usernameController,
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: "Username",
            ),
            onEditingComplete: () {},
          ),
          TextField(
            obscureText: true,
            controller: passwordController,
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: "Password",
            ),
            onEditingComplete: () {},
          ),
          DropdownButton(
              value: dropdownValue,
              items: <String>['office', 'worker', 'admin']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? val) {
                setState(() {
                  dropdownValue = val!;
                });
              }),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
                padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
              ),
              onPressed: () {
                User user = User(
                    null,
                    usernameController.text,
                    AuthService().encrypt(passwordController.text),
                    dropdownValue);
                UserService().addUsers(user);
                Navigator.of(context, rootNavigator: true).pop();
              },
              child: const Text("Add User"))
        ],
      ),
    );
  }
}
