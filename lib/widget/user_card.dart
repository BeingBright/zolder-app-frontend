import 'package:flutter/material.dart';
import 'package:zolder_app_frontend/service/userService.dart';

import '../model/User.dart';

class UserCard extends StatelessWidget {
  const UserCard({Key? key, required this.user, required this.onDelete})
      : super(key: key);

  final User user;
  final Function onDelete;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(user.username!),
          // Text("PASSWORD"),
          Text(user.type!),
          Row(
            children: [
              TextButton(onPressed: () {}, child: const Icon(Icons.update)),
              TextButton(
                  onPressed: () {
                    UserService().removeUsers(user).then((value) => onDelete(value));
                  },
                  child: const Icon(Icons.delete))
            ],
          )
        ],
      ),
    );
  }
}
