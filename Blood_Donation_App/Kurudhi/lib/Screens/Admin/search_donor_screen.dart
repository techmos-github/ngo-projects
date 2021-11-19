import 'package:flutter/material.dart';
import 'package:kurudhi/Screens/Admin/components/search_donors.dart';
import 'package:kurudhi/constants.dart';

class Search_Donor_Screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Search Donors"),
          centerTitle: true,
          elevation: 0.0,
          backgroundColor: kPrimaryColor,
        ),
      body: //Center(
       SingleChildScrollView(
          //child: Padding(
          padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
          child: Search_Donors(),
          //),
        ),
      //),
    );
  }
}