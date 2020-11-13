import 'package:flutter/material.dart';
import 'Detail_Ruang_screen.dart';
import 'package:ponny/util/globalUrl.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RuangScreen extends StatefulWidget {
  RuangScreen({Key key}) : super(key: key);

  @override
  _RuangScreenState createState() => _RuangScreenState();
}

class _RuangScreenState extends State<RuangScreen> {
  @override
  Widget build(BuildContext context) {
    return RoomData();
  }
}

class RoomScreen extends StatefulWidget {
  final List listroom;

  RoomScreen({this.listroom});
  List gabung = new List(6);

  @override
  _RoomScreenState createState() => _RoomScreenState();
}

class _RoomScreenState extends State<RoomScreen> {
  bool detil = false;
  int index;

   Future<List> roomData() async {
    final response = await http.get(myRoomUrl);

    Map<String, dynamic> map = json.decode(response.body);
    List<dynamic> data = map["room"];
    return data;
  }

  @override
  void initState() {
    for (int i = 0; i < widget.listroom.length; i++) {
      if (widget.listroom[i]["join"] == "GABUNG") {
        widget.gabung[i] = false;
      } else {
        widget.gabung[i] = true;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        setState(() {
          detil = false;
        });
      },
      child: detil
          ? DetailForum(
              gabung: widget.gabung[index],
            )
          : DefaultTabController(
              length: 2,
              child: Column(children: [
                Expanded(
                  flex: 3,
                  child: Container(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      height: double.infinity,
                      width: double.infinity,
                      color: Color(0xffF3C1B5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: FittedBox(
                              child: Text(
                                "RUANG",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color(0xffF48262),
                                  fontSize: 20,
                                  fontFamily: 'Yeseva',
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: 1,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 10),
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
                          ),
                          Container(height: 10),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50)),
                                  color: Colors.white),
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              margin: EdgeInsets.symmetric(horizontal: 30),
                              child: Row(children: [
                                Expanded(
                                    child: TextField(
                                  cursorColor: Colors.black,
                                  keyboardType: TextInputType.text,
                                  textInputAction: TextInputAction.go,
                                  decoration: new InputDecoration.collapsed(
                                      hintText: "Cari Topik",
                                      hintStyle:
                                          TextStyle(fontFamily: "Brandon")),
                                )),
                                Icon(Icons.search, color: Color(0xffF48262)),
                              ]),
                            ),
                          ),
                        ],
                      )),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  child: TabBar(
                    tabs: [
                      Text(
                        "Semua Ruang",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          fontFamily: 'Brandon',
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1,
                        ),
                      ),
                      Text(
                        "Ruang Saya",
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
                  child: TabBarView(
                    children: [
                      GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2),
                        itemCount: widget.listroom == null
                            ? 0
                            : widget.listroom.length,
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
                                        child: Container(color: Colors.grey)),
                                    Expanded(
                                        flex: 1,
                                        child: Container(
                                            color: Colors.white,
                                            child: Column(
                                              children: [
                                                Expanded(
                                                  flex: 1,
                                                  child: Text(
                                                    widget.listroom[i]["title"],
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      fontFamily: 'Yeseva',
                                                      fontWeight:
                                                          FontWeight.w800,
                                                      letterSpacing: 1,
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
                                                      Icon(Icons.people,
                                                          size: 12,
                                                          color: Color(
                                                              0xffF48262)),
                                                      Text(
                                                        widget.listroom[i]
                                                                ["total_user"]
                                                            .toString(),
                                                        style: TextStyle(
                                                            color: Color(
                                                                0xffF48262),
                                                            fontSize: 12),
                                                      ),
                                                      Container(width: 10),
                                                      Icon(Icons.comment,
                                                          size: 12,
                                                          color: Color(
                                                              0xffF48262)),
                                                      Text(
                                                          widget
                                                              .listroom[i]
                                                                  ["posts"]
                                                              .length
                                                              .toString(),
                                                          style: TextStyle(
                                                              color: Color(
                                                                  0xffF48262),
                                                              fontSize: 12))
                                                    ],
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 2,
                                                  child: Text(
                                                    widget.listroom[i]
                                                        ["sub_title"],
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontSize: 10,
                                                      fontFamily: 'Yeseva',
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      letterSpacing: 1,
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                    flex: 1,
                                                    child: widget.gabung[i]
                                                        ? Container(
                                                            width:
                                                                double.infinity,
                                                            child: RaisedButton(
                                                                color: Color(
                                                                    0xffF3C1B5),
                                                                onPressed: () {
                                                                  setState(() {
                                                                    widget.gabung[
                                                                            i] =
                                                                        false;
                                                                  });
                                                                },
                                                                child: Text(
                                                                    "MEMBER",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white))),
                                                          )
                                                        : Container(
                                                            width:
                                                                double.infinity,
                                                            child: RaisedButton(
                                                                color: Color(
                                                                    0xffF48262),
                                                                onPressed: () {
                                                                  setState(() {
                                                                    widget.gabung[
                                                                            i] =
                                                                        true;
                                                                  });
                                                                },
                                                                child: Text(
                                                                    "GABUNG",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white))),
                                                          )),
                                              ],
                                            )))
                                  ]),
                                ),
                              ),
                            ),
                          );
                        },
                      ), //RUANG SAYA
                      GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2),
                        itemCount: widget.listroom == null
                            ? 0
                            : widget.listroom.length,
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
                                        child: Container(color: Colors.grey)),
                                    Expanded(
                                        flex: 1,
                                        child: Container(
                                            color: Colors.white,
                                            child: Column(
                                              children: [
                                                Expanded(
                                                  flex: 1,
                                                  child: Text(
                                                    widget.listroom[i]["title"],
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      fontFamily: 'Yeseva',
                                                      fontWeight:
                                                          FontWeight.w800,
                                                      letterSpacing: 1,
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
                                                      Icon(Icons.people,
                                                          size: 12,
                                                          color: Color(
                                                              0xffF48262)),
                                                      Text(
                                                        widget.listroom[i]
                                                                ["total_user"]
                                                            .toString(),
                                                        style: TextStyle(
                                                            color: Color(
                                                                0xffF48262),
                                                            fontSize: 12),
                                                      ),
                                                      Container(width: 10),
                                                      Icon(Icons.comment,
                                                          size: 12,
                                                          color: Color(
                                                              0xffF48262)),
                                                      Text(
                                                          widget
                                                              .listroom[i]
                                                                  ["posts"]
                                                              .length
                                                              .toString(),
                                                          style: TextStyle(
                                                              color: Color(
                                                                  0xffF48262),
                                                              fontSize: 12))
                                                    ],
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 2,
                                                  child: Text(
                                                    widget.listroom[i]
                                                        ["sub_title"],
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontSize: 10,
                                                      fontFamily: 'Yeseva',
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      letterSpacing: 1,
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                    flex: 1,
                                                    child: widget.gabung[i]
                                                        ? Container(
                                                            width:
                                                                double.infinity,
                                                            child: RaisedButton(
                                                                color: Color(
                                                                    0xffF3C1B5),
                                                                onPressed: () {
                                                                  setState(() {
                                                                    widget.gabung[
                                                                            i] =
                                                                        false;
                                                                  });
                                                                },
                                                                child: Text(
                                                                    "MEMBER",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white))),
                                                          )
                                                        : Container(
                                                            width:
                                                                double.infinity,
                                                            child: RaisedButton(
                                                                color: Color(
                                                                    0xffF48262),
                                                                onPressed: () {
                                                                  setState(() {
                                                                    widget.gabung[
                                                                            i] =
                                                                        true;
                                                                  });
                                                                },
                                                                child: Text(
                                                                    "GABUNG",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white))),
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
                    ],
                  ),
                ),
              ]),
            ),
    );
  }
}

class RoomData extends StatefulWidget {
  RoomData({Key key}) : super(key: key);

  @override
  _RoomDataState createState() => _RoomDataState();
}

class _RoomDataState extends State<RoomData> {
  Future<List> roomData() async {
    final response = await http.get(roomUrl);

    Map<String, dynamic> map = json.decode(response.body);
    List<dynamic> data = map["room"];
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return new FutureBuilder<List>(
        future: roomData(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          return snapshot.hasData
              ? RoomScreen(
                  listroom: snapshot.data,
                )
              : Center(child: new CircularProgressIndicator());
        });
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
        child: FittedBox(
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
      ),
    ],
  );
}
