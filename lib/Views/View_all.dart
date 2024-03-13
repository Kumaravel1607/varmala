import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:retry/retry.dart';
import 'package:shared_preferences/shared_preferences.dart';
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

class viewall extends StatefulWidget {
  @override
  _viewallState createState() => _viewallState();
}

class _viewallState extends State<viewall> {
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
    SharedPreferences _pref = await SharedPreferences.getInstance();
    var id = _pref.getString("id");
    print(pageKey);

    Map extra = {
      'id': id,
      'favorite_status': "0",
      'search_text': search_data,
      'astro_status': _Astro,
      'marital_status': marital,
      'income': incomeStatus,
      'occupation': occupation,
      'height': _height,
      'community': _community,
      'caste': _caste,
      'religion': religionStatus,
      'nationality': nationalityStatus,
      'age': _age,
      'disability': disability,
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
    print(filterDetail);
    print("___________________________________________________________");
    print(filterDetail['age']);
    setState(() {
      _astro = filterDetail['astro'];
      marital_status = filterDetail['marital'];

      age = filterDetail['age'];
      income = filterDetail['income_status'];
      profession = filterDetail['occupation'];
      height = filterDetail['height'];
      community = filterDetail['community'];
      caste = filterDetail['caste'];
      religion = filterDetail['religion_status'];
      nationality = filterDetail['nationality_status'];
    });
    isloading = false;
    return "Success";
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // FocusScope.of(context).unfocus();
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
                    child: Text(
                      "Profile Filters",
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                          color: primaryColor),
                    ),
                  ),
                  title("Astro Status"),
                  Drop_down(_astro, "astro", _Astro),
                  title("Marital Status"),
                  Drop_down(marital_status, "marital", marital),
                  title("Age"),
                  Drop_down(age, "age", _age),
                  title("Income"),
                  Drop_down(income, "income", incomeStatus),
                  title("Profession"),
                  Drop_down(profession, "profession", occupation),
                  title("Height (Ft.)"),
                  Drop_down(height, "height", _height),
                  title("Community"),
                  Drop_down(community, "community", _community),
                  title("Caste"),
                  Drop_down(caste, "caste", _caste),
                  title("Religion"),
                  Drop_down(religion, "religion", religionStatus),
                  title("Nationality"),
                  Drop_down(nationality, "nationality", nationalityStatus),
                  title("Disability"),
                  dropdown(),
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
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context, "ok");
            },
            icon: Icon(Icons.arrow_back),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  width: 250,
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
                tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
              ),
            ),
            SizedBox(
              width: 10,
            ),
          ],
        ),
        body: RefreshIndicator(
            onRefresh: () async {
              _pagingController.refresh();
            },
            child: PagedListView<int, User>(
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
                                builder: (context) =>
                                    profile_view(id: item.id)));
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
                                    padding: const EdgeInsets.only(
                                        top: 10, left: 20),
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
                                            item.firstName +
                                                " " +
                                                item.lastName,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
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
                }))),
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

  Container Drop_down(
    List options,
    my_controller_name,
    selected_val,
  ) {
    return Container(
      height: 40,
      child: DropdownButtonFormField<String>(
        decoration: textDecoration("select"),
        value: selected_val != "" ? selected_val.toString() : null,
        style: TextStyle(fontSize: 14),
        items: options.map((item) {
          return DropdownMenuItem<String>(
            value: item["id"].toString(),
            child: Container(
              width: 180,
              child: new Text(
                item['name'].toString(),
                style: TextStyle(
                  color: primaryColor,
                  fontSize: 15,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          );
        }).toList(),
        onChanged: (newValue) {
          setState(() {
            if (my_controller_name == "astro") _Astro = newValue!;
            if (my_controller_name == "marital") marital = newValue!;
            if (my_controller_name == "age") _age = newValue!;
            if (my_controller_name == "income") incomeStatus = newValue!;
            if (my_controller_name == "profession") occupation = newValue!;
            if (my_controller_name == "height") _height = newValue!;
            if (my_controller_name == "community") _community = newValue!;
            if (my_controller_name == "caste") _caste = newValue!;
            if (my_controller_name == "religion") religionStatus = newValue!;
            if (my_controller_name == "nationality")
              nationalityStatus = newValue!;
          });
        },
      ),
    );
  }

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

  DropdownButtonFormField<String> dropdown() {
    return DropdownButtonFormField<String>(
      decoration: textDecoration("select"),
      items: <String>['None', 'Physically Disabled'].map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: new Text(value),
        );
      }).toList(),
      onChanged: (value) {
        value = disability;
        print(value);
      },
    );
  }

  void _showMultiSelect(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (ctx) {
        return MultiSelectDialog(
          items: [],
          initialValue: _astro,
          onConfirm: (values) {
            print(values);
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
