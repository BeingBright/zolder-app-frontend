import 'package:flutter/material.dart';

import '../components/sidebar.dart';

class OfficePage extends StatefulWidget {
  const OfficePage({Key? key}) : super(key: key);

  @override
  State<OfficePage> createState() => _OfficePageState();
}

class _OfficePageState extends State<OfficePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Office Page"),
      ),
      drawer: const Sidebar(),
    );
  }
}
