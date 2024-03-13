import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:retry/retry.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:varamala/Controller/Sharedprefrence.dart';
import 'package:varamala/Model/Gender.dart';
import 'package:varamala/Views/About_us.dart';
import 'package:varamala/Views/Account_profile.dart';
import 'package:varamala/Views/Contact_us.dart';
import 'package:images_picker/images_picker.dart';

import 'package:varamala/Views/Loginpage.dart';
import 'package:varamala/Views/Personaldetails.dart';

import 'package:varamala/Views/Terms&conditions.dart';
import 'package:varamala/Views/Transcation_history.dart';
import 'package:varamala/Views/const.dart';
import 'package:varamala/Views/personal_profile.dart';
import 'package:varamala/Widgets/home_icons.dart';
import 'package:varamala/main.dart';
import 'package:varamala/Controller/Service.dart';
import 'package:http/http.dart' as http;

import 'Change_password.dart';
import 'Delete_profile.dart';
import 'Upgradeplan.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String id = "";
  String? path;
  String first_name = "-";
  String membership = "";
  String _plan = "";
  late String profile_photo = "https://varmalaa.com/assets/default/avatar.png";
  String baseurl = "https://varmalaa.com/UPLOADS/Profile";
  String formater(String url) {
    return baseurl + url;
  }

  NetworkImage getImage(String imageName, String id) {
    String url = formater("/$id/$imageName");
    return NetworkImage(url);
  }

  @override
  void initState() {
    super.initState();
    get_id();
    _getgen();
  }

  get_id() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    id = _pref.getString("id");
  }

  _getgen() async {
    final r = RetryOptions(maxDelay: Duration(seconds: 10), maxAttempts: 4);
    try {
      await r.retry(
        () async {
          Service.account_profile().then((user_details) {
            print(user_details.isPlan);
            setState(() {
              first_name = user_details.firstName;
              profile_photo = user_details.profilePhoto;
              membership = user_details.plan;
              _plan = user_details.isPlan;
            });
          });
        },
        retryIf: (e) => e is SocketException || e is TimeoutException,
      );
    } finally {}
  }

  unset_Session() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (BuildContext context) => MyApp(),
      ),
      (Route route) => false,
    );
    // SystemNavigator.pop();
    print("-------------------v---------\n------v-------------v---------");
  }

  upload_img(path) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    var id = _pref.getString("id");
    Map data = {"image_path": path, "id": id};
    print(data);
    var url = "https://varmalaa.com/api/Demo/save_profile_image";
    print(url);
    var response = await http.post(Uri.parse(url), body: data);
    var userDetail = (json.decode(response.body));
    print(userDetail);
    setState(() {
      _getgen();
    });
  }

  Future<void> _alerBox() async {
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              "Edit profile image",
              style: TextStyle(color: primaryColor),
            ),

            content: Container(
              height: 100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  RaisedButton(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    color: primaryColor,
                    child: Container(
                      height: 40,
                      width: 80,
                      child: Center(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            'Choose',
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ),
                          Icon(
                            Icons.folder,
                            color: Colors.white,
                          )
                        ],
                      )),
                    ),
                    onPressed: () async {
                      List<Media>? res = await ImagesPicker.pick(
                        count: 1,
                        pickType: PickType.all,
                        language: Language.System,
                        // maxSize: 500,
                        cropOpt: CropOption(
                          aspectRatio: CropAspectRatio.custom,
                        ),
                      );
                      print("------------------");
                      if (res != null) {
                        print(res.map((e) => e.path).toList());
                        List my_gallery = [];

                        print(res.length);

                        setState(() {
                          for (var i = 0; i < res.length; i++) {
                            var path = res[0].thumbPath;

                            File file = File(path!);
                            Uint8List bytes = file.readAsBytesSync();
                            String base64Image = base64Encode(bytes);
                            print(base64Image);
                            my_gallery.add(base64Image);
                          }
                          print("1111");
                          print(my_gallery);
                          print("2222222");
                          my_gallery != ""
                              ? upload_img(my_gallery.join(","))
                              : "";
                        });
                        print("------------------");
                        // bool status = await ImagesPicker.saveImageToAlbum(File(res[0]?.path));
                        // print(status);
                      }
                    },
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  RaisedButton(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    color: primaryColor,
                    child: Container(
                      height: 40,
                      width: 80,
                      child: Center(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            'Camera',
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ),
                          Icon(
                            Icons.camera_alt_rounded,
                            color: Colors.white,
                          )
                        ],
                      )),
                    ),
                    onPressed: () async {
                      List<Media>? res = await ImagesPicker.openCamera(
                        pickType: PickType.image,
                        quality: 0.2,
                        // cropOpt: CropOption(
                        //   aspectRatio: CropAspectRatio.wh16x9,
                        // ),
                        // maxTime: 60,
                      );

                      if (res != null) {
                        print(res);

                        setState(() {
                          path = res[0].thumbPath;

                          File file = File(path!);
                          Uint8List bytes = file.readAsBytesSync();
                          String base64Image = base64Encode(bytes);

                          path != "" ? upload_img(base64Image) : "";
                        });
                      }
                    },
                  ),
                ],
              ),
            ),
            //title: Text(),
            actions: <Widget>[
              OutlinedButton(
                onPressed: () {
                  Navigator.pop(context, "ok");
                },
                child: const Text("Cancel"),
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          title: Padding(
            padding: EdgeInsets.only(top: 8.0),
            child: _AppBar(),
          ),
        ),
        body: SingleChildScrollView(
          child:
              //(_gender.length==0)?
              //SafeArea(child:Center(child:CircularProgressIndicator(color: primaryColor,))):
              Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    SizedBox(
                      width: 15,
                    ),
                    //(_gender[0].profile_photo=='null' || _gender[0].profile_photo=='')?
                    Stack(children: [
                      CircleAvatar(
                        // backgroundImage: AssetImage('assets/Images/profile.png'),
                        backgroundImage: NetworkImage(profile_photo),
                        radius: 60,
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 90, left: 10),
                        child: GestureDetector(
                          onTap: () {
                            _alerBox();
                          },
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.5)),
                            elevation: 10,
                            child: Container(
                              height: 25,
                              width: 25,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12.5),
                                  color: primaryColor_bg),
                              child: Icon(
                                Icons.mode_edit,
                                size: 20,
                                color: primaryColor,
                              ),
                            ),
                          ),
                        ),
                      )
                    ]),
                    /*CircleAvatar(
                      backgroundImage: getImage(_gender[0].profile_photo, _gender[0].id),//NetworkImage("https://varmalaa.com/UPLOADS/Profile/10/1613483660_330938.png"),
                      radius: 50,
                    ),*/
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            first_name,
                            style: TextStyle(
                                color: primaryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: Text(
                            "ID : " + "VAR" + id,
                            style: TextStyle(
                                color: Colors.grey[800],
                                fontWeight: FontWeight.w600,
                                fontSize: 15),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: Row(
                            children: [
                              Text(
                                'Membership',
                                style: TextStyle(
                                    color: Colors.grey[800],
                                    fontWeight: FontWeight.w700,
                                    fontSize: 15),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8, top: 5),
                          child: Row(
                            children: [
                              Text(
                                membership,
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 15),
                              ),
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              // options(HomeIcons.hand_holding_heart, 'Matches'),
              // options(Icons.mail, 'Messages'),
              InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Account()));
                  },
                  child: options(Icons.manage_accounts, 'Account Profile')),
              InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Personal_profile()));
                  },
                  child: options(Icons.account_circle, 'Personal Profile')),

              // InkWell(
              //     onTap: () {
              //       Navigator.push(context,
              //           MaterialPageRoute(builder: (context) => Personal()));
              //     },
              //     child: options(Icons.edit, 'Edit Profile')),

              InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Upgrade()));
                  },
                  child: options(Icons.local_offer_rounded, 'Membership Plan')),

              InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => transcation_history()));
                  },
                  child: options(
                      Icons.format_list_numbered, 'Transcation History')),
              InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => change_pass()));
                  },
                  child: options(Icons.lock, 'Change Password')),
              InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Delete_profile()));
                  },
                  child: options(Icons.not_interested, 'Delete Profile')),
              options(Icons.star, 'Rate Us'),
              Container(
                height: 50,
                color: Colors.white,
                child: Divider(
                  color: Colors.grey,
                ),
              ),
              InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => help_center()));
                  },
                  child: others('About us', context)),
              InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => terms_condition()));
                  },
                  child: others('Terms & Conditions', context)),
              InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => privacy_policy()));
                  },
                  child: others('Contact us', context)),
              InkWell(
                child: others('LogOut', context),
                onTap: () async {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  prefs.clear();
                  unset_Session();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget others(text, BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      height: 50,
      width: size.width,
      color: Colors.white,
      child: Padding(
          padding: const EdgeInsets.only(left: 18.0, right: 18.0),
          child: Text(
            text,
            style: TextStyle(
                color: Colors.grey[850],
                fontWeight: FontWeight.w500,
                fontSize: 18),
          )),
    );
  }

  Widget options(icon, text) {
    return Container(
      height: 50,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.only(left: 18.0, right: 18.0),
        child: Row(
          children: [
            Icon(
              icon,
              color: primaryColor,
              size: 30,
            ),
            SizedBox(
              width: 15,
            ),
            Text(
              text,
              style: TextStyle(
                  color: Colors.grey[850],
                  fontWeight: FontWeight.w400,
                  fontSize: 18),
            )
          ],
        ),
      ),
    );
  }

  Widget _AppBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            child: Text(
              'Profile',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        SizedBox(),
      ],
    );
  }
}
