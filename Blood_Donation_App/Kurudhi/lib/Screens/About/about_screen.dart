import 'package:flutter/material.dart';
import 'package:kurudhi/constants.dart';
import '/Screens/About/components/social_icon.dart';
import 'dart:html' as html;

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("About Us"),
          centerTitle: true,
          elevation: 0.0,
          backgroundColor: kPrimaryColor,
        ),
        body: Center(
          child: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "#NTKBloodDonationWing  #குருதிக்கொடை_பாசறை is a prestigious wing of Naam Thamizhar Katchi that aim to save priceless human life. We render service to mankind by linking blood donors and the needy at free of cost.",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    const SizedBox(height: 16.0),
                    Text(
                      "#NTKBloodDonationWing has been awarded, accredited, and recognized for our service by Thamizh Nadu Government and several NGOs.",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    const SizedBox(height: 16.0),
                    Text(
                      "In need of expanding the service platform to serve more and more people, Naam Thamizhar Katchi decided to build a mobile app platform.",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    const SizedBox(height: 16.0),
                    Text(
                      "Kurudhi is a free blood donation service app available on both Android and iOS platform. Kurudhi app searches, informs, and connect thousands of blood donors. Kurudhi app ensures hassle-free blood donation service by connecting blood donors and the needy ones that reduces time thereby saving precious human lives.",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    const SizedBox(height: 25.0),
                    Text(
                      "Donate Blood !!! Save Lives !!!",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20),
                    ),

                    const SizedBox(height: 25.0),
                    //Text("Download Links:"),
                    Text(
                      "Follow Us:",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, height: 5, fontSize: 20),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SocalIcon(
                          iconSrc: "assets/icons/facebook.svg",
                          press: () {
                            html.window.location.href = "https://www.facebook.com/blooddonationntk/";
                          },
                        ),
                        SocalIcon(
                          iconSrc: "assets/icons/twitter.svg",
                          press: () {
                            html.window.location.href = "https://twitter.com/kkpntk";
                          },
                        ),
                        /*SocalIcon(
                          iconSrc: "assets/icons/google-plus.svg",
                          press: () {},
                        ),
                         */
                      ],
                    )
                  ]
              )
          ),
        )
    );
  }
}