import 'package:flutter/material.dart';

import '../../models/user.dart';

class UserCard extends StatelessWidget {
  const UserCard(
      {Key? key,
      required this.user,
      required this.onDelete,
      required this.onUpdate})
      : super(key: key);

  final Function(User user) onDelete;
  final Function(User user) onUpdate;

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
            style: theme.textTheme.headline4?.copyWith(color: Colors.white),
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            user.role!,
            style: theme.textTheme.bodyMedium?.copyWith(color: Colors.white),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                  onPressed: () {
                    onUpdate(user);
                  },
                  icon: const Icon(
                    Icons.edit,
                    color: Colors.white,
                  ),
                  // color: theme.errorColor,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                    onPressed: () {
                      onDelete(user);
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
