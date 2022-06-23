import 'package:flutter/material.dart';

import '../commands/user_command.dart';
import '../models/user.dart';

class UserCard extends StatelessWidget {
  const UserCard({Key? key, required this.user}) : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Card(
      color: (user.isActive) ? Colors.green[900] : Colors.red[900],
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            user.username!,
            style: theme.textTheme.headline4,
          ),
          Text(
            user.role!,
            style: theme.textTheme.bodyMedium,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.edit),
                  // color: theme.errorColor,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                    onPressed: () {
                      UserCommand().removeUsers(context, user);
                    },
                    icon: (!user.isActive)
                        ? const Icon(Icons.person_add)
                        : const Icon(Icons.person_remove),
                    color: (!user.isActive) ? Colors.green : Colors.red),
              ),
            ],
          )
        ],
      ),
    );
  }
}
