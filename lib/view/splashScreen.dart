import 'dart:async';

import 'package:Th_delivery/model/uiconstants.dart';
import 'package:Th_delivery/view/auth/loginScreen.dart';
import 'package:Th_delivery/view/homepage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    startTime();
  }

  startTime() async {
    var duration = new Duration(seconds: 3);
    return new Timer(duration, navigate);
  }

  void navigate() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    bool temp = pref.getBool("login");
    if (temp != null) {
      if (temp) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(),
          ),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => LoginScreen(),
          ),
        );
      }
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => LoginScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: Image.asset(
              UIConstants.splashScreenLogo,
              height: UIConstants.fitToHeight(200, context),
              width: UIConstants.fitToWidth(200, context),
              fit: BoxFit.contain,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 100,
            ),
            child: LinearProgressIndicator(
                valueColor:
                    new AlwaysStoppedAnimation<Color>(Color(0xff25354E))),
          ),
        ],
      )),
    );
  }
}
