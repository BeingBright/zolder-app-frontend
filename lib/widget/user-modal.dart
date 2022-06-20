import 'package:flutter/material.dart';
import 'package:zolder_app_frontend/model/User.dart';
import 'package:zolder_app_frontend/widget/snack-message.dart';

import '../service/auth-service.dart';
import '../service/user_service.dart';

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
      title: const Text("Add User"),
      actions: [
        TextButton(
            onPressed: () {
              User user = User(null, usernameController.text,
                  AuthService.encrypt(passwordController.text), dropdownValue);
              UserService().addUsers(user).then((value) {
                SnackMessage.show(
                    context, SnackType.success, "User: '${user.username}'");
              }).onError((error, stackTrace) {
                SnackMessage.show(context, SnackType.danger, error.toString());
              });
              Navigator.of(context, rootNavigator: true).pop();
            },
            child: Text("Add User"))
      ],
      contentPadding: const EdgeInsets.all(30),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            autofocus: true,
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
            isExpanded: true,
            value: dropdownValue,
            items: <String>['office', 'worker', 'admin']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            hint: Text("User Role"),
            onChanged: (String? val) {
              setState(() {
                dropdownValue = val!;
              });
            },
          ),
        ],
      ),
    );
  }
}
