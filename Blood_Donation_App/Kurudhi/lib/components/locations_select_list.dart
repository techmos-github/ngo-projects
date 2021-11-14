import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:grouped_list/grouped_list.dart';
import '/model/location_list.dart';

LocationModel locationModelFromJson(String str) =>
    LocationModel.fromJson(json.decode(str));

class LocationSelection extends StatefulWidget {
  LocationSelection({ required Key key }) : super(key: key);
  @override
  _LocationSelectionState createState() => _LocationSelectionState();
}

class _LocationSelectionState extends State<LocationSelection> {
  LocationModel? _locationModel;
  bool isLoading = true;
  String? _selectedDistrict = "TEXAS";
  List<String?> _districtsList = [];

  late Locations _selectedLocation;
  List<Locations>? _locationsList;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getList();
  }

  Future<void> getList() async {
    try {
      /*_locationModel = await Provider.of<UserDetails>(context, listen: false)
          .getLocationList("token");*/
      String jsonString = '''
     {
      "data": [
          {
              "district": "TEXAS",
              "locations": [
                  {
                      "id": 1,
                      "name": "FITT Sugarland",
                      "city": "HOUSTON",
                      "district": "TEXAS",
                  },
                  {
                      "id": 2,
                      "name": "FITT Pearland",
                      "city": "HOUSTON",
                      "district": "TEXAS",
                  }
              ]
          },
           {
              "district": "A",
              "locations": [
                  {
                      "id": 1,
                      "name": "A1",
                      "city": "A City 1",
                      "district": "A",
                  },
                  {
                      "id": 2,
                      "name": "A2",
                      "city": "A city 2",
                      "state": "A",
                  }
              ]
          }
      ]
    }
    ''';

      _locationModel = locationModelFromJson(jsonString);

      for (int i = 0; i < _locationModel!.data.length; i++) {
        _districtsList.add(_locationModel!.data[i].district);
      }
      _locationsList = _locationModel!.data[0].locations;
      _selectedDistrict = _districtsList[0];
      _selectedLocation = _locationsList![0];
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
      //} on HttpException catch (error) {
      // CustomWidgets.buildErrorSnackbar(context);
    } catch (error) {
      //CustomWidgets.buildErrorSnackbar(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        //color: AppConfig.bgColor,
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                height: 40.0,
                child: Row(
                  //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () {
                        Navigator.pop(context, true);
                      },
                      child: Container(
                          height: 25.0,
                          width: 25.0,
                          child: Image.network(
                              'https://picsum.photos/250?image=9',
                              color: Colors.white)),
                    ),
                    Text('LOCATION',
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Color(0xffFFFFFF),
                        )),
                    SizedBox(
                      width: 25.0,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  color: Colors.white,
                  height: MediaQuery
                      .of(context)
                      .size
                      .height,
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  padding: EdgeInsets.all(30.0),
                  child: isLoading
                      ? Center(
                    child: CircularProgressIndicator(),
                  )
                      : Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 20.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 5.0),
                        child: Text('UPDATE YOUR LOCATION',
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Color(0xff000000),
                            )),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Container(
                        height: 40.0,
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.black54, width: 0.0),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: DropdownButtonHideUnderline(
                            child: ButtonTheme(
                                alignedDropdown: true,
                                child: DropdownButton(
                                  value: _selectedDistrict,
                                  hint: Text("District"),
                                  isExpanded: true,
                                  items: _districtsList
                                      .map((String? item) =>
                                      DropdownMenuItem<String>(
                                          child: Text(item!),
                                          value: item))
                                      .toList(),
                                  onChanged: (String? Value) {
                                    if (mounted)
                                      setState(() {
                                        _selectedDistrict = Value!;

                                        int index = _locationModel!.data
                                            .indexWhere((element) =>
                                        element.district ==
                                            _selectedDistrict);

                                        _locationsList = _locationModel!
                                            .data[index].locations;
                                        _selectedLocation =
                                        _locationsList![0];
                                      });
                                  },
                                  style: Theme
                                      .of(context)
                                      .textTheme
                                      .bodyText2,
                                ))),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Container(
                        height: 40.0,
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.black54, width: 0.0),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: DropdownButtonHideUnderline(
                            child: ButtonTheme(
                                alignedDropdown: true,
                                child: DropdownButton(
                                  value: _selectedLocation,
                                  hint: Text("Location"),
                                  isExpanded: true,
                                  items: _locationsList!.map((item) {
                                    return DropdownMenuItem(
                                      child: Text(item.name!),
                                      value: item,
                                    );
                                  }).toList(),
                                  onChanged: (Value) {
                                    if (mounted) print(Value);
                                    setState(() {
                                      _selectedLocation = Value as Locations;
                                      print(
                                          "${_selectedLocation
                                              .name} ${_selectedLocation
                                              .id} ${_selectedLocation.city}");
                                    });
                                  },
                                  style: Theme
                                      .of(context)
                                      .textTheme
                                      .bodyText2,
                                ))),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}


/*
class LocationSelection extends StatelessWidget {
  const LocationSelection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List _elements = [
      {'topicName': 'GridView.count', 'group': 'GridView Type'},
      {'topicName': 'GridView.builder', 'group': 'GridView Type'},
      {'topicName': 'GridView.custom', 'group': 'GridView Type'},
      {'topicName': 'GridView.extent', 'group': 'GridView Type'},
      {'topicName': 'ListView.builder', 'group': 'ListView Type'},
      {'topicName': 'StatefulWidget', 'group': 'Type of Widget'},
      {'topicName': 'ListView', 'group': 'ListView Type'},
      {'topicName': 'ListView.separated', 'group': 'ListView Type'},
      {'topicName': 'ListView.custom', 'group': 'ListView Type'},
      {'topicName': 'StatelessWidget', 'group': 'Type of Widget'},
    ];

    List<String> countries = ['USA', 'India'];
    List<String> indiaProvince = ['New Delhi', 'Bihar', 'Rajasthan'];
    List<String> usaProvince = ['Texas', 'Florida', 'California'];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Select Location"),
      ),
      /*body : Center (
        child:  SingleChildScrollView(
          //child: Padding(
          padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
          child: RequestForm(),
          //),
        ),
      ),*/
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[

              const SizedBox(height: 16.0),
              DropdownSearch<String>(
                mode: Mode.DIALOG,
                items: [
                  "Puducherry",
                  "Tiruvallur",
                  "Chennai",
                  "Kanchipuram",
                  "Chengalpattu",
                  "Vellore",
                  "Tirupati",
                  "Ranipettai",
                  "Krishnagiri",
                  "Dharmapuri",
                  "Thiruvannamalai",
                  "Villupuram",
                  "Kallakurichi",
                  "Salem",
                  "Namakkal",
                  'Erode',
                  "Nilgiris",
                  "Coimbatore",
                  "Thirupur",
                  "Dindigul",
                  "Karur",
                  "Tiruchirappalli",
                  "Perambalur",
                  "Ariyalur",
                  "Cuddalore",
                  "Nagapattinam",
                  "Thiruvarur",
                  "Pudukkottai",
                  "Sivagangai",
                  "Madurai",
                  "Theni",
                  "Virudhunagar",
                  "Ramanadhapuram",
                  "Thoothukudi",
                  "Thenkasi",
                  "Thirunelveli",
                  "Kanyakumari",
                ],
                dropdownSearchDecoration: InputDecoration(
                  labelText: "Select Location",
                  contentPadding: EdgeInsets.fromLTRB(12, 12, 0, 0),
                  border: OutlineInputBorder(),
                ),
                onChanged: print,
                //selectedItem: "Brazil",
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
                    color: Theme.of(context).primaryColorDark,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'Select Location',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
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

              /*DropdownSearch<UserModel>(
                items: [
                  UserModel(name: "Offline name1", id: "999"),
                  UserModel(name: "Offline name2", id: "0101")
                ],
                maxHeight: 300,
                onFind: (String? filter) => getData(filter),
                dropdownSearchDecoration: InputDecoration(
                  labelText: "choose a user",
                  contentPadding: EdgeInsets.fromLTRB(12, 12, 0, 0),
                  border: OutlineInputBorder(),
                ),
                onChanged: print,
                showSearchBox: true,
              ),
              Divider(),*/

              ListView.builder(
                // Let the ListView know how many items it needs to build.
                itemCount: _elements.length,
                // Provide a builder function. This is where the magic happens.
                // Convert each item into a widget based on the type of item it is.
                itemBuilder: (context, index) {
                  final item = _elements[index];

                  return ListTile(
                    title: item.buildTitle(context),
                    subtitle: item.buildSubtitle(context),
                  );
                },
              ),

            /*  const SizedBox(height: 36.0),
            GroupedListView<dynamic, String>(
              elements: _elements,
              groupBy: (element) => element['group'],
              groupComparator: (value1,
                  value2) => value2.compareTo(value1),
              itemComparator: (item1, item2) =>
                  item1['topicName'].compareTo(item2['topicName']),
              order: GroupedListOrder.DESC,
              // useStickyGroupSeparators: true,
              groupSeparatorBuilder: (String value) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  value,
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
              itemBuilder: (c, element) {
                return Card(
                  elevation: 8.0,
                  margin: new EdgeInsets.symmetric(horizontal: 10.0,
                      vertical: 6.0),
                  child: Container(
                    child: ListTile(
                      contentPadding:
                      EdgeInsets.symmetric(horizontal: 20.0,
                          vertical: 10.0),
                      //leading: Icon(Icons.account_circle),
                      title: Text(
                        element['topicName'],
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                );
              },
            ),
        */


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

    );
  }
  void onChangedCallback(country) {
    /*if (country == 'USA') {
      provinces = usaProvince;
    } else if (country == 'India') {
      provinces = indiaProvince;
    } else {
      provinces = [];
    }
    setState(() {
      selectedProvince = null;
      selectedCountry = country;
    });*/
  }
}*/