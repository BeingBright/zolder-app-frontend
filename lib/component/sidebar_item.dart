import 'package:flutter/material.dart';

class SidebarItem extends StatelessWidget {
  const SidebarItem(
      {Key? key,
        required this.title,
        required this.icons,
        required this.callback})
      : super(key: key);

  final String title;
  final IconData icons;
  final Function callback;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Row(
        children: [
          Icon(icons),
          const Spacer(),
          Text(title),
          const Spacer(),
          Icon(
            icons,
            color: Colors.transparent,
          ),
        ],
      ),
      onTap: () {
        callback.call();
      },
    );
  }
}