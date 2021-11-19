import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:kurudhi/model/blood_request_model.dart';
import '/Screens/User/Login/components/background.dart';
import '/Screens/Home/components/body.dart';
import '/Screens/User/Register/signup_screen.dart';
import '/components/already_have_an_account_acheck.dart';
import '/components/rounded_button.dart';
import '/components/text_field_container.dart';
import '/constants.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/services.dart';
import 'dart:async' show Future;

bool _obscureText = true;
class LoginFormBody extends StatefulWidget {
  @override
  _LoginFormState createState() => new _LoginFormState();
}

class _LoginFormState extends State<LoginFormBody> {
  // Toggles the password show status
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "LOGIN",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.03),
            Image.asset(
              "assets/images/logo-round.png",
              height: size.height * 0.30,
            ),

            /*SvgPicture.asset(
              "assets/images/launch screen logo.jpeg",
              height: size.height * 0.35,
            ),*/
            SizedBox(height: size.height * 0.03),
            TextFieldContainer(
              child: TextField(
                cursorColor: kPrimaryColor,
                decoration: InputDecoration(
                  hintText: "Your Email",
                  icon: Icon(
                    Icons.person,
                    color: kPrimaryColor,
                  ),
                  border: InputBorder.none,
                ),
                /*validator: (String? value) {
                    if (value
                        .toString()
                        .trim()
                        .isEmpty) {
                      return 'Email is required';
                    }
                  },*/
              ),
            ),

            TextFieldContainer(
              child: TextField(
                obscureText: _obscureText,
                //onChanged: onChanged,
                cursorColor: kPrimaryColor,
                decoration: InputDecoration(
                  hintText: "Password",
                  icon: Icon(
                    Icons.lock,
                    color: kPrimaryColor,
                  ),
                  suffixIcon: IconButton(
                      icon: Icon(
                        Icons.visibility,
                        color: kPrimaryColor,
                      ),
                      onPressed: () => _toggle()

                  ),
                  border: InputBorder.none,
                ),
                /*validator: (String? value) {
                    if (value
                        .toString()
                        .trim()
                        .isEmpty) {
                      return 'Password is required';
                    }
                  },*/
              ),
            ),
            RoundedButton(
              text: "LOGIN",
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      fetchRaisedRequest();
                     //apiTest();

                      /*Future<http.Response> createAlbum(String title) {
                        return http.post(
                          Uri.parse('https://jsonplaceholder.typicode.com/albums'),
                          headers: <String, String>{
                            'Content-Type': 'application/json; charset=UTF-8',
                          },
                          body: jsonEncode(<String, String>{
                            'title': title,
                          }),
                        );
                      }*/
                      return LandingPage();
                    },
                  ),
                );
              },
            ),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return SignUpScreen();
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<List<BloodRequest>> fetchRaisedRequest(http.Client client) async {
    final response = await client
        .get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));

    // Use the compute function to run parsePhotos in a separate isolate.
    return compute(parseRaisedRequest, response.body);
  }

  List<BloodRequest> parseRaisedRequest(String responseBody) {
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

    return parsed.map<BloodRequest>((json) => BloodRequest.fromJson(json))
        .toList();
  }


  Future<http.Response> apiTest() async {
    var client = new http.Client();
    var url = Uri.parse('https://jsonplaceholder.typicode.com/albums');
    try {

      print(await client.get(url));
    }
    finally {
    client.close();
    }
    return await client.get(url);
  }
}
