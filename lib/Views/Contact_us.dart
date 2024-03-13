import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:varamala/Views/const.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_html/flutter_html.dart';

class privacy_policy extends StatefulWidget {
  const privacy_policy({Key? key}) : super(key: key);

  @override
  _privacy_policyState createState() => _privacy_policyState();
}

class _privacy_policyState extends State<privacy_policy> {
  bool isloading = true;
  String pagecontent = "";

  @override
  void initState() {
    super.initState();
    getpage();
  }

  Future<String> getpage() async {
    var url = "https://varmalaa.com/api/Demo/contact_us";
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
        title: Text("Contact us"),
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
