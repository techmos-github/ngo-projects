import 'package:flutter/material.dart';
import '/Screens/User/Login/components/background.dart';
import '/Screens/Home/components/body.dart';
import '/Screens/User/Register/signup_screen.dart';
import '/components/already_have_an_account_acheck.dart';
import '/components/rounded_button.dart';
import 'package:http/http.dart';
import '/components/text_field_container.dart';
import '/constants.dart';

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
                ),
              ),
              //RoundedPasswordField(
              //onChanged: (value) {},
              // ),
              RoundedButton(
                text: "LOGIN",
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
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
  }
