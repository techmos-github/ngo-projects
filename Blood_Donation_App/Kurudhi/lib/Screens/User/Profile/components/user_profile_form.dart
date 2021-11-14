import 'package:flutter/material.dart';
import 'package:kurudhi/theme.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';

class UserProfileForm extends StatefulWidget {
  const UserProfileForm({Key? key}) : super(key: key);

  @override
  _UserProfileFormState createState() => _UserProfileFormState();
}

class _UserProfileFormState extends State<UserProfileForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _agreedToTOS = true;
  String? selectedBloodGroup;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          //Will be used in future
          /*
          CircularProfileAvatar(
            'https://avatars0.githubusercontent.com/u/8264639?s=460&v=4', //sets image path, it should be a URL string. default value is empty string, if path is empty it will display only initials
            radius: 100, // sets radius, default 50.0
            backgroundColor: Colors.transparent, // sets background color, default Colors.white
            borderWidth: 10,  // sets border, default 0.0
            initialsText: Text(
              "AD",
              style: TextStyle(fontSize: 40, color: Colors.white),
            ),  // sets initials text, set your own style, default Text('')
            borderColor: Colors.brown, // sets border color, default Colors.white
            elevation: 5.0, // sets elevation (shadow of the profile picture), default value is 0.0
            foregroundColor: Colors.brown.withOpacity(0.5), //sets foreground colour, it works if showInitialTextAbovePicture = true , default Colors.transparent
            cacheImage: true, // allow widget to cache image against provided url

            onTap: () {
              print('adil');
            }, // sets on tap
            showInitialTextAbovePicture: false, // setting it true will show initials text above profile picture, default false
          ),
          */

          const SizedBox(height: 16.0),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'First Name',
              border: OutlineInputBorder(),
            ),
            validator: (String? value) {
              if (value
                  .toString()
                  .trim()
                  .isEmpty) {
                return 'First Name is required';
              }
            },
          ),

          const SizedBox(height: 16.0),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Last Name',
              border: OutlineInputBorder(),
            ),
            validator: (String? value) {
              if (value
                  .toString()
                  .trim()
                  .isEmpty) {
                return 'Last Name is required';
              }
            },
          ),

          const SizedBox(height: 16.0),
          DropdownButtonFormField<String>(
            value: selectedBloodGroup,
            decoration: InputDecoration(
              labelText: 'Blood Group', border: OutlineInputBorder(),),
            onChanged: (salutation) =>
                setState(() => selectedBloodGroup = salutation),
            validator: (value) =>
            value == null
                ? 'Blood Group is required'
                : null,
            items:
            [
              'A',
              'B',
              'AB',
              '0',
              'A+',
              'A-',
              'B+',
              'B-',
              'AB+',
              'AB-',
              'O+',
              'O-'
            ].map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),

          const SizedBox(height: 16.0),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Mobile Number',
              border: OutlineInputBorder(),
            ),
            validator: (String? value) {
              if (value
                  .toString()
                  .trim()
                  .isEmpty) {
                return 'Phone number is required';
              }
            },
          ),

          const SizedBox(height: 16.0),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Email',
              border: OutlineInputBorder(),
            ),
            validator: (String? value) {
              if (value
                  .toString()
                  .trim()
                  .isEmpty) {
                return 'Please enter the valid email';
              }
            },
          ),

          const SizedBox(height: 16.0),
          TextFormField(
            decoration: const InputDecoration(
                labelText: 'Location',
                border: OutlineInputBorder(),
                hintText: "Enter District"
            ),
            validator: (String? value) {
              if (value
                  .toString()
                  .trim()
                  .isEmpty) {
                return 'Please enter the valid location';
              }
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Row(
              children: <Widget>[
                Checkbox(
                  value: _agreedToTOS,
                  onChanged: _setAgreedToTOS,
                ),
                GestureDetector(
                  onTap: () => _setAgreedToTOS(!_agreedToTOS),
                  child: const Text(
                    'I agree to the Terms of Services and Privacy Policy',
                  ),
                ),
              ],
            ),
          ),

          Row(
            children: <Widget>[
              //const S(),
              Align(
                  alignment: Alignment.center,
                  child: ElevatedButton(
                    onPressed: _submittable() ? _submit : null,
                    child: const Text('Save'),
                  )
              ),
            ],
          ),
        ],
      ),
    );
  }

  bool _submittable() {
    return  _agreedToTOS == null ? false : _agreedToTOS ;
  }

  void _submit() {
    _formKey.currentState?.validate();
    print('Form submitted');
  }

  void _setAgreedToTOS(bool? newValue) {
    setState(() {
      _agreedToTOS = newValue == null ? false : newValue;
    });
  }
}