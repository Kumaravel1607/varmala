import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:retry/retry.dart';
import 'package:varamala/Controller/Service.dart';
import 'package:varamala/Views/const.dart';

class lifestyle extends StatefulWidget {
  String user_id = "";
  lifestyle({required this.user_id});

  @override
  _lifestyleState createState() => _lifestyleState();
}

class _lifestyleState extends State<lifestyle> {
  bool _loading = true;

  String diet = "";
  String isSmoking = "";
  String hobbies = "";
  String isDrink = "";
  @override
  void initState() {
    super.initState();
    PersonalDetails("4");
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
              diet = details['diet'];
              isSmoking = details['is_smoking'];
              hobbies = details['hobbies'];
              isDrink = details['is_drink'];
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
                      Icons.face,
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
                              Expanded(child: text1("Diet")),
                              Expanded(child: text2(":  " + diet)),
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(child: text1("Hobbies")),
                              Expanded(child: text2(":  " + hobbies)),
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(child: text1("Smoking")),
                              Expanded(child: text2(":  " + isSmoking)),
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(child: text1("Drinking")),
                              Expanded(child: text2(":  " + isDrink)),
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
