import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:varamala/Controller/Service.dart';
import 'package:varamala/Controller/Sharedprefrence.dart';
import 'package:varamala/Model/Chat_screen.dart';
import 'package:varamala/Views/Frontpage.dart';
import 'package:varamala/Views/Homepage.dart';
import 'package:varamala/Views/Messagescreen.dart';
import 'package:varamala/Views/const.dart';
import 'package:varamala/main.dart';

class Messages extends StatefulWidget {
  const Messages({Key? key}) : super(key: key);
  @override
  _MessagesState createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  String login_id = "";
  late List<Chat> chat_list;

  bool _loading = true;

  @override
  void initState() {
    super.initState();
    get_id();
    chat_list = [];
    get_message();
  }

  get_id() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      login_id = pref.getString("id");
    });
  }

  get_message() async {
    Service.getmessage().then((chat_data) {
      if (mounted) {
        setState(() {
          pr(chat_data);
          chat_list = chat_data;
          _loading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        get_message();
      },
      child: Scaffold(
          backgroundColor: primaryColor_bg,
          appBar: AppBar(
            leading: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Frontpage()),
                    )),
            backgroundColor: primaryColor,
            title: Text("Chats"),
          ),
          body: _loading == true
              ? Center(
                  child: CircularProgressIndicator(
                  color: primaryColor,
                ))
              : chat_list.length == 0
                  ? Center(
                      child: Text("No Message"),
                    )
                  : ListView.builder(
                      physics: const BouncingScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics()),
                      shrinkWrap: true,
                      itemCount: chat_list.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          child: GestureDetector(
                            onTap: () {
                              print(chat_list[index].senderid);
                              print("-----------");
                              print(chat_list[index].recpid);
                              print("-----------");

                              setState(() {
                                chat_list[index].unRead = "0";
                              });

                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MessagesScreen(
                                          id: chat_list[index].senderid !=
                                                  login_id
                                              ? chat_list[index].senderid
                                              : chat_list[index].recpid,
                                          name: chat_list[index].displayName,
                                          image:
                                              chat_list[index].displayImage)));
                            },
                            child: Card(
                              elevation: 5,
                              child: ListTile(
                                title: Text(
                                  chat_list[index].displayName,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                subtitle: Text(
                                  chat_list[index].message,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                trailing: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      chat_list[index].date,
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.greenAccent[700]),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    chat_list[index].unRead == "0"
                                        ? SizedBox()
                                        : Container(
                                            child: Center(
                                              child: Text(
                                                chat_list[index].unRead,
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                            height: 20,
                                            width: 20,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: Colors.greenAccent[700]),
                                          )
                                  ],
                                ),
                                contentPadding: EdgeInsets.all(8),
                                leading: CircleAvatar(
                                  backgroundImage: NetworkImage(
                                      chat_list[index].displayImage),
                                  radius: 25,
                                ),
                              ),
                            ),
                          ),
                        );
                      })),
    );
  }

  Padding textTile() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Card(
        elevation: 5,
        child: ListTile(
          title: Text(
            "Name",
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Text(
            "hi there , this hash ref from earth hjgfjhg fjkash gfkjsag fjkhg",
            overflow: TextOverflow.ellipsis,
          ),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "yesterday",
                style: TextStyle(fontSize: 12, color: Colors.greenAccent[700]),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                child: Center(
                  child: Text(
                    "1",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                height: 20,
                width: 20,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.greenAccent[700]),
              )
            ],
          ),
          contentPadding: EdgeInsets.all(8),
          leading: CircleAvatar(
            backgroundImage:
                NetworkImage("https://wallpaperaccess.com/full/1213643.jpg"),
            radius: 25,
          ),
        ),
      ),
    );
  }
}
