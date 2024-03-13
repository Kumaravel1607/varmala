import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:retry/retry.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:varamala/Controller/Service.dart';
import 'package:varamala/Controller/Sharedprefrence.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:varamala/Model/Country.dart';
import 'package:varamala/Model/Personal_preferance_option.dart';

import 'Dropdownselect.dart';
import 'const.dart';

class tab5 extends StatefulWidget {
  const tab5({Key? key}) : super(key: key);

  @override
  _tab5State createState() => _tab5State();
}

class _tab5State extends State<tab5> {
  bool _loading = true;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  static List<OptionList> education_1 = [];
  static List<OptionList> occupation_1 = [];

  static List<OptionList> inteducation = [];

  var my_controller_name = TextEditingController();
  var my_controller = TextEditingController();
  var _location = TextEditingController();
  String astro = "";
  List occupation = [];
  List<String> education = [];
  List nationality = [];
  List income = [];
  List name = [];
  List education_new = [];

  List education_list = [];
  List occupation_list = [];
  List partnerOccupation = [];
  String partnerEducation = "";
  String partnerNation = "";

  String partnerIncome = "";

  List partner_education_res = [];
  List partner_occupation_res = [];
  List select_education = [];
  List select_occucaption = [];

  @override
  void initState() {
    super.initState();

    getDropdownValues();

    // option_list();
  }

  PersonalDetails(profile) async {
    final r = RetryOptions(maxDelay: Duration(seconds: 10), maxAttempts: 4);

    try {
      await r.retry(
        () async {
          Service.tab_details(profile).then((tab5_details) {
            setState(() {
              print("ok");

              _location.text = tab5_details['partner_location'];

              print(partnerEducation);
              partnerIncome = tab5_details['partner_income'];
              partnerNation = tab5_details['partner_nation'];
              //r partnerOccupation = tab5_details['partner_occupation'];

              partner_education_res = tab5_details['partner_education'];

              partner_occupation_res = tab5_details['partner_occupation'];

              print("dddddddddddd");
              print(education_1);
              print("1111111111");
              for (var i = 0; i < partner_education_res.length; i++) {
                var pid = partner_education_res[i];
                int index = education_1.indexWhere((item) => item.id == pid);
                select_education.add(education_1[index]);
              }
              print(select_education);

              for (var i = 0; i < partner_occupation_res.length; i++) {
                var pid = partner_occupation_res[i];
                int index = occupation_1.indexWhere((item) => item.id == pid);
                select_occucaption.add(occupation_1[index]);
              }

              _loading = false;
              print(select_occucaption);

              // OpionRes(jsonEncode(userDetail['educations']));
            });
          });
        },
        retryIf: (e) => e is SocketException || e is TimeoutException,
      );
    } finally {}
  }

  Future<String> getDropdownValues() async {
    Map data = {"profile": "5"};

    var url = "https://varmalaa.com/api/Demo/option_list";
    // print(url);
    var response = await http.post(Uri.parse(url), body: data);
    var userDetail = (json.decode(response.body));
    // print(userDetail);
    // print("___________________________________________________________");
    // print(userDetail);
    setState(() {
      // occupation = userDetail['occupation'];
      income = userDetail['income_status'];
      nationality = userDetail['nationality_status'];

      print("eee");
      print(userDetail['educations']);
      education_1 = OpionRes(jsonEncode(userDetail['educations']));
      occupation_1 = OpionRes(jsonEncode(userDetail['occupation']));
      print(education_1);
      PersonalDetails("5");

      //education_1[0].id;

      // print(education_new[0]);
      // for (var edu in education_new) {
      //   education.add({'id': edu['id'], 'name': edu['name']});
      // }
    });
    _loading = false;
    return "Success";
  }

  static List<OptionList> OpionRes(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<OptionList>((json) => OptionList.fromJson(json)).toList();
  }

  final _items = education_1
      .map((edu) => MultiSelectItem<OptionList>(edu, edu.name))
      .toList();
  final _items2 = occupation_1
      .map((edu) => MultiSelectItem<OptionList>(edu, edu.name))
      .toList();

  void update_profile() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    var id = _pref.getString("id");
    Map data = {
      'id': id,
      'profile': "5",
      'partner_occupation':
          occupation_list.length > 0 ? occupation_list.join(",") : "",
      'partner_education':
          education_list.length > 0 ? education_list.join(",") : "",
      'partner_nation': partnerNation != null ? partnerNation : "",
      'partner_location': _location.text != null ? _location.text : "",
      'partner_income': partnerIncome != null ? partnerIncome : "",
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

  // static List<Country> countrylist = [];

  // final _items = countrylist
  //     .map((animal) => MultiSelectItem<Country>(animal, animal.name))
  //     .toList();

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
                      title("Occupation"),
                      SizedBox(height: 5),
                      OutlineButton(
                          highlightColor: Colors.white,
                          color: Colors.white,
                          disabledBorderColor: Colors.white,
                          borderSide: BorderSide(color: primaryColor),
                          onPressed: () {
                            _showMultiSelect2(context);
                          },
                          child: Container(
                              height: 50,
                              width: double.infinity,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "Select Occupation ",
                                    style: TextStyle(color: primaryColor),
                                  ),
                                  Icon(Icons.arrow_drop_down_outlined)
                                ],
                              ))),

                      SizedBox(height: 10),
                      title("Education"),
                      SizedBox(height: 5),
                      OutlineButton(
                          highlightColor: Colors.white,
                          color: Colors.white,
                          disabledBorderColor: Colors.white,
                          borderSide: BorderSide(color: primaryColor),
                          onPressed: () {
                            _showMultiSelect(context);
                          },
                          child: Container(
                              // color: Colors.white,
                              height: 50,
                              width: double.infinity,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "Select Education",
                                    style: TextStyle(color: primaryColor),
                                  ),
                                  Icon(Icons.arrow_drop_down_outlined)
                                ],
                              ))),
                      // Drop_down(
                      //     education, "partner_education", partnerEducation, 1),
                      SizedBox(height: 10),
                      title("Preferred Nationality"),
                      SizedBox(height: 5),
                      Drop_down(
                          nationality, "partner_nation", partnerNation, 1),
                      SizedBox(height: 10),
                      title("Location/Other Details"),
                      Container(height: 90, child: textform(_location, 1)),
                      title("Expected Income"),
                      SizedBox(height: 5),
                      Drop_down(income, "partner_income", partnerIncome, 1),
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
    my_controller,
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
          // if (my_controller == "partner_occupation")
          //   partnerOccupation = newValue!;
          // if (my_controller == "partner_education")
          //   partnerEducation = newValue!;
          if (my_controller == "partner_nation") partnerNation = newValue!;
          if (my_controller == "partner_income") partnerIncome = newValue!;
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

//EDU
  List _selected = [];
  void _showMultiSelect(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (ctx) {
        return MultiSelectDialog(
          items: education_1.length > 0
              ? education_1
                  .map((edu) => MultiSelectItem<OptionList>(edu, edu.name))
                  .toList()
              : [],
          initialValue: select_education.length > 0 ? select_education : [],
          onConfirm: (values) {
            print("ed");
            print(values);
            select_education = values;
            // print(inilize_partnerEducation);
            select_education.forEach((item) {
              print("${item.id} ${item.name}");

              education_list.add(item.id);
            });
            //  print(education_list.join(","));
          },
        );
      },
    );
  }

  List _selected2 = [];
  void _showMultiSelect2(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (ctx) {
        return MultiSelectDialog(
          items: occupation_1.length > 0
              ? occupation_1
                  .map((edu) => MultiSelectItem<OptionList>(edu, edu.name))
                  .toList()
              : [],
          initialValue: select_occucaption.length > 0 ? select_occucaption : [],
          onConfirm: (values) {
            print(values);
            select_occucaption = values;
            select_occucaption.forEach((item) {
              print("${item.id} ${item.name}");

              occupation_list.add(item.id);
            });
          },
        );
      },
    );
  }
}

class _gen {}
