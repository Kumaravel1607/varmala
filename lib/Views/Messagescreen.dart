import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:retry/retry.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:varamala/Controller/Sharedprefrence.dart';
import 'package:varamala/Model/Gender.dart';
import 'package:varamala/Model/message.dart';
import 'package:varamala/Controller/Service.dart';
import 'package:varamala/Views/Messages.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:varamala/Views/const.dart';

import 'Profile_view.dart';

class MessagesScreen extends StatefulWidget {
  String id = "";
  String name = "";

  var image;
  MessagesScreen({required this.id, required this.name, required this.image});

  @override
  _MessagesScreenState createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  String uid = "";
  String name = "";
  late List<Message> _message;
  late List<Gender> _gender;
  bool msgsent = false;
  bool _loading = true;
  bool loading = false;
  TextEditingController message = new TextEditingController();
  String baseurl = "https://varmalaa.com/UPLOADS/Profile";

  String formater(String url) {
    return baseurl + url;
  }

  NetworkImage getImage(String imageName, String id) {
    String url = formater("/$id/$imageName");
    return NetworkImage(url);
  }

  void initState() {
    super.initState();
    _message = [];
    _gender = [];
    get_id();
    _getmessage();
  }

  get_id() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      uid = pref.getString("id");
      name = pref.getString("name");
    });
  }

  static DateTime selectedDate = DateTime.now();
  static DateFormat formatter = DateFormat('yyyy-MM-dd');
  final String formatted = formatter.format(selectedDate);

  void sendmessage() async {
    print("-----------22");
    var url = "https://varmalaa.com/api/Demo/messagesent";
    var data = {
      "recpid": widget.id,
      "recpname": widget.name,
      "senderid": uid,
      "sendername": name,
      "message": message.text
    };
    print(jsonEncode(data));
    print(message.text);
    var res = await http.post(Uri.parse(url), body: data);
    print("data");
    var response = jsonDecode(res.body);
    print(response);
    if ((res.statusCode) == 200) {
      setState(() {
        print("ddd");
        _getmessage();
        // _message.add(Message(
        //     message: "message",
        //     date: "date",
        //     id: "id",
        //     sender_id: "sender_id"));
        loading = false;
      });
    } else {
      setState(() {
        var respomnsee = response['message'];
        _alerBox(respomnsee);
        print(respomnsee);
        loading = false;
      });
    }
  }

  _getmessage() async {
    final r = RetryOptions(maxDelay: Duration(seconds: 10), maxAttempts: 8);
    try {
      await r.retry(
        () async {
          print(widget.id);
          Service.getmessagep(widget.id).then((gender) {
            setState(() {
              _message = gender;
              _loading = false;
            });
          });
        },
        retryIf: (e) => e is SocketException || e is TimeoutException,
      );
    } finally {}
  }

  Future<void> _alerBox(message) async {
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return loading == true
              ? Container(
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(
                    backgroundColor: primaryColor,
                    valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                )
              : AlertDialog(
                  content: Text(message),
                  //title: Text(),
                  actions: <Widget>[
                    OutlinedButton(
                      onPressed: () {
                        Navigator.pop(context, "ok");
                      },
                      child: const Text("OK"),
                    )
                  ],
                );
        });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        centerTitle: true,
        title: GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => profile_view(id: widget.id)));
          },
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(widget.image),
              ),
              SizedBox(
                width: 10,
              ),
              Text(widget.name)
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Container(
                  height: size.height * 0.75,
                  child: _loading == true
                      ? SafeArea(
                          child: Center(
                              child: CircularProgressIndicator(
                          color: primaryColor,
                        )))
                      : (_message.length == 0)
                          ? Text("No message")
                          : RefreshIndicator(
                              onRefresh: () async {
                                _getmessage();
                              },
                              child: ListView.builder(
                                  physics: const BouncingScrollPhysics(
                                      parent: AlwaysScrollableScrollPhysics()),
                                  reverse: true,
                                  itemCount: _message.length,
                                  itemBuilder: (context, index) {
                                    return (_message[index].sender_id == uid)
                                        ? Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 7.0, right: 10),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: [
                                                    Container(
                                                      constraints:
                                                          BoxConstraints(
                                                              minWidth: 100,
                                                              maxWidth: 300),
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                        horizontal: 20 * 0.75,
                                                        vertical: 20 / 2,
                                                      ),
                                                      decoration: BoxDecoration(
                                                        color: primaryColor_bg,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(30),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Text(
                                                          _message[index]
                                                              .message,
                                                          style: TextStyle(
                                                              color:
                                                                  primaryColor),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(height: 5),
                                                    Text(
                                                      _message[index].date,
                                                      style: TextStyle(
                                                          color: Colors.grey),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              )
                                            ],
                                          )
                                        : Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 7.0, left: 10),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      constraints:
                                                          BoxConstraints(
                                                              minWidth: 100,
                                                              maxWidth: 200),
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                        horizontal: 20 * 0.75,
                                                        vertical: 20 / 2,
                                                      ),
                                                      decoration: BoxDecoration(
                                                        color: primaryColor_bg,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(30),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Text(
                                                          _message[index]
                                                              .message,
                                                          maxLines: 11,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                              color:
                                                                  primaryColor),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(height: 5),
                                                    Text(
                                                      _message[index].date,
                                                      style: TextStyle(
                                                          color: Colors.grey),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                            ],
                                          );
                                  }),
                            ),
                ),
                (msgsent)
                    ? Container(
                        constraints:
                            BoxConstraints(minWidth: 100, maxWidth: 200),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 7.0),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 20 * 0.75,
                                  vertical: 20 / 2,
                                ),
                                decoration: BoxDecoration(
                                  color: primaryColor_bg,
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    message.text,
                                    maxLines: 11,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(color: primaryColor),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            )
                          ],
                        ),
                      )
                    : SizedBox(
                        height: 5,
                      )
              ],
            ),
            Container(
                height: size.height * 0.1, child: ChatInputField(context)),
          ],
        ),
      ),
    );
  }

  Widget Body(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          SingleChildScrollView(
            physics: ScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: size.height * 0.75,
                  child: (_message.length == 0)
                      ? SafeArea(
                          child: Center(
                              child: CircularProgressIndicator(
                          color: primaryColor,
                        )))
                      : ListView.builder(
                          shrinkWrap: true,
                          itemCount: _message.length,
                          itemBuilder: (context, index) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 7.0),
                                  child: Container(
                                    width: size.width * 0.8,
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 20 * 0.75,
                                      vertical: 20 / 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: primaryColor,
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        _message[index].message,
                                        maxLines: 11,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                )
                              ],
                            );
                          }),
                ),
                Container(
                    height: size.height * 0.1,
                    child: Row(
                      children: [
                        ChatInputField(context),
                      ],
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget ChatInputField(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20 / 2,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 4),
            blurRadius: 32,
            color: Color(0xFF087949).withOpacity(0.08),
          ),
        ],
      ),
      child: Row(
        children: [
          loading == true
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      color: primaryColor,
                    ),
                  ),
                )
              : SizedBox(width: 10),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 20 * 0.75,
              ),
              decoration: BoxDecoration(
                color: primaryColor.withOpacity(0.05),
                borderRadius: BorderRadius.circular(40),
              ),
              child: Row(
                children: [
                  SizedBox(width: 20 / 4),
                  Expanded(
                    child: TextField(
                      controller: message,
                      decoration: InputDecoration(
                        hintText: "Type message",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        print("-------------");
                        sendmessage();
                        //  _getmessage();
                        message.clear();
                        setState(() {
                          loading = true;
                        });
                      },
                      icon: Icon(
                        Icons.send,
                        color: primaryColor,
                      ))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  AppBar buildAppBar(name, lname) {
    return AppBar(
      backgroundColor: primaryColor,
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          BackButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => Messages()));
            },
          ),
          //CircleAvatar(backgroundImage: img),
          SizedBox(width: 20 * 0.75),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name + " " + lname,
                style: TextStyle(fontSize: 16),
              ),
            ],
          )
        ],
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.local_phone),
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(Icons.videocam),
          onPressed: () {},
        ),
        SizedBox(width: 20 / 2),
      ],
    );
  }
}
