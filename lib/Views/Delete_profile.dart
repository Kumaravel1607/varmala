import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:varamala/Controller/Sharedprefrence.dart';
import 'package:varamala/Views/Loginpage.dart';
import 'package:varamala/main.dart';

import 'Homepage.dart';
import 'const.dart';

class Delete_profile extends StatefulWidget {
  const Delete_profile({Key? key}) : super(key: key);

  @override
  _Delete_profileState createState() => _Delete_profileState();
}

class _Delete_profileState extends State<Delete_profile> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String id = "";
  bool _loading = false;
  var other = TextEditingController();
  var my_controller_name = TextEditingController();
  String reason = "1";
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

  unset_Session() async {
    final pref = await SharedPreferences.getInstance();
    await pref.clear();
  }

  void delete_profile() async {
    Map data = {
      'id': id,
      'reason': reason,
      'reason_others': other.text,
    };

    print(data);
    var url = "https://varmalaa.com/api/Demo/delete_profile";
    print(data);
    var res = await http.post(Uri.parse(url), body: data);
    {
      if (jsonDecode(res.body) == "false") {
        print("error");
      } else {
        setState(() {
          _loading = false;
          other.clear();
        });
        print("YES");
        _alerBox("Deleted Successfully.");
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
                  setState(() {
                    unset_Session();
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (BuildContext context) => Homepage()),
                        (Route<dynamic> route) => false);
                  });
                },
                child: const Text("OK"),
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return _loading == true
        ? Center(
            child: CircularProgressIndicator(
              color: primaryColor,
            ),
          )
        : Scaffold(
            backgroundColor: primaryColor_bg,
            appBar: AppBar(
              backgroundColor: primaryColor,
              centerTitle: true,
              title: Text("Delete Profile"),
            ),
            body: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                  Padding(
                    padding: const EdgeInsets.only(left: 3, top: 15),
                    child: Text("Reason For Account Delete",
                        style: TextStyle(
                            color: primaryColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w600)),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        addRadioButton("1", 'Not Enough Profiles', reason),
                        addRadioButton("2", 'Found a Match', reason),
                        addRadioButton("3", 'Others', reason),
                        Container(
                          child: reason == "3"
                              ? text_field(
                                  "Reason", "Please check this field", other)
                              : SizedBox(),
                        )
                      ],
                    ),
                  ),
                  btn()
                ],
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
              delete_profile();
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
              child: Text("Delete",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600)),
            ),
            height: 50,
            width: 150,
          )),
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

  Row addRadioButton(String btnValue, String title, my_controller_name) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Radio(
            activeColor: primaryColor,
            value: btnValue,
            groupValue: my_controller_name,
            onChanged: (value) {
              setState(() {
                print(value.toString());
                reason = value.toString();
              });
            }),
        // Radio(
        //   activeColor:
        //   value: gender[btnValue],
        //   groupValue: select,
        //   onChanged: (value) {
        //     setState(() {
        //       print(value);
        //     });
        //   },
        // ),
        Text(title)
      ],
    );
  }
}
