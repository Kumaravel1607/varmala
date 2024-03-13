import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:varamala/Views/Frontpage.dart';
import 'package:varamala/Views/Loginpage.dart';
import 'package:varamala/Views/Phoneauth.dart';
import 'package:varamala/Views/const.dart';

import 'Signup.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageScreen createState() => _HomepageScreen();
}

class _HomepageScreen extends State<Homepage> {
  bool _loading = false;
  @override
  void initState() {
    // checkLoginStatus();
  }

  // checkLoginStatus() async {
  //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //   if (sharedPreferences.getString("email") != null) {
  //     Navigator.of(context).pushAndRemoveUntil(
  //         MaterialPageRoute(builder: (BuildContext context) => Frontpage()),
  //         (Route<dynamic> route) => false);
  //   } else {
  //     setState(() {
  //       _loading = false;
  //     });
  //   }
  // }

  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    final background = Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/Images/cartoon.jpg"),
          fit: BoxFit.cover,
        ),
      ),
    );

    Widget _signin() {
      return RaisedButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        color: primaryColor,
        elevation: 10,
        child: Container(
          height: 50,
          width: 120,
          child: Center(
            child: Text(
              "LOGIN",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
        ),
        onPressed: () {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => Loginpage()));
        },
      );
    }

    Widget _signup() {
      return RaisedButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        color: primaryColor,
        elevation: 10,
        child: _loading == true
            ? CircularProgressIndicator()
            : Container(
                height: 50,
                width: 120,
                child: Center(
                  child: Text(
                    "SIGN UP",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Singup()));
        },
      );
    }

    Widget _signupph() {
      return RaisedButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        color: primaryColor,
        elevation: 10,
        child: Container(
          height: 50,
          width: 180,
          child: Center(
            child: Text(
              "SIGN IN WITH OTP",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
        ),
        onPressed: () {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => PhoneAuth()));
        },
      );
    }

    return ResponsiveBuilder(builder: (context, sizingInformation) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: _loading == true
            ? new Center(
                child: new SizedBox(
                  height: 50.0,
                  width: 50.0,
                  child: new CircularProgressIndicator(
                    value: null,
                    strokeWidth: 7.0,
                    color: primaryColor,
                  ),
                ),
              )
            : Center(
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    background,
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white.withOpacity(0.8),
                          ),
                          child: Image.asset(
                            'assets/Images/logo2.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        Container(
                          width: size.width,
                          child: Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    _signin(),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    _signup()
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                _signupph()
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
      );
    });
  }
}
