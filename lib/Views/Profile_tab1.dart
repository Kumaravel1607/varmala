import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:retry/retry.dart';
import 'package:varamala/Controller/Service.dart';

import 'package:varamala/Views/const.dart';

class personal_tab1 extends StatefulWidget {
  String user_id = "";
  personal_tab1({required this.user_id});

  @override
  _personal_tab1 createState() => _personal_tab1();
}

class _personal_tab1 extends State<personal_tab1> {
  bool _loading = true;
  String id = "";
  String firstName = "";
  String lastName = "";
  String isPlan = "";
  String profilePhoto = "";
  String gender = "";
  String maritalStatus = "";
  String astroStatus = "";
  String colourStatus = "";
  String birthCity = "";
  String birthState = "";
  String height = "";
  String weight = "";
  String disability = "";
  String birthTime = "";
  String birthHr = "";
  String description = "";
  String dob = "";
  String mobilenumber = "";
  String whatsapp = "";
  String city = "";

  @override
  void initState() {
    super.initState();
    PersonalDetails("1");
  }

  PersonalDetails(profile) async {
    final r = RetryOptions(maxDelay: Duration(seconds: 10), maxAttempts: 4);

    print("object");
    try {
      await r.retry(
        () async {
          Service.Profile_details(profile, widget.user_id).then((details) {
            print(details);
            setState(() {
              _loading = false;
              firstName = details['first_name'];
              lastName = details['last_name'];
              profilePhoto = details['profile_photo'];
              isPlan = details['is_plan'];
              gender = details['gender'];
              maritalStatus = details['marital_status'];
              astroStatus = details['astro_status'];
              colourStatus = details['colour_status'];
              birthCity = details['birth_city'];
              birthState = details['birth_state'];
              height = details['height'];
              weight = details['weight'];
              disability = details['disability'];
              birthTime = details['birth_time'];
              birthHr = details['birth_hr'];
              description = details['description'];
              dob = details['dob'];
              mobilenumber = details['mobile'];
              whatsapp = details['whatapp_no'];
              city = details['city'];
            });
          });
        },
        retryIf: (e) => e is SocketException || e is TimeoutException,
      );
    } finally {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _loading == true
          ? Center(
              child: CircularProgressIndicator(
              color: primaryColor,
            ))
          : SingleChildScrollView(
              child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 30, bottom: 20, left: 40, right: 40),
                      child: Column(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.grey,
                            backgroundImage: NetworkImage(profilePhoto),
                            radius: 60,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Text("ID : ",
                                  style: TextStyle(
                                      color: primaryColor,
                                      fontWeight: FontWeight.w600)),
                              Text("VAR" + widget.user_id,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600)),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 180,
                          child: Text(
                            firstName + " " + lastName,
                            style: TextStyle(
                                color: primaryColor,
                                fontSize: 20,
                                fontWeight: FontWeight.w600),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          width: 180,
                          child: Text(
                            city,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.insert_invitation,
                              color: primaryColor,
                            ),
                            Text(" : " + dob,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600)),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.call,
                              color: Colors.blueAccent,
                            ),
                            Text(" : " + mobilenumber,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600))
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Image.asset(
                              "assets/Images/whatsapp.png",
                              height: 24,
                              width: 24,
                            ),
                            Text(" : " + whatsapp,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600))
                          ],
                        )
                      ],
                    )
                  ],
                ),
                divider2(),
                // SizedBox(
                //   height: 5,
                // ),
                // Padding(
                //   padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                //   child: Row(
                //     crossAxisAlignment: CrossAxisAlignment.center,
                //     children: [
                //       Expanded(
                //         child: Text("Name" + "  :  ",
                //             style: TextStyle(
                //                 color: Colors.black,
                //                 fontSize: 22,
                //                 fontWeight: FontWeight.w600)),
                //       ),
                //       Expanded(
                //         flex: 3,
                //         child: Text("Vignesh" + "Waran",
                //             style: TextStyle(
                //                 color: primaryColor,
                //                 fontSize: 22,
                //                 fontWeight: FontWeight.w600)),
                //       )
                //     ],
                //   ),
                // ),
                // SizedBox(
                //   height: 5,
                // ),
                // divider3(),
                Padding(
                  padding: const EdgeInsets.only(top: 20, left: 20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                            text1("Marital Status"),
                            text1("Astro Status"),
                            text1("Complexion"),
                            text1("Birth City"),
                            text1("Birth State"),
                            text1("Height"),
                            text1("Weight"),
                            text1("Disability/\nHandicapped"),
                            text1("Birth Time"),
                            // text1("Description"),
                          ])),
                      Expanded(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                            text2(":  " + maritalStatus),
                            text2(":  " + astroStatus),
                            text2(":  " + colourStatus),
                            text2(":  " + birthCity),
                            text2(":  " + birthState),
                            text2(":  " + height),
                            text2(":  " + weight),
                            text2(":  " + disability + "\n"),
                            text2(":  " + birthTime),
                            // text2(":  " + "Description"),
                          ]))
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                divider2(),
                SizedBox(
                  height: 5,
                ),
                text1("Description :"),

                Padding(
                  padding: const EdgeInsets.only(left: 30, right: 20),
                  child: Text(description),
                ),
              ],
            )),
    );
  }

  Padding text1(title) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(title,
          style: TextStyle(
              color: primaryColor, fontSize: 16, fontWeight: FontWeight.w600)),
    );
  }

  Padding text2(title) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(title,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
    );
  }
}
