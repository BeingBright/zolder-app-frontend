import 'package:flutter/material.dart';

import '../component/sidebar.dart';
import '../model/UserToken.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({Key? key, required this.token}) : super(key: key);

  final UserToken token;

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
      ),
      drawer: Sidebar(title: "Zolder app",username: widget.token.user),
    );
  }
}
