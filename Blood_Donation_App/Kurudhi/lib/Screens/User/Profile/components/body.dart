import 'package:flutter/material.dart';
import 'user_profile_form.dart';
import '/theme.dart';
import '/Screens/User/Login/login_screen.dart';
import '/Screens/User/Register/components/background.dart';
import '/Screens/User/Register/components/or_divider.dart';
import '/Screens/User/Register/components/social_icon.dart';
import '/components/already_have_an_account_acheck.dart';
import '/components/rounded_button.dart';
import 'package:flutter_svg/svg.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Profile'),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
          child: UserProfileForm(),
        ),
      ),
    );
  }
}
