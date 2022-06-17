import 'package:flutter/material.dart';

import '../model/User.dart';

class UserCard extends StatelessWidget {
  const UserCard({Key? key, required this.user}) : super(key: key);

  final User user;

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
              TextButton(onPressed: () {}, child: const Icon(Icons.delete))
            ],
          )
        ],
      ),
    );
  }
}
