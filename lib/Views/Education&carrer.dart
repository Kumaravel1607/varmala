import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:retry/retry.dart';
import 'package:varamala/Controller/Service.dart';
import 'package:varamala/Views/const.dart';

class education_career extends StatefulWidget {
  String user_id = "";
  education_career({required this.user_id});

  @override
  _education_careerState createState() => _education_careerState();
}

class _education_careerState extends State<education_career> {
  bool _loading = true;
  @override
  void initState() {
    super.initState();
    PersonalDetails("3");
  }

  String education = "";
  String occupation = "";
  String nationality = "";
  String income = "";
  String jobLocation = "";

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
              education = details['education'];
              occupation = details['occupation'];
              nationality = details['nationality'];
              income = details['income'];
              jobLocation = details['job_location'];
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
            : ListView(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: Icon(
                      Icons.school_outlined,
                      color: primaryColor,
                      size: 40,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20, left: 20),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(child: text1("Nationality")),
                              Expanded(child: text2(":  " + nationality)),
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(child: text1("Profession/\nOccupation")),
                              Expanded(child: text2(":  " + occupation + "\n")),
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(child: text1("Income (Yearly)")),
                              Expanded(child: text2(":  " + income + "\n")),
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                  child: text1(
                                      "Job Location/\nBusiness Location")),
                              Expanded(child: text2(":  " + jobLocation)),
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                  child: text1("Educational Qualification")),
                              Expanded(child: text2(":  " + education)),
                            ],
                          ),
                        ]),
                  )
                ],
              ));
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
