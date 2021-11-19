import 'package:flutter/material.dart';
import 'package:kurudhi/Screens/Admin/components/manage_users.dart';
import 'package:kurudhi/constants.dart';

class Manage_User_Screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Manage Users"),
          centerTitle: true,
          elevation: 0.0,
          backgroundColor: kPrimaryColor,
        ),
      body: Center(
        child: SingleChildScrollView(
          //child: Padding(
          padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
          child: Manage_User(),
          //),
        ),
      ),
    );
  }
}