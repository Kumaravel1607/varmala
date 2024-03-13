import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:varamala/Controller/Sharedprefrence.dart';
import 'package:varamala/Views/Frontpage.dart';
import 'package:varamala/Views/Messages.dart';
import 'package:varamala/Views/Messagescreen.dart';
import 'package:varamala/Views/Profileview.dart';

import 'Views/Homepage.dart';

Future<void> main() async {
  var home_route = "/";
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // Get any messages which caused the application to open from
  // a terminated state.
  RemoteMessage? initialMessage =
      await FirebaseMessaging.instance.getInitialMessage();

  // If the message also contains a data property with a "type" of "chat",
  // navigate to a chat screen
  if (initialMessage?.data['status'] == '/Message') {
    print("Ddddddd");
    home_route = "/Message";
  }

  // Also handle any interaction when the app is in the background via a
  // Stream listener
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    if (message.data['status'] == '/Message') {
      home_route = "/Message";

      print('A new onMessageOpenedApp event was published! $home_route');
      print("current -- $home_route");

      //     // Navigator.pushNamed(context, '/message', arguments: Messages());
    }
  });
  print("current ++  $home_route");
  runApp(
    MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: home_route,
        routes: <String, WidgetBuilder>{
          "/": (BuildContext context) => new MyApp(),
          "/Message": (BuildContext context) => new Messages(),
        }),
  );
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();

  print('Handling a background message ${message.messageId}');
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late SharedPreferences sharedPreferences;
  var user_login = "";
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  @override
  void initState() {
    // getMessage();
    super.initState();
    // initFirebase();
    username();
  }

  // void initFirebase() {
  //   FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  //     print("onMessage: $message");
  //   });
  //   FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
  //     print("onMessageOpenedApp: $message");
  //   });
  // }

  username() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    print(_pref.getString("id"));
    setState(() {
      user_login = _pref.getString("id") != null ? _pref.getString("id") : "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xFF842269),
      ),
      home: user_login == "" ? Homepage() : Frontpage(),
    );
  }
}
