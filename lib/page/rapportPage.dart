import 'package:flutter/material.dart';

class RapportPage extends StatefulWidget {
  const RapportPage({Key? key}) : super(key: key);

  @override
  State<RapportPage> createState() => _RapportPageState();
}

class _RapportPageState extends State<RapportPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Zolder app - Rapport"),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
    );
  }
}
