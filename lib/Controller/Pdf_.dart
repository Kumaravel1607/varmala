import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

class ApiServiceProvider {
  static Future<String> loadPDF() async {
    var BASE_URL = "https://varmalaa.com/api/Demo/view_invoice/1240/6";
    var response = await http.get(Uri.parse(BASE_URL));

    var dir = await getApplicationDocumentsDirectory();
    File file = new File("${dir.path}/data.pdf");
    file.writeAsBytesSync(response.bodyBytes, flush: true);
    return file.path;
  }
}
