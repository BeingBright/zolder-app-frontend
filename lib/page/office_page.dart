import 'package:flutter/material.dart';
import 'package:zolder_app_frontend/model/UserToken.dart';

import '../component/sidebar.dart';

class OfficePage extends StatefulWidget {
  const OfficePage({Key? key, required this.token}) : super(key: key);

  final UserToken token;

  @override
  State<OfficePage> createState() => _OfficePageState();
}

class _OfficePageState extends State<OfficePage> {
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
