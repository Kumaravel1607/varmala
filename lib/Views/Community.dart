import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:varamala/Model/Gender.dart';
import 'package:varamala/Model/User.dart';
import 'package:varamala/Controller/Service.dart';
import 'package:varamala/Views/Fliterview.dart';
import 'package:varamala/Views/const.dart';

class Communities extends StatefulWidget {
  String index;
  Communities({required this.index});
  @override
  _CommunitiesState createState() => _CommunitiesState();
}

class _CommunitiesState extends State<Communities> {
  late Future<List<User>?> _user;
  List<Gender> _gender = [];
  void initState() {
    super.initState();
    _getuser();
    _getgen();
    _gender = [];
  }

  _getgen() async {
    Service.getgender().then((gender) {
      setState(() {
        _gender = gender;
      });
      print(_gender.length);
    });
  }

  _getuser() {
    _user = Service.getcommunity(widget.index);
  }

  String baseurl = "https://varmalaa.com/UPLOADS/Profile";
  String formater(String url) {
    return baseurl + url;
  }

  NetworkImage getImage(String imageName, String id) {
    String url = formater("/$id/$imageName");
    return NetworkImage(url);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text("Fliters"),
            backgroundColor: primaryColor,
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              tooltip: 'Menu Icon',
              onPressed: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => Fliterview()));
              },
            ),
          ),
          body: FutureBuilder<List<User>?>(
            future: _user,
            builder: (context, snapShot) {
              if (snapShot.connectionState == ConnectionState.waiting)
                return Center(
                  child: CircularProgressIndicator(),
                );
              else if (snapShot.hasError) {
                return Center(
                  child: Text("ERROR: ${snapShot.error}"),
                );
              } else {
                if (snapShot.hasData && snapShot.data!.isNotEmpty)
                  return body(snapShot.data, size);
                else //`snapShot.hasData` can be false if the `snapshot.data` is null
                  return Center(
                    child: Text(
                      "No Data Found",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                  );
              }
            },
          )),
    );
  }

  Widget body(List<User>? _astro, var size) {
    return SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(children: [
          ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: _astro!.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding:
                      const EdgeInsets.only(left: 18.0, right: 18.0, top: 12),
                  child: Container(
                    height: 210,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  (_astro[index].profile_photo == 'null' ||
                                          _astro[index].profile_photo == '')
                                      ? CircleAvatar(
                                          backgroundImage: AssetImage(
                                              'assets/Images/profile.png'),
                                          //backgroundImage: getImage(_user[index].profile_photo, _user[index].id),
                                          radius: 50,
                                        )
                                      : CircleAvatar(
                                          backgroundImage: getImage(
                                              _astro[index].profile_photo,
                                              _astro[index].id),
                                          radius: 50,
                                        ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        children: [
                                          Text(
                                            _astro[index].firstName,
                                            style: TextStyle(
                                                color: Colors.grey[800],
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            _astro[index].dob,
                                            style: TextStyle(
                                              color: Colors.grey[800],
                                              fontSize: 18,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          (_gender[0].is_plan == "0")
                                              ? Row(
                                                  children: [
                                                    Icon(
                                                      Icons.account_box,
                                                      color: Colors.blue,
                                                      size: 15,
                                                    ),
                                                    SizedBox(
                                                      width: 3,
                                                    ),
                                                    Text(
                                                      'CONTACT: **********',
                                                      style: TextStyle(
                                                          color: Colors.black
                                                              .withOpacity(0.7),
                                                          fontSize: 15),
                                                    )
                                                  ],
                                                )
                                              : Row(
                                                  children: [
                                                    Icon(
                                                      Icons.account_box,
                                                      color: Colors.blue,
                                                      size: 15,
                                                    ),
                                                    SizedBox(
                                                      width: 3,
                                                    ),
                                                    Text(
                                                      'CONTACT:' +
                                                          _astro[index].mobile,
                                                      style: TextStyle(
                                                          color: Colors.black
                                                              .withOpacity(0.7),
                                                          fontSize: 15),
                                                    )
                                                  ],
                                                ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          (_gender[0].is_plan == "0")
                                              ? Row(
                                                  children: [
                                                    Icon(
                                                      Icons
                                                          .perm_phone_msg_sharp,
                                                      color: Colors.blue,
                                                      size: 15,
                                                    ),
                                                    SizedBox(
                                                      width: 3,
                                                    ),
                                                    Text(
                                                      'WHATSAPP: ***********',
                                                      style: TextStyle(
                                                          color: Colors.black
                                                              .withOpacity(0.7),
                                                          fontSize: 15),
                                                    )
                                                  ],
                                                )
                                              : Row(
                                                  children: [
                                                    Icon(
                                                      Icons
                                                          .perm_phone_msg_sharp,
                                                      color: Colors.blue,
                                                      size: 15,
                                                    ),
                                                    SizedBox(
                                                      width: 3,
                                                    ),
                                                    Text(
                                                      'WHATSAPP:' +
                                                          _astro[index]
                                                              .whatsapp_no,
                                                      style: TextStyle(
                                                          color: Colors.black
                                                              .withOpacity(0.7),
                                                          fontSize: 15),
                                                    )
                                                  ],
                                                ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Icon(
                                    Icons.more_vert,
                                    color: Colors.black.withOpacity(0.3),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Divider(
                            color: Colors.grey,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                height: 40,
                                width: size.width * 0.65,
                                decoration: BoxDecoration(
                                    color: primaryColor,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        'MESSAGE',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                      ),
                                    ]),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
        ]));
  }
}
