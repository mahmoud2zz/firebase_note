import 'package:flutter/material.dart';

import '../../firebase/fb_auth_controller.dart';
class LaunchScreen extends StatefulWidget {
  const LaunchScreen({super.key});

  @override
  State<LaunchScreen> createState() => _LaunchScreenState();
}

class _LaunchScreenState extends State<LaunchScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      bool loggedIn=FbAuthController().loggedIn;
      String route=loggedIn?'/home_screen':'/login_screen';
      Navigator.pushReplacementNamed(context, route);

      // bool loggedIn =
      //     ShardPrefController().getValueFor<bool>(PrefKey.loggedIn.name) ??
      //         false;
      // String route = loggedIn ? '/users_screen' : '/login_screen';
      // Navigator.pushReplacementNamed(context, route);
      // Navigator.pushReplacementNamed(context, '/images_screen');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Note App',
        ),
      ),
    );
  }
}
