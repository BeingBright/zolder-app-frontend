import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';
import 'package:toast/toast.dart';
import 'package:zolder_app/models/user_model.dart';
import 'package:zolder_app/models/user_token_model.dart';
import 'package:zolder_app/views/admin_page.dart';
import 'package:zolder_app/views/login_page.dart';
import 'package:zolder_app/views/office_page.dart';
import 'package:zolder_app/views/worker_page.dart';

//
void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => UserTokenModel()),
      ChangeNotifierProvider(create: (context) => UserModel())
    ],
    child: const MyApp(),
  ));
  // connectToStomp();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    return MaterialApp(
      title: 'Zolder',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: Consumer<UserTokenModel>(
        builder: (context, userTokenModel, child) {
          return getPage(userTokenModel.userToken.role);
        },
      ),
    );
  }

  Widget getPage(String type) {
    switch (type) {
      case "ADMIN":
        return const AdminPage();

      case "WORKER":
        return const WorkerPage();

      case "OFFICE":
        return const OfficePage();

      default:
        return const LoginPage();
    }
  }
}

void onConnect(StompFrame frame) {
  stompClient.subscribe(
    destination: "/topic/greetings",
    callback: (StompFrame frame) {
      print(frame.body);
    },
  );

  Timer(Duration(seconds: 5), () {
    stompClient.send(destination: "/app/hello");
  });
}

final stompClient = StompClient(
  config: StompConfig.SockJS(
      url: "http://localhost:7000/zolder/ws",
      onConnect: onConnect,
      onDebugMessage: print,
      onWebSocketError: (dynamic error) => print(error.toString()),
      stompConnectHeaders: {
        'Authorization': "28793f54-e7ed-4793-ab6c-e9f4aa9091fc"
      },
      webSocketConnectHeaders: {
        'Authorization': "28793f54-e7ed-4793-ab6c-e9f4aa9091fc"
      }),
);

void connectToStomp() {
  stompClient.activate();
}
