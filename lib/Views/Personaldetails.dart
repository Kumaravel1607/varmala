// import 'package:csc_picker/csc_picker.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:varamala/Views/Personaldetails2.dart';
// import 'package:varamala/Views/Profile.dart';

// import 'Addpic.dart';

// class Personal extends StatefulWidget {
//   @override
//   _PersonalState createState() => _PersonalState();
// }

// class _PersonalState extends State<Personal> {
//   String countryValue = "";
//   String stateValue = "";
//   String cityValue = "";
//   @override
//   Widget build(BuildContext context) {
//     var size = MediaQuery.of(context).size;
//     return MaterialApp(
//       home: Scaffold(
//         body: SingleChildScrollView(
//           child: SafeArea(
//             child: Column(
//               children: [
//                 Container(
//                   height: 90,
//                   width: size.width,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.only(left: 8.0, top: 10.0),
//                         child: Text(
//                           'Gender',
//                           textAlign: TextAlign.left,
//                           style: TextStyle(
//                               color: Colors.black,
//                               fontSize: 20,
//                               fontWeight: FontWeight.bold),
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.only(
//                             left: 18.0, right: 18.0, top: 8.0),
//                         child: Row(
//                           children: [
//                             Container(
//                               height: 40,
//                               width: size.width * 0.3,
//                               decoration: BoxDecoration(
//                                   color: Colors.black.withOpacity(0.1),
//                                   borderRadius: BorderRadius.circular(20)),
//                               child: Row(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   crossAxisAlignment: CrossAxisAlignment.center,
//                                   children: [
//                                     Text(
//                                       'Male',
//                                       textAlign: TextAlign.center,
//                                       style: TextStyle(
//                                           color: Colors.black.withOpacity(0.8),
//                                           fontSize: 15,
//                                           fontWeight: FontWeight.bold),
//                                     ),
//                                   ]),
//                             ),
//                             SizedBox(
//                               width: 5,
//                             ),
//                             Container(
//                               height: 40,
//                               width: size.width * 0.3,
//                               decoration: BoxDecoration(
//                                   color: Colors.black.withOpacity(0.1),
//                                   borderRadius: BorderRadius.circular(20)),
//                               child: Row(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   crossAxisAlignment: CrossAxisAlignment.center,
//                                   children: [
//                                     Text(
//                                       'Female',
//                                       textAlign: TextAlign.center,
//                                       style: TextStyle(
//                                           color: Colors.black.withOpacity(0.8),
//                                           fontSize: 15,
//                                           fontWeight: FontWeight.bold),
//                                     ),
//                                   ]),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 SizedBox(
//                   height: 5,
//                 ),
//                 Container(
//                   height: 150,
//                   width: size.width,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.only(left: 8.0, top: 10.0),
//                         child: Text(
//                           'Marital Status',
//                           textAlign: TextAlign.left,
//                           style: TextStyle(
//                               color: Colors.black,
//                               fontSize: 20,
//                               fontWeight: FontWeight.bold),
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.only(left: 18.0, right: 18.0),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Container(
//                               height: 40,
//                               width: size.width * 0.3,
//                               decoration: BoxDecoration(
//                                   color: Colors.black.withOpacity(0.1),
//                                   borderRadius: BorderRadius.circular(20)),
//                               child: Row(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   crossAxisAlignment: CrossAxisAlignment.center,
//                                   children: [
//                                     Text(
//                                       'Unmarried',
//                                       textAlign: TextAlign.center,
//                                       style: TextStyle(
//                                           color: Colors.black.withOpacity(0.8),
//                                           fontSize: 15,
//                                           fontWeight: FontWeight.bold),
//                                     ),
//                                   ]),
//                             ),
//                             Container(
//                               height: 40,
//                               width: size.width * 0.3,
//                               decoration: BoxDecoration(
//                                   color: Colors.black.withOpacity(0.1),
//                                   borderRadius: BorderRadius.circular(20)),
//                               child: Row(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   crossAxisAlignment: CrossAxisAlignment.center,
//                                   children: [
//                                     Text(
//                                       'Divorced',
//                                       textAlign: TextAlign.center,
//                                       style: TextStyle(
//                                           color: Colors.black.withOpacity(0.8),
//                                           fontSize: 15,
//                                           fontWeight: FontWeight.bold),
//                                     ),
//                                   ]),
//                             ),
//                             Container(
//                               height: 40,
//                               width: size.width * 0.3,
//                               decoration: BoxDecoration(
//                                   color: Colors.black.withOpacity(0.1),
//                                   borderRadius: BorderRadius.circular(20)),
//                               child: Row(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   crossAxisAlignment: CrossAxisAlignment.center,
//                                   children: [
//                                     Text(
//                                       'Widower',
//                                       textAlign: TextAlign.center,
//                                       style: TextStyle(
//                                           color: Colors.black.withOpacity(0.8),
//                                           fontSize: 15,
//                                           fontWeight: FontWeight.bold),
//                                     ),
//                                   ]),
//                             ),
//                           ],
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.only(left: 18.0, right: 18.0),
//                         child: Container(
//                           height: 40,
//                           width: size.width * 0.3,
//                           decoration: BoxDecoration(
//                               color: Colors.black.withOpacity(0.1),
//                               borderRadius: BorderRadius.circular(20)),
//                           child: Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               children: [
//                                 Text(
//                                   'Widower',
//                                   textAlign: TextAlign.center,
//                                   style: TextStyle(
//                                       color: Colors.black.withOpacity(0.8),
//                                       fontSize: 15,
//                                       fontWeight: FontWeight.bold),
//                                 ),
//                               ]),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.only(left: 8.0, top: 10.0),
//                       child: Text(
//                         'Permanent Residency',
//                         textAlign: TextAlign.left,
//                         style: TextStyle(
//                             color: Colors.black,
//                             fontSize: 20,
//                             fontWeight: FontWeight.bold),
//                       ),
//                     ),
//                     SizedBox(
//                       height: 10,
//                     ),
//                     Container(
//                         padding: EdgeInsets.symmetric(horizontal: 20),
//                         child: Column(
//                           children: [
//                             CSCPicker(
//                               showStates: true,
//                               showCities: false,
//                               flagState: CountryFlag.DISABLE,
//                               dropdownDecoration: BoxDecoration(
//                                   borderRadius:
//                                       BorderRadius.all(Radius.circular(10)),
//                                   color: Colors.grey.shade300,
//                                   border: Border.all(
//                                       color: Colors.grey.shade300, width: 1)),
//                               disabledDropdownDecoration: BoxDecoration(
//                                   borderRadius:
//                                       BorderRadius.all(Radius.circular(10)),
//                                   color: Colors.grey.shade300,
//                                   border: Border.all(
//                                       color: Colors.grey.shade300, width: 1)),
//                               defaultCountry: DefaultCountry.India,
//                               selectedItemStyle: TextStyle(
//                                 color: Colors.black,
//                                 fontSize: 14,
//                               ),
//                               dropdownHeadingStyle: TextStyle(
//                                   color: Colors.black,
//                                   fontSize: 17,
//                                   fontWeight: FontWeight.bold),
//                               dropdownItemStyle: TextStyle(
//                                 color: Colors.black,
//                                 fontSize: 14,
//                               ),
//                               dropdownDialogRadius: 10.0,
//                               searchBarRadius: 10.0,
//                               onCountryChanged: (value) {
//                                 setState(() {
//                                   countryValue = value;
//                                 });
//                               },
//                               onStateChanged: (value) {
//                                 setState(() {
//                                   stateValue = value!;
//                                 });
//                               },
//                               onCityChanged: (value) {
//                                 setState(() {
//                                   cityValue = value!;
//                                 });
//                               },
//                             ),
//                           ],
//                         )),
//                   ],
//                 ),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.only(left: 8.0, top: 10.0),
//                       child: Text(
//                         'Current Residency',
//                         textAlign: TextAlign.left,
//                         style: TextStyle(
//                             color: Colors.black,
//                             fontSize: 20,
//                             fontWeight: FontWeight.bold),
//                       ),
//                     ),
//                     SizedBox(
//                       height: 10,
//                     ),
//                     Container(
//                         padding: EdgeInsets.symmetric(horizontal: 20),
//                         child: Column(
//                           children: [
//                             CSCPicker(
//                               showStates: true,
//                               showCities: true,
//                               flagState: CountryFlag.ENABLE,
//                               dropdownDecoration: BoxDecoration(
//                                   borderRadius:
//                                       BorderRadius.all(Radius.circular(10)),
//                                   color: Colors.grey.shade300,
//                                   border: Border.all(
//                                       color: Colors.grey.shade300, width: 1)),
//                               disabledDropdownDecoration: BoxDecoration(
//                                   borderRadius:
//                                       BorderRadius.all(Radius.circular(10)),
//                                   color: Colors.grey.shade300,
//                                   border: Border.all(
//                                       color: Colors.grey.shade300, width: 1)),
//                               defaultCountry: DefaultCountry.India,
//                               selectedItemStyle: TextStyle(
//                                 color: Colors.black,
//                                 fontSize: 14,
//                               ),
//                               dropdownHeadingStyle: TextStyle(
//                                   color: Colors.black,
//                                   fontSize: 17,
//                                   fontWeight: FontWeight.bold),
//                               dropdownItemStyle: TextStyle(
//                                 color: Colors.black,
//                                 fontSize: 14,
//                               ),
//                               dropdownDialogRadius: 10.0,
//                               searchBarRadius: 10.0,
//                               onCountryChanged: (value) {
//                                 setState(() {
//                                   countryValue = value;
//                                 });
//                               },
//                               onStateChanged: (value) {
//                                 setState(() {
//                                   stateValue = value!;
//                                 });
//                               },
//                               onCityChanged: (value) {
//                                 setState(() {
//                                   cityValue = value!;
//                                 });
//                               },
//                             ),
//                           ],
//                         )),
//                   ],
//                 ),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 Padding(
//                     padding: EdgeInsets.only(top: 10, left: 15, right: 15),
//                     child: TextField(
//                       decoration: InputDecoration(
//                         border: OutlineInputBorder(),
//                         labelText: 'Education',
//                         labelStyle: TextStyle(color: Colors.black),
//                       ),
//                     )),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 Padding(
//                     padding: EdgeInsets.only(left: 15, right: 15),
//                     child: TextField(
//                       decoration: InputDecoration(
//                         border: OutlineInputBorder(),
//                         labelText: 'Occupation',
//                         labelStyle: TextStyle(color: Colors.black),
//                       ),
//                     )),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 Padding(
//                     padding: EdgeInsets.only(left: 15, right: 15),
//                     child: TextField(
//                       decoration: InputDecoration(
//                         border: OutlineInputBorder(),
//                         labelText: 'Annual Income',
//                         labelStyle: TextStyle(color: Colors.black),
//                       ),
//                     )),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 Padding(
//                     padding: EdgeInsets.only(left: 15, right: 15),
//                     child: TextField(
//                       decoration: InputDecoration(
//                         border: OutlineInputBorder(),
//                         labelText: 'Horoscope',
//                         labelStyle: TextStyle(color: Colors.black),
//                       ),
//                     )),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 Padding(
//                     padding: EdgeInsets.only(left: 15, right: 15),
//                     child: TextField(
//                       decoration: InputDecoration(
//                         border: OutlineInputBorder(),
//                         labelText: 'Rasi',
//                         labelStyle: TextStyle(color: Colors.black),
//                       ),
//                     )),
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
//                         padding: const EdgeInsets.only(left: 8.0, top: 10.0),
//                         child: Text(
//                           'Physical Status',
//                           textAlign: TextAlign.left,
//                           style: TextStyle(
//                               color: Colors.black,
//                               fontSize: 20,
//                               fontWeight: FontWeight.bold),
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.only(
//                             left: 18.0, right: 18.0, top: 8.0),
//                         child: Row(
//                           children: [
//                             Container(
//                               height: 40,
//                               width: size.width * 0.3,
//                               decoration: BoxDecoration(
//                                   color: Colors.black.withOpacity(0.1),
//                                   borderRadius: BorderRadius.circular(20)),
//                               child: Row(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   crossAxisAlignment: CrossAxisAlignment.center,
//                                   children: [
//                                     Text(
//                                       'Normal',
//                                       textAlign: TextAlign.center,
//                                       style: TextStyle(
//                                           color: Colors.black.withOpacity(0.8),
//                                           fontSize: 15,
//                                           fontWeight: FontWeight.bold),
//                                     ),
//                                   ]),
//                             ),
//                             SizedBox(
//                               width: 5,
//                             ),
//                             Container(
//                               height: 40,
//                               width: size.width * 0.45,
//                               decoration: BoxDecoration(
//                                   color: Colors.black.withOpacity(0.1),
//                                   borderRadius: BorderRadius.circular(20)),
//                               child: Row(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   crossAxisAlignment: CrossAxisAlignment.center,
//                                   children: [
//                                     Text(
//                                       'Physically Challenged',
//                                       textAlign: TextAlign.center,
//                                       style: TextStyle(
//                                           color: Colors.black.withOpacity(0.8),
//                                           fontSize: 15,
//                                           fontWeight: FontWeight.bold),
//                                     ),
//                                   ]),
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
//                         padding: const EdgeInsets.only(left: 8.0, top: 10.0),
//                         child: Text(
//                           'Physical Status',
//                           textAlign: TextAlign.left,
//                           style: TextStyle(
//                               color: Colors.black,
//                               fontSize: 20,
//                               fontWeight: FontWeight.bold),
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.only(
//                             left: 18.0, right: 18.0, top: 8.0),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Row(
//                               children: [
//                                 Container(
//                                   height: 40,
//                                   width: size.width * 0.3,
//                                   decoration: BoxDecoration(
//                                       color: Colors.black.withOpacity(0.1),
//                                       borderRadius: BorderRadius.circular(20)),
//                                   child: Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.center,
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.center,
//                                       children: [
//                                         Text(
//                                           'Middle Class',
//                                           textAlign: TextAlign.center,
//                                           style: TextStyle(
//                                               color:
//                                                   Colors.black.withOpacity(0.8),
//                                               fontSize: 15,
//                                               fontWeight: FontWeight.bold),
//                                         ),
//                                       ]),
//                                 ),
//                                 SizedBox(
//                                   width: 5,
//                                 ),
//                                 Container(
//                                   height: 40,
//                                   width: size.width * 0.45,
//                                   decoration: BoxDecoration(
//                                       color: Colors.black.withOpacity(0.1),
//                                       borderRadius: BorderRadius.circular(20)),
//                                   child: Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.center,
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.center,
//                                       children: [
//                                         Text(
//                                           'Upper Middle Class',
//                                           textAlign: TextAlign.center,
//                                           style: TextStyle(
//                                               color:
//                                                   Colors.black.withOpacity(0.8),
//                                               fontSize: 15,
//                                               fontWeight: FontWeight.bold),
//                                         ),
//                                       ]),
//                                 ),
//                               ],
//                             ),
//                             SizedBox(
//                               height: 10,
//                             ),
//                             Container(
//                               height: 40,
//                               width: size.width * 0.45,
//                               decoration: BoxDecoration(
//                                   color: Colors.black.withOpacity(0.1),
//                                   borderRadius: BorderRadius.circular(20)),
//                               child: Row(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   crossAxisAlignment: CrossAxisAlignment.center,
//                                   children: [
//                                     Text(
//                                       'Rich / Affluent',
//                                       textAlign: TextAlign.center,
//                                       style: TextStyle(
//                                           color: Colors.black.withOpacity(0.8),
//                                           fontSize: 15,
//                                           fontWeight: FontWeight.bold),
//                                     ),
//                                   ]),
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
//                         padding: const EdgeInsets.only(left: 8.0, top: 10.0),
//                         child: Text(
//                           'Family Type',
//                           textAlign: TextAlign.left,
//                           style: TextStyle(
//                               color: Colors.black,
//                               fontSize: 20,
//                               fontWeight: FontWeight.bold),
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.only(
//                             left: 18.0, right: 18.0, top: 8.0),
//                         child: Row(
//                           children: [
//                             Container(
//                               height: 40,
//                               width: size.width * 0.3,
//                               decoration: BoxDecoration(
//                                   color: Colors.black.withOpacity(0.1),
//                                   borderRadius: BorderRadius.circular(20)),
//                               child: Row(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   crossAxisAlignment: CrossAxisAlignment.center,
//                                   children: [
//                                     Text(
//                                       'Joint Family',
//                                       textAlign: TextAlign.center,
//                                       style: TextStyle(
//                                           color: Colors.black.withOpacity(0.8),
//                                           fontSize: 15,
//                                           fontWeight: FontWeight.bold),
//                                     ),
//                                   ]),
//                             ),
//                             SizedBox(
//                               width: 5,
//                             ),
//                             Container(
//                               height: 40,
//                               width: size.width * 0.45,
//                               decoration: BoxDecoration(
//                                   color: Colors.black.withOpacity(0.1),
//                                   borderRadius: BorderRadius.circular(20)),
//                               child: Row(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   crossAxisAlignment: CrossAxisAlignment.center,
//                                   children: [
//                                     Text(
//                                       'Nuclear Family',
//                                       textAlign: TextAlign.center,
//                                       style: TextStyle(
//                                           color: Colors.black.withOpacity(0.8),
//                                           fontSize: 15,
//                                           fontWeight: FontWeight.bold),
//                                     ),
//                                   ]),
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
//                         child: Text(
//                           'About Me',
//                           textAlign: TextAlign.left,
//                           style: TextStyle(
//                               color: Colors.black,
//                               fontSize: 20,
//                               fontWeight: FontWeight.bold),
//                         ),
//                       ),
//                       SizedBox(
//                         height: 8,
//                       ),
//                       Container(
//                         height: 80.0,
//                         decoration: BoxDecoration(
//                           shape: BoxShape.rectangle,
//                           color: Colors.black.withOpacity(0.2),
//                           borderRadius: BorderRadius.all(
//                             Radius.circular(8.0),
//                           ),
//                         ),
//                         child: TextFormField(
//                           textAlign: TextAlign.left,
//                           decoration: InputDecoration(
//                             hintText: 'Boi..',
//                             hintStyle: TextStyle(
//                               color: Colors.black.withOpacity(0.8),
//                             ),
//                             contentPadding: EdgeInsets.all(40.0),
//                             fillColor: Colors.white,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 SizedBox(
//                   height: 5,
//                 ),
//                 InkWell(
//                   onTap: () {
//                     // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>Profile()()));
//                   },
//                   child: Container(
//                     height: 50,
//                     width: size.width * 0.65,
//                     decoration: BoxDecoration(
//                         color: Colors.purple,
//                         borderRadius: BorderRadius.circular(10)),
//                     child: Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           Text(
//                             'Continue',
//                             textAlign: TextAlign.center,
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontWeight: FontWeight.bold,
//                               fontSize: 20,
//                             ),
//                           ),
//                         ]),
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
