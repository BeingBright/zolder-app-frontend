import 'package:flutter/material.dart';
import 'package:zolder_app_frontend/service/userService.dart';
import 'package:zolder_app_frontend/widget/user-modal.dart';
import 'package:zolder_app_frontend/widget/user_card.dart';

import '../model/User.dart';
import '../model/UserToken.dart';
import '../widget/sidebar.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({Key? key, required this.token}) : super(key: key);

  final UserToken token;

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  List<User> _userModel = <User>[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getUsers();
  }

  void _getUsers() {
    Future.delayed(const Duration(seconds: 2), () {
      UserService().getUsers().then((value) => {
            setState(() {
              _userModel = value!;
            })
          });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
      ),
      drawer: Sidebar(title: "Zolder app", username: widget.token.user),
      body: (_userModel.isEmpty)
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _userModel.length,
              itemBuilder: (context, index) {
                return UserCard(user: _userModel[index]);
              },
            ),
      floatingActionButton: (_userModel.isEmpty)
          ? null
          : FloatingActionButton(
              onPressed: () {
                var dialog = showDialog(
                    context: context, builder: (context) => UserModal());
                dialog.then((value) => {_getUsers()});
              },
              child: const Icon(Icons.add),
            ),
    );
  }
}
