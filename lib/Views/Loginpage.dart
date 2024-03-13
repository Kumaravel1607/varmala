import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:varamala/Views/Forget_Password.dart';
import 'package:varamala/Views/Log_to_profile.dart';
import 'package:varamala/Views/Signup.dart';
import 'package:varamala/Views/const.dart';
import 'package:varamala/Views/personal_profile.dart';
import 'Frontpage.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class Loginpage extends StatefulWidget {
  @override
  _LoginpageState createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  bool signin = true;
  String error = "";
  String emailerror = "";
  String passerror = "";
  late TextEditingController emailctrl, passctrl;
  late SharedPreferences preferences;

  bool processing = false;

  String firebase_id = "";

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  @override
  initState() {
    // TODO: implement initState
    super.initState();
    emailctrl = new TextEditingController();
    passctrl = new TextEditingController();
    getMessage();
  }

  void getMessage() {
    _firebaseMessaging.getToken().then((token) {
      print(token);
      firebase_id = token!;
      print("-----------NK---------------");
    });
  }

  void userSignIn() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.clear();
    pref.commit();

    setState(() {
      pref.clear();

      processing = true;
    });
    var url = "https://varmalaa.com/api/Demo/userlogin";
    var data = {
      "email": emailctrl.text,
      "password": passctrl.text,
      "app_id": firebase_id
    };
    print(data);
    var res = await http.post(Uri.parse(url), body: data);
    print(jsonDecode(res.body));
    if (jsonDecode(res.body) == "dont have an account") {
      setState(() {
        error = "Email or Mobile number is incorrect";
        signin = false;
      });
    } else {
      if (jsonDecode(res.body) == "false") {
        setState(() {
          error = "incorrect password";
          signin = false;
        });
      } else {
        if (jsonDecode(res.body)['message'] == "Successfully Logged In") {
          setState(() {});
          print(jsonDecode(res.body));
          error = " ";
          var data = jsonDecode(res.body);
          // signin = true;
          //print(jsonDecode(res.body)['message']);

          print(data['last_login']);

          pref.setString("id", data['id']);
          pref.setString("email", emailctrl.text);
          pref.setString("name", data['name']);
          pref.setString("gender", data['gender']);

          // SharedPrefence.setUsername(emailctrl.text);
          // SharedPrefence.setid(data['id']);
          // SharedPrefence.setFirstname(data['name']);

          // print(SharedPrefence.getid());
          // print(SharedPrefence.getUsername());

          Future.delayed(const Duration(milliseconds: 500), () {
            setState(() {
              if (data['last_login'] == "" || data['last_login'] == null) {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (BuildContext context) => Personal_profile2()),
                    (Route<dynamic> route) => false);
              } else {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (BuildContext context) => Frontpage()),
                    (Route<dynamic> route) => false);
              }
            });
          });
        } else {
          setState(() {
            error = jsonDecode(res.body)['message'];
            signin = false;
          });
        }
      }
    }

    setState(() {
      processing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(13, 55, 13, 13),
            child: Column(
              children: [
                Image.asset("assets/Images/icon.jpeg",
                    height: 300, fit: BoxFit.fill),
                SizedBox(
                  height: 20,
                ),
                Padding(
                    padding: EdgeInsets.only(left: 15, right: 15),
                    child: TextField(
                      controller: emailctrl,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: primaryColor)),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: primaryColor)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: primaryColor)),
                        labelText: 'Email Or the Phone Number',
                        labelStyle: TextStyle(color: Colors.black),
                      ),
                    )),
                (emailerror != "")
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            emailerror,
                            style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      )
                    : SizedBox(
                        height: 10,
                      ),
                Padding(
                    padding: EdgeInsets.only(left: 15, right: 15),
                    child: TextField(
                      controller: passctrl,
                      obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: primaryColor)),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: primaryColor)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: primaryColor)),
                        labelText: 'Password',
                        labelStyle: TextStyle(color: Colors.black),
                      ),
                    )),
                (passerror != "")
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            passerror,
                            style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      )
                    : SizedBox(height: 10),
                Text(
                  error,
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    if (emailctrl.text == "" && passctrl.text == '') {
                      setState(() {
                        emailerror = "This field is required";
                        passerror = "This field is required";
                      });
                    } else if (emailctrl.text == "") {
                      setState(() {
                        emailerror = "This field is required";
                      });
                    } else if (passctrl.text == "") {
                      setState(() {
                        passerror = "This field is required";
                      });
                    } else {
                      userSignIn();
                      setState(() {
                        error = " ";
                        emailerror = "";
                        passerror = "";
                        // SharedPrefence.setUsername(emailctrl.text);
                      });
                    }
                    //Navigator.push(context, MaterialPageRoute(builder: (context) => Frontpage()));
                  },
                  child: Container(
                    height: 50,
                    width: size.width * 0.65,
                    decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          processing == false
                              ? Text(
                                  'Login',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                )
                              : CircularProgressIndicator(
                                  color: Colors.white,
                                )
                        ]),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      child: Text(
                        'Forget Password?',
                        style: TextStyle(color: Colors.indigo, fontSize: 15),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => forgetpassword()));
                      },
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      '|',
                      style: TextStyle(color: Colors.indigo, fontSize: 15),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (BuildContext context) => Singup()),
                            (Route<dynamic> route) => false);
                      },
                      child: Text(
                        'Create an Account',
                        style: TextStyle(color: Colors.indigo, fontSize: 15),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        )));
  }
}
