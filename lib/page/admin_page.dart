import 'package:flutter/material.dart';
import 'package:zolder_app_frontend/service/userService.dart';

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

  void _getUsers() async {
    print(widget.token.token);
    _userModel = (await UserService().getUsers(widget.token.token))!;
    Future.delayed(const Duration(seconds: 2)).then((value) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
      ),
      drawer: Sidebar(title: "Zolder app", username: widget.token.user),
      body: (_userModel.isEmpty)
          ? Center(child: const CircularProgressIndicator())
          : ListView.builder(
              itemCount: _userModel.length,
              itemBuilder: (context, index) {
                return Card(
                  child: Text(_userModel[index].username!),
                );
              },
            ),
    );
  }
}
