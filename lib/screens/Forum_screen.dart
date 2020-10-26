import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:ponny/widgets/PonnyBottomNavbar.dart';
import 'Detail_Forum_screen.dart';

class ForumScreen extends StatefulWidget {
  static const String id = "forums_screen";
  List gabung = new List(6);
  

  @override
  _ForumScreenState createState() => _ForumScreenState();
}

class _ForumScreenState extends State<ForumScreen> {
  bool detil = false;
  int index;

  @override
  void initState() {
    for (int i = 0; i <= 5; i++) {
      widget.gabung[i] = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: WillPopScope(
        onWillPop: () {
          setState(() {
            detil = false;
          });
        },
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
                                  Text(
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
                                  Text(
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
                                itemCount: 5,
                                itemBuilder: (context, i) {
                                  return Container(
                                      margin: EdgeInsets.all(10),
                                      height: 200,
                                      width: double.infinity,
                                      color: Colors.grey);
                                }),
                          ),
                        ],
                      ),
                      detil
                          ? DetailForum(
                              gabung: widget.gabung[index],
                            )
                          : Column(children: [
                              Expanded(
                                flex: 3,
                                child: Container(
                                    height: double.infinity,
                                    width: double.infinity,
                                    color: Color(0xffF3C1B5),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "RUANG",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Color(0xffF48262),
                                            fontSize: 24,
                                            fontFamily: 'Yeseva',
                                            fontWeight: FontWeight.w800,
                                            letterSpacing: 1,
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: Text(
                                            "Temukan berbagai topik menarik seputar skincare yang kamu sukai dan berbincang dengan member lainnya.",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontFamily: 'Brandon',
                                              fontWeight: FontWeight.w800,
                                              letterSpacing: 1,
                                            ),
                                          ),
                                        ),
                                        Container(height: 10),
                                        Container(
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(50)),
                                              color: Colors.white),
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10),
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 30),
                                          child: Row(children: [
                                            Expanded(
                                                child: TextField(
                                              cursorColor: Colors.black,
                                              keyboardType: TextInputType.text,
                                              textInputAction:
                                                  TextInputAction.go,
                                              decoration:
                                                  new InputDecoration.collapsed(
                                                      hintText: "Cari Topik",
                                                      hintStyle: TextStyle(
                                                          fontFamily:
                                                              "Brandon")),
                                            )),
                                            Icon(Icons.search,
                                                color: Color(0xffF48262)),
                                          ]),
                                        ),
                                      ],
                                    )),
                              ),
                              Container(height: 10),
                              Expanded(
                                  flex: 1,
                                  child: ListView(
                                    scrollDirection: Axis.horizontal,
                                    children: [
                                      listCategory("Skincare"),
                                      listCategory("Trending"),
                                      listCategory("Popular"),
                                      listCategory("Makeup"),
                                      listCategory("Skincare"),
                                      listCategory("Skincare")
                                    ],
                                  )),
                              Expanded(
                                flex: 7,
                                child: GridView.builder(
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2),
                                  itemCount: 6,
                                  itemBuilder: (context, i) {
                                    return GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          detil = true;
                                          index = i;
                                        });
                                      },
                                      child: Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 5, vertical: 5),
                                        child: Card(
                                          child: Container(
                                            child: Column(children: [
                                              Expanded(
                                                  flex: 1,
                                                  child: Container(
                                                      color: Colors.grey)),
                                              Expanded(
                                                  flex: 1,
                                                  child: Container(
                                                      color: Colors.white,
                                                      child: Column(
                                                        children: [
                                                          Expanded(
                                                            flex: 1,
                                                            child: Text(
                                                              "Kulit Berminyak",
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: TextStyle(
                                                                fontSize: 12,
                                                                fontFamily:
                                                                    'Yeseva',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w800,
                                                                letterSpacing:
                                                                    1,
                                                              ),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            flex: 1,
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Icon(
                                                                    Icons
                                                                        .people,
                                                                    size: 12,
                                                                    color: Color(
                                                                        0xffF48262)),
                                                                Text(
                                                                  "1200",
                                                                  style: TextStyle(
                                                                      color: Color(
                                                                          0xffF48262),
                                                                      fontSize:
                                                                          12),
                                                                ),
                                                                Container(
                                                                    width: 10),
                                                                Icon(
                                                                    Icons
                                                                        .comment,
                                                                    size: 12,
                                                                    color: Color(
                                                                        0xffF48262)),
                                                                Text("500",
                                                                    style: TextStyle(
                                                                        color: Color(
                                                                            0xffF48262),
                                                                        fontSize:
                                                                            12))
                                                              ],
                                                            ),
                                                          ),
                                                          Expanded(
                                                            flex: 2,
                                                            child: Text(
                                                              "Ga setiap saat harus glowing",
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: TextStyle(
                                                                fontSize: 10,
                                                                fontFamily:
                                                                    'Yeseva',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                letterSpacing:
                                                                    1,
                                                              ),
                                                            ),
                                                          ),
                                                          Expanded(
                                                              flex: 1,
                                                              child: widget
                                                                      .gabung[i]
                                                                  ? Container(
                                                                      width: double
                                                                          .infinity,
                                                                      child: RaisedButton(
                                                                          color: Color(0xffF3C1B5),
                                                                          onPressed: () {
                                                                            setState(() {
                                                                              widget.gabung[i] = false;
                                                                            });
                                                                          },
                                                                          child: Text("MEMBER", style: TextStyle(color: Colors.white))),
                                                                    )
                                                                  : Container(
                                                                      width: double
                                                                          .infinity,
                                                                      child: RaisedButton(
                                                                          color: Color(0xffF48262),
                                                                          onPressed: () {
                                                                            setState(() {
                                                                              widget.gabung[i] = true;
                                                                            });
                                                                          },
                                                                          child: Text("GABUNG", style: TextStyle(color: Colors.white))),
                                                                    )),
                                                        ],
                                                      )))
                                            ]),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ])
                    ],
                  ),
                ),
              ],
            ),
            bottomNavigationBar: new PonnyBottomNavbar(selectedIndex: 3)),
      ),
    );
  }
}

Widget listCategory(String tagCategory) {
  return Wrap(
    children: [
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: Color(0xffF3C1B5),
        ),
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        margin: EdgeInsets.symmetric(horizontal: 5),
        child: Text(
          tagCategory,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 12,
            fontFamily: 'Brandon',
            fontWeight: FontWeight.w800,
            letterSpacing: 1,
          ),
        ),
      ),
    ],
  );
}
