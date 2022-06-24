import 'dart:convert';

import 'package:crypto/crypto.dart';

mixin encryption {
  String encrypt(String msg) {
    return sha512.convert(utf8.encode(msg)).toString();
  }
}
