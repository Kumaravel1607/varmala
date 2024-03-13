import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:gallery_view/gallery_view.dart';

import 'package:images_picker/images_picker.dart';
import 'package:retry/retry.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:varamala/Controller/Service.dart';
import 'package:varamala/Controller/Sharedprefrence.dart';
import 'package:varamala/Model/Gallery.dart';
import 'package:varamala/Views/const.dart';

class ProfilePicture extends StatefulWidget {
  const ProfilePicture({Key? key}) : super(key: key);
  @override
  _ProfilePictureState createState() => _ProfilePictureState();
}

class _ProfilePictureState extends State<ProfilePicture> {
  String? path;

  // dynamic gallery_name = [];
  bool _loading = true;
  bool loading = false;
  // String gallery = "";
  static List<Gallery> images = [];

  @override
  void initState() {
    super.initState();
    // PersonalDetails("6");
    get_gallery();
    images = [];
  }

  get_gallery() async {
    Service.gallery().then((_image) {
      if (mounted) {
        setState(() {
          print(_image);
          images = _image;
          _loading = false;
          loading = false;
        });
      }
    });
  }

  // PersonalDetails(profile) async {
  //   final r = RetryOptions(maxDelay: Duration(seconds: 10), maxAttempts: 4);

  //   print("object");
  //   try {
  //     await r.retry(
  //       () async {
  //         Service.tab_details(
  //           profile,
  //         ).then((details) {
  //           setState(() {
  //             gallery = details['gallery'];
  //             if (gallery != "") {
  //               gallery_name = gallery.split(',');
  //             }
  //             print(gallery_name.length);
  //             _loading = false;
  //             loading = false;
  //           });
  //         });
  //       },
  //       retryIf: (e) => e is SocketException || e is TimeoutException,
  //     );
  //   } finally {}
  // }

  upload_img(path) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    var id = _pref.getString("id");
    Map data = {"image_path": path, "id": id};
    print(data);
    var url = "https://varmalaa.com/api/Demo/save_profile";
    print(url);
    var response = await http.post(Uri.parse(url), body: data);
    var userDetail = (json.decode(response.body));
    print(userDetail);
    setState(() {
      // PersonalDetails("6");
      get_gallery();
      loading = true;
    });
  }

  del_image(image_id) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    var id = _pref.getString("id");
    Map data = {"gallery_id": image_id, "id": id};
    print(data);
    var url = "https://varmalaa.com/api/Demo/delete_image";
    print(url);
    var response = await http.post(Uri.parse(url), body: data);
    var userDetail = (json.decode(response.body));
    print(userDetail);
    setState(() {
      get_gallery();
    });
    loading = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _loading == true
          ? Center(
              child: CircularProgressIndicator(
                color: primaryColor,
              ),
            )
          : Column(
              children: [
                images.length == 0
                    ? Center(
                        child: Text("No Gallery"),
                      )
                    : loading == true
                        ? Flexible(
                            fit: FlexFit.tight,
                            child: Center(
                                child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircularProgressIndicator(
                                  color: primaryColor,
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text("Uploading . . . . . ")
                              ],
                            )),
                          )
                        : Flexible(
                            child: GridView.count(
                              crossAxisCount: 3,
                              children: new List<Widget>.generate(images.length,
                                  (index) {
                                return Stack(children: [
                                  Card(
                                    elevation: 10,
                                    child: Container(
                                      height: 150,
                                      width: 150,
                                      child: Image(
                                        image:
                                            NetworkImage(images[index].image),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 90),
                                    child: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            loading = true;
                                            del_image(images[index].id);
                                          });
                                        },
                                        icon: Icon(
                                          Icons.delete_forever,
                                          color: Colors.red,
                                        )),
                                  ),
                                ]);
                              }),
                            ),
                          ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      RaisedButton(
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
                                style: TextStyle(
                                    color: Colors.white, fontSize: 14),
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
                            count: 5,
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
                            print("lenf");
                            setState(() {
                              for (var i = 0; i < res.length; i++) {
                                var path = res[i].thumbPath;

                                File file = File(path!);
                                Uint8List bytes = file.readAsBytesSync();
                                String base64Image = base64Encode(bytes);
                                print(base64Image);
                                my_gallery.add(base64Image);
                                loading = true;
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
                      RaisedButton(
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
                                style: TextStyle(
                                    color: Colors.white, fontSize: 14),
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
                              loading = true;

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
                SizedBox(
                  height: 10,
                )
              ],
            ),
    );
  }
}
