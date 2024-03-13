import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:varamala/Views/const.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_html/flutter_html.dart';

class help_center extends StatefulWidget {
  const help_center({Key? key}) : super(key: key);

  @override
  _help_centerState createState() => _help_centerState();
}

class _help_centerState extends State<help_center> {
  bool isloading = true;
  String pagecontent = "";

  @override
  void initState() {
    super.initState();
    getpage();
  }

  Future<String> getpage() async {
    var url = "https://varmalaa.com/api/Demo/about_us";
    print(url);
    var response = await http.get(Uri.parse(url));
    var page = (json.decode(response.body));

    setState(() {
      pagecontent = page['page_content'];
    });
    isloading = false;
    return "Success";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text("About us"),
        centerTitle: true,
      ),
      body: isloading == true
          ? Center(
              child: CircularProgressIndicator(
                color: primaryColor,
              ),
            )
          : Padding(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: SingleChildScrollView(
                  child: Html(
                data: pagecontent,
              ))),
    );
  }
}
