import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:kurudhi/constants.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:kurudhi/theme.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';

List _items = [];
class RegisterForm extends StatefulWidget {
  const RegisterForm({Key? key}) : super(key: key);

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _agreedToTOS = true;
  String? selectedBloodGroup;
  String? selectedGender;
  List _items = [];
  String? _mySelection;
  List<Map> _myJson = [{"id":0,"name":"<New>"},{"id":1,"name":"Test Practice"}];

  Future<void> readJson() async {

    final String response = await rootBundle.loadString('assets/bloodrequest.json');
    final data = await json.decode(response);
    setState(() {
      _items = data["items"];
    });
    print(_items[0]["id"]);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[

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
              //imageFit = BoxFit.cover,
              onTap: () {
                print('adil');
              }, // sets on tap
              showInitialTextAbovePicture: true, // setting it true will show initials text above profile picture, default false
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
            value: selectedGender,
            decoration: InputDecoration(
              labelText: 'Gender', border: OutlineInputBorder(),),
            onChanged: (selectedBloodGroup) =>
                setState(() => selectedBloodGroup = selectedGender),
            validator: (value) => value == null ? 'Gender is required' : null,
            items:
            ['Male', 'Female', 'Others'].map<DropdownMenuItem<String>>((
                String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),

          const SizedBox(height: 16.0),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Age',
              border: OutlineInputBorder(),
            ),
            validator: (String? value) {
              if (value
                  .toString()
                  .trim()
                  .isEmpty) {
                return 'Age is required';
              }
            },
          ),

          const SizedBox(height: 16.0),
          DropdownButtonFormField<String>(
            value: selectedBloodGroup,
            decoration: InputDecoration(
              labelText: 'Blood Group', border: OutlineInputBorder(),),
            onChanged: (selectedBloodGroup) =>
                setState(() => selectedBloodGroup = selectedBloodGroup),
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

          DropdownButton<String>(
            isDense: true,
            hint: new Text("Select"),
            value: _mySelection,
            onChanged: (String? newValue) {
              setState(() {
                _mySelection = newValue!;
              });

              print(_mySelection);
            },
            items: _myJson.map((Map map) {
              return new DropdownMenuItem<String>(
                value: map["id"].toString(),
                child: new Text(
                  map["name"],
                ),
              );
            }).toList(),
          ),

          Padding(
            padding: const EdgeInsets.all(25),
            child: Column(
              children: [
                ElevatedButton(
                  child: const Text('Load Data'),
                  //onPressed: readJson,
                  onPressed: () {
                    print("Loaded");
                    readJson;
                    print(_items[0]["id"]);
                  },
                ),

                // Display the data loaded from sample.json
                _items.isNotEmpty
                    ? Expanded(
                  child: ListView.builder(
                    itemCount: _items.length,
                    itemBuilder: (context, index) {
                      return Card(
                        margin: const EdgeInsets.all(10),
                        child: ListTile(
                          leading: Text(_items[index]["id"]),
                          title: Text(_items[index]["name"]),
                          subtitle: Text(_items[index]["description"]),
                        ),
                      );
                    },
                  ),
                )
                    : Container()
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Row(
              children: <Widget>[
                Checkbox(
                  value: _agreedToTOS,
                  onChanged: _setAgreedToTOS,
                  checkColor: kPrimaryLightColor,
                  activeColor: kPrimaryColor,
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Align(
                  alignment: Alignment.center,
                  child: ElevatedButton(
                    onPressed: _submittable() ? _submit : null,
                    child: const Text('Register'),
                    style: ElevatedButton.styleFrom(
                      primary: kPrimaryColor,
                    ),
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