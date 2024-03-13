// import 'package:camera/camera.dart';
// import 'dart:io';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:responsive_builder/responsive_builder.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:varamala/Views/Frontpage.dart';
// import 'package:varamala/Views/Personaldetails2.dart';

// import 'Profilecamera.dart';

// class ProfilePicture extends StatefulWidget {
//   @override
//   _ProfilePictureState createState() => _ProfilePictureState();
// }

// class _ProfilePictureState extends State<ProfilePicture> {
//   late CameraController _cameraController;
//   late List<CameraDescription> cameras;

//   @override
//   void initState() {
//     _initializedCamera();
//     super.initState();
//   }

//   @override
//   void dispose() {
//     _cameraController.dispose();
//     super.dispose();
//   }

//   _initializedCamera() async {
//     cameras = await availableCameras();
//     _cameraController =
//         CameraController(cameras[0], ResolutionPreset.ultraHigh);
//     _cameraController.initialize().then((value) {
//       if (!mounted) return;
//       setState(() {});
//     });
//   }

//   late File _Image;
//   ImagePicker? picker = ImagePicker();
//   _pickImage() async {
//     PickedFile? pickedFile =
//         await picker!.getImage(source: ImageSource.gallery);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ResponsiveBuilder(
//         builder: (BuildContext context, SizingInformation sizingInformation) {
//       return Material(
//           child: Stack(
//         children: [
//           Container(
//             width: sizingInformation.screenSize.width,
//             height: sizingInformation.screenSize.height,
//             decoration: BoxDecoration(
//               color: Colors.black,
//             ),
//           ),
//           SafeArea(
//             child: IconButton(
//               icon: Icon(
//                 Icons.arrow_back,
//                 color: Colors.white,
//                 size: 30.0,
//               ),
//               onPressed: () => Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => Personal1()),
//               ),
//             ),
//           ),
//           Center(
//             child: Container(
//               height: sizingInformation.screenSize.height * 0.6,
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: <Widget>[
//                   Column(
//                     children: <Widget>[
//                       CircleAvatar(
//                         backgroundImage:
//                             AssetImage('assets/Images/profile.png'),
//                         radius: sizingInformation.screenSize.width * 0.2,
//                       ),
//                       SizedBox(
//                         height: 30,
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           InkWell(
//                             onTap: () => Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) => Profilecamera()),
//                             ),
//                             child: Container(
//                               height: 35,
//                               width: sizingInformation.screenSize.width * 0.45,
//                               decoration: BoxDecoration(
//                                   color: Colors.white12,
//                                   borderRadius:
//                                       BorderRadius.all(Radius.circular(5))),
//                               child: Text(
//                                 "Camera",
//                                 textAlign: TextAlign.center,
//                                 style: TextStyle(
//                                   color: Colors.white,
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: 20.0,
//                                 ),
//                               ),
//                             ),
//                           ),
//                           SizedBox(
//                             width: 5,
//                           ),
//                           InkWell(
//                             onTap: () => _pickImage(),
//                             child: Container(
//                               width: sizingInformation.screenSize.width * 0.45,
//                               height: 35,
//                               decoration: BoxDecoration(
//                                   color: Colors.white12,
//                                   borderRadius:
//                                       BorderRadius.all(Radius.circular(5))),
//                               child: Text(
//                                 "Gallery",
//                                 textAlign: TextAlign.center,
//                                 style: TextStyle(
//                                     color: Colors.white,
//                                     fontWeight: FontWeight.bold,
//                                     fontSize: 20.0),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                       SizedBox(
//                         height: 20,
//                       ),
//                       Container(
//                         width: sizingInformation.screenSize.width * 0.45,
//                         height: 35,
//                         decoration: BoxDecoration(
//                             color: Colors.red,
//                             borderRadius: BorderRadius.all(Radius.circular(5))),
//                         child: Text(
//                           "Remove",
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontWeight: FontWeight.bold,
//                             fontSize: 20.0,
//                           ),
//                           textAlign: TextAlign.center,
//                         ),
//                       ),
//                       SizedBox(
//                         height: 180,
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           Positioned(
//               bottom: 20,
//               left: sizingInformation.screenSize.width * 0.45,
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   InkWell(
//                     onTap: () {
//                       Navigator.push(context,
//                           MaterialPageRoute(builder: (context) => Frontpage()));
//                     },
//                     child: Text(
//                       'Do It later',
//                       style: TextStyle(
//                         color: Colors.purpleAccent,
//                         fontSize: 15,
//                       ),
//                     ),
//                   ),
//                 ],
//               ))
//         ],
//       ));
//     });
//   }
// }
