import 'package:flutter/material.dart';
import 'package:kurudhi/model/location_model.dart';
import '/components/blood_request_form.dart';

class NewRequest extends StatelessWidget {
  const NewRequest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("New Blood Request"),
      ),
      body : Center (
        child:  SingleChildScrollView(
          //child: Padding(
            padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
            child: RequestForm(),
          //),
        ),
      ),
      /*body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 16.0),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Attender Name',
                ),
                validator: (String? value) {
                  if (value.toString().trim().isEmpty) {
                    return 'Attender Name is required';
                  }
                },
              ),

              const SizedBox(height: 16.0),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Attender Contact Number',
                ),
                validator: (String? value) {
                  if (value.toString().trim().isEmpty) {
                    return 'Attender Contact is required';
                  }
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Patient Name',
                ),
                validator: (String? value) {
                  if (value.toString().trim().isEmpty) {
                    return 'Patient Name is required';
                  }
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Patient Name',
                ),
                validator: (String? value) {
                  if (value.toString().trim().isEmpty) {
                    return 'Patient Name is required';
                  }
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Patient Age',
                ),
                validator: (String? value) {
                  if (value.toString().trim().isEmpty) {
                    return 'Patient Age is required';
                  }
                },
              ),

              const SizedBox(height: 16.0),
              DropdownButtonFormField<String>(
                value: selectedBloodGroup,
                hint: Text(
                  'Blood Group',
                ),
                onChanged: (salutation) =>
                    setState(() => selectedBloodGroup = salutation),
                validator: (value) => value == null ? 'Blood Group is required' : null,
                items:
                ['A','B','AB','0','A+','A-','B+','B-','AB+', 'AB-','O+', 'O-'].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),

              const SizedBox(height: 16.0),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Hospital Name',
                ),
                validator: (String? value) {
                  if (value.toString().trim().isEmpty) {
                    return 'Hospital Name is required';
                  }
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Hospital Address',
                ),
                validator: (String? value) {
                  if (value.toString().trim().isEmpty) {
                    return 'Hospital Address is required';
                  }
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Last Name',
                ),
                validator: (String? value) {
                  if (value.toString().trim().isEmpty) {
                    return 'Last Name is required';
                  }
                },
              ),

              const SizedBox(height: 36.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Confirm Request'),
              ),
            ],
          ),
        ),

      ),
      */
    );
  }
}