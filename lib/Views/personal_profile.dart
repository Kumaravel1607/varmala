import 'package:flutter/material.dart';
import 'package:varamala/Views/Tab1.dart';
import 'package:varamala/Views/Tab3.dart';
import 'package:varamala/Views/Tab4.dart';

import 'package:varamala/Views/tab2.dart';

import 'Tab5.dart';
import 'Tab6.dart';
import 'const.dart';

class Personal_profile extends StatelessWidget {
  const Personal_profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 6,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: primaryColor,
            bottom: const TabBar(
              indicatorColor: Colors.white,
              isScrollable: true,
              tabs: [
                Tab(text: "Personal Details"),
                Tab(text: "Family Details"),
                Tab(text: "Education & Career"),
                Tab(text: "Life Style"),
                Tab(text: "Partner Preferences"),
                Tab(text: "Gallery"),
              ],
            ),
            title: const Text('Profile'),
            centerTitle: true,
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          body: const TabBarView(
            children: [
              tab1(),
              tab2(),
              tab3(),
              tab4(),
              tab5(),
              ProfilePicture(),
            ],
          ),
        ),
      ),
    );
  }
}
