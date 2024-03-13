import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:varamala/Controller/Sharedprefrence.dart';
import 'package:varamala/Model/Gender.dart';

import 'package:varamala/Views/Messages.dart';
import 'package:varamala/Views/Messagescreen.dart';
import 'package:varamala/Views/Profile_view.dart';
import 'package:varamala/Views/Profileview.dart';
import 'package:varamala/Views/Upgradeplan.dart';
import 'package:varamala/Views/View_all.dart';
import 'package:varamala/Views/const.dart';
import 'package:varamala/Widgets/front_icons.dart';
import 'package:varamala/Model/User.dart';
import 'package:varamala/Controller/Service.dart';
import 'package:retry/retry.dart';
import 'dart:async';
import 'dart:io';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late List<User> _ruser;
  bool _loading = true;
  bool visibile = true;
  void initState() {
    super.initState();
    _ruser = [];
    _getusers();
  }

  _getusers() async {
    Service.getMatchDetails(1, "", 0, "").then((users) {
      if (mounted) {
        setState(() {
          _ruser = users;
          _loading = false;
        });
      }
    });
  }

  _fav_status(fav_id, fav_status, index_no) async {
    Service.favourite_status(fav_id, fav_status).then((users) {
      if (mounted) {}
    });
  }

  _block_status(block_id, block_status, index_no) async {
    Service.block_status(block_id, block_status).then((users) {
      print(users);
      if (mounted) {}
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: primaryColor_bg,
        appBar: AppBar(
          title: Container(
            padding: EdgeInsets.all(5),
            width: 120,
            height: 40,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20), color: Colors.white),
            margin: const EdgeInsets.only(left: 10),
            child: Image(
              image: AssetImage("assets/Images/logo2.png"),
              fit: BoxFit.contain,
            ),
          ),
          backgroundColor: primaryColor,
          actions: [
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: Container(
                width: 150,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.3),
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                      onTap: () {
                        Navigator.of(context, rootNavigator: true).push(
                            CupertinoPageRoute(
                                builder: (context) => Upgrade()));
                      },
                      child: Text(
                        'Membership plan',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      )),
                ),
              ),
            ),
            SizedBox(
              width: 16,
            ),
          ],
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            setState(() {
              _getusers();
            });
          },
          child: SingleChildScrollView(
            physics: ScrollPhysics(),
            child: _loading == true
                ? SafeArea(
                    child: Padding(
                    padding: const EdgeInsets.only(top: 320),
                    child: Center(
                        child: CircularProgressIndicator(
                      color: primaryColor,
                    )),
                  ))
                : (_ruser.length == 0)
                    ? Center(
                        child: Text(
                        "NO DATA FOUND",
                        style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ))
                    : Column(
                        children: [
                          ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: _ruser.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(
                                      left: 18.0, right: 18.0, top: 12),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  profile_view(
                                                      id: _ruser[index].id)));
                                    },
                                    child: Container(
                                      // height:
                                      //     MediaQuery.of(context).size.height *
                                      //         0.32,
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
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 10, left: 20),
                                                  child: Column(
                                                    children: [
                                                      CircleAvatar(
                                                        backgroundImage:
                                                            NetworkImage(_ruser[
                                                                    index]
                                                                .profile_photo),
                                                        radius: 50,
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      Row(
                                                        children: [
                                                          Text("ID : ",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .purple)),
                                                          Text(
                                                            _ruser[index]
                                                                .profile_id,
                                                            style: TextStyle(
                                                                fontSize: 12),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 20),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Container(
                                                        width: 200,
                                                        child: Text(
                                                          _ruser[index]
                                                                  .firstName +
                                                              " " +
                                                              _ruser[index]
                                                                  .lastName,
                                                          style: TextStyle(
                                                              color:
                                                                  primaryColor,
                                                              fontSize: 18,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      Container(
                                                        width: 150,
                                                        child: Text(
                                                          _ruser[index]
                                                                      .stateName ==
                                                                  null
                                                              ? ""
                                                              : _ruser[index]
                                                                  .stateName,
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 14,
                                                          ),
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      Row(
                                                        children: [
                                                          Icon(
                                                            Icons
                                                                .insert_invitation,
                                                            color: primaryColor,
                                                          ),
                                                          Text(
                                                            " : " +
                                                                _ruser[index]
                                                                    .dob,
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 14,
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      Row(
                                                        children: [
                                                          Icon(
                                                            Icons.call,
                                                            color: Colors.blue,
                                                          ),
                                                          Text(
                                                              " : " +
                                                                  _ruser[index]
                                                                      .mobile,
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 14,
                                                              ))
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
                                                          Text(
                                                              " : " +
                                                                  _ruser[index]
                                                                      .whatsapp_no,
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 14,
                                                              ))
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Divider(
                                              color: Colors.grey,
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                btn(
                                                    context,
                                                    MessagesScreen(
                                                        id: _ruser[index].id,
                                                        name: _ruser[index]
                                                            .firstName,
                                                        image: _ruser[index]
                                                            .profile_photo),
                                                    "Message",
                                                    Icons.chat),
                                                btn2(
                                                    Icons.favorite,
                                                    _ruser[index]
                                                        .favorite_status,
                                                    _ruser[index].id,
                                                    index),
                                                btn1(
                                                    Icons.block,
                                                    _ruser[index].id,
                                                    _ruser[index].block_status,
                                                    index),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 8,
                                            ),
                                            Text(
                                              _ruser[index].lastseen,
                                              style:
                                                  TextStyle(color: Colors.grey),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }),
                          SizedBox(
                            height: 10,
                          ),
                          Center(
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => viewall()));
                              },
                              child: Container(
                                width: size.width * 0.4,
                                decoration: BoxDecoration(
                                    color: primaryColor,
                                    borderRadius: BorderRadius.circular(20)),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'View All',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                          ),
                                        ),
                                        Icon(
                                          Icons.chevron_right,
                                          size: 25,
                                          color: Colors.white,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              'Discover mathches based on',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 28.0, right: 28.0, top: 8, bottom: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    Icon(
                                      Front.location,
                                      color: Colors.grey,
                                      size: 30,
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      'Location',
                                      style: TextStyle(
                                          color: Colors.grey[700],
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Icon(
                                      Front.graduation_hat,
                                      color: Colors.grey,
                                      size: 30,
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      'Education',
                                      style: TextStyle(
                                          color: Colors.grey[850],
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Icon(
                                      Front.work,
                                      color: Colors.grey,
                                      size: 30,
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      'Profession',
                                      style: TextStyle(
                                          color: Colors.grey[700],
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 18.0, bottom: 8.0),
                            child: Container(
                                color: Colors.white.withOpacity(0.5),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 18.0, top: 10, bottom: 10),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.help_outline,
                                        color: Colors.orangeAccent,
                                        size: 90,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Column(
                                        children: [
                                          Text(
                                            'Need Help?',
                                            style: TextStyle(
                                                color: Colors.grey[850],
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20),
                                          ),
                                          SizedBox(
                                            height: 3,
                                          ),
                                          Text(
                                            'We are here to assist you 24/7',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w200,
                                                color: Colors.black,
                                                fontSize: 15),
                                          ),
                                          SizedBox(
                                            height: 3,
                                          ),
                                          Text(
                                            'Reach us with your queries',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w200,
                                                color: Colors.black,
                                                fontSize: 15),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                )),
                          )
                        ],
                      ),
          ),
        ),
      ),
    );
  }

  InkWell btn(BuildContext context, value1, value2, var Icons) {
    return InkWell(
      onTap: () {
        Navigator.of(context, rootNavigator: true)
            .push(CupertinoPageRoute(builder: (context) => value1));
      },
      child: Container(
        height: 40,
        width: 110,
        decoration: BoxDecoration(
            color: primaryColor, borderRadius: BorderRadius.circular(5)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons,
              color: Colors.white,
              size: 20,
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              value2,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }

  InkWell btn1(var Icons, block_id, block_status, index_no) {
    return InkWell(
      onTap: () {
        block_status = block_status == "0" ? "1" : "0";

        setState(() {
          _block_status(block_id, block_status, index_no);
          _ruser[index_no].block_status = block_status;
        });
      },
      child: Container(
        height: 40,
        width: 110,
        decoration: BoxDecoration(
            color: block_status == "1" ? primaryColor_bg : primaryColor,
            borderRadius: BorderRadius.circular(5)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons,
              color: block_status == "1" ? primaryColor : Colors.white,
              size: 20,
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              block_status == "1" ? "Un Block" : "Block",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: block_status == "1" ? primaryColor : Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }

  InkWell btn2(var Icons, fav_status, fav_id, index_no) {
    return InkWell(
      onTap: () {
        fav_status = fav_status == "0" ? "1" : "0";

        setState(() {
          _ruser[index_no].favorite_status = fav_status;
        });

        _fav_status(fav_id, fav_status, index_no);
      },
      child: Container(
        height: 40,
        width: 60,
        decoration: BoxDecoration(
            color: fav_status == "1" ? Colors.white : primaryColor,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: primaryColor)),
        child: Center(
          child: Icon(
            Icons,
            color: fav_status == "1" ? primaryColor : Colors.white,
            size: 20,
          ),
        ),
      ),
    );
  }
  // Don't worry about displaying progress or error indicators on screen; the
  // package takes care of that. If you want to customize them, use the
  // [PagedChildBuilderDelegate] properties.

}
