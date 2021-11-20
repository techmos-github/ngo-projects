import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:kurudhi/model/blood_request_model.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/services.dart';
import 'dart:async' show Future;

class RaisedRequest extends StatelessWidget {

  Future<List<BloodRequest>> ReadJsonData() async {
    //read json file
    final jsondata = await rootBundle.loadString('assets/bloodrequest.json');
    //decode json data as list
    final list = json.decode(jsondata) as List<dynamic>;

    //map json and initialize using DataModel
    return list.map((e) => BloodRequest.fromJson(e)).toList();
  }

  Future<List<BloodRequest>> fetchRaisedRequest(http.Client client) async {
    final response = await client
        .get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));

    // Use the compute function to run parsePhotos in a separate isolate.
    return compute(parseRaisedRequest, response.body);
  }

  Future<List<BloodRequest>> readRaisedRequestJson() async {
    final String response = await rootBundle.loadString('assets/bloodrequest.json');
    return compute(parseRaisedRequest, response);
  }


  // A function that converts a response body into a List<Photo>.
  List<BloodRequest> parseRaisedRequest(String responseBody) {
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

    return parsed.map<BloodRequest>((json) => BloodRequest.fromJson(json))
        .toList();
  }

  //RaisedRequest({Key? key, required this.raisedRequest}) : super(key: key);

  RaisedRequest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    Future<List<BloodRequest>> _items = readRaisedRequestJson();

    return FutureBuilder(
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
                        child: Text(items[index].bloodgroup.toString()),
                        backgroundColor: Colors.amber,
                      ),

                      title:
                      Text('Name:  ${items[index].patientname.toString()} ' '  Age:  ${items[index].age.toString()} '),

                      subtitle:
                      Column(children: <Widget>[
                        Row(
                          //mainAxisSize: MainAxisSize.min,
                          //crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                                'Units required: ${items[index].units.toString() }'
                            ),
                          ],
                        ),
                        Row(
                          //mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                                'Location: ${items[index].location }'
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
                                leading: Icon(Icons.edit_outlined),
                                title: Text('Edit'),
                              ),
                            ),
                            PopupMenuItem(
                              value: 'delete',
                              child: ListTile(
                                leading: Icon(Icons.auto_delete_outlined),
                                title: Text('Delete'),
                              ),
                            )
                          ];
                        },
                        onSelected: (String value) => actionPopUpItemSelected(),
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
    );
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
}


