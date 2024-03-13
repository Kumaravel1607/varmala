import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:varamala/Controller/Service.dart';
import 'package:varamala/Model/Transcation.dart';
import 'package:varamala/Views/Pdf_view.dart';
import 'package:varamala/Views/const.dart';

class transcation_history extends StatefulWidget {
  const transcation_history({Key? key}) : super(key: key);

  @override
  _transcation_historyState createState() => _transcation_historyState();
}

class _transcation_historyState extends State<transcation_history> {
  bool _loading = true;
  late String localPath;
  late List<Transcation> trans_list;
  void initState() {
    super.initState();
    trans_list = [];
    get_transcation();
  }

  void _launchURL(_url) async {
    await canLaunch(_url) ? await launch(_url) : throw 'Could not launch $_url';
  }

  get_transcation() async {
    Service.transcation().then((transcation) {
      if (mounted) {
        setState(() {
          print(transcation);
          trans_list = transcation;
          _loading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor_bg,
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text("Transcation History"),
        centerTitle: true,
      ),
      body: _loading == true
          ? Center(
              child: CircularProgressIndicator(
              color: primaryColor,
            ))
          : trans_list.length != 0
              ? ListView.builder(
                  shrinkWrap: true,
                  itemCount: trans_list.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 8),
                      child: Card(
                        elevation: 5,
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                          height: MediaQuery.of(context).size.height * 0.27,
                          child: Column(
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Transcation.ID :",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: primaryColor),
                                      ),
                                      Text(
                                        trans_list[index].paymentId,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                        ),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Status :",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Text(
                                        trans_list[index].paymentStatus,
                                        style: trans_list[index]
                                                    .paymentStatus ==
                                                "success"
                                            ? TextStyle(
                                                color: Colors.green,
                                                fontWeight: FontWeight.w600)
                                            : TextStyle(
                                                color: Colors.red,
                                                fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Text("Plan :",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600)),
                                  Text(trans_list[index].title,
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.pink[300])),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                      flex: 4,
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Date ",
                                                    // style: TextStyle(color: Colors.grey),
                                                  ),
                                                  Text(
                                                    "Duration ",
                                                    //   style: TextStyle(color: Colors.grey),
                                                  ),
                                                ]),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    ": " +
                                                        trans_list[index]
                                                            .ts
                                                            .toIso8601String()
                                                            .substring(0, 10),
                                                    // style: TextStyle(color: Colors.grey),
                                                  ),
                                                  Text(
                                                    ": " +
                                                        trans_list[index]
                                                            .duration +
                                                        " Months",
                                                    // style: TextStyle(color: Colors.grey),
                                                  ),
                                                ]),
                                          ),
                                        ],
                                      )),
                                  Expanded(
                                      flex: 3,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            "Amount",
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          Text(
                                            trans_list[index].amount,
                                            style: TextStyle(
                                                color: primaryColor,
                                                fontSize: 19,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ],
                                      ))
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 20),
                                child: RaisedButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  color: primaryColor,
                                  padding: null,
                                  elevation: 5,
                                  onPressed: () {
                                    _launchURL(trans_list[index].url);
                                  },
                                  child: Container(
                                    width: 150,
                                    height: 40,
                                    child: Center(
                                      child: Text(
                                        "Download",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 18),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  })
              : Center(
                  child: Text("No Transcation here"),
                ),
    );
  }
}
