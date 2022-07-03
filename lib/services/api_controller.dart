import 'dart:convert';

import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';
import 'package:zolder_app/configuration/api_configuration.dart';
import 'package:zolder_app/model/user/auth_token.dart';

class APIController {
  static final APIController _instance = APIController._internal();

  factory APIController() => _instance;

  final Map<int, List<Function(String body)>> _onStatusCallbacks = {};

  final GetIt getIt = GetIt.instance;

  late final StompClient stompClient;

  Function(StompFrame f)? onConnect;
  Function()? onLoc;
  Function()? onUser;
  Function()? onBook;

  APIController._internal() {
    stompClient = StompClient(
      config: StompConfig(
        url: APIConfiguration.stompSocketUrl,
        onConnect: _onConnect,
        onDebugMessage: (s) {},
        onWebSocketError: (dynamic error) => print(error.toString()),
        stompConnectHeaders: <String, String>{
          'authorization': getIt<AuthTokenModel>().authToken.token
        },
        webSocketConnectHeaders: {
          'authorization': getIt<AuthTokenModel>().authToken.token
        },
      ),
    );
    stompClient.activate();
  }

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
      if (response.body.isNotEmpty) {
        return jsonDecode(response.body);
      } else {
        return;
      }
    } else {
      if (!_onStatus(response.statusCode, response)) {
        throw Exception(
            "Call To ${response.request?.url.path} Ended With StatusCode ${response.statusCode}");
      }
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

  void _onConnect(StompFrame frame) {
    onConnect?.call(frame);
    stompClient.subscribe(
        destination: '/topic/user',
        callback: (f) {
          onUser?.call();
        });
    stompClient.subscribe(
        destination: '/topic/book',
        callback: (f) {
          onBook?.call();
        });
    stompClient.subscribe(
        destination: '/topic/location',
        callback: (f) {
          onLoc?.call();
        });
  }

  void subscribe(String path, Function(StompFrame) callback) {
    stompClient.subscribe(destination: path, callback: callback);
  }

  bool isActiveClient() {
    return stompClient.isActive;
  }

  void dispose() {
    stompClient.deactivate();
  }
}

// void onConnect(StompFrame frame) {
//   stompClient.subscribe(
//     destination: "/topic/book",
//     callback: (StompFrame frame) {
//       print("Books Altered");
//     },
//   );
//
//   stompClient.subscribe(
//     destination: "/topic/location",
//     callback: (StompFrame frame) {
//       print("Location Altered");
//     },
//   );
//
//   stompClient.subscribe(
//     destination: "/topic/user",
//     callback: (StompFrame frame) {
//       print("User Altered");
//     },
//   );
//   //
//   // Timer.periodic(Duration(seconds: 1), (timer) {
//   //   stompClient.send(destination: "/app/hello");
//   //   print("Time");
//   // });
// }
//
// final stompClient = StompClient(
//   config: StompConfig(
//       url: "ws://localhost:7000/zolder/stomp",
//       onConnect: onConnect,
//       onDebugMessage: print,
//       onWebSocketError: (dynamic error) => print(error.toString()),
//       stompConnectHeaders: <String,String>{
//         'authorization': "a6a50bda-afbc-486f-8b0b-a8d1180e910e"
//       },
//       webSocketConnectHeaders: {
//         'authorization': "a6a50bda-afbc-486f-8b0b-a8d1180e910e"
//       }),
// );
//
// void connectToStomp() {
//   stompClient.activate();
// }
