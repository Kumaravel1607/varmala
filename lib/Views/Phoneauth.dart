// ignore: import_of_legacy_library_into_null_safe

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:varamala/Controller/Sharedprefrence.dart';
import 'package:varamala/Views/Frontpage.dart';
import 'package:varamala/Views/Homepage.dart';
import 'package:http/http.dart' as http;
import 'package:varamala/Views/const.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class PhoneAuth extends StatefulWidget {
  @override
  _PhoneAuthState createState() => _PhoneAuthState();
}

class _PhoneAuthState extends State<PhoneAuth> {
  bool loading = false;
  late String verId;
  String phone = "";
  String otp_pin = "";
  bool codeSent = false;
  String mobileno = "";
  String message = "";
  String otp = "";
  String firebase_id = "";
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  @override
  void initState() {
    super.initState();
    getMessage();
  }

  void mobile_login() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    Map data = {'mobile': phone.substring(3, 13), "app_id": firebase_id};

    print(data);
    var url = "https://varmalaa.com/api/Demo/send_otp";
    print(data);
    var res = await http.post(Uri.parse(url), body: data);
    var userDetail = (json.decode(res.body));
    {
      if (jsonDecode(res.body) == "false") {
        print("error");
      } else {
        setState(() {
          loading = false;
          message = userDetail['message'];
          otp = userDetail['otp'];
          pref.setString("id", userDetail['id']);
          pref.setString("email", userDetail['email']);
          pref.setString("name", userDetail['name']);
          pref.setString("gender", userDetail['gender']);
        });

        print(userDetail['email']);

        print(jsonDecode(res.body));
        _alerBox(message);
        // print(message);
      }
    }
  }

  void getMessage() {
    _firebaseMessaging.getToken().then((token) {
      print(token);
      setState(() {
        firebase_id = token!;
      });

      print("-----------NK---------------");
    });
  }

  Future<void> _alerBox(message) async {
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text(message),
            //title: Text(),
            actions: <Widget>[
              OutlinedButton(
                onPressed: () {
                  setState(() {
                    message != "Invalid Mobile No."
                        ? codeSent = true
                        : codeSent = false;
                  });
                  message != "Invalid Mobile No."
                      ? Navigator.pop(context, "ok")
                      : Navigator.pop(context, "ok");
                },
                child: const Text("OK"),
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (BuildContext context) => Homepage()),
                    (Route<dynamic> route) => false);
              },
              icon: Icon(Icons.arrow_back_rounded)),
          title: Text('Sign in with mobile number'),
        ),
        body: loading == true
            ? Center(
                child: CircularProgressIndicator(
                  color: primaryColor,
                ),
              )
            : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    codeSent
                        ? OTPTextField(
                            length: 4,
                            width: MediaQuery.of(context).size.width,
                            fieldWidth: 30,
                            style: TextStyle(fontSize: 20),
                            textFieldAlignment: MainAxisAlignment.spaceAround,
                            fieldStyle: FieldStyle.underline,
                            onCompleted: (pin) {
                              print(pin);
                              setState(() {
                                otp_pin = pin;
                              });
                            },
                          )
                        : Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: IntlPhoneField(
                              decoration: InputDecoration(
                                  labelText: 'Phone Number',
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide())),
                              initialCountryCode: 'IN',
                              onChanged: (phoneNumber) {
                                setState(() {
                                  // phoneNumber = mobileno as PhoneNumber;
                                  print(phone);
                                  phone = phoneNumber.completeNumber;
                                });
                              },
                            ),
                          ),
                    SizedBox(
                      height: 40,
                    ),
                    codeSent != false
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              InkWell(
                                onTap: () {
                                  mobile_login();
                                },
                                child: Text(
                                  "Resend OTP",
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              )
                            ],
                          )
                        : SizedBox(),
                    SizedBox(
                      height: 10,
                    ),
                    codeSent == false
                        ? ElevatedButton(
                            onPressed: () {
                              print(phone);
                              mobile_login();
                              setState(() {
                                loading = true;
                              });
                            },
                            child: Text("Verify"))
                        : ElevatedButton(
                            onPressed: () {
                              otp == otp_pin
                                  ? Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              Frontpage()),
                                      (Route<dynamic> route) => false)
                                  : showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          content: Text("Invalid OTP"),
                                          //title: Text(),
                                          actions: <Widget>[
                                            OutlinedButton(
                                              onPressed: () {
                                                Navigator.pop(context, "ok");
                                              },
                                              child: const Text("OK"),
                                            )
                                          ],
                                        );
                                      });
                            },
                            child: Text("Submit"))
                  ],
                ),
              ),
      ),
    );
  }
}
