import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:varamala/Controller/Sharedprefrence.dart';
import 'package:varamala/Model/Country.dart';
import 'package:varamala/Controller/Service.dart';
import 'package:varamala/Model/State.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:varamala/Views/Homepage.dart';
import 'package:varamala/Views/Loginpage.dart';
import 'package:varamala/Views/Terms&conditions.dart';
import 'package:varamala/Views/const.dart';
import 'dart:convert';

import 'Frontpage.dart';

enum SingingCharacter { male, female }

class Singup extends StatefulWidget {
  @override
  _SingupState createState() => _SingupState();
}

class _SingupState extends State<Singup> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool signin = true;
  bool processing = false;
  bool termscondition = false;
  String error = "";
  String _state = "";
  String _gen = "m";
  void initState() {
    super.initState();
    countrylist = [];
    _getcou();
    _get_state_list("96", 1);
  }

  void userSignIn() async {
    setState(() {
      processing = true;
    });
    var url = "https://varmalaa.com/api/Demo/create";
    var data = {
      "firstname": fristname.text,
      "lastname": lastname.text,
      "email": email.text,
      "mobile": contact.text,
      "whatsapp": whatsapp.text,
      "gender": _gen,
      "dob": formatter.format(selectedDate),
      "country": _country,
      "state": _state,
      "city": city.text,
      "password": pass.text,
    };
    print(data);
    var res = await http.post(Uri.parse(url), body: data);
    var results = jsonDecode(res.body);
    print(results);
    if (res.statusCode == 200) {
      setState(() {
        processing = false;
      });
      signin = true;
      var message = results['message'];
      _alerBox(message, 1);
    } else if (res.statusCode == 202) {
      setState(() {
        processing = false;
      });
      var message = results['message'];
      _alerBox(message, 2);
      signin = false;
    } else {
      setState(() {
        processing = false;
      });
      signin = false;
    }
  }

  Future<void> _alerBox(message, redirect) async {
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text(message),
            //title: Text(),
            actions: <Widget>[
              OutlinedButton(
                onPressed: () {
                  if (redirect == 1) {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (BuildContext context) => Loginpage()),
                        (Route<dynamic> route) => false);
                  } else
                    Navigator.pop(context, "ok");
                },
                child: const Text("OK"),
              )
            ],
          );
        });
  }

  _getcou() {
    print("ddd");
    Service.getc().then((users) {
      setState(() {
        countrylist = users;
      });

      print(countrylist.length);
    });
  }

  _get_state_list(country, chnage_1) {
    print("number" + country);
    Service.get_state_list(country).then((state_data) {
      setState(() {
        print("-------v----------");
        print(statelist);
        print("-------v----------");
        statelist = state_data;
        // if (chnage_1 == 1) {
        //   statelist = [];
        //   _state = "";
        // }
      });
      print(statelist.length);
    });
  }

  static DateTime selectedDate = DateTime.now();
  static DateFormat formatter = DateFormat('yyyy-MM-dd');
  final String formatted = formatter.format(selectedDate);
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1970, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  static List<States> statelist = [];
  static List<Country> countrylist = [];
  TextEditingController fristname = new TextEditingController();
  TextEditingController lastname = new TextEditingController();
  TextEditingController contact = new TextEditingController();
  TextEditingController whatsapp = new TextEditingController();
  TextEditingController dob = new TextEditingController(
      text: formatter.format(selectedDate).toString());
  TextEditingController pass = new TextEditingController();
  TextEditingController email = new TextEditingController();
  TextEditingController city = new TextEditingController();
  SingingCharacter? _character = SingingCharacter.male;
  bool istext = false;
  bool iscountry = false;
  bool isstate = false;
  String countryValue = "";
  String countryid = "";
  String stateid = "";
  String gen = "";
  late String stateValue = "";
  String _country = "96";
  // String _state = "";
  //   static List<Country> countrylist = [];
  // static List<States> statelist = [];

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    String getgender(SingingCharacter name) {
      String ge = "";
      if (name == "SingingCharacter.female")
        ge = "f";
      else
        ge = "m";

      return ge;
    }

    return MaterialApp(
      home: Scaffold(
        backgroundColor: primaryColor_bg,
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
          title: Text("Sign Up"),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Form(
                key: _formKey,
                child: Column(children: [
                  Padding(
                      padding: EdgeInsets.only(left: 20, right: 20),
                      child: TextFormField(
                        controller: fristname,
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
                          labelText: 'Frist Name',
                        ),
                        validator: (value) {
                          if (value == "") {
                            return 'This field is requrired';
                          }
                          return null;
                        },
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                      padding: EdgeInsets.only(left: 20, right: 20),
                      child: TextFormField(
                        controller: lastname,
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
                          labelText: 'Last Name',
                        ),
                        validator: (value) {
                          if (value == "") {
                            return 'This field is requrired';
                          }
                          return null;
                        },
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                      padding: EdgeInsets.only(left: 20, right: 20),
                      child: TextFormField(
                        controller: contact,
                        keyboardType: TextInputType.phone,
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
                          labelText: 'Contact Number',
                        ),
                        validator: (value) {
                          if (value == "") {
                            return 'This field is requrired';
                          }
                          return null;
                        },
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                      padding: EdgeInsets.only(left: 20, right: 20),
                      child: TextFormField(
                        controller: whatsapp,
                        keyboardType: TextInputType.phone,
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
                          labelText: 'Whatsapp Number',
                        ),
                        validator: (value) {
                          if (value == "") {
                            return 'This field is requrired';
                          }
                          return null;
                        },
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                      padding: EdgeInsets.only(left: 20, right: 20),
                      child: TextFormField(
                        controller: email,
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
                          labelText: 'Email',
                        ),
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  (istext)
                      ? Row(
                          children: [
                            Padding(
                                padding: const EdgeInsets.only(
                                    left: 18.0, right: 18.0, top: 8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(color: primaryColor),
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(5)),
                                  height: 50,
                                  width: 275,
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.only(top: 15, left: 5),
                                    child: Text(
                                      formatter.format(selectedDate).toString(),
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                )),
                            IconButton(
                              onPressed: () {
                                _selectDate(context);
                              },
                              icon: Icon(
                                Icons.calendar_today,
                                size: 30,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        )
                      : Padding(
                          padding: EdgeInsets.only(left: 20, right: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                height: 50,
                                width: 275,
                                child: TextFormField(
                                  controller: dob,
                                  keyboardType: TextInputType.datetime,
                                  decoration: InputDecoration(
                                    fillColor: Colors.white,
                                    filled: true,
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(0xFF842269))),
                                    // labelText: value,
                                    labelStyle: TextStyle(color: primaryColor),
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(0xFF842269))),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(0xFF842269))),
                                    labelText: 'Date Of Brith',
                                  ),
                                  validator: (value) {
                                    if (value == "") {
                                      return 'This field is requrired';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              IconButton(
                                onPressed: () {
                                  _selectDate(context);
                                  istext = true;
                                },
                                icon: Icon(
                                  Icons.calendar_today,
                                  color: primaryColor,
                                  size: 30,
                                ),
                              ),
                            ],
                          )),
                  SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20, top: 15),
                          child: Text("Gender",
                              style: TextStyle(
                                  color: primaryColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600)),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 30),
                          child: Row(
                            children: <Widget>[
                              addRadioButton("m", 'Male', _gen),
                              addRadioButton("f", 'Female', _gen),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  (iscountry)
                      ? Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 8.0, top: 10.0),
                              child: Text(
                                'COUNTRY',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                                padding: const EdgeInsets.only(
                                    left: 18.0, right: 18.0, top: 8.0),
                                child: Text(
                                  countryValue,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )),
                          ],
                        )
                      : Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10)),
                          child: DropdownButtonFormField<String>(
                            decoration: textDecoration("Select your country"),
                            value: _country == "" || _country == null
                                ? null
                                : _country,
                            // hint: Text("job type"),

                            style: TextStyle(fontSize: 14),
                            validator: (value) {
                              print("yes");
                              print(value);
                              if (value == "" || value == null) {
                                return 'This field is requrired';
                              }
                              return null;
                            },
                            items: countrylist.map((item) {
                              return DropdownMenuItem<String>(
                                value: item.id.toString(),
                                child: new Text(
                                  item.name,
                                  style: TextStyle(
                                      fontSize: 15, color: primaryColor),
                                ),
                              );
                            }).toList(),
                            onChanged: (newValue) {
                              setState(() {
                                print("--------------------");
                                print(newValue);
                                _get_state_list(newValue, 1);
                                _country = newValue!;
                              });
                            },
                            // validator: (value) => value == null ? 'Job Type' : null,
                          ),
                        ),
                  SizedBox(
                    height: 10,
                  ),
                  (isstate)
                      ? Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 8.0, top: 10.0),
                              child: Text(
                                'STATE',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                                padding: const EdgeInsets.only(
                                    left: 18.0, right: 18.0, top: 8.0),
                                child: Text(
                                  stateValue,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )),
                          ],
                        )
                      : Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10)),
                          child: DropdownButtonFormField<String>(
                            decoration: textDecoration("Select your state"),
                            value:
                                _state == "" || _state == null ? null : _state,
                            // hint: Text("job type"),

                            style: TextStyle(fontSize: 14),
                            validator: (value) {
                              print("yes");
                              print(value);
                              if (value == "" || value == null) {
                                return 'This field is requrired';
                              }
                              return null;
                            },
                            items: statelist.map((item) {
                              return DropdownMenuItem<String>(
                                value: item.id.toString(),
                                child: new Text(
                                  item.state_name,
                                  style: TextStyle(
                                      fontSize: 15, color: primaryColor),
                                ),
                              );
                            }).toList(),
                            onChanged: (newValue) {
                              setState(() {
                                _state = newValue!;
                              });
                            },
                            // validator: (value) => value == null ? 'Job Type' : null,
                          ),
                        ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                      padding: EdgeInsets.only(left: 20, right: 20),
                      child: TextFormField(
                        controller: city,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFF842269))),
                          // labelText: value,
                          labelStyle: TextStyle(color: primaryColor),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFF842269))),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFF842269))),
                          labelText: 'Enter City',
                        ),
                        validator: (value) {
                          if (value == "") {
                            return 'This field is requrired';
                          }
                          return null;
                        },
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                      padding: EdgeInsets.only(left: 20, right: 20),
                      child: TextFormField(
                        controller: pass,
                        obscureText: true,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFF842269))),
                          // labelText: value,
                          labelStyle: TextStyle(color: primaryColor),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFF842269))),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFF842269))),
                          labelText: 'Password',
                        ),
                        validator: (value) {
                          if (value == "") {
                            return 'This field is requrired';
                          }
                          return null;
                        },
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Checkbox(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                          activeColor: primaryColor,
                          checkColor: Colors.white,
                          fillColor: MaterialStateProperty.all(primaryColor),
                          value: termscondition,
                          onChanged: (value) async {
                            setState(() {
                              termscondition = value!;
                              print(value);
                            });
                          }),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context, rootNavigator: true).push(
                              CupertinoPageRoute(
                                  builder: (context) => terms_condition()));
                        },
                        child: Text(
                          "Terms and Conditions",
                          style: TextStyle(
                              color: primaryColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      SizedBox(
                        width: 50,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  InkWell(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        termscondition == true
                            ? userSignIn()
                            : _alerBox("Please accpect Terms and conditons", 0);
                      }
                    },
                    child: Container(
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
                                      'Sign Up',
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
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (BuildContext context) => Loginpage()),
                          (Route<dynamic> route) => false);
                    },
                    child: Text(
                      "Already have an account. Click here",
                      style: TextStyle(color: primaryColor, fontSize: 16),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(error),
                ]),
              ),
            ),
          ),
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
                _gen = value.toString();
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
