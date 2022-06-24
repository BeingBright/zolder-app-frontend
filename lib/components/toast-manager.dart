import 'package:flutter/material.dart';

class ToastManager {
  static init(BuildContext context) {
    // ToastContext().init(context);
  }

  static show(BuildContext context, String message) {
    // Toast.show(message, gravity: Toast.top, duration: Toast.lengthShort);
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        dismissDirection: DismissDirection.vertical,
        behavior: SnackBarBehavior.floating,
        padding: EdgeInsets.all(16),
      ),
    );
  }
}
