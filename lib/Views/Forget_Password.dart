import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:retry/retry.dart';
import 'package:varamala/Controller/Service.dart';
import 'package:varamala/Views/Loginpage.dart';
import 'package:varamala/Views/const.dart';
import 'package:http/http.dart' as http;

class forgetpassword extends StatefulWidget {
  forgetpassword({Key? key}) : super(key: key);

  @override
  _forgetpasswordState createState() => _forgetpasswordState();
}

class _forgetpasswordState extends State<forgetpassword> {
  bool val = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var newpassword1 = TextEditingController();
  var newpassword2 = TextEditingController();
  var mobilenumber = TextEditingController();
  String message = "";

  void forget_password() async {
    Map data = {
      'email': mobilenumber.text,
    };

    print(data);
    var url = "https://varmalaa.com/api/Demo/forget_password";
    print(data);
    var res = await http.post(Uri.parse(url), body: data);
    var userDetail = (json.decode(res.body));
    {
      if (jsonDecode(res.body) == "false") {
        print("error");
      } else {
        setState(() {
          message = userDetail['message'];
        });
        print(jsonDecode(res.body));
        _alerBox(message);
        print(message);
      }
    }
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
                  message != "Invalid email or mobile number."
                      ? Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (BuildContext context) => Loginpage()),
                          (Route<dynamic> route) => false)
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
        backgroundColor: primaryColor_bg,
        appBar: AppBar(
          title: Text("Forget Password"),
          centerTitle: true,
        ),
        body: val == true
            ? Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  color: primaryColor_bg,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 40),
                        child: Form(
                          key: _formKey,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(height: 15),
                                title("New Password"),
                                SizedBox(height: 5),
                                text_field("New Password",
                                    "Enter your new password", newpassword1),
                                SizedBox(height: 15),
                                title("Confirm Password"),
                                SizedBox(height: 5),
                                text_field("Confirm Password",
                                    "Enter your new password", newpassword2),
                                SizedBox(height: 50),
                                Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.90,
                                    child: btn("Update")),
                                SizedBox(
                                  height: 15,
                                ),
                              ]),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  color: primaryColor_bg,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 40),
                        child: Form(
                          key: _formKey,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(height: 15),
                                title("Enter your Whatsapp number"),
                                SizedBox(height: 5),
                                text_field("Enter your Whatsapp number",
                                    "Enter your new password", mobilenumber),
                                SizedBox(height: 50),
                                Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.90,
                                    child: btn("Submit")),
                                SizedBox(
                                  height: 15,
                                ),
                              ]),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  Padding btn(value) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: FlatButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          color: primaryColor,
          onPressed: () {
            setState(() {
              print(mobilenumber.text);
              print("---------fdfgd-----");
            });
            forget_password();
          },
          child: Container(
            child: Center(
              child: Text(value,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600)),
            ),
            height: 50,
            width: 200,
          )),
    );
  }

  Text title(value) {
    return Text(
      value,
      textAlign: TextAlign.left,
      style: TextStyle(
          fontSize: 16, color: Colors.black, fontWeight: FontWeight.w500),
    );
  }

  TextFormField text_field(hint, error, my_controller_name) {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return error;
        }

        return null;
      },
      controller: my_controller_name,
      // onSaved: (String value) {},
      // controller: oldPassword,
      obscureText: false,
      style: TextStyle(
        fontSize: 16.0,
        color: Colors.black,
      ),
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        // prefixIcon: Icon(
        //   Icons.lock_outlined,
        //   color: primaryColor,
        // ),
        fillColor: Colors.white,
        filled: true,
        contentPadding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
        hintText: (hint),
        hintStyle: TextStyle(
          color: Colors.grey,
          fontSize: 14.0,
        ),
        border: new OutlineInputBorder(
          borderSide: new BorderSide(color: primaryColor, width: 1.0),
          borderRadius: BorderRadius.circular(10.0),
        ),
        focusedErrorBorder: new OutlineInputBorder(
          borderSide: BorderSide(color: primaryColor, width: 1.0),
          borderRadius: BorderRadius.circular(10.0),
        ),
        errorBorder: new OutlineInputBorder(
          borderSide: new BorderSide(color: primaryColor, width: 1.5),
          borderRadius: BorderRadius.circular(10.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: primaryColor, width: 1.0),
          borderRadius: BorderRadius.circular(10.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: primaryColor, width: 1.0),
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
}
