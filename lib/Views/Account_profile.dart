import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:retry/retry.dart';
import 'package:varamala/Controller/Service.dart';
import 'package:varamala/Model/Country.dart';
import 'package:varamala/Model/State.dart';

import 'const.dart';

class Account extends StatefulWidget {
  Account({Key? key}) : super(key: key);

  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  DateTime selectedDate = DateTime.now();
  DateTime currentDate = DateTime.now();

  void _selectYear1() async {
    final DateTime? newYear = await showDatePicker(
      context: context,
      initialEntryMode: DatePickerEntryMode.calendar,
      initialDatePickerMode: DatePickerMode.year,
      initialDate: DateTime.now(),
      firstDate: DateTime(DateTime.now().year - 80, 1),
      lastDate: DateTime.now(),
    );
    if (newYear != null) {
      // selectedYear = newYear.year;
      setState(() {
        final selectedDate = new DateFormat('yyyy-MM-dd');
        String newVal = selectedDate.format(newYear);
        Birth_date.text = newVal;
      });
    }
    // print("-----------------NK----------");
    print(newYear);
  }

  bool _isLoading = true;

  String member_id = "";
  String firstname = "";
  String lastname = "";
  String mobileno = "";
  String whats_app = "";
  String mailid = "";
  String dob = "";
  String _gen = "";
  String _country = "";
  String _state = "";
  String _city = "";

  List gender = ["Male", "Female", "Other"];
  static List<Country> countrylist = [];
  static List<States> statelist = [];

  String countryValue = "";
  String stateValue = "";
  final first_name = TextEditingController();
  final last_name = TextEditingController();
  final mobile = TextEditingController();
  final whatsapp = TextEditingController();
  final mail_id = TextEditingController();
  final Birth_date = TextEditingController();
  // final _gender = TextEditingController();

  // final country = TextEditingController();
  // final state = TextEditingController();
  final city = TextEditingController();
  // final pass1 = TextEditingController();
  // final pass2 = TextEditingController();

  late String select;

  @override
  void initState() {
    // TODO: implement initState
    // first_name.text = firstname;
    // last_name.text = "G";
    _getcou();
    get_acc_details();
  }

  _getcou() {
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
        statelist = state_data;
        // print("dd");
        print(chnage_1);
        if (chnage_1 != "" || chnage_1 != null) {
          _state = chnage_1;
        }
      });
      print(statelist.length);
    });
  }

  void update_account() async {
    Map data = {
      'id': member_id,
      'first_name': first_name.text,
      'last_name': last_name.text,
      'mobile': mobile.text,
      'whatapp_no': whatsapp.text,
      // 'gender': _gen,
      'dob': Birth_date.text,
      'country': _country,
      'state': _state,
      'city': city.text,
      'email': mail_id.text,
    };

    var url = "https://varmalaa.com/api/Demo/account_info_update";
    print(data);
    var res = await http.post(Uri.parse(url), body: data);
    {
      if (jsonDecode(res.body) == "false") {
        print("error");
      } else {
        _isLoading = false;
        print("YES");
        _alerBox("Update Successfully");
      }
    }
  }

  Future<void> _alerBox(message) async {
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return _isLoading == true
              ? Container(
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(
                    backgroundColor: primaryColor,
                    valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                )
              : AlertDialog(
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

  get_acc_details() async {
    final r = RetryOptions(maxDelay: Duration(seconds: 10), maxAttempts: 4);
    try {
      await r.retry(
        () async {
          Service.account_profile().then((user_acc_details) {
            print(user_acc_details);
            setState(() {
              member_id = user_acc_details.id;
              firstname = user_acc_details.firstName;
              lastname = user_acc_details.lastName;
              mobileno = user_acc_details.mobile;
              whats_app = user_acc_details.whatappNo;
              mailid = user_acc_details.email;
              dob = user_acc_details.dob;
              _gen = user_acc_details.gender;
              _country = user_acc_details.country;

              _city = user_acc_details.city;
              //////////////////////////
              first_name.text = firstname;
              last_name.text = lastname;
              mobile.text = mobileno;
              whatsapp.text = whats_app;
              mail_id.text = mailid;
              city.text = _city;
              Birth_date.text = dob;
              // country.text = _country;
              // state.text = _state;
              // city.text = _city;
              var sle_state = user_acc_details.state;
              if (_country != "") {
                _get_state_list(_country, sle_state);
                _state = sle_state;
              }
              _isLoading = false;
            });
          });
        },
        retryIf: (e) => e is SocketException || e is TimeoutException,
      );
    } finally {}
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigator.pop(context);
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: primaryColor_bg,
        appBar: AppBar(
            backgroundColor: primaryColor,
            title: Text("Update Account"),
            centerTitle: true),
        body: _isLoading == true
            ? Container(
                alignment: Alignment.center,
                child: CircularProgressIndicator(
                  backgroundColor: primaryColor,
                  valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    child: Column(
                      children: [
                        textform("First Name", first_name, 1, 0),
                        textform("Last Name", last_name, 1, 0),
                        textform("Contact Number", mobile, 0, 1),
                        textform("Whatsapp Number", whatsapp, 0, 0),
                        textform("Mail id", mail_id, 0, 0),
                        textform_date("Date-of-Birth", Birth_date, 0, 0),
                        //  textform("Age", age, 0),

                        //Use the above widget where you want the radio button
                        // Column(
                        //   crossAxisAlignment: CrossAxisAlignment.start,
                        //   children: [
                        //     Padding(
                        //       padding: const EdgeInsets.only(left: 3, top: 15),
                        //       child: Text("Gender",
                        //           style: TextStyle(
                        //               color: Colors.purple,
                        //               fontSize: 18,
                        //               fontWeight: FontWeight.w600)),
                        //     ),
                        //     Row(
                        //       children: <Widget>[
                        //         addRadioButton("m", 'Male', _gen),
                        //         addRadioButton("f", 'Female', _gen),
                        //       ],
                        //     ),
                        //   ],
                        // ),
                        DropdownButtonFormField<String>(
                          decoration: textDecoration(_country),
                          value: _country == "" || _country == null
                              ? null
                              : _country,
                          // hint: Text("job type"),

                          style: TextStyle(fontSize: 14),
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
                              _get_state_list(newValue, "");
                              _country = newValue!;
                            });
                          },
                          // validator: (value) => value == null ? 'Job Type' : null,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        DropdownButtonFormField<String>(
                          decoration: textDecoration(_state),
                          value: _state == "" || _state == null ? null : _state,
                          // hint: Text("job type"),

                          style: TextStyle(fontSize: 14),
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
                        SizedBox(height: 10),

                        textform("City Name", city, 0, 0),
                        button(),
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }

  Padding button() {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: FlatButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          color: primaryColor,
          onPressed: () {
            _isLoading = true;
            // print("clicked");

            if (_formKey.currentState!.validate()) {
              update_account();
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

  Row addRadioButton(String btnValue, String title, my_controller_name) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Radio(
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

  Padding textform(
      value, TextEditingController my_controller_name, required, en) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        enabled: en == 0 ? true : false,
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
          labelText: value,
          labelStyle: TextStyle(color: primaryColor),
          border: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF842269))),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF842269))),
        ),
      ),
    );
  }

  Padding textform_date(
      value, TextEditingController my_controller_name, required, en) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        onTap: _selectYear1,
        enabled: en == 0 ? true : false,
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
          labelText: value,
          labelStyle: TextStyle(color: primaryColor),
          border: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF842269))),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF842269))),
        ),
      ),
    );
  }
}
