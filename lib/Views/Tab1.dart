import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:retry/retry.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:varamala/Controller/Service.dart';
import 'package:varamala/Controller/Sharedprefrence.dart';
import 'const.dart';

class tab1 extends StatefulWidget {
  const tab1({Key? key}) : super(key: key);

  @override
  _tab1State createState() => _tab1State();
}

class _tab1State extends State<tab1> {
  bool _isLoading = true;
  var my_controller_name = TextEditingController();
  var birth_city = TextEditingController();
  var birth_hrs = TextEditingController();
  var birth_min = TextEditingController();
  var description = TextEditingController();

  get countrylist => null;
  String astro_sel = "";
  String marital_sel = "";
  String colour_sel = "";
  String birth_state_sel = "";
  String height_sel = "";
  String weight_sel = "";

  List astro_stauts = [];
  List marital_stauts = [];
  List height = [];
  List marital_status = [];
  List complexion = [];
  List birth_state = [];
  List weight = [];
  List birth_time = [];
  String disability = "";
///////////////////////////////
  List options_data = [];
  String birthcity = "";
  String birthHrs = "";
  String birthMin = "";
  String Description = "";

  @override
  void initState() {
    super.initState();
    getDropdownValues();
    Tabprofileinfo();
  }

  Tabprofileinfo() async {
    final r = RetryOptions(maxDelay: Duration(seconds: 10), maxAttempts: 4);

    print("object");
    try {
      await r.retry(
        () async {
          Service.profileinfo("1").then((tab1_details) {
            print("3333333333");
            print(tab1_details.astroStatus);
            setState(() {
              astro_sel = tab1_details.astroStatus;
              marital_sel = tab1_details.maritalStatus;
              colour_sel = tab1_details.colourStatus;
              birth_state_sel = tab1_details.birthState;
              height_sel = tab1_details.height;
              weight_sel = tab1_details.weight;
              birthcity = tab1_details.birthCity;
              birthHrs = tab1_details.birthHr;
              birthMin = tab1_details.birthTime;
              disability = tab1_details.disability;
              Description = tab1_details.description;

              description.text = Description;

              birth_city.text = tab1_details.birthCity;

              // birth_hrs.text = birthMin.substring(3, 5);
              // birth_min.text = birthMin.substring(0, 2);
              disability = tab1_details.disability;
              print(birthMin);
              if (birthMin != null) {
                var birthMin_a = birthMin.split(':');
                birth_hrs.text = birthMin_a[0];
                birth_min.text = birthMin_a[1];
              }

              // birthcity = tab1_details['birth_city'];

              _isLoading = false;
            });
          });
        },
        retryIf: (e) => e is SocketException || e is TimeoutException,
      );
    } finally {}
  }

  Future<String> getDropdownValues() async {
    Map data = {'profile': 1};

    var url = api_url + "option_list";
    // print(url);
    var response = await http.post(Uri.parse(url), body: {"profile": "1"});
    var userDetail = (json.decode(response.body));

    // print(userDetail);
    setState(() {
      astro_stauts = userDetail['astro'];
      marital_stauts = userDetail['marital'];
      complexion = userDetail['colour'];
      birth_state = userDetail['states_list'];
      height = userDetail['height'];
      // disability = userDetail['disability'];
      weight = userDetail['weight'];
    });
    _isLoading = false;
    return "Success";
  }

  void update_profile() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    var id = _pref.getString("id");
    Map data = {
      'id': id,
      'profile': "1",
      'astro_status': astro_sel == null ? "" : astro_sel,
      'marital_status': marital_sel == null ? "" : marital_sel,
      'colour_status': colour_sel == null ? "" : colour_sel,
      'birth_state': birth_state_sel == null ? "" : birth_state_sel,
      'height': height_sel == null ? "" : height_sel,
      'weight': weight_sel == null ? "" : weight_sel,
      'birth_city': birth_city.text,
      'disability': disability == null ? "" : disability,
      'birth_hr': birthHrs == null ? "" : birthHrs,
      'birth_time': birthMin == null ? "" : birthMin,
      'description': description.text,
    };

    print(jsonEncode(data));

    var url = "https://varmalaa.com/api/Demo/profile_update";
    print(data);
    var res = await http.post(Uri.parse(url), body: data);
    {
      print(jsonDecode(res.body));
      if (jsonDecode(res.body) == "false") {
        print("error");
      } else {
        setState(() {
          _isLoading = false;
        });
        print(jsonDecode(res.body));
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

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor.withOpacity(0.05),
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
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      title("Astro Status"),
                      Drop_down(astro_stauts, "astro", astro_sel, 1),
                      SizedBox(
                        height: 15,
                      ),
                      title("Mariage Status"),
                      Drop_down(marital_stauts, "marital", marital_sel, 1),
                      SizedBox(
                        height: 15,
                      ),
                      title("Complexion"),
                      Drop_down(complexion, "colour", colour_sel, 1),
                      SizedBox(
                        height: 15,
                      ),
                      title("Birth City"),
                      textform("", birth_city, 1),
                      SizedBox(
                        height: 15,
                      ),
                      title("Birth State"),
                      Drop_down(birth_state, "states_list", birth_state_sel, 1),
                      SizedBox(
                        height: 15,
                      ),
                      title("Height"),
                      Drop_down(height, "height", height_sel, 1),
                      SizedBox(
                        height: 15,
                      ),
                      title("Weight"),
                      Drop_down(weight, "weight", weight_sel, 1),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 3, top: 15),
                            child: Text("Disability/Handicapped",
                                style: TextStyle(
                                    color: primaryColor,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600)),
                          ),
                          Row(
                            children: <Widget>[
                              addRadioButton("1", 'None', disability),
                              addRadioButton(
                                  "2", 'Physically Disabled', disability),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            row_text("Birth Hrs", birth_hrs),
                            SizedBox(width: 30),
                            row_text("Birth Min", birth_min),
                            SizedBox(width: 30),
                            row_dropdown("Birth Time")
                          ],
                        ),
                      ),
                      about_form("About Your Self", description),
                      btn()
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  DropdownButtonFormField<String> Drop_down(
    List options,
    controller_name,
    selected_val,
    required,
  ) {
    print(controller_name);
    return DropdownButtonFormField<String>(
      decoration: textDecoration(""),
      value: selected_val != "" ? selected_val : null,
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
          if (controller_name == "astro") astro_sel = newValue!;
          if (controller_name == "marital") marital_sel = newValue!;
          if (controller_name == "colour") colour_sel = newValue!;
          if (controller_name == "states_list") birth_state_sel = newValue!;
          if (controller_name == "height") height_sel = newValue!;
          if (controller_name == "weight") weight_sel = newValue!;
          // var keyPair = {
          //   'Key': controller_name,
          //   'value': newValue,
          // };
          // options_data.add(keyPair);
          // print(options_data);

          // var index =
          //     options_data.indexWhere((pair) => pair['Key'] == "astro");
          // if (index > 0) var astra = options_data[index]['value'];
        });
      },
      validator: (value) {
        if (required == 1) {
          // print(value);
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

  Padding about_form(title, TextEditingController comment) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
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
            controller: comment,
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

  Padding btn() {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: FlatButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          color: primaryColor,
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              // print("dd");

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

  Expanded row_dropdown(title) {
    return Expanded(
      flex: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
                fontSize: 14, color: primaryColor, fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 10),
          DropdownButtonFormField<String>(
            value: birthHrs == null || birthHrs == "" ? null : birthHrs,
            decoration: textDecoration(""),
            items: <String>['am', 'pm'].map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: new Text(value),
              );
            }).toList(),
            onChanged: (newValue) {
              birthHrs = newValue!;
            },
          ),
        ],
      ),
    );
  }

  Expanded row_text(title, bh_controller) {
    return Expanded(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
              fontSize: 14, color: primaryColor, fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 10),
        Container(
          height: 50,
          child: TextFormField(
            controller: bh_controller,
            decoration: InputDecoration(
                fillColor: Colors.white,
                filled: true,
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: primaryColor)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: primaryColor)),
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: primaryColor))),
          ),
        ),
      ],
    ));
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
                disability = value.toString();
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

  Padding textform(value, my_controller_name, required) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 0),
      child: Container(
        height: 50,
        child: TextFormField(
          controller: my_controller_name,
          validator: (value) {
            if (required == 1) {
              if (value == "") {
                return 'This field is requrired';
              }
              setState(() {
                _isLoading = true;
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
                borderSide: BorderSide(color: Color(0xFF842269))),
            labelText: value,
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
