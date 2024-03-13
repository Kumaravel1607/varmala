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

class tab4 extends StatefulWidget {
  const tab4({Key? key}) : super(key: key);

  @override
  _tab4State createState() => _tab4State();
}

class _tab4State extends State<tab4> {
  bool _loading = true;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var my_controller_name = TextEditingController();
  var my_controller = TextEditingController();
  var mycontroller_name = TextEditingController();
  var mycontrollername = TextEditingController();
  var hobbies = TextEditingController();

  String astro = "";
  List name = [];
  List _diet = [];

  String isSmoking = "";
  String diet = "";
  String isDrink = "";

  @override
  void initState() {
    super.initState();
    getDropdownValues();
    PersonalDetails("4");
  }

  PersonalDetails(profile) async {
    final r = RetryOptions(maxDelay: Duration(seconds: 10), maxAttempts: 4);

    try {
      await r.retry(
        () async {
          Service.tab_details(profile).then((tab4_details) {
            setState(() {
              _loading = false;

              diet = tab4_details['diet'];
              isSmoking = tab4_details['is_smoking'];
              hobbies.text = tab4_details['hobbies'];
              isDrink = tab4_details['is_drink'];
            });
          });
        },
        retryIf: (e) => e is SocketException || e is TimeoutException,
      );
    } finally {}
  }

  Future<String> getDropdownValues() async {
    Map data = {"profile": "4"};

    var url = "https://varmalaa.com/api/Demo/option_list";
    print(url);
    var response = await http.post(Uri.parse(url), body: data);
    var userDetail = (json.decode(response.body));
    print(userDetail);
    print("___________________________________________________________");
    // print(userDetail);
    setState(() {
      _diet = userDetail['diet_status'];
      // income = userDetail['income_status'];
      // nationality = userDetail['nationality_status'];
    });
    _loading = false;
    return "Success";
  }

  void update_profile() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    var id = _pref.getString("id");

    Map data = {
      'id': id,
      'profile': "4",
      'hobbies': hobbies.text != null ? hobbies.text : "",
      'diet': diet != null ? diet : "",
      'is_smoking': isSmoking != null ? isSmoking : "",
      'is_drink': isDrink != null ? isDrink : "",
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
                      title("Diet"),
                      SizedBox(height: 5),
                      Drop_down(_diet, "diet", diet, 1),
                      SizedBox(height: 10),
                      title("Hobbies"),
                      textform(hobbies, 1),
                      SizedBox(height: 5),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 3, top: 15),
                            child: Text("Smoking",
                                style: TextStyle(
                                    color: primaryColor,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600)),
                          ),
                          Row(
                            children: <Widget>[
                              addRadioButton("1", 'Yes', isSmoking),
                              addRadioButton("2", 'No', isSmoking),
                            ],
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 3, top: 15),
                            child: Text("Drinking",
                                style: TextStyle(
                                    color: primaryColor,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600)),
                          ),
                          Row(
                            children: <Widget>[
                              addRadioButton1("1", 'Yes', isDrink),
                              addRadioButton1("2", 'No', isDrink),
                            ],
                          ),
                        ],
                      ),
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
            if (_formKey.currentState!.validate()) {
              update_profile();
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

  Row addRadioButton(String btnValue, String title, my_controller) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Radio(
            value: btnValue,
            groupValue: my_controller,
            onChanged: (value) {
              setState(() {
                print(value.toString());
                isSmoking = value.toString();
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

  Row addRadioButton1(String btnValue, String title, mycontroller_name) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Radio(
            value: btnValue,
            groupValue: mycontroller_name,
            onChanged: (value) {
              setState(() {
                print(value.toString());
                isDrink = value.toString();
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
          if (my_controller_name == "diet") diet = newValue!;
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

  Padding textform(mycontrollername, required) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0),
      child: Container(
        height: 50,
        child: TextFormField(
          controller: mycontrollername,
          validator: (value) {
            if (required == 1) {
              if (value == "") {
                return 'This field is requrired';
              }
              setState(() {
                _loading = true;
              });
              return null;
            } else {
              return null;
            }
          },
          decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFF844469))),
            // labelText: value,
            labelStyle: TextStyle(color: primaryColor),
            border: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFF844469))),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFF844469))),
          ),
        ),
      ),
    );
  }
}
