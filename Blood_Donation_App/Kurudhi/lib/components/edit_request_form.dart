import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:kurudhi/model/blood_request_model.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/services.dart';
import 'dart:async' show Future;
import 'package:intl/intl.dart';
import 'package:kurudhi/model/location_model.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:dropdown_search/dropdown_search.dart';

class EditRequest extends StatefulWidget {
  const EditRequest({Key? key}) : super(key: key);

  @override
  _EditRequestState createState() => _EditRequestState();
}

class _EditRequestState extends State<EditRequest> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _agreedToTOS = true;
  String? selectedBloodGroup;
  final format = DateFormat("yyyy-MM-dd HH:mm");
  String selectedRequestType = "Blood";
  String selectedRequestStatus = "Normal";
  List<String> _status = ["Blood", "Platelets"];
  String selectedDistrict = "";
  List<String>? matchLocations = [];
  String? selectedGender;

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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[

                  const SizedBox(height: 16.0),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Patient Name',
                      border: OutlineInputBorder(),
                    ),
                    validator: (String? value) {
                      if (value
                          .toString()
                          .trim()
                          .isEmpty) {
                        return 'Patient Name is required';
                      }
                    },
                  ),

                  const SizedBox(height: 16.0),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Patient Admission ID',
                      border: OutlineInputBorder(),
                    ),
                    /*validator: (String? value) {
                      if (value
                          .toString()
                          .trim()
                          .isEmpty) {
                        return 'Patient Admission Id is required';
                      }
                    },*/
                  ),

                  const SizedBox(height: 16.0),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Patient Age',
                      border: OutlineInputBorder(),
                    ),
                    validator: (String? value) {
                      if (value
                          .toString()
                          .trim()
                          .isEmpty) {
                        return 'Patient Age is required';
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
                  DropdownButtonFormField<String>(
                    value: selectedRequestType,
                    decoration: InputDecoration(
                      labelText: 'Request Type', border: OutlineInputBorder(),),
                    onChanged: (selectedBloodGroup) =>
                        setState(() => selectedBloodGroup = selectedRequestType),
                    validator: (value) => value == null ? 'Request Type is required' : null,
                    items:
                    ['Blood', 'Platelets', 'Plasma'].map<DropdownMenuItem<String>>((
                        String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),

                  const SizedBox(height: 16.0),
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      labelText: 'Blood Group', border: OutlineInputBorder(),),
                    value: selectedBloodGroup,
                    onChanged: (salutation) =>
                        setState(() => selectedBloodGroup = salutation),
                    validator: (value) =>
                    value == null
                        ? 'Blood Group is required'
                        : null,
                    items:
                    [
                      'Any',
                      'A+',
                      'A-',
                      'B+',
                      'B-',
                      'AB+',
                      'AB-',
                      'A1+',
                      'A1-',
                      'A1B+',
                      'A1B-',
                      'A2+',
                      'A2-',
                      'A2B+',
                      'A2B-',
                      'O+',
                      'O-',
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
                      labelText: 'Blood Units Required',
                      border: OutlineInputBorder(),
                    ),
                    validator: (String? value) {
                      if (value
                          .toString()
                          .trim()
                          .isEmpty) {
                        return 'Blood Units is required';
                      }
                    },
                  ),

                  const SizedBox(height: 16.0),
                  DropdownButtonFormField<String>(
                    value: selectedRequestStatus,
                    decoration: InputDecoration(
                      labelText: 'Medical Status', border: OutlineInputBorder(),),
                    onChanged: (selectedBloodGroup) =>
                        setState(() => selectedBloodGroup = selectedRequestStatus),
                    validator: (value) => value == null ? 'Medical status is required' : null,
                    items:
                    ['Normal', 'Emergency', 'Critical'].map<DropdownMenuItem<String>>((
                        String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),

                  const SizedBox(height: 16.0),
                  DateTimeField(
                    decoration: InputDecoration(
                      labelText: 'Due Date', border: OutlineInputBorder(),
                    ),
                    validator: (DateTime? value) {
                      if (value
                          .toString()
                          .trim()
                          .isEmpty) {
                        return 'Due Date is required';
                      }
                    },
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

                  const SizedBox(height: 16.0),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Attender Name',
                      border: OutlineInputBorder(),
                    ),
                    validator: (String? value) {
                      if (value
                          .toString()
                          .trim()
                          .isEmpty) {
                        return 'Attender Name is required';
                      }
                    },
                  ),

                  const SizedBox(height: 16.0),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Attender Contact Number',
                      border: OutlineInputBorder(),
                    ),
                    validator: (String? value) {
                      if (value
                          .toString()
                          .trim()
                          .isEmpty) {
                        return 'Attender Contact is required';
                      }
                    },
                  ),


                  const SizedBox(height: 16.0),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Hospital Name',
                      border: OutlineInputBorder(),
                    ),
                    validator: (String? value) {
                      if (value
                          .toString()
                          .trim()
                          .isEmpty) {
                        return 'Hospital Name is required';
                      }
                    },
                  ),

                  const SizedBox(height: 16.0),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Hospital Address',
                      border: OutlineInputBorder(),
                    ),
                    validator: (String? value) {
                      if (value
                          .toString()
                          .trim()
                          .isEmpty) {
                        return 'Hospital Address is required';
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

                  const SizedBox(height: 16.0),
                  DropdownSearch<String>(
                    mode: Mode.DIALOG,
                    items: matchLocations?.cast<String>(),
                    dropdownSearchDecoration: InputDecoration(
                      labelText: "Select Location",
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

                  //LocationSelection(key: _formKey),
                  const SizedBox(height: 36.0),
                  ElevatedButton(
                    onPressed: () {
                      _submit();
                      if (_submittable()) {

                      }
                    },
                    child: const Text('Confirm Request'),
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
    print('Form submitted');
  }

  void _setAgreedToTOS(bool? newValue) {
    setState(() {
      _agreedToTOS = newValue == null ? false : newValue;
    });
  }
}
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