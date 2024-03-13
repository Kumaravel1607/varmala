import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:varamala/Controller/Service.dart';
import 'package:varamala/Model/Gender.dart';
import 'package:varamala/Model/User.dart';
import 'package:varamala/Views/const.dart';

class Marital extends StatefulWidget {
  String marital = "";

  Marital({required this.marital});
  @override
  _MaritalState createState() => _MaritalState();
}

class _MaritalState extends State<Marital> {
  String marital = "";
  List<User> _muser = [];
  List<Gender> _gender = [];
  String baseurl = "https://varmalaa.com/UPLOADS/Profile";

  String formater(String url) {
    return baseurl + url;
  }

  NetworkImage getImage(String imageName, String id) {
    String url = formater("/$id/$imageName");
    return NetworkImage(url);
  }

  void initState() {
    super.initState();
    marital = widget.marital;
    _getmuser();
    _muser;
    _getgen();
    _gender = [];
  }

  _getgen() async {
    Service.getgender().then((gender) {
      setState(() {
        _gender = gender;
      });
      print(_gender.length);
    });
  }

  _getmuser() {
    Service.getmuser(marital).then((value) {
      setState(() {
        _muser = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            backgroundColor: primaryColor,
            title: Text("MATCHES SEARCH",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold)),
          ),
          body: SingleChildScrollView(
              physics: ScrollPhysics(),
              child: (_muser.length == 0)
                  ? SafeArea(
                      child: Center(
                          child: CircularProgressIndicator(
                      color: primaryColor,
                    )))
                  : Column(children: [
                      ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: _muser.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(
                                  left: 18.0, right: 18.0, top: 12),
                              child: Container(
                                height: 210,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              (_muser[index].profile_photo ==
                                                          'null' ||
                                                      _muser[index]
                                                              .profile_photo ==
                                                          '')
                                                  ? CircleAvatar(
                                                      backgroundImage: AssetImage(
                                                          'assets/Images/profile.png'),
                                                      //backgroundImage: getImage(_user[index].profile_photo, _user[index].id),
                                                      radius: 50,
                                                    )
                                                  : CircleAvatar(
                                                      backgroundImage: getImage(
                                                          _muser[index]
                                                              .profile_photo,
                                                          _muser[index].id),
                                                      radius: 50,
                                                    ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Column(
                                                    children: [
                                                      Text(
                                                        _muser[index].firstName,
                                                        style: TextStyle(
                                                            color: Colors
                                                                .grey[800],
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      Text(
                                                        _muser[index].dob,
                                                        style: TextStyle(
                                                          color:
                                                              Colors.grey[800],
                                                          fontSize: 18,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      (_gender[0].is_plan ==
                                                              "0")
                                                          ? Row(
                                                              children: [
                                                                Icon(
                                                                  Icons
                                                                      .account_box,
                                                                  color: Colors
                                                                      .blue,
                                                                  size: 15,
                                                                ),
                                                                SizedBox(
                                                                  width: 3,
                                                                ),
                                                                Text(
                                                                  'CONTACT: **********',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black
                                                                          .withOpacity(
                                                                              0.7),
                                                                      fontSize:
                                                                          15),
                                                                )
                                                              ],
                                                            )
                                                          : Row(
                                                              children: [
                                                                Icon(
                                                                  Icons
                                                                      .account_box,
                                                                  color: Colors
                                                                      .blue,
                                                                  size: 15,
                                                                ),
                                                                SizedBox(
                                                                  width: 3,
                                                                ),
                                                                Text(
                                                                  'CONTACT:' +
                                                                      _muser[index]
                                                                          .mobile,
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black
                                                                          .withOpacity(
                                                                              0.7),
                                                                      fontSize:
                                                                          15),
                                                                )
                                                              ],
                                                            ),
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      (_gender[0].is_plan ==
                                                              "0")
                                                          ? Row(
                                                              children: [
                                                                Icon(
                                                                  Icons
                                                                      .perm_phone_msg_sharp,
                                                                  color: Colors
                                                                      .blue,
                                                                  size: 15,
                                                                ),
                                                                SizedBox(
                                                                  width: 3,
                                                                ),
                                                                Text(
                                                                  'WHATSAPP: ***********',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black
                                                                          .withOpacity(
                                                                              0.7),
                                                                      fontSize:
                                                                          15),
                                                                )
                                                              ],
                                                            )
                                                          : Row(
                                                              children: [
                                                                Icon(
                                                                  Icons
                                                                      .perm_phone_msg_sharp,
                                                                  color: Colors
                                                                      .blue,
                                                                  size: 15,
                                                                ),
                                                                SizedBox(
                                                                  width: 3,
                                                                ),
                                                                Text(
                                                                  'WHATSAPP:' +
                                                                      _muser[index]
                                                                          .whatsapp_no,
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black
                                                                          .withOpacity(
                                                                              0.7),
                                                                      fontSize:
                                                                          15),
                                                                )
                                                              ],
                                                            ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Icon(
                                                Icons.more_vert,
                                                color: Colors.black
                                                    .withOpacity(0.3),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Divider(
                                        color: Colors.grey,
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            height: 40,
                                            width: size.width * 0.65,
                                            decoration: BoxDecoration(
                                                color: primaryColor,
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    'MESSAGE',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 20,
                                                    ),
                                                  ),
                                                ]),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                    ]))),
    );
  }
}
