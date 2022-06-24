import 'dart:convert';

import 'package:http/http.dart';
import 'package:http/http.dart' as http;

class APIController {
  static final APIController _instance = APIController._internal();

  factory APIController() => _instance;

  APIController._internal();

  final Map<int, List<Function(String body)>> _onStatusCallbacks = {};

  addOnStatusCallback(int statusCode, Function(String body) callback) {
    if (_onStatusCallbacks[statusCode] == null) {
      _onStatusCallbacks[statusCode] = [];
    }
    _onStatusCallbacks[statusCode]?.add(callback);
  }

  Future<dynamic> get(String url,
      {Map<String, String>? headers, Object? body, Encoding? encoding}) async {
    var uri = Uri.parse(url);
    return getResult(await http.get(uri, headers: headers));
  }

  Future<dynamic> post(String url,
      {Map<String, String>? headers, Object? body, Encoding? encoding}) async {
    var uri = Uri.parse(url);
    return getResult(await http.post(uri,
        body: jsonEncode(body), encoding: encoding, headers: headers));
  }

  Future<dynamic> put(String url,
      {Map<String, String>? headers, Object? body, Encoding? encoding}) async {
    var uri = Uri.parse(url);
    return getResult(await http.put(uri,
        body: jsonEncode(body), encoding: encoding, headers: headers));
  }

  Future<dynamic> delete(String url,
      {Map<String, String>? headers, Object? body, Encoding? encoding}) async {
    var uri = Uri.parse(url);
    return getResult(await http.delete(uri,
        body: jsonEncode(body), encoding: encoding, headers: headers));
  }

  dynamic getResult(Response response) {
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      _onStatus(response.statusCode, response);
      throw Exception(
          "Call To ${response.request?.url.path} Ended With StatusCode ${response.statusCode}");
    }
  }

  bool _onStatus(int statusCode, Response response) {
    if (_onStatusCallbacks.containsKey(statusCode)) {
      _onStatusCallbacks[statusCode]?.forEach((element) {
        element.call(response.body);
      });
      return true;
    }
    return false;
  }
}
