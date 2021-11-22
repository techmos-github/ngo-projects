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
import 'package:email_validator/email_validator.dart';

bool _obscureText = true;

class LoginFormBody extends StatefulWidget {
  @override
  _LoginFormState createState() => new _LoginFormState();
}

class _LoginFormState extends State<LoginFormBody> {
  // Toggles the password show status
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _agreedToTOS = false;
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
                padding: EdgeInsets.fromLTRB(200, 5, 10, 30),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
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
                          'Admin',
                        ),
                      ),
                    ])),
            Text(
              "LOGIN",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.03),
            Image.asset(
              "assets/images/logo-round.png",
              height: size.height * 0.30,
            ),
            SizedBox(height: size.height * 0.03),
            Container(
              padding: EdgeInsets.all(10),
              child: TextField(
                controller: nameController,
                decoration: InputDecoration(
                  hintText: "Your Email",
                  errorText: validateEmail(nameController.text),
                  icon: Icon(
                    Icons.person,
                    color: kPrimaryColor,
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: TextField(
                controller: passwordController,
                decoration: InputDecoration(
                  hintText: "Password",
                  errorText: validatePassword(passwordController.text),
                  icon: Icon(
                    Icons.person,
                    color: kPrimaryColor,
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
            RoundedButton(
              text: "LOGIN",
              press: () {
                loginAPI(nameController.text, passwordController.text, context);
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

  String? validatePassword(String value) {
    if (value.isEmpty) {
      return "Password is required";
    }
    return null;
  }

  String? validateEmail(String value) {
    if (value.isEmpty) {
      return "Email is required";
    } else if (EmailValidator.validate(value) == null) {
      return "Enter a valid email";
    }
    return null;
  }

  void _setAgreedToTOS(bool? newValue) {
    setState(() {
      _agreedToTOS = newValue == null ? false : newValue;
    });
  }

  Future<List<BloodRequest>> fetchRaisedRequest(http.Client client) async {
    final response = await client
        .get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));

    // Use the compute function to run parsePhotos in a separate isolate.
    return compute(parseRaisedRequest, response.body);
  }

  List<BloodRequest> parseRaisedRequest(String responseBody) {
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

    return parsed
        .map<BloodRequest>((json) => BloodRequest.fromJson(json))
        .toList();
  }

  Future<http.Response> apiTest() async {
    var client = new http.Client();
    var url = Uri.parse('https://jsonplaceholder.typicode.com/albums');
    try {
      print(await client.get(url));
    } finally {
      client.close();
    }
    return await client.get(url);
  }
}

Future loginAPI(String userName, String password, BuildContext context) async {
  final response = await http.post(
    Uri.parse('https://www.kurudhi.org/Users/authenticate'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(
        <String, String>{'username': userName, 'password': password}),
  );

  if (response.statusCode == 200) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    // return Album.fromJson(jsonDecode(response.body));
    print(jsonDecode(response.body));
    Map<String, dynamic> responseJson = json.decode(response.body);
    if (responseJson["token"] != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return LandingPage();
          },
        ),
      );
    }
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text("Login failed"),
        content: Text("Invalid user credentials"),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: Text("Ok"),
          ),
        ],
      ),
    );
  }
}
