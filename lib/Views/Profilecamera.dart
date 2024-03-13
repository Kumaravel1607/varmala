// import 'package:camera/camera.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:responsive_builder/responsive_builder.dart';

// import 'Addpic.dart';
// List<CameraDescription>? cameras=  availableCameras() as List<CameraDescription>;
// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();

//   runApp(Profilecamera());
// }class Profilecamera extends StatefulWidget {
//   @override
//   _ProfilecameraState createState() => _ProfilecameraState();
// }

// class _ProfilecameraState extends State<Profilecamera> {
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
//     _cameraController = CameraController(cameras[0],  ResolutionPreset.max);
//     _cameraController.initialize().then((_) {
//       if (!mounted) return;
//       setState(() {});
//     });
//   }
//   @override
//   Widget build(BuildContext context) {
//     return ResponsiveBuilder(
//         builder:(BuildContext context, SizingInformation sizingInformation){
//           return Material(
//             child: Stack(
//               children: [

//                 Container(
//                   height:sizingInformation.screenSize.height,
//                   child: _cameraController == null || !_cameraController.value.isInitialized
//                       ? Center(
//                     child: CircularProgressIndicator(backgroundColor: Colors.white,),
//                   )
//                       : Container(
//                       child: CameraPreview(_cameraController)
//                   ),
//                 ),
//                 SafeArea
//                   (
//                     child:Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         InkWell(
//                           onTap: ()=> Navigator.push(
//                             context,
//                             MaterialPageRoute(builder: (context) => ProfilePicture()),
//                           ),
//                           child:Icon(Icons.cancel,color: Colors.white,),
//                         ),
//                       ],
//                     )
//                 ),
//                 Column(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Center(child:Icon(Icons.radio_button_off_rounded,color: Colors.orange,size: 90)),

//                   ],
//                 )
//               ],
//             ),
//           );
//         }
//     );
//   }
// }
