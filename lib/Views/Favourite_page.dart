import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:retry/retry.dart';
import 'package:varamala/Model/User.dart';
import 'package:varamala/Controller/Service.dart';
import 'package:varamala/Model/Gender.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:varamala/Views/Messages.dart';
import 'package:varamala/Views/Profileview.dart';

import 'Profile_view.dart';
import 'const.dart';

class Fav_Page extends StatefulWidget {
  const Fav_Page({Key? key}) : super(key: key);

  @override
  _Fav_PageState createState() => _Fav_PageState();
}

class _Fav_PageState extends State<Fav_Page> {
  @override
  List<Gender> _gender = [];
  bool iscountry = false;

  bool viewVisible = true;
  String search_data = "";
  static const _pageSize = 10;

  final PagingController<int, User> _pagingController =
      PagingController(firstPageKey: 0);

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }

  void hideWidget() {
    setState(() {
      viewVisible = false;
    });
  }

  _fav_status(fav_id) async {
    Service.favourite_status(fav_id, "0").then((users) {
      setState(() {
        _pagingController.refresh();
      });
      if (mounted) {}
    });
  }

  Future<void> _fetchPage(int pageKey) async {
    print(pageKey);
    try {
      final newItems =
          await Service.getMatchDetails(pageKey + 1, search_data, 1, "");
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

  @override
  Widget build(BuildContext context) {
    var search = TextEditingController();
    return GestureDetector(
        onTap: () {
          // FocusScope.of(context).unfocus();
        },
        child: Scaffold(
            backgroundColor: primaryColor_bg,
            appBar: AppBar(
              backgroundColor: primaryColor,
              title: Text("My Favourite"),
            ),
            body: RefreshIndicator(
                onRefresh: () async {
                  _pagingController.refresh();
                },
                child: PagedListView<int, User>(
                    pagingController: _pagingController,
                    builderDelegate: PagedChildBuilderDelegate<User>(
                      itemBuilder: (context, item, index) => Padding(
                        padding: const EdgeInsets.only(
                            left: 18.0, right: 18.0, top: 12),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        profile_view(id: item.id)));
                          },
                          child: Stack(
                            children: [
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.17,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 15, left: 8, right: 8, bottom: 8),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 10, left: 10),
                                            child: CircleAvatar(
                                              backgroundImage: NetworkImage(
                                                  item.profile_photo),
                                              radius: 50,
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 20),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.4,
                                                  child: Text(
                                                    item.firstName +
                                                        " " +
                                                        item.lastName,
                                                    style: TextStyle(
                                                        color: primaryColor,
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                    overflow:
                                                        TextOverflow.ellipsis,
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
                                                    Text(
                                                        " : " +
                                                            item.whatsapp_no,
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
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 280, top: 15),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    btn2(Icons.favorite, item.id,
                                        item.favorite_status),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )))));
  }

  InkWell btn2(var Icons, fav_id, fav_status) {
    return InkWell(
      onTap: () {
        fav_status = fav_status == "1" ? "0" : "0";

        _fav_status(
          fav_id,
        );
      },
      child: Card(
        elevation: 10,
        child: Container(
          height: 40,
          width: 40,
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
      ),
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
