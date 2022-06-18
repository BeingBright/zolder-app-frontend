import 'package:flutter/material.dart';
import 'package:zolder_app_frontend/widget/snack-message.dart';
import 'package:zolder_app_frontend/widget/user-card.dart';
import 'package:zolder_app_frontend/widget/user-title.dart';

import '../model/User.dart';
import '../service/user_service.dart';
import '../widget/user-modal.dart';

class UserOverviewPage extends StatefulWidget {
  const UserOverviewPage({Key? key}) : super(key: key);

  @override
  State<UserOverviewPage> createState() => _UserOverviewPageState();
}

class _UserOverviewPageState extends State<UserOverviewPage> {
  List<User> _userModel = <User>[];

  @override
  void initState() {
    super.initState();
    _getUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 1000),
        child: ListView(
          children: [
            const UserTitle(),
            ListView.builder(
              shrinkWrap: true,
              itemCount: _userModel.length,
              itemBuilder: (context, index) => UserCard(
                  user: _userModel[index],
                  onDelete: (user) {
                    _removeUser(context, user);
                  },
                  onModify: (user) {
                    SnackMessage.show(context, SnackType.info, "TO DO");
                  }),
            ),
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      _getUsers();
                    },
                    icon: Icon(Icons.refresh)),
                Spacer(),
                ElevatedButton( 
                    onPressed: () {
                      var dialog = showDialog(
                          context: context, builder: (context) => UserModal());
                      dialog.then((value) {
                        Future.delayed(
                          Duration(seconds: 1),
                          () => _getUsers(),
                        );
                      });
                    },
                    child: Icon(Icons.add))
              ],
            )
          ],
        ),
      ),
    );
  }

  _getUsers() {
    UserService().getUsers().then((value) => {
          setState(() {
            _userModel = value!;
          })
        });
  }

  _removeUser(BuildContext context, User user) {
    UserService().removeUsers(user).then((value) {
      _getUsers();
      SnackMessage.show(context, SnackType.success, value.toString());
    });
  }
}
