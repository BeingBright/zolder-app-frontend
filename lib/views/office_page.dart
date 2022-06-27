import 'package:flutter/material.dart';

import '../components/sidebar.dart';
import 'location_view.dart';

class OfficePage extends StatefulWidget {
  const OfficePage({Key? key}) : super(key: key);

  @override
  State<OfficePage> createState() => _OfficePageState();
}

class _OfficePageState extends State<OfficePage> {
  @override
  Widget build(BuildContext context) {
    return const LocationView(
      sidebar: Sidebar(
        children: [],
      ),
    );
  }
}
