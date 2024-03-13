import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:retry/retry.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:varamala/Controller/Service.dart';
import 'package:varamala/Controller/Sharedprefrence.dart';

import 'Dropdownselect.dart';
import 'const.dart';

class tab3 extends StatefulWidget {
  const tab3({Key? key}) : super(key: key);

  @override
  _tab3State createState() => _tab3State();
}

class _tab3State extends State<tab3> {
  bool _loading = true;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  var my_controller_name = TextEditingController();
  var my_controller = TextEditingController();
  var qualification = TextEditingController();
  var location = TextEditingController();

  String astro = "";
  List name = [];
  List income = [];
  List occupation = [];
  List nationality = [];

  String education = "";
  String _occupation = "";
  String _nationality = "";
  String _income = "";
  String jobLocation = "";
  @override
  void initState() {
    super.initState();
    getDropdownValues();
    PersonalDetails("3");
  }

  PersonalDetails(profile) async {
    final r = RetryOptions(maxDelay: Duration(seconds: 10), maxAttempts: 4);

    try {
      await r.retry(
        () async {
          Service.tab_details("3").then((tab3_details) {
            setState(() {
              _loading = false;
              qualification.text = tab3_details['education'];
              location.text = tab3_details['job_location'];
              _occupation = tab3_details['occupation'];
              _nationality = tab3_details['nationality'];
              _income = tab3_details['income'];
            });
          });
        },
        retryIf: (e) => e is SocketException || e is TimeoutException,
      );
    } finally {}
  }

  Future<String> getDropdownValues() async {
    Map data = {"profile": "3"};

    var url = "https://varmalaa.com/api/Demo/option_list";
    print(url);
    var response = await http.post(Uri.parse(url), body: data);
    var userDetail = (json.decode(response.body));
    print(userDetail);
    print("___________________________________________________________");
    // print(userDetail);
    setState(() {
      occupation = userDetail['occupation'];
      income = userDetail['income_status'];
      nationality = userDetail['nationality_status'];
    });
    _loading = false;
    return "Success";
  }

  void update_profile() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    var id = _pref.getString("id");

    Map data = {
      'id': id,
      'profile': "3",
      'education': qualification.text != null ? qualification.text : "",
      'occupation': _occupation != null ? _occupation : "",
      'nationality': _nationality != null ? _nationality : "",
      'income': _income != null ? _income : "",
      'job_location': location.text != null ? location.text : "",
    };

    print(jsonEncode(data));
    var url = "https://varmalaa.com/api/Demo/profile_update";
    print(data);
    var res = await http.post(Uri.parse(url), body: data);
    {
      if (jsonDecode(res.body) == "false") {
        print("error");
      } else {
        setState(() {
          _loading = false;
        });
        print("YES");
        _alerBox("Update Successfully");
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
      backgroundColor: primaryColor.withOpacity(0.05),
      body: _loading == true
          ? Center(
              child: CircularProgressIndicator(
                color: primaryColor,
              ),
            )
          : SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      about_form("Educational Qualification", qualification),
                      SizedBox(height: 10),
                      title("Profession/Occupation"),
                      SizedBox(height: 5),
                      Drop_down(occupation, "occupation", _occupation, 1),
                      SizedBox(height: 10),
                      title("Income (Yearly)"),
                      SizedBox(height: 5),
                      Drop_down(income, "income", _income, 1),
                      SizedBox(height: 10),
                      title("Job Location/Business Location"),
                      textform(location, 0),
                      title("Nationality"),
                      SizedBox(height: 5),
                      Drop_down(nationality, "nationality", _nationality, 1),
                      SizedBox(height: 30),
                      btn()
                    ],
                  ),
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
            update_profile();
            setState(() {
              _loading = true;
            });
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

  Padding title(value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                  color: primaryColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }

  DropdownButtonFormField<String> Drop_down(
    List options,
    my_controller_name,
    selected_val,
    required,
  ) {
    return DropdownButtonFormField<String>(
      decoration: textDecoration(astro),
      value: selected_val == "" || selected_val == null
          ? null
          : selected_val.toString(),
      style: TextStyle(fontSize: 14),
      items: options.map((item) {
        return DropdownMenuItem<String>(
          value: item["id"].toString(),
          child: new Text(
            item['name'],
            style: TextStyle(
              color: primaryColor,
              fontSize: 15,
            ),
          ),
        );
      }).toList(),
      onChanged: (newValue) {
        setState(() {
          if (my_controller_name == "occupation") _occupation = newValue!;
          if (my_controller_name == "income") _income = newValue!;
          if (my_controller_name == "nationality") _nationality = newValue!;
        });
        // setState(() {
        //   var keyPair = {
        //     'Key': controller_name,
        //     'value': newValue,
        //   };
        //   options_data.add(keyPair);
        //   print(options_data);

        //   // var index =
        //   //     options_data.indexWhere((pair) => pair['Key'] == "astro");
        //   // if (index > 0) var astra = options_data[index]['value'];
        // });
      },
      validator: (value) {
        if (required == 1) {
          print(value);
          if (value == "" || value == null) {
            return 'This field is requrired';
          }
          return null;
        } else {
          return null;
        }
      },
    );
  }

  // DropdownButtonFormField<String> dropdown() {
  //   return DropdownButtonFormField<String>(
  //     decoration: textDecoration(astro),
  //     items: <String>['A', 'B', 'C', 'D'].map((String value) {
  //       return DropdownMenuItem<String>(
  //         value: value,
  //         child: new Text(value),
  //       );
  //     }).toList(),
  //     onChanged: (_) {},
  //   );
  // }
  Padding about_form(title, my_controller) {
    return Padding(
      padding: const EdgeInsets.only(top: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
                fontSize: 14, color: primaryColor, fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 10),
          TextFormField(
            controller: my_controller,
            decoration: InputDecoration(
                // enabledBorder: OutlineInputBorder(
                //     borderSide: BorderSide(color: appcolor)),

                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: primaryColor)),
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: primaryColor)),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: primaryColor)),
                // hintText: "About Your Self . . . .",
                // hintStyle: TextStyle(color: primaryColor.withOpacity(0.9)),
                floatingLabelBehavior: FloatingLabelBehavior.always,
                fillColor: Colors.white,
                filled: true),
            minLines:
                3, // any number you need (It works as the rows for the textarea)
            keyboardType: TextInputType.multiline,
            maxLines: null,
          ),
        ],
      ),
    );
  }

  Padding textform(my_controller_name, required) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        height: 50,
        child: TextFormField(
          controller: my_controller_name,
          validator: (value) {
            if (required == 1) {
              if (value == "") {
                return 'This field is requrired';
              }
              return null;
            } else {
              return null;
            }
          },
          decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFF843369))),
            // labelText: value,
            labelStyle: TextStyle(color: primaryColor),
            border: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFF843369))),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFF843369))),
          ),
        ),
      ),
    );
  }
}
