import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:ponny/widgets/PonnyBottomNavbar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'Ruang_screen.dart';
import 'package:ponny/util/globalUrl.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ForumScreen extends StatefulWidget {
  final List list;

  ForumScreen({this.list});

  List gabung = new List(6);

  @override
  _ForumScreenState createState() => _ForumScreenState();
}

class _ForumScreenState extends State<ForumScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Hexcolor('#FCF8F0'),
          body: Column(
            children: [
              Container(
                height: 35,
                width: double.infinity,
                decoration: BoxDecoration(color: Color(0xffF48262)),
              ),
              Container(
                height: 80,
                width: double.infinity,
                decoration: BoxDecoration(color: Color(0xffF48262)),
                child: TabBar(
                  indicatorColor: Colors.white,
                  tabs: [
                    Text(
                      "BERANDA",
                      style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'Brandon',
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1,
                          color: Colors.white),
                    ),
                    Text(
                      "RUANG",
                      style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'Brandon',
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1,
                          color: Colors.white),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    Column(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                            height: double.infinity,
                            width: double.infinity,
                            color: Color(0xffF3C1B5),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Flexible(
                                  child: FittedBox(
                                    fit: BoxFit.cover,
                                    child: Text(
                                      "PHOEBE BOARD",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Color(0xffF48262),
                                        fontSize: 14,
                                        fontFamily: 'Yeseva',
                                        fontWeight: FontWeight.w800,
                                        letterSpacing: 1,
                                      ),
                                    ),
                                  ),
                                ),
                                Flexible(
                                  child: FittedBox(
                                    child: Text(
                                      "FORUM",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Color(0xffF48262),
                                        fontSize: 24,
                                        fontFamily: 'Brandon',
                                        fontWeight: FontWeight.w800,
                                        letterSpacing: 1,
                                      ),
                                    ),
                                  ),
                                ),
                                Text(
                                  "Berbincang mengenai seputar skincare dan permasalahannya.",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontFamily: 'Brandon',
                                    fontWeight: FontWeight.w800,
                                    letterSpacing: 1,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: ListView.builder(
                              itemCount:
                                  widget.list == null ? 0 : widget.list.length,
                              itemBuilder: (context, i) {
                                return Column(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(top: 10),
                                      height: 200,
                                      width: double.infinity,
                                      child: CachedNetworkImage(
                                        imageUrl:
                                            "http://via.placeholder.com/350x150",
                                        placeholder: (context, url) =>
                                            CircularProgressIndicator(),
                                        errorWidget: (context, url, error) =>
                                            Icon(Icons.error),
                                      ),
                                    ),
                                    Text(
                                      widget.list[i]["title"],
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontFamily: "Brandon",
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(
                                      "Temukan topik yang kamu",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: "Brandon",
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                );
                              }),
                        ),
                      ],
                    ),
                    RuangScreen()
                  ],
                ),
              ),
            ],
          ),
          bottomNavigationBar: new PonnyBottomNavbar(selectedIndex: 3)),
    );
  }
}

class ForumData extends StatefulWidget {
  static const String id = "forums_screen";

  @override
  _ForumDataState createState() => _ForumDataState();
}

class _ForumDataState extends State<ForumData> {
  Future<List> forumData() async {
    final response = await http.get(forumUrl);

    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return new FutureBuilder<List>(
        future: forumData(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          return snapshot.hasData
              ? ForumScreen(
                  list: snapshot.data,
                )
              : Center(child: new CircularProgressIndicator());
        });
  }
}
