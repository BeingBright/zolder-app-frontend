import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import 'package:zolder_app_frontend/model/ServerException.dart';

class ToastHandler {
  Map<int, TextStyle> styles = {
    404: const TextStyle(color: Color.fromRGBO(255, 0, 0, 100)),
    401: const TextStyle(color: Color.fromRGBO(255, 0, 0, 100)),
    403: const TextStyle(color: Color.fromRGBO(255, 0, 0, 100)),
    500: const TextStyle(color: Color.fromRGBO(255, 0, 0, 100)),
    200: const TextStyle(color: Color.fromRGBO(0, 255, 0, 100)),
  };

  void showException(ServerException exception) {}

  void notFound(String message) {}

  void internalServerError(String message) {}

  void forbidden(String message) {}

  void succes(String message){}

  void showToast(String message) {
    Toast.show(message, duration: 3, gravity: 2);
  }
}
