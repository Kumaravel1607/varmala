import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gallery_view/gallery_view.dart';
import 'package:retry/retry.dart';
import 'package:varamala/Controller/Service.dart';
import 'package:varamala/Views/const.dart';

class gallery_tab extends StatefulWidget {
  String user_id = "";

  gallery_tab({required this.user_id});

  @override
  _gallery_tabState createState() => _gallery_tabState();
}

class _gallery_tabState extends State<gallery_tab> {
  dynamic gallery_name = [];
  bool _loading = true;
  String gallery = "";
  @override
  void initState() {
    super.initState();
    PersonalDetails("6");
  }

  PersonalDetails(profile) async {
    final r = RetryOptions(maxDelay: Duration(seconds: 10), maxAttempts: 4);

    print("object");
    try {
      await r.retry(
        () async {
          Service.Profile_details(profile, widget.user_id).then((details) {
            setState(() {
              gallery = details['gallery'];
              if (gallery != "") {
                gallery_name = gallery.split(',');
              }
              print(gallery_name.length);
              _loading = false;
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
          : gallery_name.length == 0
              ? Center(
                  child: Text("No Gallery"),
                )
              : GalleryView(
                  crossAxisCount: 3,
                  imageUrlList: gallery_name,
                ),
    );
  }
}
