import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zolder_app/components/user_card.dart';
import 'package:zolder_app/components/user_modal.dart';

import '../components/sidebar.dart';
import '../controller/user_command.dart';
import '../models/user_model.dart';

class UserView extends StatefulWidget {
  const UserView({Key? key}) : super(key: key);

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
      drawer: const Sidebar(),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            UserCommand().getUsers(context);
            var addUserModal =
                showDialog(context: context, builder: (context) => const UserModal());
            addUserModal.then((value) {
              print(value);
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
                return UserCard(user: userModel.users[index]);
              },
            );
          },
        ),
      ),
    );
  }
}
