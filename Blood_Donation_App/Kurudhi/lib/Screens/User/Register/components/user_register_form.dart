import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:kurudhi/constants.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:kurudhi/model/location_model.dart';
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart' show rootBundle;
import 'dart:async' show Future;
import 'package:intl/intl.dart';
import 'package:email_validator/email_validator.dart';

Future<List<Location>> ReadJsonData() async {
  final jsondata = await rootBundle.loadString('assets/location.json');
  final list = json.decode(jsondata) as List<dynamic>;
  return list.map((e) => Location.fromJson(e)).toList();
}

Future<List<Location>> fetchRaisedRequest(http.Client client) async {
  final response = await client
      .get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));
  // Use the compute function to run parsePhotos in a separate isolate.
  return compute(parseRaisedRequest, response.body);
}

Future<List<Location>> readRaisedRequestJson() async {
  final String response = await rootBundle.loadString('assets/location.json');
  return compute(parseRaisedRequest, response);
}

// A function that converts a response body into a List<Photo>.
List<Location> parseRaisedRequest(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Location>((json) => Location.fromJson(json))
      .toList();
}

class RegisterForm extends StatefulWidget {
  const RegisterForm({Key? key}) : super(key: key);

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _agreedToTOS = true;
  String? selectedBloodGroup;
  String selectedDistrict = "";
  List<String>? matchLocations = [];
  String? selectedGender;
  final format = DateFormat("yyyy-MM-dd HH:mm");

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: ReadJsonData(),
        builder: (context, data) {
          if (data.hasError) {
            return Center(child: Text("${data.error}"));
          } else if (data.hasData) {
            var _locations = data.data as List<Location>;
            return Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
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
                    validator: (value) =>
                    value == null
                        ? 'Gender is required'
                        : null,
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
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
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
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    decoration: const InputDecoration(
                      labelText: 'Mobile Number',
                      border: OutlineInputBorder(),
                    ),
                    validator: (String? value) {
                      if (value
                          .toString()
                          .trim()
                          .isEmpty) {
                        return 'Mobile number is required';
                      }
                    },
                  ),

                  const SizedBox(height: 16.0),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) => EmailValidator.validate(value) ? null : "Please enter a valid email",
                  ),

                  const SizedBox(height: 16.0),
                  TextFormField(
                    obscureText: true,
                    obscuringCharacter: '*',
                    decoration: const InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(),
                    ),
                    validator: (String? value) {
                      if (value
                          .toString()
                          .trim()
                          .isEmpty) {
                        return 'Password is required';
                      }
                    },
                  ),

                  const SizedBox(height: 16.0),
                  DropdownSearch<String>(
                    mode: Mode.DIALOG,
                    items: (_locations.map((value) =>
                        value.district.toString())).toList().cast<String>(),
                    dropdownSearchDecoration: InputDecoration(
                        labelText: "Select District",
                        contentPadding: EdgeInsets.fromLTRB(12, 12, 0, 0),
                        border: OutlineInputBorder(),
                        hintText: "Select a district"
                    ),
                    validator: (String? value) {
                      if (value
                          .toString()
                          .trim()
                          .isEmpty) {
                        return 'District is required';
                      }
                    },
                    selectedItem: selectedDistrict,
                    onChanged: (selectedValue) {
                      setState(() {
                        matchLocations = null;
                        selectedDistrict = selectedValue.toString();
                        matchLocations = _locations
                            .where((x) => x.district == selectedDistrict)
                            .map((value) => value.location)
                            .first
                            .toList()
                            .cast<String>();
                      });
                    },
                    showSearchBox: true,
                    searchFieldProps: TextFieldProps(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.fromLTRB(12, 12, 8, 0),
                        labelText: "Search a district",
                      ),
                    ),
                    popupTitle: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: Theme
                            .of(context)
                            .primaryColorDark,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16),
                          topRight: Radius.circular(16),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          'Select District',
                          style: TextStyle(
                            fontSize: 23,
                            fontWeight: FontWeight.normal,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    popupShape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24),
                        topRight: Radius.circular(24),
                      ),
                    ),
                  ),
                  Divider(),

                  const SizedBox(height: 16.0),
                  DropdownSearch<String>(
                    mode: Mode.DIALOG,
                    items: matchLocations?.cast<String>(),
                    dropdownSearchDecoration: InputDecoration(
                      labelText: "Select Location",
                      hintText: "Select Location",
                      contentPadding: EdgeInsets.fromLTRB(12, 12, 0, 0),
                      border: OutlineInputBorder(),
                    ),
                    validator: (String? value) {
                      if (value
                          .toString()
                          .trim()
                          .isEmpty) {
                        return 'Location is required';
                      }
                    },
                    onChanged: print,
                    selectedItem: "",
                    showSearchBox: true,
                    searchFieldProps: TextFieldProps(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.fromLTRB(12, 12, 8, 0),
                        labelText: "Search a location",
                      ),
                    ),
                    popupTitle: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: Theme
                            .of(context)
                            .primaryColorDark,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16),
                          topRight: Radius.circular(16),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          'Select Location',
                          style: TextStyle(
                            fontSize: 23,
                            fontWeight: FontWeight.normal,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    popupShape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24),
                        topRight: Radius.circular(24),
                      ),
                    ),
                  ),
                  Divider(),

                  const SizedBox(height: 16.0),
                  DateTimeField(
                    decoration: InputDecoration(
                      labelText: 'Last Donated Date', border: OutlineInputBorder(),
                    ),
                    format: format,
                    onShowPicker: (context, currentValue) async {
                      final date = await showDatePicker(
                          context: context,
                          firstDate: DateTime(1900),
                          initialDate: currentValue ?? DateTime.now(),
                          lastDate: DateTime(2100));
                      if (date != null) {
                        final time = await showTimePicker(
                          context: context,
                          initialTime:
                          TimeOfDay.fromDateTime(
                              currentValue ?? DateTime.now()),
                        );
                        return DateTimeField.combine(date, time);
                      } else {
                        return currentValue;
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
          else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }

  bool _submittable() {
    return _agreedToTOS == null ? false : _agreedToTOS;
  }

  void _submit() {
    _formKey.currentState?.validate();
    RegisterUser();
    print('Form submitted');
  }

  void _setAgreedToTOS(bool? newValue) {
    setState(() {
      _agreedToTOS = newValue == null ? false : newValue;
    });
  }

  Future<http.Response> RegisterUser() async {
    String url = "https://jsonplaceholder.typicode.com/posts";
    final response = await http.get(
        Uri.parse('https://localhost:5001/api/user'));
    return http.get(
      Uri.parse('https://localhost:5001/api/user'),
      //headers: <String, String>{
      //'Content-Type': 'application/json; charset=UTF-8',
      //},
      //body: jsonEncode(<String, String>{
      // 'title': title,
      //}),
    );
  }
}