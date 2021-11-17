import 'package:flutter/material.dart';
import 'package:kurudhi/Screens/Donation/components/request_allover.dart';
import 'package:kurudhi/Screens/Donation/components/request_nearme.dart';
import '../../Request/new_blood_request.dart';
import '/Screens/Home/components/nav_drawer.dart';
import '/Screens/Request/components/raised_request.dart';
import '/Screens/Request/components/pending_approval_request.dart';
import '/Screens/Request/components/approved_request.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kurudhi Demo',
      theme: ThemeData(
        primarySwatch: Colors.red, //#DB1022FF,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const MyHomePage(title: 'Kurudhi'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  int _selectedIndex = 0;
  static const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static  List<Widget> _widgetOptions = <Widget>[
    /*Text(
      'Index 0: Home',
      style: optionStyle,
    ),*/
    Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: <Widget>[
      SizedBox(height: 20.0),
     // Text('Request', textAlign: TextAlign.center, style: TextStyle(fontSize: 22)),
      DefaultTabController(
          length: 3, // length of tabs
          initialIndex: 0,
          child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: <Widget>[
            Container(
              child: TabBar(
                labelColor: Colors.green,
                unselectedLabelColor: Colors.black,
                tabs: [
                  Tab(text: 'Raised Request'),
                  Tab(text: 'Approved Request'),
                  Tab(text: 'Pending Approval'),
                ],
              ),
            ),
            Container(
                height: 500, //height of TabBarView
                decoration: BoxDecoration(
                    border: Border(top: BorderSide(color: Colors.grey, width: 0.5))
                ),
                child: TabBarView(children: <Widget>[
                  Container(
                    child: Center(
                        child: RaisedRequest()
                    ),
                  ),
                  Container(
                    child: Center(
                        child: ApprovedRequest()
                    ),
                  ),
                  Container(
                    child: Center(
                        child: ApprovalPendingRequest()
                    ),
                  ),
                ])
            )
          ])
      ),
    ]),

    Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: <Widget>[
      SizedBox(height: 20.0),
      DefaultTabController(
          length: 2, // length of tabs
          initialIndex: 0,
          child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: <Widget>[
            Container(
              child: TabBar(
                labelColor: Colors.green,
                unselectedLabelColor: Colors.black,
                tabs: [
                  Tab(text: 'Blood Request (Near Me)'),
                  Tab(text: 'All Over'),
                ],
              ),
            ),
            Container(
                height: 500, //height of TabBarView
                decoration: BoxDecoration(
                    border: Border(top: BorderSide(color: Colors.grey, width: 0.5))
                ),
                child: TabBarView(children: <Widget>[
                  Container(
                    child: Center(
                        child: RequestNearMe()
                    ),
                  ),
                  Container(
                    child: Center(
                        child: RequestAllOver()
                    ),
                  ),
                ])
            )
          ])
      ),
    ]),
  ];

  void _incrementCounter() {
    setState(() {
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        title: Text(widget.title),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.red,
        items: const <BottomNavigationBarItem>[
          /*BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),*/
          BottomNavigationBarItem(
            icon: Icon(Icons.medical_services),
            label: 'Request',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.volunteer_activism),
            label: 'Donate',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        onTap: _onItemTapped,
      ),

      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: _widgetOptions.elementAt(_selectedIndex),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) =>  NewRequest()),
          );
        },
        tooltip: 'Request Blood',
        backgroundColor: Colors.red,
        child: const Icon(Icons.add),
      ),
    );
  }
}

