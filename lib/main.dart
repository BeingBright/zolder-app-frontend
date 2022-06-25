import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zolder_app/components/toast_manager.dart';
import 'package:zolder_app/models/location_model.dart';
import 'package:zolder_app/models/user_token_model.dart';
import 'package:zolder_app/views/admin_page.dart';
import 'package:zolder_app/views/login_page.dart';
import 'package:zolder_app/views/office_page.dart';
import 'package:zolder_app/views/worker_page.dart';

import 'models/user_model.dart';

//
void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => UserTokenModel()),
      ChangeNotifierProvider(create: (context) => UserModel()),
      ChangeNotifierProvider(create: (context) => LocationModel())
    ],
    child: const MyApp(),
  ));
  // connectToStomp();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ToastManager.init(context);
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

// void test() async{
//   print(await LocationCommand().getLocationsByBuilding("Celc"));
// }

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
