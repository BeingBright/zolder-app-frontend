import 'package:flutter/material.dart';
import 'package:zolder_app/models/user.dart';

class UserModal extends StatefulWidget {
  const UserModal({Key? key}) : super(key: key);

  @override
  State<UserModal> createState() => _UserModalState();
}

class _UserModalState extends State<UserModal> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String _role = "WORKER";
  final List<String> _roles = <String>['WORKER', 'OFFICE', 'ADMIN'];

  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Add user"),
      content: Form(
        key: _formkey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              keyboardType: TextInputType.name,
              controller: _usernameController,
              autocorrect: false,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: "Username",
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Required';
                }
                return null;
              },
              autovalidateMode: AutovalidateMode.onUserInteraction,
            ),
            TextFormField(
              obscureText: true,
              keyboardType: TextInputType.visiblePassword,
              controller: _passwordController,
              autocorrect: false,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: "Password",
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Required';
                }
                return null;
              },
              autovalidateMode: AutovalidateMode.onUserInteraction,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 16, 0),
                  child: Text("Role:"),
                ),
                Expanded(
                  child: DropdownButton(
                      isExpanded: true,
                      value: _role,
                      items:
                          _roles.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Center(child: Text(value)),
                        );
                      }).toList(),
                      onChanged: (String? value) {
                        setState(() {
                          _role = value!;
                        });
                      }),
                ),
              ],
            )
          ],
        ),
      ),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.of(context, rootNavigator: true).pop();
            },
            child: const Text("Cancel")),
        TextButton(
          onPressed: () {
            if (_formkey.currentState!.validate()) {
              Navigator.of(context, rootNavigator: true).pop(
                User(
                  null,
                  _usernameController.text,
                  _passwordController.text,
                  _role,
                  true,
                ),
              );
            }
          },
          child: const Text("Add User"),
        ),
      ],
    );
  }
}
