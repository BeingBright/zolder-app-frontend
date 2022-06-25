import 'package:flutter/material.dart';

class ToastManager {
  static init(BuildContext context) {}

  static show(BuildContext context, String message) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        dismissDirection: DismissDirection.vertical,
        behavior: SnackBarBehavior.floating,
        padding: const EdgeInsets.all(16),
      ),
    );
  }
}
