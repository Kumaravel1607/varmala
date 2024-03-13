import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:varamala/Controller/Sharedprefrence.dart';

import 'const.dart';

class change_pass extends StatefulWidget {
  const change_pass({Key? key}) : super(key: key);

  @override
  _change_passState createState() => _change_passState();
}

class _change_passState extends State<change_pass> {
  String id = "";
  bool _loading = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var my_controller_name = TextEditingController();
  var oldpassword = TextEditingController();
  var newpassword1 = TextEditingController();
  var newpassword2 = TextEditingController();

  @override
  void initState() {
    super.initState();
    get_id();
  }

  get_id() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      id = pref.getString("id");
    });
  }

  void update_password() async {
    Map data = {
      'id': id,
      'old_password': oldpassword.text,
      'new_password': newpassword1.text,
      'confirm_password': newpassword2.text,
    };

    print(data);
    var url = "https://varmalaa.com/api/Demo/change_password";
    print(data);
    var res = await http.post(Uri.parse(url), body: data);
    {
      pr(res.statusCode);
      var message = jsonDecode(res.body)["message"];
      if (res.statusCode == 200) {
        setState(() {
          _loading = false;
          oldpassword.clear();
          newpassword1.clear();
          newpassword2.clear();
          _alerBox(message);
        });
      } else if (res.statusCode == 202) {
        setState(() {
          _loading = false;
          _alerBox(message);
        });
      } else {
        setState(() {
          _loading = false;
          _alerBox(message);
        });
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
                  Navigator.pop(context, "ok");
                },
                child: const Text("OK"),
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Set New Password"),
      ),
      body: _loading == true
          ? Center(
              child: CircularProgressIndicator(
                color: primaryColor,
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
                              title("Old Password"),
                              SizedBox(height: 5),
                              text_field("Old Password",
                                  "Enter your old password", oldpassword),
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
                                  width:
                                      MediaQuery.of(context).size.width * 0.90,
                                  child: btn()),
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
    );
  }

  Padding btn() {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: FlatButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          color: primaryColor,
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              update_password();
              setState(() {
                _loading = true;
              });
              // print("dd");
              // _isLoading = true;
              // update_profile();
            }
          },
          child: Container(
            child: Center(
              child: Text("Update",
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
