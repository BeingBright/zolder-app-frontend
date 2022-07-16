import 'package:flutter/material.dart';
import 'package:zolder_app/model/user/user.dart';

class UserModal extends StatefulWidget {
  const UserModal({
    Key? key,
    this.currentUser,
    required this.title,
  }) : super(key: key);

  final String title;

  final User? currentUser;

  @override
  State<UserModal> createState() => _UserModalState();
}

class _UserModalState extends State<UserModal> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  UserRole _role = UserRole.none;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    if (widget.currentUser != null) {
      _usernameController.text = widget.currentUser!.username!;
      _role = widget.currentUser!.role;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: AlertDialog(
          title: Text(widget.title),
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  autofocus: true,
                  textInputAction: TextInputAction.next,
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
                  textInputAction: TextInputAction.next,
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
                      child: DropdownButtonFormField(
                        isExpanded: true,
                        value: _role,
                        items: UserRole.values
                            .map<DropdownMenuItem<UserRole>>((UserRole value) {
                          return DropdownMenuItem<UserRole>(
                            value: value,
                            child: Center(child: Text(value.name)),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _role = value as UserRole;
                          });
                        },
                        validator: (value) {
                          if ((value as UserRole) == UserRole.none) {
                            return "role can not be none";
                          }
                          return null;
                        },
                      ),
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
                if (_formKey.currentState!.validate()) {
                  Navigator.of(context, rootNavigator: true).pop(
                    User(
                      (widget.currentUser != null)
                          ? widget.currentUser!.id
                          : null,
                      _usernameController.text,
                      _passwordController.text,
                      _role,
                      (widget.currentUser != null)
                          ? widget.currentUser!.isActive
                          : true,
                    ),
                  );
                }
              },
              child: Text(widget.title),
            ),
          ],
        ),
      ),
    );
  }
}
