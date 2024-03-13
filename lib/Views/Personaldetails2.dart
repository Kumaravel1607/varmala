// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:varamala/Views/Addpic.dart';

// class Personal1 extends StatefulWidget {
//   @override
//   _Personal1State createState() => _Personal1State();
// }

// class _Personal1State extends State<Personal1> {
//   @override
//   Widget build(BuildContext context) {
//     var size=MediaQuery.of(context).size;
//     return MaterialApp(
//       home: Scaffold(
//         body: SingleChildScrollView(
//           child: SafeArea(
//             child: Column(
//               children: [
//                 Padding(
//                     padding: EdgeInsets.only(top:10,left:15,right:15),
//                     child: TextField(
//                       decoration: InputDecoration(
//                         border: OutlineInputBorder(),
//                         labelText: 'Education',
//                         labelStyle: TextStyle(color: Colors.black),
//                       ),
//                     )
//                 ),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 Padding(
//                     padding: EdgeInsets.only(left:15,right:15),
//                     child: TextField(
//                       decoration: InputDecoration(
//                         border: OutlineInputBorder(),
//                         labelText: 'Occupation',
//                         labelStyle: TextStyle(color: Colors.black),
//                       ),
//                     )
//                 ),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 Padding(
//                     padding: EdgeInsets.only(left:15,right:15),
//                     child: TextField(
//                       decoration: InputDecoration(
//                         border: OutlineInputBorder(),
//                         labelText: 'Annual Income',
//                         labelStyle: TextStyle(color: Colors.black),
//                       ),
//                     )
//                 ),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 Padding(
//                     padding: EdgeInsets.only(left:15,right:15),
//                     child: TextField(
//                       decoration: InputDecoration(
//                         border: OutlineInputBorder(),
//                         labelText: 'Horoscope',
//                         labelStyle: TextStyle(color: Colors.black),
//                       ),
//                     )
//                 ),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 Padding(
//                     padding: EdgeInsets.only(left:15,right:15),
//                     child: TextField(
//                       decoration: InputDecoration(
//                         border: OutlineInputBorder(),
//                         labelText: 'Rasi',
//                         labelStyle: TextStyle(color: Colors.black),
//                       ),
//                     )
//                 ),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 Container(
//                   height: 90,
//                   width: size.width,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.only(left: 8.0,top: 10.0),
//                         child: Text('Physical Status',textAlign: TextAlign.left,style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.only(left: 18.0,right: 18.0,top: 8.0),
//                         child: Row(
//                           children: [
//                             Container(
//                               height: 40,
//                               width: size.width*0.3,
//                               decoration: BoxDecoration(
//                                   color:Colors.black.withOpacity(0.1),
//                                   borderRadius: BorderRadius.circular(20)
//                               ),
//                               child:
//                               Row(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   crossAxisAlignment: CrossAxisAlignment.center,
//                                   children:[
//                                     Text('Normal',textAlign:TextAlign.center,style: TextStyle(
//                                         color: Colors.black.withOpacity(0.8),
//                                         fontSize: 15,
//                                         fontWeight: FontWeight.bold
//                                     ),),
//                                   ]
//                               ),
//                             ),
//                             SizedBox(
//                               width: 5,
//                             ),
//                             Container(
//                               height: 40,
//                               width: size.width*0.45,
//                               decoration: BoxDecoration(
//                                   color:Colors.black.withOpacity(0.1),
//                                   borderRadius: BorderRadius.circular(20)
//                               ),
//                               child:
//                               Row(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   crossAxisAlignment: CrossAxisAlignment.center,
//                                   children:[
//                                     Text('Physically Challenged',textAlign:TextAlign.center,style: TextStyle(
//                                         color: Colors.black.withOpacity(0.8),
//                                         fontSize: 15,
//                                         fontWeight: FontWeight.bold
//                                     ),),
//                                   ]
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 Container(
//                   height: 150,
//                   width: size.width,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.only(left: 8.0,top: 10.0),
//                         child: Text('Physical Status',textAlign: TextAlign.left,style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.only(left: 18.0,right: 18.0,top: 8.0),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Row(
//                               children: [
//                                 Container(
//                                   height: 40,
//                                   width: size.width*0.3,
//                                   decoration: BoxDecoration(
//                                       color:Colors.black.withOpacity(0.1),
//                                       borderRadius: BorderRadius.circular(20)
//                                   ),
//                                   child:
//                                   Row(
//                                       mainAxisAlignment: MainAxisAlignment.center,
//                                       crossAxisAlignment: CrossAxisAlignment.center,
//                                       children:[
//                                         Text('Middle Class',textAlign:TextAlign.center,style: TextStyle(
//                                             color: Colors.black.withOpacity(0.8),
//                                             fontSize: 15,
//                                             fontWeight: FontWeight.bold
//                                         ),),
//                                       ]
//                                   ),
//                                 ),
//                                 SizedBox(
//                                   width: 5,
//                                 ),
//                                 Container(
//                                   height: 40,
//                                   width: size.width*0.45,
//                                   decoration: BoxDecoration(
//                                       color:Colors.black.withOpacity(0.1),
//                                       borderRadius: BorderRadius.circular(20)
//                                   ),
//                                   child:
//                                   Row(
//                                       mainAxisAlignment: MainAxisAlignment.center,
//                                       crossAxisAlignment: CrossAxisAlignment.center,
//                                       children:[
//                                         Text('Upper Middle Class',textAlign:TextAlign.center,style: TextStyle(
//                                             color: Colors.black.withOpacity(0.8),
//                                             fontSize: 15,
//                                             fontWeight: FontWeight.bold
//                                         ),),
//                                       ]
//                                   ),

//                                 ),
//                               ],
//                             ),
//                             SizedBox(
//                               height: 10,
//                             ),
//                             Container(
//                               height: 40,
//                               width: size.width*0.45,
//                               decoration: BoxDecoration(
//                                   color:Colors.black.withOpacity(0.1),
//                                   borderRadius: BorderRadius.circular(20)
//                               ),
//                               child:
//                               Row(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   crossAxisAlignment: CrossAxisAlignment.center,
//                                   children:[
//                                     Text('Rich / Affluent',textAlign:TextAlign.center,style: TextStyle(
//                                         color: Colors.black.withOpacity(0.8),
//                                         fontSize: 15,
//                                         fontWeight: FontWeight.bold
//                                     ),),
//                                   ]
//                               ),

//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Container(
//                   height: 90,
//                   width: size.width,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.only(left: 8.0,top: 10.0),
//                         child: Text('Family Type',textAlign: TextAlign.left,style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.only(left: 18.0,right: 18.0,top: 8.0),
//                         child: Row(
//                           children: [
//                             Container(
//                               height: 40,
//                               width: size.width*0.3,
//                               decoration: BoxDecoration(
//                                   color:Colors.black.withOpacity(0.1),
//                                   borderRadius: BorderRadius.circular(20)
//                               ),
//                               child:
//                               Row(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   crossAxisAlignment: CrossAxisAlignment.center,
//                                   children:[
//                                     Text('Joint Family',textAlign:TextAlign.center,style: TextStyle(
//                                         color: Colors.black.withOpacity(0.8),
//                                         fontSize: 15,
//                                         fontWeight: FontWeight.bold
//                                     ),),
//                                   ]
//                               ),
//                             ),
//                             SizedBox(
//                               width: 5,
//                             ),
//                             Container(
//                               height: 40,
//                               width: size.width*0.45,
//                               decoration: BoxDecoration(
//                                   color:Colors.black.withOpacity(0.1),
//                                   borderRadius: BorderRadius.circular(20)
//                               ),
//                               child:
//                               Row(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   crossAxisAlignment: CrossAxisAlignment.center,
//                                   children:[
//                                     Text('Nuclear Family',textAlign:TextAlign.center,style: TextStyle(
//                                         color: Colors.black.withOpacity(0.8),
//                                         fontSize: 15,
//                                         fontWeight: FontWeight.bold
//                                     ),),
//                                   ]
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.only(left: 8.0),
//                         child: Text('About Me',textAlign: TextAlign.left,style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),),
//                       ),
//                       SizedBox(
//                         height: 8,
//                       ),
//                       Container(
//     height: 80.0,
//     decoration: BoxDecoration(
//             shape: BoxShape.rectangle,
//             color: Colors.black.withOpacity(0.2),
//     borderRadius: BorderRadius.all(
//     Radius.circular(8.0),
//     ),
//     ),
//     child:TextFormField(
//     textAlign: TextAlign.left,
//     decoration: InputDecoration(
//     hintText: 'Boi..',
//     hintStyle: TextStyle(
//     color: Colors.black.withOpacity(0.8),
//     ),
//     contentPadding: EdgeInsets.all(40.0),
//     fillColor: Colors.white,
//     ),
//     ),
//     ),
//                     ],
//                   ),
//                 ),
//                 SizedBox(
//                   height: 5,
//                 ),
//                 InkWell(
//                   onTap: (){
//                     Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>ProfilePicture()));
//                   },
//                   child: Container(
//                     height: 50,
//                     width: size.width*0.65,
//                     decoration: BoxDecoration(
//                         color:Colors.purple,
//                         borderRadius: BorderRadius.circular(10)
//                     ),
//                     child:
//                     Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children:[
//                           Text('Continue',textAlign:TextAlign.center,style: TextStyle(
//                             color: Colors.white,
//                             fontWeight: FontWeight.bold,
//                             fontSize: 20,
//                           ),),
//                         ]
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 10,
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
