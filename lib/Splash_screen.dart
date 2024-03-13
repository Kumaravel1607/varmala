// import 'dart:async';
// import 'package:flutter/material.dart';

// import 'package:varamala/Views/Frontpage.dart';
// import 'package:varamala/Views/Homepage.dart';
// import 'package:varamala/Controller/Sharedprefrence.dart';

// class Splashscreen extends StatefulWidget {
//   @override
//   _Splashscreen createState() => _Splashscreen();
// }

// class _Splashscreen extends State<Splashscreen> {
//   var user = SharedPrefence.getUsername();

//   @override
//   void initState() {
//     super.initState();
//     Timer(Duration(seconds: 1), () async {
//       print(user);
//       if (user != "") {
//         Navigator.of(context).pushReplacement(
//             MaterialPageRoute(builder: (BuildContext context) => Frontpage()));
//       } else {
//         Navigator.of(context).pushReplacement(
//             MaterialPageRoute(builder: (BuildContext context) => Homepage()));
//       }
//       print("dd");
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Center(
//         child: Image.asset("assets/Images/logo.png"),
//       ),
//     );
//   }
// }
