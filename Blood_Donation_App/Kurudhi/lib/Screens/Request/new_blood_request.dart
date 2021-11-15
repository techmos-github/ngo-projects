import 'package:flutter/material.dart';
import 'package:kurudhi/model/location_model.dart';
import 'components/blood_request_form.dart';

class NewRequest extends StatelessWidget {
  const NewRequest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("New Blood Request"),
      ),
      body: Center(
        child: SingleChildScrollView(
          //child: Padding(
          padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
          child: RequestForm(),
          //),
        ),
      ),
    );
  }
}