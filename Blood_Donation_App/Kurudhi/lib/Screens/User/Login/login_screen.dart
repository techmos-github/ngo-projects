import 'package:flutter/material.dart';
import '/Screens/User/Login/components/body.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoginFormBody(),
    );
  }
}
