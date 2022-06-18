import 'package:flutter/material.dart';

import '../model/User.dart';

class UserCard extends StatelessWidget {
  const UserCard(
      {Key? key,
      required this.user,
      required this.onDelete,
      required this.onModify})
      : super(key: key);

  final User user;
  final Function(User) onDelete;
  final Function(User) onModify;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.fromLTRB(0, 4, 0, 4),
      child: Row(
        children: [
          Expanded(child: Text(user.username!)),
          Expanded(child: Text(user.type!)),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: () {
                  onModify(user);
                },
                icon: const Icon(Icons.mode),
              ),
              IconButton(
                onPressed: () {
                  onDelete(user);
                },
                icon: const Icon(Icons.delete_outline_outlined),
              )
            ],
          )
        ],
      ),
    );
  }
}
