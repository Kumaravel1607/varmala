import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:varamala/Views/Ageview.dart';
import 'package:varamala/Views/Fliterview.dart';
import 'package:varamala/Views/const.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    String age = "";
    String marital = "";
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          title: Padding(
            padding: EdgeInsets.only(top: 8.0),
            child: _AppBar(),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  "SEARCH BY ID",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Padding(
                padding: EdgeInsets.only(left: 15, right: 15),
                child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Row(
                        children: [
                          Icon(
                            Icons.search,
                            color: primaryColor,
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Expanded(
                              child: TextFormField(
                            decoration: InputDecoration(
                              hintText: "Search by ID or Name",
                              hintStyle: TextStyle(color: Colors.grey),
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                            ),
                          ))
                        ],
                      ),
                    )),
              ),
              SizedBox(
                height: 10,
              ),
              Divider(
                color: Colors.grey,
              ),
              SizedBox(
                height: 5,
              ),
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  "PROFILE FILTERS",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Center(
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => Fliterview()));
                  },
                  child: Container(
                    height: 40,
                    width: size.width * 0.5,
                    decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Apply Filters',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ]),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Container(
                    height: 50,
                    width: size.width * 0.49,
                    color: Colors.white.withOpacity(0.3),
                    child: Column(
                      children: [
                        Icon(
                          Icons.save,
                          color: Colors.grey,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Saved Profile',
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.w900),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 2,
                  ),
                  Container(
                    height: 50,
                    color: Colors.white.withOpacity(0.3),
                    width: size.width * 0.49,
                    child: Column(
                      children: [
                        Icon(
                          Icons.save,
                          color: Colors.grey,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text('Recently viewed',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w900))
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget Filters(Flitername, BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Padding(
        padding: EdgeInsets.only(left: 10.0, right: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
                height: 40,
                width: size.width * 0.45,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(Flitername),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: primaryColor,
                        size: 15,
                      )
                    ],
                  ),
                )),
          ],
        ));
  }

  Widget _AppBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            child: Text(
              'SEARCH',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(
            Icons.notifications,
            color: Colors.white,
          ),
        )
      ],
    );
  }
}
