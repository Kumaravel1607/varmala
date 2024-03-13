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

class tab2 extends StatefulWidget {
  const tab2({Key? key}) : super(key: key);

  @override
  _tab2State createState() => _tab2State();
}

class _tab2State extends State<tab2> {
  bool _loading = true;
  var my_controller_name = TextEditingController();
  var fatherName = TextEditingController();
  var fatherOccupation = TextEditingController();
  var motherName = TextEditingController();
  var motherOccupation = TextEditingController();
  var aboutFamily = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String astro = "";
  List bro_sis_number = [];
  List family_type = [];
  List religion = [];
  List community = [];
  List caste = [];
  List name = [];

  // String fatherName = "";

  String brotherNo = "";
  String sisterNo = "";

  String familyType = "";
  String _religion = "";
  String _community = "";
  String _caste = "";
  @override
  void initState() {
    super.initState();
    getDropdownValues();
    PersonalDetails("1");
  }

  PersonalDetails(profile) async {
    final r = RetryOptions(maxDelay: Duration(seconds: 10), maxAttempts: 4);

    try {
      await r.retry(
        () async {
          Service.tab_details("2").then((tab2_details) {
            setState(() {
              _loading = false;
              fatherName.text = tab2_details['father_name'];
              fatherOccupation.text = tab2_details['father_occupation'];
              motherName.text = tab2_details['mother_name'];
              motherOccupation.text = tab2_details['mother_occupation'];
              aboutFamily.text = tab2_details['about_family'];
              brotherNo = tab2_details['brother_no'];
              sisterNo = tab2_details['sister_no'];
              familyType = tab2_details['family_type'];
              _religion = tab2_details['religion'];
              _community = tab2_details['community'];
              _caste = tab2_details['caste'];
              _loading = false;
            });
          });
        },
        retryIf: (e) => e is SocketException || e is TimeoutException,
      );
    } finally {}
  }

  Future<String> getDropdownValues() async {
    Map data = {"profile": "2"};

    var url = "https://varmalaa.com/api/Demo/option_list";
    print(url);
    var response = await http.post(Uri.parse(url), body: data);
    var userDetail = (json.decode(response.body));
    print(userDetail);
    print("___________________________________________________________");
    // print(userDetail);
    setState(() {
      bro_sis_number = userDetail['bro_sis_number'];
      family_type = userDetail['family_type'];
      religion = userDetail['religion_status'];
      community = userDetail['community'];
      caste = userDetail['caste'];
    });
    _loading = false;
    return "Success";
  }

  void update_profile() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    var id = _pref.getString("id");
    Map data = {
      'id': id,
      'profile': "2",
      'father_name': fatherName.text,
      'father_occupation': fatherOccupation.text,
      'mother_name': motherName.text,
      'mother_occupation': motherOccupation.text,
      'brother_no': brotherNo != null ? brotherNo : "",
      'sister_no': sisterNo != null ? sisterNo : "",
      'about_family': aboutFamily.text,
      'family_type': familyType != null ? familyType : "",
      'religion': _religion != null ? _religion : "",
      'community': _community != null ? _community : "",
      'caste': _caste != null ? _caste : "",
    };

    print(data);
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
                      title("Father's Name"),
                      textform(fatherName, 0),
                      title("Father's Occupation"),
                      textform(fatherOccupation, 0),
                      title("Mother’s Name"),
                      textform(motherName, 0),
                      title("Mother’s Occupation"),
                      textform(motherOccupation, 0),
                      //SizedBox(height: 10),
                      title("Number of Brother"),
                      SizedBox(height: 5),
                      Drop_down(bro_sis_number, "isBrother",
                          brotherNo == null ? "0" : brotherNo, 1),
                      SizedBox(height: 10),
                      title("Number Of sisters"),
                      SizedBox(height: 5),
                      Drop_down(bro_sis_number, "isSister",
                          sisterNo == null ? "0" : sisterNo, 1),
                      SizedBox(height: 10),
                      title("About Family"),
                      textform(aboutFamily, 0),
                      // SizedBox(height: 10),
                      title("Family Type"),
                      SizedBox(height: 5),
                      Drop_down(family_type, "familytype", familyType, 1),
                      SizedBox(height: 10),
                      title("Religion"),
                      SizedBox(height: 5),
                      Drop_down(religion, "religion", _religion, 1),
                      SizedBox(height: 10),
                      title("Community/Caste"),
                      SizedBox(height: 5),
                      Drop_down(community, "community", _community, 1),
                      SizedBox(height: 10),
                      title("Gotra"),
                      SizedBox(height: 5),
                      Drop_down(caste, "caste", _caste, 1),

                      SizedBox(height: 20),
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
            if (_formKey.currentState!.validate()) {
              update_profile();
              setState(() {
                _loading = true;
              });
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
          child: Container(
            width: 300,
            child: new Text(
              item['name'].toString(),
              style: TextStyle(
                color: primaryColor,
                fontSize: 15,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        );
      }).toList(),
      onChanged: (newValue) {
        setState(() {
          if (my_controller_name == "isBrother") brotherNo = newValue!;
          if (my_controller_name == "isSister") sisterNo = newValue!;
          if (my_controller_name == "familytype") familyType = newValue!;
          if (my_controller_name == "religion") _religion = newValue!;
          if (my_controller_name == "community") _community = newValue!;
          if (my_controller_name == "caste") _caste = newValue!;
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
                borderSide: BorderSide(color: Color(0xFF842269))),
            // labelText: value,
            labelStyle: TextStyle(color: primaryColor),
            border: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFF842269))),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFF842269))),
          ),
        ),
      ),
    );
  }
}

class _gen {}
