import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get_it/get_it.dart';
import 'package:zolder_app/views/location_view.dart';

import '../model/user/auth_token.dart';
import '../model/user/user.dart';

class WorkerPage extends StatefulWidget {
  const WorkerPage({Key? key}) : super(key: key);

  @override
  State<WorkerPage> createState() => _WorkerPageState();
}

class _WorkerPageState extends State<WorkerPage> {
  final GetIt getIt = GetIt.instance;

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      if (getIt<AuthTokenModel>().authToken.role != UserRole.worker) {
        Navigator.pushReplacementNamed(context, '/');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return LocationView();
  }
}
