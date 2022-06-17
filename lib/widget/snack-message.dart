import 'dart:math';

import 'package:flutter/material.dart';
import 'package:zolder_app_frontend/theme/snackbar_type_colors.dart';

class SnackMessage extends StatelessWidget {
  const SnackMessage({Key? key, required this.message, required this.type})
      : super(key: key);

  final String message;
  final SnackType type;

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: EdgeInsets.zero,
      constraints: const BoxConstraints(
        maxHeight: 75,
      ),
      child: Row(
        children: [
          Container(
            width: 10,
            color: getColor(context, type),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Icon(
              getIcon(context, type),
              size: 50,
              color: getColor(context, type),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(message),
            ],
          )
        ],
      ),
    );
  }

  Color getColor(BuildContext context, SnackType type) {
    switch (type) {
      case SnackType.success:
        return Theme.of(context).colorScheme.success;

      case SnackType.info:
        return Theme.of(context).colorScheme.info;

      case SnackType.warning:
        return Theme.of(context).colorScheme.warning;

      case SnackType.danger:
        return Theme.of(context).colorScheme.danger;

      default:
        return Colors.purpleAccent;
    }
  }

  IconData getIcon(BuildContext context, SnackType type) {
    switch (type) {
      case SnackType.success:
        return Icons.check_circle_outline_outlined;

      case SnackType.info:
        return Icons.info_outlined;

      case SnackType.warning:
        return Icons.warning_outlined;

      case SnackType.danger:
        return Icons.dangerous_outlined;

      default:
        return Icons.question_mark_outlined;
    }
  }

  static void show(BuildContext context, SnackType type, String message) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();;
    final screenWidth = MediaQuery.of(context).size.width;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        behavior: SnackBarBehavior.floating,
        padding: EdgeInsets.zero,
        width: min(screenWidth * 0.9, 750),
        content: SnackMessage(
          message: message,
          type: type,
        )));
  }
}

enum SnackType { success, info, danger, warning }
