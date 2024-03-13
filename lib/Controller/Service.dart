import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:varamala/Controller/Sharedprefrence.dart';
import 'package:varamala/Model/Chat_screen.dart';
import 'package:varamala/Model/Country.dart';
import 'package:varamala/Model/Filter.dart';
import 'package:varamala/Model/Gallery.dart';
import 'package:varamala/Model/Membership.dart';

import 'package:varamala/Model/Occupation.dart';
import 'package:varamala/Model/Personal_preferance_option.dart';

import 'package:varamala/Model/Suser.dart';
import 'package:varamala/Model/Tab_details.dart';
import 'package:varamala/Model/Transcation.dart';
import 'package:varamala/Model/User.dart';
import 'package:varamala/Model/Gender.dart';
import 'package:varamala/Model/State.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:varamala/Model/acc_details.dart';
import 'package:varamala/Model/message.dart';
import 'package:varamala/Model/puser.dart';
import 'package:varamala/Views/Forget_Password.dart';
import 'package:varamala/Views/Profile.dart';
import 'package:path_provider/path_provider.dart';

class Service {
  late SharedPreferences preferences;
  // static String username = SharedPrefence.getUsername();
  // static String gender = SharedPrefence.getgender();
  // static String id = SharedPrefence.getid();

  // static Future<String> loadPDF() async {
  //   var url = "https://varmalaa.com/api/Demo/view_invoice/1240/6";
  //   var response = await http.get(Uri.parse(url));
  //   print(jsonDecode(response.body));
  //   var dir = await getApplicationDocumentsDirectory();
  //   File file = new File("${dir.path}/data.pdf");
  //   file.writeAsBytesSync(response.bodyBytes, flush: true);
  //   return file.path;
  // }

  static Future<Suser> singleUser() async {
    var url = "https://varmalaa.com/api/Demo/user_detail";

    SharedPreferences _pref = await SharedPreferences.getInstance();
    var username = _pref.getString("email");

    var response = await http.post(Uri.parse(url), body: {"email": username});
    var userDetail = (json.decode(response.body));
    if (jsonDecode(response.body) == "false") {
      throw Exception('Failed to load post');
    } else {
      return Suser.fromJson(userDetail);
    }
  }

  static Future<AccDetails> account_profile() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    var username = _pref.getString("email");

    var url = "https://varmalaa.com/api/Demo/account_info";

    var response = await http.post(Uri.parse(url), body: {"email": username});
    var userDetail = (json.decode(response.body));
    if (jsonDecode(response.body) == "false") {
      throw Exception('Failed to load post');
    } else {
      return AccDetails.fromJson(userDetail);
    }
  }

  static Future<Tab1Details> profileinfo(String profile) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    var id = _pref.getString("id");

    Map data = {"profile": profile, "id": id};
    print(data);
    var url = "https://varmalaa.com/api/Demo/profile";
    print(url);
    var response = await http.post(Uri.parse(url), body: data);
    var userDetail = (json.decode(response.body));
    print(jsonDecode(response.body));
    if (jsonDecode(response.body) == "false") {
      throw Exception('Failed to load post');
    } else {
      return Tab1Details.fromJson(userDetail);
    }
  }

  static tab_details(String profile) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    var id = _pref.getString("id");

    Map data = {"profile": profile, "id": id};
    print(data);
    var url = "https://varmalaa.com/api/Demo/profile";

    var response = await http.post(Uri.parse(url), body: data);
    var userDetail = (json.decode(response.body));
    if (jsonDecode(response.body) == "false") {
      throw Exception('Failed to load post');
    } else {
      print(userDetail);
      return userDetail;
    }
  }

  static chat_count() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    var id = _pref.getString("id");

    Map data = {"id": id};
    print(data);
    var url = "https://varmalaa.com/api/Demo/home";

    var response = await http.post(Uri.parse(url), body: data);
    var userDetail = (json.decode(response.body));
    if (jsonDecode(response.body) == "false") {
      throw Exception('Failed to load post');
    } else {
      print(userDetail);
      return userDetail;
    }
  }

  static Profile_details(String profile, String user_id) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    var username = _pref.getString("email");

    Map data = {"profile": profile, "id": user_id, "email": username};
    print(data);
    var url = "https://varmalaa.com/api/Demo/profile_details";

    var response = await http.post(Uri.parse(url), body: data);
    var userDetail = (json.decode(response.body));
    if (jsonDecode(response.body) == "false") {
      throw Exception('Failed to load post');
    } else {
      print(userDetail);
      return userDetail;
    }
  }

  static forgetpassword(email) async {
    Map data = {"email": email};
    print(data);
    var url = "https://varmalaa.com/api/Demo/forget_password";

    var response = await http.post(Uri.parse(url), body: data);
    var userDetail = (json.decode(response.body));
    if (jsonDecode(response.body) == "false") {
      throw Exception('Failed to load post');
    } else {
      print(userDetail);
      return userDetail;
    }
  }

  static favourite_status(String fav_id, favorite_status) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    var id = _pref.getString("id");

    Map data = {
      "id": id,
      "favorite_id": fav_id,
      "favorite_status": favorite_status
    };
    print(data);
    var url = "https://varmalaa.com/api/Demo/favorite_status";

    var response = await http.post(Uri.parse(url), body: data);
    var userDetail = (json.decode(response.body));
    if (jsonDecode(response.body) == "false") {
      throw Exception('Failed to load post');
    } else {
      print(userDetail);
      return userDetail;
    }
  }

  static block_status(String block_id, block_status) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    var id = _pref.getString("id");

    Map data = {"id": id, "block_id": block_id, "block_status": block_status};
    print(data);
    var url = "https://varmalaa.com/api/Demo/block_status";

    var response = await http.post(Uri.parse(url), body: data);
    var userDetail = (json.decode(response.body));
    if (jsonDecode(response.body) == "false") {
      throw Exception('Failed to load post');
    } else {
      print(userDetail);
      return userDetail;
    }
  }

  // static profileinfo(profile) async {
  //   Map data = {"profile": profile, "email": username};
  //   var url = "https://varmalaa.com/api/Demo/profile";
  //
  //   var response = await http.post(Uri.parse(url), body: data);
  //   var userDetail = (json.decode(response.body));
  //   if (jsonDecode(response.body) == "false") {
  //     throw Exception('Failed to load post');
  //   } else {
  //     return userDetail;
  //   }
  // }

  static Future<List<Gender>> getgender() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    var username = _pref.getString("email");
    var gender = _pref.getString("gender");

    List<Gender> list = [];
    Map data = {"email": username};
    var url = "https://varmalaa.com/api/Demo/gender";

    var response = await http.post(Uri.parse(url), body: data);

    print(jsonDecode(response.body));

    if (jsonDecode(response.body) == "false") {
      list[0].id = "0";
      return list;
    } else {
      list = genResponse(response.body);
      return list;
    }
  }

  static List<Gender> genResponse(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Gender>((json) => Gender.fromJson(json)).toList();
  }

  static Future<List<States>> gets() async {
    List<States> list = [];
    var url = "https://varmalaa.com/api/Demo/sts";
    var response = await http.get(Uri.parse(url));
    list = sResponse(response.body);
    return list;
  }

  static List<States> sResponse(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<States>((json) => States.fromJson(json)).toList();
  }

  static Future<List<States>> get_state_list(country) async {
    List<States> list = [];

    var response = await http.post(
        Uri.parse('https://varmalaa.com/api/Demo/state_list'),
        body: {"country": country});
    list = sResponse(response.body);
    return list;
  }

  static Future<List<Country>> getc() async {
    List<Country> list = [];
    var url = "https://varmalaa.com/api/Demo/country";
    var response = await http.get(Uri.parse(url));
    list = cResponse(response.body);
    return list;
  }

  static List<Country> cResponse(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Country>((json) => Country.fromJson(json)).toList();
  }

  static Future<List<User>?> getcountry(String country) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    var gender = _pref.getString("gender");

    List<User> list = [];
    var url = "https://varmalaa.com/api/Demo/country";
    var response = await http.post(Uri.parse(url),
        body: {"country": country.toLowerCase(), "gender": gender});
    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);
      if (responseBody is List) {
        list = couResponse(response.body);
        return list;
      } else if (responseBody == "false") {
        print(responseBody);
        return null;
      } else {
        print(response.statusCode);
        throw Exception("Problem in fetching address List");
      }
    }
  }

  static List<User> couResponse(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<User>((json) => User.fromJson(json)).toList();
  }

  static Future<List<Puser>> getpuser(String id) async {
    List<Puser> list = [];
    var url = "https://varmalaa.com/api/Demo/puser";
    var response = await http.post(Uri.parse(url), body: {"id": id});
    if (jsonDecode(response.body) == "false") {
      list[0].id = "0";
      return list;
    } else {
      list = puResponse(response.body);
      return list;
    }
  }

  static List<Puser> puResponse(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Puser>((json) => Puser.fromJson(json)).toList();
  }

  static Future<List<User>> getMatchDetails(
      page, search_data, favorite_status, extra) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    var username = _pref.getString("email");

    List<User> list = [];
    Map data = {
      "email": username,
      "page": page.toString(),
      "search_text": search_data,
      "favorite_status": favorite_status.toString()
    };
    if (extra != "") data.addAll(extra);

    print(data);
    var map = Map<String, dynamic>();
    var url = "https://varmalaa.com/api/Demo/get_match_profile";
    var response = await http.post(Uri.parse(url), body: data);
    //  print(jsonDecode(response.body));
    if (jsonDecode(response.body) == "false") {
      list[0].id = "0";
      return list;
    } else {
      list = brideResponse(response.body);
      return list;
    }
  }

  static Future<List<User>> getbride() async {
    List<User> list = [];
    var map = Map<String, dynamic>();
    final response =
        await http.get(Uri.parse('https://varmalaa.com/api/Demo/m'));

    if (jsonDecode(response.body) == "false") {
      list[0].id = "0";
      return list;
    } else {
      list = brideResponse(response.body);
      return list;
    }
  }

  static List<User> brideResponse(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<User>((json) => User.fromJson(json)).toList();
  }

  static Future<List<User>> getgroom() async {
    List<User> list = [];
    var map = Map<String, dynamic>();
    final response =
        await http.get(Uri.parse('https://varmalaa.com/api/Demo/f'));
    if (jsonDecode(response.body) == "false") {
      list[0].id = "0";
      return list;
    } else {
      list = groomResponse(response.body);
      return list;
    }
  }

  static List<User> groomResponse(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<User>((json) => User.fromJson(json)).toList();
  }

  static Future<List<Occupation>> getprof() async {
    List<Occupation> list = [];
    var map = Map<String, dynamic>();
    final response =
        await http.get(Uri.parse('https://varmalaa.com/api/Demo/occupation'));
    list = profResponse(response.body);
    return list;
  }

  static List<Occupation> profResponse(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Occupation>((json) => Occupation.fromJson(json)).toList();
  }

  static Future<List<Occupation>> getcom() async {
    List<Occupation> list = [];
    var map = Map<String, dynamic>();
    final response =
        await http.get(Uri.parse('https://varmalaa.com/api/Demo/community'));
    list = comResponse(response.body);
    return list;
  }

  static List<Occupation> comResponse(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Occupation>((json) => Occupation.fromJson(json)).toList();
  }

  static Future<List<Occupation>> getcas() async {
    List<Occupation> list = [];
    final response =
        await http.get(Uri.parse('https://varmalaa.com/api/Demo/caste'));
    list = casfResponse(response.body);
    return list;
  }

  static List<Occupation> casfResponse(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Occupation>((json) => Occupation.fromJson(json)).toList();
  }

  static Future<List<User>> getuser() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    var gender = _pref.getString("gender");

    List<User> list = [];
    final response = await http.post(
        Uri.parse('https://varmalaa.com/api/Demo/member'),
        body: {"gender": gender});
    print(gender);
    if (jsonDecode(response.body) == "false") {
      list[0].id = "0";
      return list;
    } else {
      list = userResponse(response.body);
      return list;
    }
  }

  static List<User> userResponse(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<User>((json) => User.fromJson(json)).toList();
  }

  static Future<List<User>?> getastro(String id) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    var gender = _pref.getString("gender");

    List<User> list = [];
    final response = await http.post(
        Uri.parse('https://varmalaa.com/api/Demo/astro'),
        body: {"astro": id, "gender": gender});
    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);
      if (responseBody is List) {
        list = astroResponse(response.body);
        return list;
      } else if (responseBody == "false") {
        print(responseBody);
        return null;
      } else {
        print(response.statusCode);
        throw Exception("Problem in fetching address List");
      }
    }
  }

  static List<User> astroResponse(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<User>((json) => User.fromJson(json)).toList();
  }

  static Future<List<User>?> getoccupation(String id) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    var gender = _pref.getString("gender");

    List<User> list = [];
    final response = await http.post(
        Uri.parse('https://varmalaa.com/api/Demo/prof'),
        body: {"id": id, "gender": gender});
    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);
      if (responseBody is List) {
        list = occupResponse(response.body);
        return list;
      } else if (responseBody == "false") {
        print(responseBody);
        return null;
      } else {
        print(response.statusCode);
        throw Exception("Problem in fetching address List");
      }
    }
  }

  static List<User> occupResponse(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<User>((json) => User.fromJson(json)).toList();
  }

  static Future<List<User>?> getcaste(String id) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    var gender = _pref.getString("gender");

    List<User> list = [];
    final response = await http.post(
        Uri.parse('https://varmalaa.com/api/Demo/cas'),
        body: {"id": id, "gender": gender});
    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);
      if (responseBody is List) {
        list = occupResponse(response.body);
        return list;
      } else if (responseBody == "false") {
        print(responseBody);
        return null;
      } else {
        print(response.statusCode);
        throw Exception("Problem in fetching address List");
      }
    }
  }

  static List<User> casteResponse(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<User>((json) => User.fromJson(json)).toList();
  }

  static Future<List<User>?> getcommunity(String id) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    var gender = _pref.getString("gender");

    List<User> list = [];
    final response = await http.post(
        Uri.parse('https://varmalaa.com/api/Demo/commu'),
        body: {"id": id, "gender": gender});
    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);
      if (responseBody is List) {
        list = occupResponse(response.body);
        return list;
      } else if (responseBody == "false") {
        print(responseBody);
        return null;
      } else {
        print(response.statusCode);
        throw Exception("Problem in fetching address List");
      }
    }
  }

  static List<User> coumunResponse(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<User>((json) => User.fromJson(json)).toList();
  }

  static Future<List<User>?> getmarital(String id) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    var gender = _pref.getString("gender");

    List<User> list = [];
    final response = await http.post(
        Uri.parse('https://varmalaa.com/api/Demo/marital'),
        body: {"marital": id, "gender": gender});
    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);
      if (responseBody is List) {
        list = maritalResponse(response.body);
        return list;
      } else if (responseBody == "false") {
        print(responseBody);
        return null;
      } else {
        print(response.statusCode);
        throw Exception("Problem in fetching address List");
      }
    }
  }

  static List<User> maritalResponse(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<User>((json) => User.fromJson(json)).toList();
  }

  static Future<List<User>> getfav() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    var id = _pref.getString("id");

    List<User> list = [];
    print("id:$id");
    final response = await http
        .post(Uri.parse('https://varmalaa.com/api/Demo/fav'), body: {"id": id});
    if (jsonDecode(response.body) == "false") {
      list[0].id = "0";
      return list;
    } else {
      list = favResponse(response.body);
      return list;
    }
  }

  static List<User> favResponse(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<User>((json) => User.fromJson(json)).toList();
  }

  static Future<List<OptionList>> optionList() async {
    List<OptionList> list = [];
    Map data = {
      "profile": "5",
    };
    print(data);
    var map = Map<String, dynamic>();
    var url = "https://varmalaa.com/api/Demo/option_list";
    var response = await http.post(Uri.parse(url), body: data);
    print(jsonDecode(response.body));
    if (jsonDecode(response.body) == "false") {
      return list;
    } else {
      list = optionListResponse(response.body);
      return list;
    }
  }

  static List<OptionList> optionListResponse(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<OptionList>((json) => OptionList.fromJson(json)).toList();
  }

  static Future<List<Gallery>> gallery() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    var id = _pref.getString("id");

    List<Gallery> list = [];
    Map data = {
      "id": id,
      "profile": "6",
    };
    print(data);
    var map = Map<String, dynamic>();
    var url = "https://varmalaa.com/api/Demo/profile";
    var response = await http.post(Uri.parse(url), body: data);
    print(jsonDecode(response.body));
    if (jsonDecode(response.body) == "false") {
      return list;
    } else {
      list = galleryResponse(response.body);
      return list;
    }
  }

  static List<Gallery> galleryResponse(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Gallery>((json) => Gallery.fromJson(json)).toList();
  }

  static Future<List<Transcation>> transcation() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    var id = _pref.getString("id");

    List<Transcation> list = [];
    Map data = {
      "id": id,
    };
    print(data);
    var map = Map<String, dynamic>();
    var url = "https://varmalaa.com/api/Demo/transcation";
    var response = await http.post(Uri.parse(url), body: data);
    print(jsonDecode(response.body));
    if (jsonDecode(response.body) == "false") {
      return list;
    } else {
      list = TranscationResponse(response.body);
      return list;
    }
  }

  static List<Transcation> TranscationResponse(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<Transcation>((json) => Transcation.fromJson(json))
        .toList();
  }

  static Future<List<Membership>> member() async {
    List<Membership> list = [];

    // var map = Map<String, dynamic>();
    var url = "https://varmalaa.com/api/Demo/get_plans";
    final response = await http.get(Uri.parse(url));
    print(jsonDecode(response.body));

    if (jsonDecode(response.body) == "false") {
      return list;
    } else {
      list = membershipResponse(response.body);
      return list;
    }
  }

  static List<Membership> membershipResponse(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Membership>((json) => Membership.fromJson(json)).toList();
  }

  static Future<List<Filter>> filter_option() async {
    List<Filter> list = [];
    print("--------v---------v----------v");
    var url = "https://varmalaa.com/api/Demo/fliter_options";
    final response = await http.get(Uri.parse(url));
    print(jsonDecode(response.body));
    if (jsonDecode(response.body) == "false") {
      return list;
    } else {
      list = filteroption(response.body);
      print("--------v---------v----");
      return list;
    }
  }

  static List<Filter> filteroption(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Filter>((json) => Filter.fromJson(json)).toList();
  }

  static Future<List<User>> getmuser(String status) async {
    List<User> list = [];
    final response = await http.post(
        Uri.parse('https://varmalaa.com/api/Demo/muser'),
        body: {"marital": status});
    if (jsonDecode(response.body) == "false") {
      list[0].id = "0";
      return list;
    } else {
      list = muserResponse(response.body);
      return list;
    }
  }

  static List<User> muserResponse(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<User>((json) => User.fromJson(json)).toList();
  }

  static Future<List<Chat>> getmessage() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    var id = _pref.getString("id");

    List<Chat> list = [];
    Map data = {
      "id": id,
    };
    print(data);
    var map = Map<String, dynamic>();
    var url = "https://varmalaa.com/api/Demo/message";
    var response = await http.post(Uri.parse(url), body: data);
    print(jsonDecode(response.body));
    if (jsonDecode(response.body) == "false") {
      return list;
    } else {
      list = chatResponse(response.body);
      return list;
    }
  }

  static List<Chat> chatResponse(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Chat>((json) => Chat.fromJson(json)).toList();
  }

  static Future<List<Message>> getmessagep(String sid) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    var id = _pref.getString("id");

    List<Message> list = [];
    print({"id": id, "sid": sid});
    final response = await http.post(
        Uri.parse('https://varmalaa.com/api/Demo/messagepage'),
        body: {"id": id, "sid": sid});
    if (jsonDecode(response.body) == "false") {
      list[0].id = "0";
      return list;
    } else {
      list = messagepResponse(response.body);
      return list;
    }
  }

  static List<Message> messagepResponse(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Message>((json) => Message.fromJson(json)).toList();
  }
}
