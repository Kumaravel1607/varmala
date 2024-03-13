// import 'package:flutter/material.dart';
// import 'package:flutter_pdfview/flutter_pdfview.dart';
// import 'package:varamala/Controller/Pdf_.dart';
// import 'package:url_launcher/url_launcher.dart';

// class PdfViewerPage extends StatefulWidget {
//   @override
//   _PdfViewerPageState createState() => _PdfViewerPageState();
// }

// class _PdfViewerPageState extends State<PdfViewerPage> {
//   late String localPath;

//   @override
//   void initState() {
//     pdf();
//     // TODO: implement initState
//     super.initState();
//   }

//   pdf() async {
//     ApiServiceProvider.loadPDF().then((value) {
//       setState(() {
//         print(value);
//         localPath = value;
//       });
//     });
//   }

//   void _launchURL(_url) async {
//     await canLaunch(_url) ? await launch(_url) : throw 'Could not launch $_url';
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           "Transcation Invoice",
//           style: TextStyle(fontWeight: FontWeight.bold),
//         ),
//         actions: <Widget>[
//           IconButton(
//             icon: Icon(
//               Icons.settings,
//               color: Colors.white,
//             ),
//             onPressed: () {
//               _launchURL("https://varmalaa.com/view-invoice/MzM0NUBAQDM3Mw==");
//               // do something
//             },
//           )
//         ],
//       ),
//       body: localPath != null
//           ? PDFView(
//               // autoSpacing: false,
//               // enableSwipe: false,
//               filePath: localPath,
//             )
//           : Center(child: CircularProgressIndicator()),
//     );
//   }
// }
