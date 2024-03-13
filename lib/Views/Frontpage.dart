import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:retry/retry.dart';
import 'package:varamala/Controller/Service.dart';
import 'package:varamala/Views/Favourite_page.dart';
import 'package:varamala/Views/Home.dart';
import 'package:varamala/Views/Matches.dart';
import 'package:varamala/Views/Messages.dart';
import 'package:varamala/Views/Profile.dart';
import 'package:varamala/Views/Search.dart';
import 'package:varamala/Views/const.dart';
import 'package:varamala/Widgets/home_icons.dart';

class Frontpage extends StatefulWidget {
  @override
  _FrontpageState createState() => _FrontpageState();
}

class _FrontpageState extends State<Frontpage> {
  bool notification = false;
  int _pageController = 0;
  var color_name;
  String message_count = "";
  @override
  void initState() {
    super.initState();
    chat_count();
  }

  chat_count() async {
    final r = RetryOptions(maxDelay: Duration(seconds: 10), maxAttempts: 4);

    try {
      await r.retry(
        () async {
          Service.chat_count().then((count) {
            setState(() {
              message_count = count['message'].toString();
              print("------");
              print(message_count);
            });
          });
        },
        retryIf: (e) => e is SocketException || e is TimeoutException,
      );
    } finally {}
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _pages = [
      Home(),
      Matches(),
      Messages(),
      Fav_Page(),
      Profile(),
    ];
    return ResponsiveBuilder(
      builder: (BuildContext context, SizingInformation sizingInformation) {
        return Scaffold(
          bottomNavigationBar: Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            color: Colors.white12,
            height: sizingInformation.localWidgetSize.height * 0.08,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                InkWell(
                  onTap: () {
                    setState(() {
                      _pageController = 0;
                    });
                  },
                  child: _navBarItem(
                      title: "Home", icon: HomeIcons.home, color_no: 0),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      _pageController = 1;
                    });
                  },
                  child: _navBarItem(
                      title: "Search",
                      icon: HomeIcons.hand_holding_heart,
                      color_no: 1),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      notification = true;
                      _pageController = 2;
                    });
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //       builder: (_) => Messages(),
                    //     ));
                  },
                  child: _navBarItem(
                      title: "Messages", icon: HomeIcons.comment, color_no: 2),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      _pageController = 3;
                    });
                  },
                  child: _navBarItem(
                      title: "My Fav", icon: Icons.favorite, color_no: 3),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      _pageController = 4;
                    });
                  },
                  child: _navBarItem(
                      title: "Profile", icon: HomeIcons.user, color_no: 4),
                ),
              ],
            ),
          ),
          body: _pages[_pageController],
        );
      },
    );
  }

  Widget _navBarItem(
      {required String title, required IconData icon, required color_no}) {
    color_name = Colors.grey[700];
    if (color_no.toString() == _pageController.toString()) {
      color_name = primaryColor;
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        title != "Messages" || notification == true
            ? Icon(
                icon,
                color: color_name,
              )
            : message_count == ""
                ? Icon(
                    icon,
                    color: color_name,
                  )
                : Stack(
                    children: [
                      Icon(
                        icon,
                        color: color_name,
                      ),
                      Card(
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(7.5)),
                        margin: EdgeInsets.only(left: 20),
                        child: Container(
                          child: Center(
                            child: Text(
                              message_count.toString(),
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          height: 15,
                          width: 15,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7.5),
                            color: primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
        Text(
          title,
          style: TextStyle(
              color: color_name, fontSize: 10, fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}
