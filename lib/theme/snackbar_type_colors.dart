import 'package:flutter/material.dart';

extension SnackbarTypeColors on ColorScheme {
//  Success
  Color get success => Colors.green;

  Color get onSuccess =>
      brightness == Brightness.light ? Colors.white : Colors.black;

//  Info
  Color get info => Colors.blueAccent;

  Color get onInfo =>
      brightness == Brightness.light ? Colors.white : Colors.black;

//  Warning
  Color get warning => Colors.orangeAccent;

  Color get onWarning =>
      brightness == Brightness.light ? Colors.white : Colors.black;

//  Danger
  Color get danger => Colors.red;

  Color get onDanger =>
      brightness == Brightness.light ? Colors.white : Colors.black;
}
