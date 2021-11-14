import 'package:flutter/material.dart';
import '/Screens/User/Login/login_screen.dart';
import '/Screens/User/Profile/user_profile_page.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';

class NavDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
                color: Colors.red,
                image: DecorationImage(
                    fit: BoxFit.scaleDown,
                    image: AssetImage('assets/images/logo-round.png'),
                    alignment: Alignment.center,
                )
            ),
            child:
                Text(
                  '',
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
          ),
          ListTile(
            leading: Icon(Icons.input),
            title: Text('Welcome'),
            onTap: () => {},
          ),
          ListTile(
            leading: Icon(Icons.verified_user),
            title: Text('My Profile'),
            onTap: () => {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return UserProfilePage();
                  },
                ),
              )
              //Navigator.of(context).pop()
            },
          ),
          ListTile(
            leading: Icon(Icons.watch_later_outlined),
            title: Text('My Activity'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Icon(Icons.verified_outlined),
            title: Text('Pending For Approval'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Icon(Icons.local_activity),
            title: Text('Donation History'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () => {Navigator.of(context).pop()},
          ),

          ListTile(
            leading: Icon(Icons.border_color),
            title: Text('Feedback'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            //onTap: () => {Navigator.of(context).pop()},
            onTap: () => {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return LoginScreen();
                  },
                ),
              )
            },
          ),
        ],
      ),
    );
  }
}