import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zolder_app/components/user_card.dart';
import 'package:zolder_app/components/user_modal.dart';

import '../components/sidebar.dart';
import '../controller/user_command.dart';
import '../models/user.dart';
import '../models/user_model.dart';

class UserView extends StatefulWidget {
  const UserView({Key? key, required this.sidebar}) : super(key: key);

  final Widget sidebar;

  @override
  State<UserView> createState() => _UserViewState();
}

class _UserViewState extends State<UserView> {
  @override
  void initState() {
    super.initState();
    UserCommand().getUsers(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Users"),
      ),
      drawer: widget.sidebar,
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            UserCommand().getUsers(context);
            var addUserModal = showDialog(
                context: context,
                builder: (context) => const UserModal(title: "Add User"));
            addUserModal.then((user) {
              if (user != null) {
                UserCommand().addUser(context, user);
              }
            });
          },
          child: const Icon(Icons.add)),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Consumer<UserModel>(
          builder: (context, userModel, child) {
            return GridView.builder(
              itemCount: userModel.users.length,
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 350,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  mainAxisExtent: 150),
              itemBuilder: (BuildContext ctx, index) {
                return UserCard(
                  user: userModel.users[index],
                  onDelete: onDelete,
                  onUpdate: onUpdate,
                );
              },
            );
          },
        ),
      ),
    );
  }

  void onDelete(User user) {
    UserCommand().removeUsers(context, user);
  }

  void onUpdate(User user) {
    var updateUserModal = showDialog(
      context: context,
      builder: (context) => UserModal(
        currentUser: user,
        title: "Update User",
      ),
    );
    updateUserModal.then((user) {
      if (user != null) {
        UserCommand().updateUser(context, user);
      }
    });
  }
}
