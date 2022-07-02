import 'package:flutter/material.dart';

class OfficePage extends StatefulWidget {
  const OfficePage({Key? key}) : super(key: key);

  @override
  State<OfficePage> createState() => _OfficePageState();
}

class _OfficePageState extends State<OfficePage> {
  @override
  void initState() {
    super.initState();
    // SchedulerBinding.instance.addPostFrameCallback((_) {
    //   if (Provider.of<UserTokenModel>(context, listen: false).userToken.role !=
    //       "OFFICE") {
    //     Navigator.pushReplacementNamed(context, '/');
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Text("Office Page");
  }
}
