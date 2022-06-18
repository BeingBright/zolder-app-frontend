import 'package:flutter/material.dart';

class UserTitle extends StatelessWidget {
  const UserTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Expanded(child: Text("Username")),
        const Expanded(child: Text("User Role")),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Icon(Icons.mode, color: Colors.transparent),
            Icon(Icons.delete_outline_outlined, color: Colors.transparent),
          ],
        )
      ],
    );
  }
}
