import 'package:flutter/material.dart';
import 'package:kurudhi/constants.dart';
import 'components/pending_approval_list.dart';

class Pending_Approval_Screen extends StatefulWidget {
  @override
  _ApprovalPendingState createState() => new _ApprovalPendingState();
}

class _ApprovalPendingState extends State<Pending_Approval_Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pending Approval"),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: kPrimaryColor,
      ),
      body: Center(
        child: SingleChildScrollView(
          //child: Padding(
          padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
          child: ApprovalPending(),
          //),
        ),
      ),
    );
  }
}


/*class Pending_Approval_Screen extends StatelessWidget {
  const Pending_Approval_Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pending Approval"),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: kPrimaryColor,
      ),
      body: Center(
        child: SingleChildScrollView(
          //child: Padding(
          padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
          child: ApprovalPending(),
          //),
        ),
      ),
    );
  }
}*/