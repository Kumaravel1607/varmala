import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:varamala/Model/Occupation.dart';
import 'package:varamala/Model/State.dart';
import 'package:varamala/Model/puser.dart';
import 'package:varamala/Controller/Service.dart';
import 'package:varamala/Model/Country.dart';
import 'package:varamala/Views/const.dart';

class Profileview extends StatefulWidget {
  String id;
  Profileview({required this.id});
  @override
  _ProfileviewState createState() => _ProfileviewState();
}

class _ProfileviewState extends State<Profileview> {
  List<Occupation> _professiontype = [];
  List<Occupation> communitytype = [];
  List<Occupation> castetype = [];
  List<Puser> _user = [];
  List<States> statelist = [];
  List<Country> countrylist = [];
  void initState() {
    super.initState();
    _professiontype = [];
    communitytype = [];
    castetype = [];
    _user = [];
    statelist = [];
    countrylist = [];
    _getocc();
    _getcas();
    _getcom();
    _getuser();
    _getcou();
    _getsts();
  }

  _getocc() {
    Service.getprof().then((users) {
      setState(() {
        _professiontype = users;
      });

      print(_professiontype.length);
    });
  }

  _getcom() {
    Service.getcom().then((users) {
      setState(() {
        communitytype = users;
      });

      print(communitytype.length);
    });
  }

  _getcas() {
    Service.getcas().then((users) {
      setState(() {
        castetype = users;
      });

      print(castetype.length);
    });
  }

  _getcou() {
    Service.getc().then((users) {
      setState(() {
        countrylist = users;
      });

      print(countrylist.length);
    });
  }

  _getsts() {
    Service.gets().then((users) {
      setState(() {
        statelist = users;
      });

      print(statelist.length);
    });
  }

  _getuser() {
    Service.getpuser(widget.id).then((users) {
      setState(() {
        _user = users;
      });
      print("Length ${_user.length}");
      print(_user[0].whatapp_no);
    });
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
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: primaryColor,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: Colors.grey[850],
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: (_user.length == 0)
            ? Center(
                child: CircularProgressIndicator(
                  color: primaryColor,
                ),
              )
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          (_user[0].profile_photo == 'null' ||
                                  _user[0].profile_photo == '')
                              ? CircleAvatar(
                                  radius: 70,
                                  backgroundColor: primaryColor,
                                  child: Text(
                                    _user[0].first_name[0].toUpperCase(),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 40,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                )
                              : CircleAvatar(
                                  backgroundImage: getImage(
                                      _user[0].profile_photo, _user[0].id),
                                  radius: 120,
                                ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text(
                          _user[0].first_name + " " + _user[0].last_name,
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Divider(
                        color: Colors.grey[850],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text(
                          "Mobile: " + _user[0].mobile,
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Divider(
                        color: Colors.grey[850],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text(
                          "WhatsApp No: " + _user[0].whatapp_no,
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Divider(
                        color: Colors.grey[850],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text(
                          "Email: " + _user[0].email,
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Divider(
                        color: Colors.grey[850],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text(
                          "DOB: " + _user[0].dob,
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Divider(
                        color: Colors.grey[850],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text(
                          "Country: " +
                              countrylist[int.parse(_user[0].country) - 1].name,
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Divider(
                        color: Colors.grey[850],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      /*Padding(
                  padding: const EdgeInsets.only(left:10.0),
                  child: Text("State: "+statelist[int.parse(_user[0].state)-1].state_name,style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20
                  ),),
                ),
                SizedBox(
                  height:10,
                ),
                Divider(
                  color: Colors.grey[850],
                ),
                SizedBox(
                  height:10,
                ),*/
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text(
                          "City: " + (_user[0].city),
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Divider(
                        color: Colors.grey[850],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text(
                          "Address: " + (_user[0].address),
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Divider(
                        color: Colors.grey[850],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text(
                          "Description: " + (_user[0].description),
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Divider(
                        color: Colors.grey[850],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text(
                          "Height: " + (_user[0].height),
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Divider(
                        color: Colors.grey[850],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text(
                          "Weight: " + (_user[0].weight),
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Divider(
                        color: Colors.grey[850],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text(
                          "Proffesion: " +
                              _professiontype[
                                      int.parse(_user[0].occupation) - 1]
                                  .name,
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Divider(
                        color: Colors.grey[850],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      /*Padding(
                  padding: const EdgeInsets.only(left:10.0),
                  child: Text("Caste: "+castetype[int.parse(_user[0].caste)-1].name,style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20
                  ),),
                ),
                SizedBox(
                  height:10,
                ),
                Divider(
                  color: Colors.grey[850],
                ),
                SizedBox(
                  height:10,
                ),*/
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text(
                          "Community: " +
                              communitytype[int.parse(_user[0].community) - 1]
                                  .name,
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Divider(
                        color: Colors.grey[850],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text(
                          "Education: " + (_user[0].education),
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Divider(
                        color: Colors.grey[850],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text(
                          "Father's Name: " + (_user[0].father_name),
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Divider(
                        color: Colors.grey[850],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text(
                          "Mother's Name: " + (_user[0].mother_name),
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Divider(
                        color: Colors.grey[850],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text(
                          "Father's Occupation: " +
                              (_user[0].father_occupation),
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Divider(
                        color: Colors.grey[850],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      (_user[0].is_smoking == 2)
                          ? Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Text(
                                "IS SMOKING: NO",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                            )
                          : Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Text(
                                "IS SMOKING: YES",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                            ),
                      SizedBox(
                        height: 10,
                      ),
                      Divider(
                        color: Colors.grey[850],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      (_user[0].is_drink == 2)
                          ? Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Text(
                                "IS DRINKING: NO",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                            )
                          : Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Text(
                                "IS DRINKING: OCCASIONALLY",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                            ),
                      SizedBox(
                        height: 10,
                      ),
                      Divider(
                        color: Colors.grey[850],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
