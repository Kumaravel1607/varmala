import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:retry/retry.dart';
import 'package:varamala/Controller/Service.dart';
import 'package:varamala/Views/const.dart';

class familydetails extends StatefulWidget {
  String user_id = "";
  familydetails({required this.user_id});

  @override
  _familydetailsState createState() => _familydetailsState();
}

class _familydetailsState extends State<familydetails> {
  bool _loading = true;
  @override
  void initState() {
    super.initState();
    print("family tab");
    print(widget.user_id);
    PersonalDetails("2");
  }

  String fatherName = "";
  String fatherOccupation = "";
  String motherName = "";
  String motherOccupation = "";
  String brotherNo = "";
  String sisterNo = "";
  String aboutFamily = "";
  String familyType = "";
  String religion = "";
  String community = "";
  String caste = "";
  PersonalDetails(profile) async {
    final r = RetryOptions(maxDelay: Duration(seconds: 10), maxAttempts: 4);

    print("object");
    try {
      await r.retry(
        () async {
          Service.Profile_details(profile, widget.user_id).then((details) {
            setState(() {
              _loading = false;
              fatherName = details['father_name'];
              fatherOccupation = details['father_occupation'];
              motherName = details['mother_name'];
              motherOccupation = details['mother_occupation'];
              brotherNo = details['brother_no'];
              sisterNo = details['sister_no'];
              aboutFamily = details['about_family'];
              familyType = details['family_type'];
              religion = details['religion'];
              community = details['community'];
              caste = details['caste'];
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
                      Icons.groups,
                      color: primaryColor,
                      size: 40,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20, left: 20),
                    child: Column(children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(child: text1("Father’s Name")),
                          Expanded(child: text2(":  " + fatherName)),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(child: text1("Father Occupation")),
                          Expanded(child: text2(":  " + fatherOccupation)),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(child: text1("Mother’s Name")),
                          Expanded(child: text2(":  " + motherName)),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(child: text1("Mother’s Occupation")),
                          Expanded(child: text2(":  " + motherOccupation)),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(child: text1("Number of Brother")),
                          Expanded(child: text2(":  " + brotherNo)),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(child: text1("Number Of sisters")),
                          Expanded(child: text2(":  " + sisterNo)),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(child: text1("Family Type")),
                          Expanded(child: text2(":  " + familyType)),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(child: text1("Religion")),
                          Expanded(child: text2(":  " + religion)),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(child: text1("Community/Caste")),
                          Expanded(child: text2(":  " + community)),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(child: text1("Gotra")),
                          Expanded(child: text2(":  " + caste)),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(child: text1("About Family")),
                          Expanded(child: text2(":  " + aboutFamily)),
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
