import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:kurudhi/model/blood_request_model.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/services.dart';
import 'dart:async' show Future;
import 'package:kurudhi/model/location_model.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:kurudhi/constants.dart';

Future<List<Location>> ReadLocationJsonData() async {
  final jsondata = await rootBundle.loadString('assets/location.json');
  final list = json.decode(jsondata) as List<dynamic>;
  return list.map((e) => Location.fromJson(e)).toList();
}

Future<List<BloodRequest>> ReadJsonData() async {
  final jsondata = await rootBundle.loadString('assets/bloodrequest.json');
  final list = json.decode(jsondata) as List<dynamic>;
  return list.map((e) => BloodRequest.fromJson(e)).toList();
}

Future<List<BloodRequest>> fetchRaisedRequest(http.Client client) async {
  final response = await client
      .get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));

  // Use the compute function to run parsePhotos in a separate isolate.
  return compute(parseRaisedRequest, response.body);
}

Future<List<BloodRequest>> readRaisedRequestJson() async {
  final String response = await rootBundle.loadString(
      'assets/bloodrequest.json');
  return compute(parseRaisedRequest, response);
}

// A function that converts a response body into a List<Photo>.
List<BloodRequest> parseRaisedRequest(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<BloodRequest>((json) => BloodRequest.fromJson(json))
      .toList();
}

class Search_Donors extends StatefulWidget {
  const Search_Donors({Key? key}) : super(key: key);

  @override
  _Search_DonorsState createState() => _Search_DonorsState();
}

class _Search_DonorsState extends State<Search_Donors> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _agreedToTOS = true;
  String? selectedBloodGroup;
  String selectedDistrict = "";
  List<String>? matchLocations = [];
  String? selectedCriteria;

  @override
  Widget build(BuildContext context) {
    Future<List<BloodRequest>> _items = readRaisedRequestJson();
    return FutureBuilder(
        future: ReadLocationJsonData(),
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
                  DropdownButtonFormField<String>(
                    value: selectedCriteria,
                    decoration: InputDecoration(
                      labelText: 'Select Criteria',
                      border: OutlineInputBorder(),),
                    onChanged: (selectedBloodGroup) =>
                        setState(() => selectedBloodGroup = selectedCriteria),
                    items:
                    ['All Donors', 'Available Donors'].map<
                        DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
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

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Align(
                          alignment: Alignment.center,
                          child: ElevatedButton(
                            onPressed: _submit,
                            child: const Text('Search'),
                            style: ElevatedButton.styleFrom(
                              primary: kPrimaryColor,
                            ),
                          )
                      ),
                    ],
                  ),
                  FutureBuilder(
                      future: ReadJsonData(),
                      builder: (context, data) {
                        if (data.hasError) {
                          return Center(child: Text("${data.error}"));
                        } else if (data.hasData) {
                          var items = data.data as List<BloodRequest>;
                          return ListView.separated(
                            padding: const EdgeInsets.all(8),
                            itemCount: items.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                height: 100,
                                color: Colors.black12,
                                //child: Center(child: Text('Entry ${entries[index]}')),
                                child: Card(
                                  child: ListTile(
                                    leading: CircleAvatar(
                                      child: Text(
                                          items[index].bloodgroup.toString()),
                                      backgroundColor: Colors.amber,
                                    ),

                                    title:
                                    Text('Name:  ${items[index].patientname
                                        .toString()} ' '  Age:  ${items[index]
                                        .age
                                        .toString()} '),

                                    subtitle:
                                    Column(children: <Widget>[
                                      Row(
                                        //mainAxisSize: MainAxisSize.min,
                                        //crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment
                                            .start,
                                        children: [
                                          Text(
                                              'Units required: ${items[index]
                                                  .units
                                                  .toString() }'
                                          ),
                                        ],
                                      ),
                                      Row(
                                        //mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment: MainAxisAlignment
                                            .start,
                                        children: [
                                          Text(
                                              'Location: ${items[index]
                                                  .location }'
                                          ),
                                        ],
                                      ),
                                      Row(
                                        //mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                              'Status: ${items[index].medicalstatus }'
                                          ),
                                        ],
                                      ),
                                    ]),

                                    //trailing: Icon(Icons.more_vert),
                                    trailing: PopupMenuButton(
                                      itemBuilder: (context) {
                                        return [
                                          PopupMenuItem(
                                            value: 'edit',
                                            //child: Text('Edit'),
                                            child: ListTile(
                                              leading: Icon(
                                                  Icons.edit_outlined),
                                              title: Text('Edit'),
                                            ),
                                          ),
                                          PopupMenuItem(
                                            value: 'delete',
                                            child: ListTile(
                                              leading: Icon(
                                                  Icons.auto_delete_outlined),
                                              title: Text('Delete'),
                                            ),
                                          )
                                        ];
                                      },
                                      onSelected: (String value) =>
                                          actionPopUpItemSelected(),
                                    ),
                                    isThreeLine: false,
                                  ),
                                ),
                              );
                            },
                            separatorBuilder: (BuildContext context,
                                int index) => const Divider(),
                          );
                        }
                        else {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      }
                  ),
                  GridView.count(
                    crossAxisCount: 1,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                    shrinkWrap: true,
                    children: List.generate(20, (index) {
                      return Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: ListView(
                            children: const <Widget>[
                              Card(
                                child: ListTile(
                                  leading: FlutterLogo(size: 72.0),
                                  title: Text('Three-line ListTile'),
                                  subtitle: Text(
                                      'A sufficiently long subtitle warrants three lines.'
                                  ),
                                  trailing: Icon(Icons.more_vert),
                                  isThreeLine: true,
                                ),
                              ),
                            ],
                          )
                      );
                    },),
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

  void actionPopUpItemSelected() {
    /*_scaffoldkey.currentState.hideCurrentSnackBar();
    String message;
    if (value == 'edit') {
      message = 'You selected edit for $name';
    } else if (value == 'delete') {
      message = 'You selected delete for $name';
    } else {
      message = 'Not implemented';
    }
    final snackBar = SnackBar(content: Text(message));
    _scaffoldkey.currentState.showSnackBar(snackBar);
    */
  }

  void _submit() {
    _formKey.currentState?.validate();
    print('Form submitted');
    return;
  }
}


