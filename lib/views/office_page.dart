import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:zolder_app/models/user_token_model.dart';

import '../components/sidebar.dart';
import 'location_view.dart';

class OfficePage extends StatefulWidget {
  const OfficePage({Key? key}) : super(key: key);

  @override
  State<OfficePage> createState() => _OfficePageState();
}

class _OfficePageState extends State<OfficePage> {
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      if (Provider.of<UserTokenModel>(context, listen: false).userToken.role !=
          "OFFICE") {
        Navigator.pushReplacementNamed(context, '/');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const LocationView(
      sidebar: Sidebar(
        children: [],
      ),
    );
  }
}
