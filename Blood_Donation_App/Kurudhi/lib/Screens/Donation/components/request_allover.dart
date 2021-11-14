import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:kurudhi/model/blood_request_model.dart';

class RequestAllOver extends StatelessWidget {

  Future<List<BloodRequest>> fetchRaisedRequest(http.Client client) async {
    final response = await client
        .get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));

    // Use the compute function to run parsePhotos in a separate isolate.
    return compute(parseRaisedRequest, response.body);
  }

  // A function that converts a response body into a List<Photo>.
  List<BloodRequest> parseRaisedRequest(String responseBody) {
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

    return parsed.map<BloodRequest>((json) => BloodRequest.fromJson(json))
        .toList();
  }

  final List<String> entries = <String>[
    'A',
    'B',
    'C',
    'A',
    'B',
    'C',
    'A',
    'B',
    'C',
    'A',
    'B',
    'C',
    'A',
    'B',
    'C',
    'A',
    'B'
  ];
  final List<String> names = <String>[
    'Guru Charan',
    'Rajesh Kumar',
    'Manikandan',
    'Dinesh',
    'Sukumar',
    'Guru',
    'Charan',
    'Mani',
    'Dinesh',
    'Sukumar',
    'Sukumar',
    'Guru',
    'Charan',
    'Mani',
    'Dinesh',
    'Sukumar',
    'Guru',
  ];
  final List<int> colorCodes = <int>[
    600,
    500,
    100,
    600,
    500,
    100,
    600,
    500,
    100,
    600,
    500,
    100,
    600,
    500,
    100,
    600,
    500
  ];

  final List dummyList = List.generate(17, (index) {
    return {
      "id": index,
      "title": "This is the title $index",
      "subtitle": "This is the subtitle $index"
    };
  });

  //RaisedRequest({Key? key, required this.raisedRequest}) : super(key: key);
  //final List<BloodRequest> raisedRequest;
  RequestAllOver({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(8),
      itemCount: entries.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          height: 100,
          color: Colors.black12,
          //child: Center(child: Text('Entry ${entries[index]}')),
          child: Card(
            child: ListTile(
              /*leading: CircleAvatar(
                backgroundColor: Colors.amber,
                child: Text(entries[index].toString()),
              ),*/
              leading: CircleAvatar(
                child: Text(dummyList[index]["id"].toString()),
                backgroundColor: Colors.amber,
              ),
              title: Text(
                  'Name:  ${names[index]} ' '  Age:  ${colorCodes[index]}'),
              //subtitle: Text(
              //  'A sufficiently long subtitle warrants three lines.'
              //),
              subtitle:
              Column(children: <Widget>[
                Row(
                  //mainAxisSize: MainAxisSize.min,
                  //crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                        'Units required: ${dummyList[index]["id"].toString()}'
                    ),
                  ],
                ),
                Row(
                  //mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                        'Location: ${dummyList[index]["id"].toString()}'
                    ),
                  ],
                ),
                Row(
                  //mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                        'Status: Critical'
                    ),
                  ],
                ),
              ]),

              //trailing: Icon(Icons.more_vert),
              trailing: PopupMenuButton(
                itemBuilder: (context) {
                  return [
                    PopupMenuItem(
                      value: 'accept',
                      child: ListTile(
                        leading: Icon(Icons.volunteer_activism_outlined),
                        title: Text('Accept'),
                      ),
                    ),
                    PopupMenuItem(
                      value: 'share',
                      child: ListTile(
                        leading: Icon(Icons.share),
                        title: Text('Share'),
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



