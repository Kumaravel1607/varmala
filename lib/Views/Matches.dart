import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:retry/retry.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:varamala/Controller/Sharedprefrence.dart';
import 'package:varamala/Model/Personal_preferance_option.dart';
import 'package:varamala/Model/User.dart';
import 'package:varamala/Controller/Service.dart';
import 'package:varamala/Model/Gender.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:varamala/Views/Addpic.dart';
import 'package:varamala/Views/Messages.dart';
import 'package:varamala/Views/Messagescreen.dart';
import 'package:varamala/Views/Profileview.dart';
import 'package:http/http.dart' as http;
import 'package:multi_select_flutter/multi_select_flutter.dart';

import 'Profile_view.dart';
import 'const.dart';

class Matches extends StatefulWidget {
  @override
  _MatchesState createState() => _MatchesState();
}

class _MatchesState extends State<Matches> {
  var my_controller_name = TextEditingController();
  var search = TextEditingController();
  List<Gender> _gender = [];
  bool iscountry = false;
  bool isloading = true;
  String baseurl = "https://varmalaa.com/UPLOADS/Profile";
  String search_data = "";
  List my_index = [];
  int number_count = 1;
  static const _pageSize = 10;
  String disability = "";

  final PagingController<int, User> _pagingController =
      PagingController(firstPageKey: 0);

  static List<OptionList> astro_list = [];
  static List<OptionList> marital_list = [];
  static List<OptionList> age_list = [];
  static List<OptionList> income_list = [];
  static List<OptionList> profession_list = [];
  static List<OptionList> height_list = [];
  static List<OptionList> caste_list = [];
  static List<OptionList> gotra_list = [];
  static List<OptionList> religion_list = [];
  static List<OptionList> nationality_list = [];
  static List<OptionList> disability_list = [];
  List name = [];
  List _ruser = [];
  List _astro = [];
  List marital_status = [];
  List age = [];
  List income = [];
  List profession = [];
  List height = [];
  List community = [];
  List caste = [];
  List religion = [];
  List nationality = [];
  List _disability = [];

  String _Astro = "";
  String marital = "";
  String incomeStatus = "";
  String _age = "";
  String occupation = "";
  String _height = "";
  String religionStatus = "";
  String _community = "";
  String _caste = "";
  String nationalityStatus = "";

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
    getDropdownValues();
  }

  _fav_status(fav_id, fav_status) async {
    Service.favourite_status(fav_id, fav_status).then((users) {
      if (mounted) {}
    });
  }

  _block_status(block_id, block_status) async {
    Service.block_status(block_id, block_status).then((users) {
      print(users);
      if (mounted) {}
    });
  }

  Future<void> _fetchPage(int pageKey) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var id = pref.getString("id");

    print(pageKey);

    Map extra = {
      'id': id,
      'favorite_status': "0",
      'search_text': search_data,
      'astro_status': _astro.length > 0 ? _astro.join(",") : "",
      'marital_status':
          marital_status.length > 0 ? marital_status.join(",") : "",
      'income': income.length > 0 ? income.join(",") : "",
      'occupation': profession.length > 0 ? profession.join(",") : "",
      'height': height.length > 0 ? height.join(",") : "",
      'community': community.length > 0 ? community.join(",") : "",
      'caste': caste.length > 0 ? caste.join(",") : "",
      'religion': religion.length > 0 ? religion.join(",") : "",
      'nationality': nationality.length > 0 ? nationality.join(",") : "",
      'age': age.length > 0 ? age.join(",") : "",
      'disability': _disability.length > 0 ? _disability.join(",") : "",
    };
    print(search.text);
    try {
      final newItems =
          await Service.getMatchDetails(pageKey + 1, search_data, 0, extra);

      _ruser = newItems;
      final isLastPage = newItems.length < _pageSize;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems);
      } else {
        // if (pageKey == 0) {
        //   final nextPageKey = pageKey + newItems.length;
        //   _pagingController.set(newItems, nextPageKey);
        // } else {
        final nextPageKey = pageKey + newItems.length;
        _pagingController.appendPage(newItems, nextPageKey);
        // }
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  Future<String> getDropdownValues() async {
    var url = "https://varmalaa.com/api/Demo/fliter_options";
    print(url);
    var response = await http.get(Uri.parse(url));
    var filterDetail = (json.decode(response.body));
    // print(filterDetail);
    print("___________________________________________________________");
    // print(filterDetail['astro']);
    setState(() {
      // _astro = filterDetail['astro'];
      // marital_status = filterDetail['marital'];

      // //age = filterDetail['age'];
      // income = filterDetail['income_status'];
      // profession = filterDetail['occupation'];
      // height = filterDetail['height'];
      // community = filterDetail['community'];
      // caste = filterDetail['caste'];
      // religion = filterDetail['religion_status'];
      // nationality = filterDetail['nationality_status'];
      // _disability = filterDetail['disability'];

      astro_list = OpionRes(jsonEncode(filterDetail['astro']));
      marital_list = OpionRes(jsonEncode(filterDetail['marital']));
      age_list = OpionRes(jsonEncode(filterDetail['age']));
      income_list = OpionRes(jsonEncode(filterDetail['income_status']));
      profession_list = OpionRes(jsonEncode(filterDetail['occupation']));
      height_list = OpionRes(jsonEncode(filterDetail['height']));
      caste_list = OpionRes(jsonEncode(filterDetail['community']));
      gotra_list = OpionRes(jsonEncode(filterDetail['caste']));
      religion_list = OpionRes(jsonEncode(filterDetail['religion_status']));
      nationality_list =
          OpionRes(jsonEncode(filterDetail['nationality_status']));
      disability_list = OpionRes(jsonEncode(filterDetail['disability']));
    });
    isloading = false;
    return "Success";
  }

  static List<OptionList> OpionRes(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<OptionList>((json) => OptionList.fromJson(json)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // FocusScope.of(context).unfocus();
      },
      child: RefreshIndicator(
        onRefresh: () async {
          _pagingController.refresh();
        },
        child: Scaffold(
          endDrawer: Drawer(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 50),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            "Profile Filters",
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w600,
                                color: primaryColor),
                          ),
                        ],
                      ),
                    ),
                    title("Astro Status"),
                    OutlineButton(
                        highlightColor: Colors.white,
                        color: Colors.white,
                        disabledBorderColor: Colors.white,
                        borderSide: BorderSide(color: primaryColor),
                        onPressed: () {
                          _showMultiSelect1(context);
                        },
                        child: Container(
                            height: 40,
                            width: double.infinity,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Select",
                                  style: TextStyle(color: primaryColor),
                                ),
                                Icon(Icons.arrow_drop_down_outlined)
                              ],
                            ))),
                    // Drop_down(_astro, "astro", _Astro),
                    title("Marital Status"),
                    OutlineButton(
                        highlightColor: Colors.white,
                        color: Colors.white,
                        disabledBorderColor: Colors.white,
                        borderSide: BorderSide(color: primaryColor),
                        onPressed: () {
                          _showMultiSelect2(context);
                        },
                        child: Container(
                            height: 40,
                            width: double.infinity,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Select",
                                  style: TextStyle(color: primaryColor),
                                ),
                                Icon(Icons.arrow_drop_down_outlined)
                              ],
                            ))),

                    // Drop_down(marital_status, "marital", marital),
                    title("Age"),
                    OutlineButton(
                        highlightColor: Colors.white,
                        color: Colors.white,
                        disabledBorderColor: Colors.white,
                        borderSide: BorderSide(color: primaryColor),
                        onPressed: () {
                          _showMultiSelect3(context);
                        },
                        child: Container(
                            height: 40,
                            width: double.infinity,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Select",
                                  style: TextStyle(color: primaryColor),
                                ),
                                Icon(Icons.arrow_drop_down_outlined)
                              ],
                            ))),
                    // Drop_down(age, "age", _age),
                    title("Income"),
                    OutlineButton(
                        highlightColor: Colors.white,
                        color: Colors.white,
                        disabledBorderColor: Colors.white,
                        borderSide: BorderSide(color: primaryColor),
                        onPressed: () {
                          _showMultiSelect4(context);
                        },
                        child: Container(
                            height: 40,
                            width: double.infinity,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Select",
                                  style: TextStyle(color: primaryColor),
                                ),
                                Icon(Icons.arrow_drop_down_outlined)
                              ],
                            ))),
                    // Drop_down(income, "income", incomeStatus),
                    title("Profession"),
                    OutlineButton(
                        highlightColor: Colors.white,
                        color: Colors.white,
                        disabledBorderColor: Colors.white,
                        borderSide: BorderSide(color: primaryColor),
                        onPressed: () {
                          _showMultiSelect5(context);
                        },
                        child: Container(
                            height: 40,
                            width: double.infinity,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Select",
                                  style: TextStyle(color: primaryColor),
                                ),
                                Icon(Icons.arrow_drop_down_outlined)
                              ],
                            ))),
                    // Drop_down(profession, "profession", occupation),
                    title("Height (Ft.)"),
                    OutlineButton(
                        highlightColor: Colors.white,
                        color: Colors.white,
                        disabledBorderColor: Colors.white,
                        borderSide: BorderSide(color: primaryColor),
                        onPressed: () {
                          _showMultiSelect6(context);
                        },
                        child: Container(
                            height: 40,
                            width: double.infinity,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Select",
                                  style: TextStyle(color: primaryColor),
                                ),
                                Icon(Icons.arrow_drop_down_outlined)
                              ],
                            ))),
                    // Drop_down(height, "height", _height),
                    title("Community/Caste"),
                    OutlineButton(
                        highlightColor: Colors.white,
                        color: Colors.white,
                        disabledBorderColor: Colors.white,
                        borderSide: BorderSide(color: primaryColor),
                        onPressed: () {
                          _showMultiSelect7(context);
                        },
                        child: Container(
                            height: 40,
                            width: double.infinity,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Select",
                                  style: TextStyle(color: primaryColor),
                                ),
                                Icon(Icons.arrow_drop_down_outlined)
                              ],
                            ))),
                    // Drop_down(community, "community", _community),
                    title("Gotra"),
                    OutlineButton(
                        highlightColor: Colors.white,
                        color: Colors.white,
                        disabledBorderColor: Colors.white,
                        borderSide: BorderSide(color: primaryColor),
                        onPressed: () {
                          _showMultiSelect8(context);
                        },
                        child: Container(
                            height: 40,
                            width: double.infinity,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Select",
                                  style: TextStyle(color: primaryColor),
                                ),
                                Icon(Icons.arrow_drop_down_outlined)
                              ],
                            ))),
                    // Drop_down(caste, "caste", _caste),
                    title("Religion"),
                    OutlineButton(
                        highlightColor: Colors.white,
                        color: Colors.white,
                        disabledBorderColor: Colors.white,
                        borderSide: BorderSide(color: primaryColor),
                        onPressed: () {
                          _showMultiSelect9(context);
                        },
                        child: Container(
                            height: 40,
                            width: double.infinity,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Select",
                                  style: TextStyle(color: primaryColor),
                                ),
                                Icon(Icons.arrow_drop_down_outlined)
                              ],
                            ))),
                    // Drop_down(religion, "religion", religionStatus),
                    title("Nationality"),
                    OutlineButton(
                        highlightColor: Colors.white,
                        color: Colors.white,
                        disabledBorderColor: Colors.white,
                        borderSide: BorderSide(color: primaryColor),
                        onPressed: () {
                          _showMultiSelect10(context);
                        },
                        child: Container(
                            height: 40,
                            width: double.infinity,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Select",
                                  style: TextStyle(color: primaryColor),
                                ),
                                Icon(Icons.arrow_drop_down_outlined)
                              ],
                            ))),
                    // Drop_down(nationality, "nationality", nationalityStatus),
                    title("Disability"),
                    OutlineButton(
                        highlightColor: Colors.white,
                        color: Colors.white,
                        disabledBorderColor: Colors.white,
                        borderSide: BorderSide(color: primaryColor),
                        onPressed: () {
                          _showMultiSelect11(context);
                        },
                        child: Container(
                            height: 40,
                            width: double.infinity,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Select",
                                  style: TextStyle(color: primaryColor),
                                ),
                                Icon(Icons.arrow_drop_down_outlined)
                              ],
                            ))),
                    // Drop_down(_disability, "disability", disability),
                    // dropdown(),
                    SizedBox(
                      height: 20,
                    ),
                    Filter_button(),
                    SizedBox(
                      height: 40,
                    )
                  ],
                ),
              ),
            ),
          ),
          backgroundColor: primaryColor_bg,
          appBar: AppBar(
            backgroundColor: primaryColor,
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    width: 296,
                    height: 10,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.white,
                    ),
                    child: TextFormField(
                      textInputAction: TextInputAction.search,
                      onFieldSubmitted: (value) {
                        setState(() {
                          search.text = value;
                          search_data = value;
                        });

                        _pagingController.refresh();

                        search.text = search.text;
                        search_data = search.text;
                      },
                      controller: search,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        contentPadding: EdgeInsets.only(
                            left: 15, bottom: 15, top: 11, right: 15),
                        hintText: "Enter City OR Varmalaa ID & press enter",
                        hintStyle: TextStyle(fontSize: 14),
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                search.text = search.text;
                                search_data = search.text;
                              });
                              FocusScope.of(context).unfocus();

                              _pagingController.refresh();

                              search.text = search.text;
                              search_data = search.text;
                            },
                            icon: Icon(Icons.search)),
                      ),
                    )),
              ),
              SizedBox(
                width: 10,
              ),
              Builder(
                builder: (context) => IconButton(
                  icon: Icon(Icons.filter_alt),
                  onPressed: () => Scaffold.of(context).openEndDrawer(),
                  tooltip:
                      MaterialLocalizations.of(context).openAppDrawerTooltip,
                ),
              ),
              SizedBox(
                width: 10,
              ),
            ],
          ),
          body: PagedListView<int, User>(
              pagingController: _pagingController,
              builderDelegate: PagedChildBuilderDelegate<User>(
                  itemBuilder: (context, item, index) {
                return Padding(
                  padding:
                      const EdgeInsets.only(left: 18.0, right: 18.0, top: 12),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => profile_view(id: item.id)));
                    },
                    child: Container(
                      // height: MediaQuery.of(context).size.height * 0.30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 10, left: 20),
                                  child: Column(
                                    children: [
                                      CircleAvatar(
                                        backgroundImage:
                                            NetworkImage(item.profile_photo),
                                        radius: 50,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          Text("ID : ",
                                              style: TextStyle(
                                                  color: primaryColor)),
                                          Text(
                                            item.profile_id,
                                            style: TextStyle(fontSize: 12),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        width: 200,
                                        child: Text(
                                          item.firstName + " " + item.lastName,
                                          style: TextStyle(
                                              color: primaryColor,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        width: 150,
                                        child: Text(
                                          item.stateName == null
                                              ? ""
                                              : item.stateName,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.insert_invitation,
                                            color: primaryColor,
                                          ),
                                          Text(
                                            " : " + item.dob,
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14,
                                            ),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.call,
                                            color: Colors.blue,
                                          ),
                                          Text(" : " + item.mobile,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 14,
                                              ))
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        children: [
                                          Image.asset(
                                            "assets/Images/whatsapp.png",
                                            height: 24,
                                            width: 24,
                                          ),
                                          Text(" : " + item.whatsapp_no,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 14,
                                              ))
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Divider(
                              color: Colors.grey,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                btn(
                                    context,
                                    MessagesScreen(
                                        id: item.id,
                                        name: item.firstName,
                                        image: item.profile_photo),
                                    "Message",
                                    Icons.chat),
                                btn2(Icons.favorite, item.favorite_status,
                                    item.id, index),
                                btn1(Icons.block, item.id, item.block_status,
                                    index),
                              ],
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Container(
                              child: Text(
                                item.lastseen,
                                style: TextStyle(color: Colors.grey),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              })),
        ),
      ),
    );
  }

  InkWell btn(BuildContext context, value1, value2, var Icons) {
    return InkWell(
      onTap: () {
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (context) => value1));
      },
      child: Container(
        height: 40,
        width: 110,
        decoration: BoxDecoration(
            color: primaryColor, borderRadius: BorderRadius.circular(5)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons,
              color: Colors.white,
              size: 20,
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              value2,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }

  InkWell btn1(var Icons, block_id, block_status, index_no) {
    return InkWell(
      onTap: () {
        _block_status(block_id, block_status);
        block_status = block_status == "0" ? "1" : "0";
        final oldList = _pagingController.itemList;
        setState(() {
          print(oldList![index_no].block_status = block_status);
        });

        //  block_status = _ruser[index_no].block_status;
      },
      child: Container(
        height: 40,
        width: 110,
        decoration: BoxDecoration(
            color: block_status == "1" ? primaryColor_bg : primaryColor,
            borderRadius: BorderRadius.circular(5)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons,
              color: block_status == "1" ? primaryColor : Colors.white,
              size: 20,
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              block_status == "1" ? "Un Block" : "Block",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: block_status == "1" ? primaryColor : Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }

  InkWell btn2(var Icons, fav_status, fav_id, index_no) {
    return InkWell(
      onTap: () {
        fav_status = fav_status == "0" ? "1" : "0";

        final oldList = _pagingController.itemList;
        setState(() {
          print(oldList![index_no].favorite_status = fav_status);
        });

        _fav_status(fav_id, fav_status);
      },
      child: Container(
        height: 40,
        width: 60,
        decoration: BoxDecoration(
            color: fav_status == "1" ? Colors.white : primaryColor,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: primaryColor)),
        child: Center(
          child: Icon(
            Icons,
            color: fav_status == "1" ? primaryColor : Colors.white,
            size: 20,
          ),
        ),
      ),
    );
  }

  Padding Filter_button() {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: FlatButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          color: primaryColor,
          onPressed: () {
            Navigator.pop(context);
            _pagingController.refresh();

            // if (_formKey.currentState!.validate()) {
            //   update_account();
            // }
            setState(() {
              // _Astro = "";
              // marital = "";
              // _age = "";
              // incomeStatus = "";
              // occupation = "";
              // _height = "";
              // _community = "";
              // _caste = "";
              // religionStatus = "";
              // nationalityStatus = "";
              // disability = "";
            });
          },
          child: Container(
            child: Center(
              child: Text("Apply",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600)),
            ),
            height: 50,
            width: 200,
          )),
    );
  }

  // Container Drop_down(
  //   List options,
  //   my_controller_name,
  //   selected_val,
  // ) {
  //   return Container(
  //     height: 40,
  //     child: DropdownButtonFormField<String>(
  //       decoration: textDecoration("select"),
  //       value: selected_val != "" ? selected_val.toString() : null,
  //       style: TextStyle(fontSize: 14),
  //       items: options.map((item) {
  //         return DropdownMenuItem<String>(
  //           value: item["id"].toString(),
  //           child: Container(
  //             width: 180,
  //             child: new Text(
  //               item['name'].toString(),
  //               style: TextStyle(
  //                 color: primaryColor,
  //                 fontSize: 15,
  //               ),
  //               overflow: TextOverflow.ellipsis,
  //             ),
  //           ),
  //         );
  //       }).toList(),
  //       onChanged: (newValue) {
  //         setState(() {
  //           if (my_controller_name == "astro") _Astro = newValue!;
  //           if (my_controller_name == "marital") marital = newValue!;
  //           if (my_controller_name == "age") _age = newValue!;
  //           if (my_controller_name == "income") incomeStatus = newValue!;
  //           if (my_controller_name == "profession") occupation = newValue!;
  //           if (my_controller_name == "height") _height = newValue!;
  //           if (my_controller_name == "community") _community = newValue!;
  //           if (my_controller_name == "caste") _caste = newValue!;
  //           if (my_controller_name == "religion") religionStatus = newValue!;
  //           if (my_controller_name == "nationality")
  //             nationalityStatus = newValue!;
  //           if (my_controller_name == "disability") disability = newValue!;
  //         });
  //       },
  //     ),
  //   );
  // }

  Padding title(value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8, top: 10),
      child: Row(
        children: [
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                  color: primaryColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }

  // DropdownButtonFormField<String> dropdown() {
  //   return DropdownButtonFormField<String>(
  //     decoration: textDecoration("select"),
  //     items: <String>['All', 'None', 'Physically Disabled'].map((String value) {
  //       return DropdownMenuItem<String>(
  //         value: value,
  //         child: new Text(value),
  //       );
  //     }).toList(),
  //     onChanged: (value) {
  //       disability = value!;
  //       print(value);
  //     },
  //   );
  // }

  List _selected1 = [];
  void _showMultiSelect1(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (ctx) {
        return MultiSelectDialog(
          items: astro_list.length > 0
              ? astro_list
                  .map((edu) => MultiSelectItem<OptionList>(edu, edu.name))
                  .toList()
              : [],
          initialValue: _selected1,
          onConfirm: (values) {
            print("ed");
            print(values);
            _selected1 = values;
            // print(inilize_partnerEducation);
            _astro.clear();
            _selected1.forEach((item) {
              print("${item.id} ${item.name}");

              _astro.add(item.id);
            });
            //  print(education_list.join(","));
          },
        );
      },
    );
  }

  List _selected2 = [];
  void _showMultiSelect2(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (ctx) {
        return MultiSelectDialog(
          items: marital_list
              .map((edu) => MultiSelectItem<OptionList>(edu, edu.name))
              .toList(),
          initialValue: _selected2,
          onConfirm: (values) {
            print("ed");
            print(values);
            _selected2 = values;
            marital_status.clear();
            // print(inilize_partnerEducation);
            _selected2.forEach((item) {
              print("${item.id} ${item.name}");

              marital_status.add(item.id);
            });
            //  print(education_list.join(","));
          },
        );
      },
    );
  }

  List _selected3 = [];
  void _showMultiSelect3(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (ctx) {
        return MultiSelectDialog(
          items: age_list
              .map((edu) => MultiSelectItem<OptionList>(edu, edu.name))
              .toList(),
          initialValue: _selected3,
          onConfirm: (values) {
            print("ed");
            print(values);
            _selected3 = values;
            age.clear();
            // print(inilize_partnerEducation);
            _selected3.forEach((item) {
              print("${item.id} ${item.name}");

              age.add(item.id);
            });
            //  print(education_list.join(","));
          },
        );
      },
    );
  }

  List _selected4 = [];
  void _showMultiSelect4(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (ctx) {
        return MultiSelectDialog(
          items: income_list
              .map((edu) => MultiSelectItem<OptionList>(edu, edu.name))
              .toList(),
          initialValue: _selected4,
          onConfirm: (values) {
            print("ed");
            print(values);
            _selected4 = values;
            income.clear();
            // print(inilize_partnerEducation);
            _selected4.forEach((item) {
              print("${item.id} ${item.name}");

              income.add(item.id);
            });
            //  print(education_list.join(","));
          },
        );
      },
    );
  }

  List _selected5 = [];
  void _showMultiSelect5(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (ctx) {
        return MultiSelectDialog(
          items: profession_list
              .map((edu) => MultiSelectItem<OptionList>(edu, edu.name))
              .toList(),
          initialValue: _selected5,
          onConfirm: (values) {
            print("ed");
            print(values);
            _selected5 = values;
            profession.clear();
            // print(inilize_partnerEducation);
            _selected5.forEach((item) {
              print("${item.id} ${item.name}");

              profession.add(item.id);
            });
            //  print(education_list.join(","));
          },
        );
      },
    );
  }

  List _selected6 = [];
  void _showMultiSelect6(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (ctx) {
        return MultiSelectDialog(
          items: height_list
              .map((edu) => MultiSelectItem<OptionList>(edu, edu.name))
              .toList(),
          initialValue: _selected6,
          onConfirm: (values) {
            print("ed");
            print(values);
            setState(() {
              _selected6 = values;
            });
            // print(inilize_partnerEducation);
            height.clear();
            _selected6.forEach((item) {
              print("${item.id} ${item.name}");

              height.add(item.id);
            });
            //  print(education_list.join(","));
          },
        );
      },
    );
  }

  List _selected7 = [];
  void _showMultiSelect7(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (ctx) {
        return MultiSelectDialog(
          items: caste_list
              .map((edu) => MultiSelectItem<OptionList>(edu, edu.name))
              .toList(),
          initialValue: _selected7,
          onConfirm: (values) {
            print("ed");
            print(values);
            _selected7 = values;
            community.clear();
            // print(inilize_partnerEducation);
            _selected7.forEach((item) {
              print("${item.id} ${item.name}");

              community.add(item.id);
            });
            //  print(education_list.join(","));
          },
        );
      },
    );
  }

  List _selected8 = [];
  void _showMultiSelect8(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (ctx) {
        return MultiSelectDialog(
          items: gotra_list
              .map((edu) => MultiSelectItem<OptionList>(edu, edu.name))
              .toList(),
          initialValue: _selected8,
          onConfirm: (values) {
            print("ed");
            print(values);
            _selected8 = values;
            caste.clear();
            // print(inilize_partnerEducation);
            _selected8.forEach((item) {
              print("${item.id} ${item.name}");

              caste.add(item.id);
            });
            //  print(education_list.join(","));
          },
        );
      },
    );
  }

  List _selected9 = [];
  void _showMultiSelect9(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (ctx) {
        return MultiSelectDialog(
          items: religion_list
              .map((edu) => MultiSelectItem<OptionList>(edu, edu.name))
              .toList(),
          initialValue: _selected9,
          onConfirm: (values) {
            print("ed");
            print(values);
            _selected9 = values;
            religion.clear();
            // print(inilize_partnerEducation);
            _selected9.forEach((item) {
              print("${item.id} ${item.name}");

              religion.add(item.id);
            });
            //  print(education_list.join(","));
          },
        );
      },
    );
  }

  List _selected10 = [];
  void _showMultiSelect10(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (ctx) {
        return MultiSelectDialog(
          items: nationality_list
              .map((edu) => MultiSelectItem<OptionList>(edu, edu.name))
              .toList(),
          initialValue: _selected10,
          onConfirm: (values) {
            print("ed");
            print(values);
            _selected10 = values;
            nationality.clear();
            // print(inilize_partnerEducation);
            _selected10.forEach((item) {
              print("${item.id} ${item.name}");

              nationality.add(item.id);
            });
            //  print(education_list.join(","));
          },
        );
      },
    );
  }

  List _selected11 = [];
  void _showMultiSelect11(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (ctx) {
        return MultiSelectDialog(
          items: disability_list
              .map((edu) => MultiSelectItem<OptionList>(edu, edu.name))
              .toList(),
          initialValue: _selected11,
          onConfirm: (values) {
            print("ed");
            print(values);
            _selected11 = values;
            _disability.clear();
            // print(inilize_partnerEducation);
            _selected11.forEach((item) {
              print("${item.id} ${item.name}");

              _disability.add(item.id);
            });
            //  print(education_list.join(","));
          },
        );
      },
    );
  }
  // Don't worry about displaying progress or error indicators on screen; the
  // package takes care of that. If you want to customize them, use the
  // [PagedChildBuilderDelegate] properties.

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }
}
