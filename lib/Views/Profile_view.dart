import 'package:flutter/material.dart';
import 'package:gallery_view/gallery_view.dart';
import 'package:varamala/Views/Education&carrer.dart';
import 'package:varamala/Views/Family_details.dart';
import 'package:varamala/Views/Gallery.dart';
import 'package:varamala/Views/Lifestyle.dart';
import 'package:varamala/Views/Partner_preferences.dart';
import 'package:varamala/Views/Tab1.dart';
import 'Profile_tab1.dart';
import 'const.dart';

class profile_view extends StatefulWidget {
  String id = "";
  profile_view({required this.id});

  @override
  _profile_view createState() => _profile_view();
}

class _profile_view extends State<profile_view> {
  @override
  void initState() {
    super.initState();
    print(widget.id.toString());
    print("tab");
  }

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
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          body: TabBarView(
            children: [
              personal_tab1(user_id: widget.id.toString()),
              familydetails(user_id: widget.id.toString()),
              education_career(user_id: widget.id.toString()),
              lifestyle(user_id: widget.id.toString()),
              partner_preferences(user_id: widget.id.toString()),
              gallery_tab(user_id: widget.id.toString())
            ],
          ),
        ),
      ),
    );
  }
}
