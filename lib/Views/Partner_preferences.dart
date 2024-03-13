import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:retry/retry.dart';
import 'package:varamala/Controller/Service.dart';

import 'const.dart';

class partner_preferences extends StatefulWidget {
  String user_id = "";
  partner_preferences({required this.user_id});

  @override
  _partner_preferencesState createState() => _partner_preferencesState();
}

class _partner_preferencesState extends State<partner_preferences> {
  bool _loading = true;
  String partnerOccupation = "";
  String partnerEducation = "";
  String partnerNation = "";
  String partnerLocation = "";
  String partnerIncome = "";
  @override
  void initState() {
    super.initState();
    PersonalDetails("5");
  }

  PersonalDetails(profile) async {
    final r = RetryOptions(maxDelay: Duration(seconds: 10), maxAttempts: 4);

    print("object");
    try {
      await r.retry(
        () async {
          Service.Profile_details(profile, widget.user_id).then((details) {
            setState(() {
              _loading = false;
              partnerOccupation = details['partner_occupation'];
              partnerEducation = details['partner_education'];
              partnerNation = details['partner_nation'];
              partnerIncome = details['partner_income'];
              partnerLocation = details['partner_location'];
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
                      Icons.face_retouching_natural,
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
                              Expanded(child: text1("Occupation")),
                              Expanded(child: text2(":  " + partnerOccupation)),
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(child: text1("Education")),
                              Expanded(child: text2(":  " + partnerEducation)),
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(child: text1("Preferred Nationality")),
                              Expanded(child: text2(":  " + partnerNation)),
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(child: text1("Expected Income")),
                              Expanded(child: text2(":  " + partnerIncome)),
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(child: text1("Location/Other Details")),
                              Expanded(child: text2(":  " + partnerLocation)),
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
