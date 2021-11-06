import 'package:flutter/material.dart';
import 'package:kara/src/resources/login_page.dart';
import 'package:kara/src/resources/single_user_screen.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new MaterialApp(
      // home: SingleUserScreen(),
      home: LoginPage(),
    );
  }
}
