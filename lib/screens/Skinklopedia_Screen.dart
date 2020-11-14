import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:ponny/widgets/PonnyBottomNavbar.dart';
import 'package:http/http.dart' as http;
import 'package:ponny/util/globalUrl.dart';
import 'dart:convert';

class Skinklopedia extends StatefulWidget {
  static const String id = "Skinklopedia_Screen";

  @override
  _SkinklopediaState createState() => _SkinklopediaState();
}

class _SkinklopediaState extends State<Skinklopedia> {
  String alphaBets = "A";
  var arrayOfalphaBets = [
    "A",
    "B",
    "C",
    "D",
    "E",
    "F",
    "G",
    "H",
    "I",
    "J",
    "K",
    "L",
    "M",
    "N",
    "O",
    "P",
    "Q",
    "R",
    "S",
    "T",
    "U",
    "V",
    "W",
    "X",
    "Y",
    "Z"
  ];

  Future<List> filterSkin(String alphaBets) async {
    final response = await http.get(skinkloUrl + alphaBets);
    Map<String, dynamic> map = json.decode(response.body);
    List<dynamic> data = map["data"];
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 26,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Hexcolor('#FCF8F0'),
        body: Column(
          children: <Widget>[
            Container(
              height: 70,
            ),
            Container(
              padding: EdgeInsets.only(left: 15, bottom: 15),
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 14),
                    child: GestureDetector(
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: Color(0xffF48262),
                        size: 26,
                      ),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  Container(
                    child: Text(
                      "Skinklopedia",
                      style: TextStyle(
                        fontSize: 24,
                        fontFamily: "Yeseva",
                        fontWeight: FontWeight.w500,
                        color: Color(0xffF48262),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 1,
              color: Color(0xffF3C1B5),
            ),
            Stack(
              children: [
                Container(
                  padding: EdgeInsets.only(top: 70, bottom: 70),
                  color: Hexcolor('#FACAC3'),
                  child: Container(
                    child: Column(
                      children: [
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                child: Text(
                                  "SKINKLOPEDIA",
                                  style: TextStyle(
                                    color: Color(0xffF48262),
                                    fontFamily: "Brandon",
                                    fontSize: 24,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                child: Text(
                                  "Seputar masalah kulit dan kandungan skincare",
                                  style: TextStyle(
                                    fontFamily: "Brandon",
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                child: Text(
                                  "yang kamu butuhkan ada di sini",
                                  style: TextStyle(
                                    fontFamily: "Brandon",
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Colors.white),
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.only(left: 30, top: 195, right: 30),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          style: TextStyle(
                            fontSize: 13,
                          ),
                          onTap: () {
                            // showSearch(context: null, delegate: Search());
                          },
                          cursorColor: Colors.black,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.go,
                          decoration: new InputDecoration.collapsed(
                              hintText: "Cari..."),
                        ),
                      ),
                      Icon(Icons.search, color: Color(0xffF48262)),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              // color: Colors.green,
              padding: EdgeInsets.only(top: 10, bottom: 10),
              width: MediaQuery.of(context).size.width,
              child: TabBar(
                onTap: (i) {
                  setState(() {
                    alphaBets = arrayOfalphaBets[i];
                  });
                },
                isScrollable: true,
                unselectedLabelColor: Colors.black,
                indicatorSize: TabBarIndicatorSize.label,
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  // color: Color(0xffF48262),
                ),
                labelColor: Color(0xffF48262),
                tabs: [
                  tabStyler("A"),
                  tabStyler("B"),
                  tabStyler("C"),
                  tabStyler("D"),
                  tabStyler("E"),
                  tabStyler("F"),
                  tabStyler("G"),
                  tabStyler("H"),
                  tabStyler("I"),
                  tabStyler("J"),
                  tabStyler("K"),
                  tabStyler("L"),
                  tabStyler("M"),
                  tabStyler("N"),
                  tabStyler("O"),
                  tabStyler("P"),
                  tabStyler("Q"),
                  tabStyler("R"),
                  tabStyler("S"),
                  tabStyler("T"),
                  tabStyler("U"),
                  tabStyler("V"),
                  tabStyler("W"),
                  tabStyler("X"),
                  tabStyler("Y"),
                  tabStyler("Z"),
                ],
              ),
            ),
            Expanded(
                child: new FutureBuilder<List>(
                    future: filterSkin(alphaBets),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) print(snapshot.error);
                      return snapshot.hasData
                          ? pageAlphaBets(snapshot.data)
                          : Center(child: new CircularProgressIndicator());
                    })),
          ],
        ),
        bottomNavigationBar: new PonnyBottomNavbar(selectedIndex: 4),
      ),
    );
  }
}

Widget pageAlphaBets(List list) {
  return TabBarView(
    children: [
      page_a(list: list),
      page_a(list: list),
      page_a(list: list),
      page_a(list: list),
      page_a(list: list),
      page_a(list: list),
      page_a(list: list),
      page_a(list: list),
      page_a(list: list),
      page_a(list: list),
      page_a(list: list),
      page_a(list: list),
      page_a(list: list),
      page_a(list: list),
      page_a(list: list),
      page_a(list: list),
      page_a(list: list),
      page_a(list: list),
      page_a(list: list),
      page_a(list: list),
      page_a(list: list),
      page_a(list: list),
      page_a(list: list),
      page_a(list: list),
      page_a(list: list),
      page_a(list: list),
    ],
  );
}

class page_a extends StatefulWidget {
  List list;
  page_a({this.list});

  @override
  _PageAScreen createState() => _PageAScreen();
}

class _PageAScreen extends State<page_a> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.list.length,
      itemBuilder: (context, i) {
        return Column(
          children: [
            i % 2 == 0
                ? Container(
                    margin: EdgeInsets.only(left: 25, right: 25, top: 20),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                            padding: EdgeInsets.only(
                              top: 20,
                              left: 20,
                            ),
                            decoration: BoxDecoration(
                              // color: Colors.indigo,

                              border: Border(
                                right: BorderSide(
                                  color: Color(0xffF48262),
                                ),
                              ),
                            ),
                            child: Container(
                              height: 140,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            padding: EdgeInsets.only(
                              top: 20,
                              left: 20,
                            ),

                            decoration: BoxDecoration(
                              // color: Colors.indigo,

                              border: Border(

                                  // right: BorderSide(

                                  //   color: Color(0xffF48262),

                                  // ),

                                  ),
                            ),

                            child: Container(
                              height: 140,

                              // color: Colors.grey,

                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      child: Row(
                                        children: [
                                          Flexible(
                                            child: Container(
                                              child: FittedBox(
                                                  child: Text(
                                                widget.list[i]["title"],
                                                style: TextStyle(
                                                  fontFamily: "Yeseva",
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              )),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 5),
                                      child: Text(
                                        widget.list[i]["text"],
                                        style: TextStyle(
                                          fontFamily: "Brandon",
                                          fontWeight: FontWeight.w300,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            // height: 150,
                          ),
                        )
                      ],
                    ),
                  )
                : Container(
                    margin: EdgeInsets.only(left: 25, right: 25),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                            padding: EdgeInsets.only(
                              top: 20,
                              left: 20,
                            ),

                            decoration: BoxDecoration(
                              // color: Colors.indigo,

                              border: Border(
                                right: BorderSide(
                                  color: Color(0xffF48262),
                                ),
                              ),
                            ),

                            child: Container(
                              height: 140,

                              // color: Colors.grey,

                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      child: Row(
                                        children: [
                                          Flexible(
                                            child: Container(
                                              child: FittedBox(
                                                child: Text(
                                                  widget.list[i]["title"],
                                                  style: TextStyle(
                                                    fontFamily: "Yeseva",
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 5),
                                      child: Text(
                                        widget.list[i]["text"],
                                        style: TextStyle(
                                          fontFamily: "Brandon",
                                          fontWeight: FontWeight.w300,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            // height: 150,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            padding: EdgeInsets.only(
                              top: 20,
                              right: 20,
                            ),
                            decoration: BoxDecoration(

                                // color: Colors.indigo,

                                ),
                            child: Container(
                              height: 140,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
          ],
        );
      },
    );
  }
}

class page_b extends StatefulWidget {
  @override
  _PageBScreen createState() => _PageBScreen();
}

class _PageBScreen extends State<page_b> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Center(
          child: Text("B"),
        ),
      ),
    );
  }
}

class page_c extends StatefulWidget {
  @override
  _PageCScreen createState() => _PageCScreen();
}

class _PageCScreen extends State<page_c> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Center(
          child: Text("C"),
        ),
      ),
    );
  }
}

class page_d extends StatefulWidget {
  @override
  _PageDScreen createState() => _PageDScreen();
}

class _PageDScreen extends State<page_d> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Center(
          child: Text("D"),
        ),
      ),
    );
  }
}

class page_e extends StatefulWidget {
  @override
  _PageEScreen createState() => _PageEScreen();
}

class _PageEScreen extends State<page_e> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Center(
          child: Text("E"),
        ),
      ),
    );
  }
}

class page_f extends StatefulWidget {
  @override
  _PageFScreen createState() => _PageFScreen();
}

class _PageFScreen extends State<page_f> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Center(
          child: Text("F"),
        ),
      ),
    );
  }
}

class page_g extends StatefulWidget {
  @override
  _PageGScreen createState() => _PageGScreen();
}

class _PageGScreen extends State<page_g> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Center(
          child: Text("G"),
        ),
      ),
    );
  }
}

Widget tabStyler(String alphaBets) {
  return Container(
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(5),
      border: Border.all(
        color: Color(0xffF48262),
        width: 1,
      ),
    ),
    child: Align(
      alignment: Alignment.center,
      child: Text(
        alphaBets,
        style: TextStyle(
          fontFamily: "Yeseva",
          fontWeight: FontWeight.w600,
          fontSize: 20,
        ),
      ),
    ),
  );
}
