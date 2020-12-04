import 'package:flutter/material.dart';
import 'package:ponny/common/constant.dart';
import 'Detail_Ruang_screen.dart';
import 'package:ponny/util/globalUrl.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:ponny/model/rommId.dart';

import 'package:cached_network_image/cached_network_image.dart';

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
  int category = 1;
  RoomScreen({this.listroom, this.category});
  List gabung = new List(6);

  @override
  _RoomScreenState createState() => _RoomScreenState();
}

class _RoomScreenState extends State<RoomScreen> {
  bool detil = false;
  int index;
  int indexFilter;
  int idRuang;
  bool filtered;
  bool filters;
  List<bool> checkedValue = new List<bool>(6);
  List listFilter;
  var joinRoom = {""};

  /*Future<List> myRoomData() async {
    final response = await http.get(myRoomUrl);

    Map<String, dynamic> map = json.decode(response.body);
    List<dynamic> data = map["room"];
    return data;
  }*/

  getGabungValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return int
    int intValue = prefs.getInt('intValue');
    bool boolValue = prefs.getBool('GabungValue');

    if (boolValue != null) {
      setState(() {
        widget.gabung[intValue] = boolValue;
      });
    }
  }

  void postData() {
    //var ojo = ;

    http.post(postRoom, body: {"room_id": idRuang.toString()});

    /*if (response.statusCode == 302) {
      return response;
    }*/

    /*  if (response.statusCode == 302) {
      roomId value = roomId.fromJson(json.decode(response.body));
      return value;
    } else {
      throw Exception('Failed to read notification');
    }*/

    /*if (response.statusCode < 200 ||
        response.statusCode >= 400 ||
        json == null) {
      print("fail");
    } else {
      print("success");
    }*/

    //print(response.statusCode);
  }

  @override
  void initState() {
    for (int i = 0; i < widget.listroom.length; i++) {
      if (widget.listroom[i]["join"] == "GABUNG") {
        widget.gabung[i] = true;
      } else {
        widget.gabung[i] = false;
      }
    }
    print(widget.listroom);
    checkedValue[0] = false;
    checkedValue[1] = false;
    checkedValue[2] = false;
    checkedValue[3] = false;
    checkedValue[4] = false;
    filtered = false;
    filters = false;
  }

  Future<List> myRoomData(int category) async {
    final response =
        await http.get(roomUrl + "/" + category.toString() + "/0/23");

    Map<String, dynamic> map = json.decode(response.body);
    List<dynamic> data = map["room"];
    return data;
  }

  addBoolToSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('GabungValue', widget.gabung[index]);
  }

  addIntToSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('intValue', index);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        setState(() {
          detil = false;
          getGabungValuesSF();
        });
      },
      child: detil
          ? DetailForum(
              gabung: widget.gabung[index],
              list: widget.listroom,
              index: index,
              indexFilter: indexFilter,
              listFilter: listFilter,
              filters: filters)
          : DefaultTabController(
              length: 2,
              child: Column(children: [
                Container(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    width: double.infinity,
                    color: Color(0xffFBDFD2),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                        "RUANG",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xffF48262),
                            fontSize: 26,
                            fontFamily: 'Yeseva',
                            fontWeight: FontWeight.w800,
                            letterSpacing: 1,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 30),
                          child: Text(
                            "Temukan berbagai topik menarik seputar skincare yang kamu sukai dan berbincang dengan member lainnya.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'Brandon',
                              fontWeight: FontWeight.w800,
                              letterSpacing: 1,
                            ),
                          ),
                        ),
                        Container(height: 10),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50)),
                              color: Colors.white),
                          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 3),
                          margin: EdgeInsets.symmetric(horizontal: 50),
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
                      ],
                    )),
                Container(
                  child: TabBar(
                    tabs: [
                      Tab(
                        child: Text(
                          "Semua Ruang",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Brandon',
                            fontWeight: FontWeight.w800,
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                      Tab(
                        child: Text(
                          "Ruang Saya",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Brandon',
                            fontWeight: FontWeight.w800,
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        listCategory("Skincare"),
                        listCategory("Trending"),
                        listCategory("Popular"),
                        listCategory("Makeup"),
                        listCategory("Skincare"),
                        listCategory("Skincare")
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, childAspectRatio: 0.8),
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
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: Color(0xffF48262),
                                  ),
                                ),
                                child: Column(children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                                    ),
                                    width: double.infinity,
                                    height: 100,
                                    child: ClipRRect(borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                                        child: CachedNetworkImage(
                                          imageUrl:widget.listroom[i]["img"] != null?  img_url+widget.listroom[i]["img"].toString():"",
                                          placeholder: (context, url) => LoadingWidgetPulse(context),
                                          errorWidget: (context, url, error) => Image.asset('assets/images/1366x615.png'),
                                          fit: BoxFit.fill,
                                        )
                                    ),
                                  ),
                                  Container(
                                      color: Colors.white,
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(top: 5),
                                            child: Text(
                                              widget.listroom[i]["title"],
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontFamily: 'Yeseva',
                                                fontWeight:
                                                    FontWeight.w800,
                                                letterSpacing: 1,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            padding: EdgeInsets.symmetric(vertical: 5),
                                            margin: EdgeInsets.symmetric(horizontal: 10),
                                            decoration: BoxDecoration(
                                              border: Border(bottom: BorderSide(width: 1, color: Color(0xffF48262))),
                                            ),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Image.asset(
                                                  'assets/images/forum/member.png',
                                                  height: 14,
                                                ),
                                                Container(width: 5),
                                                Text(
                                                  widget.listroom[i]
                                                  ["total_user"]
                                                      .toString(),
                                                  style: TextStyle(
                                                      color: Color(
                                                          0xffF48262),
                                                      fontSize: 12),
                                                ),
                                                Container(width: 20),
                                                Image.asset(
                                                  'assets/images/forum/komen.png',
                                                  height: 14,
                                                ),
                                                Container(width: 5),
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
                                          Padding(
                                            padding: EdgeInsets.only(top: 5),
                                            child: Text(
                                              widget.listroom[i]
                                                  ["sub_title"],
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontFamily: 'Brandon',
                                                fontWeight:
                                                    FontWeight.w500,
                                                height: 1,
                                              ),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      )),
                                  Expanded(
                                    child: widget.gabung[i]
                                        ? Container(
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.only(topLeft: Radius.circular(0), topRight: Radius.circular(0), bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10))
                                          ),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              Container(
                                                width:
                                                double.infinity,
                                                child: FlatButton(
                                                    color: Color(0xffFBDFD2),
                                                    height: 0,
                                                    padding: EdgeInsets.symmetric(vertical: 3),
                                                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.only(topLeft: Radius.circular(0), topRight: Radius.circular(0), bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10))
                                                    ),
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
                                                            fontFamily: 'Brandon',
                                                            color: Colors
                                                                .black))),
                                              ),
                                            ],
                                          ),
                                        )
                                        : Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.only(topLeft: Radius.circular(0), topRight: Radius.circular(0), bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10))
                                      ),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              Container(
                                                width:
                                                double.infinity,
                                                child: FlatButton(
                                                    color: Color(
                                                        0xffF48262),
                                                    height: 0,
                                                    padding: EdgeInsets.symmetric(vertical: 3),
                                                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                                    shape: RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.only(topLeft: Radius.circular(0), topRight: Radius.circular(0), bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10))
                                                    ),
                                                    onPressed: () {
                                                      setState(() {
                                                        widget.gabung[
                                                        i] =
                                                        true;
                                                        idRuang = widget
                                                            .listroom[
                                                        i]["id"];
                                                        index = i;
                                                        addBoolToSF();
                                                        addIntToSF();
                                                        postData();
                                                      });
                                                    },
                                                    child: Text(
                                                        "GABUNG",
                                                        style: TextStyle(
                                                            fontFamily: 'Brandon',
                                                            color: Colors
                                                                .white))),
                                              ),
                                            ],
                                          ),
                                        ),
                                  ),
                                ]),
                              ),
                            ),
                          );
                        },
                      ), //RUANG SAYA
                      new FutureBuilder<List>(
                          future: myRoomData(widget.category),
                          builder: (context, snapshot) {
                            if (snapshot.hasError) print(snapshot.error);
                            List list = snapshot.data;
                            listFilter = snapshot.data;

                            return snapshot.hasData
                                ? Column(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.all(15),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                filtered = !filtered;
                                              },
                                              child: Container(
                                                padding: EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Color(0xffF48262)),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0),
                                                ),
                                                child: Row(
                                                  children: [
                                                    Icon(Icons.tune),
                                                    Text("Filter",
                                                        style: TextStyle(
                                                            fontFamily:
                                                                "Brandon",
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500)),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Container(width: 10),
                                            Container(
                                              padding: EdgeInsets.all(10),
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Color(0xffF48262)),
                                                borderRadius:
                                                    BorderRadius.circular(5.0),
                                              ),
                                              child: Row(
                                                children: [
                                                  Icon(Icons
                                                      .keyboard_arrow_down),
                                                  Text("Urutkan",
                                                      style: TextStyle(
                                                          fontFamily: "Brandon",
                                                          fontWeight:
                                                              FontWeight.w500)),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Stack(
                                          children: [
                                            Expanded(
                                              child: GridView.builder(
                                                shrinkWrap: true,
                                                gridDelegate:
                                                    SliverGridDelegateWithFixedCrossAxisCount(
                                                        crossAxisCount: 2),
                                                itemCount: list == null
                                                    ? 0
                                                    : filters
                                                        ? list.length
                                                        : widget
                                                            .listroom.length,
                                                itemBuilder: (context, i) {
                                                  return GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        detil = true;
                                                        index = i;
                                                        indexFilter = i;
                                                      });
                                                    },
                                                    child: Container(
                                                      margin:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 5,
                                                              vertical: 5),
                                                      child: Card(
                                                        child: Container(
                                                          child: Column(
                                                              children: [
                                                                Expanded(
                                                                    flex: 1,
                                                                    child: Container(
                                                                        color: Colors
                                                                            .grey)),
                                                                Expanded(
                                                                    flex: 1,
                                                                    child: Container(
                                                                        color: Colors.white,
                                                                        child: Column(
                                                                          children: [
                                                                            Expanded(
                                                                              flex: 1,
                                                                              child: Text(
                                                                                filters ? list[i]["title"] : widget.listroom[i]["title"],
                                                                                textAlign: TextAlign.center,
                                                                                style: TextStyle(
                                                                                  fontSize: 12,
                                                                                  fontFamily: 'Yeseva',
                                                                                  fontWeight: FontWeight.w800,
                                                                                  letterSpacing: 1,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Expanded(
                                                                              flex: 1,
                                                                              child: Row(
                                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                                children: [
                                                                                  Icon(Icons.people, size: 12, color: Color(0xffF48262)),
                                                                                  Text(
                                                                                    widget.listroom[i]["total_user"].toString(),
                                                                                    style: TextStyle(color: Color(0xffF48262), fontSize: 12),
                                                                                  ),
                                                                                  Container(width: 10),
                                                                                  Icon(Icons.comment, size: 12, color: Color(0xffF48262)),
                                                                                  Text(widget.listroom[i]["posts"].length.toString(), style: TextStyle(color: Color(0xffF48262), fontSize: 12))
                                                                                ],
                                                                              ),
                                                                            ),
                                                                            Expanded(
                                                                              flex: 2,
                                                                              child: Text(
                                                                                filters ? list[i]["sub_title"] : widget.listroom[i]["sub_title"],
                                                                                textAlign: TextAlign.center,
                                                                                style: TextStyle(
                                                                                  fontSize: 10,
                                                                                  fontFamily: 'Yeseva',
                                                                                  fontWeight: FontWeight.w500,
                                                                                  letterSpacing: 1,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Expanded(
                                                                                flex: 1,
                                                                                child: widget.gabung[i]
                                                                                    ? Container(
                                                                                        width: double.infinity,
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
                                                                                        width: double.infinity,
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
                                            filtered
                                                ? Align(
                                                    alignment:
                                                        Alignment.centerRight,
                                                    child: Container(
                                                      margin: EdgeInsets.only(
                                                          right: 20),
                                                      decoration: BoxDecoration(
                                                        color:
                                                            Hexcolor('#FCF8F0'),
                                                        border: Border.all(
                                                            color: Color(
                                                                0xffF48262)),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                      ),
                                                      padding:
                                                          EdgeInsets.all(10),
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.3,
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.5,
                                                      child:
                                                          SingleChildScrollView(
                                                        child: Column(
                                                          children: [
                                                            Row(
                                                              children: [
                                                                Checkbox(
                                                                  value:
                                                                      (checkedValue[
                                                                          0]),
                                                                  onChanged:
                                                                      (newValue) {
                                                                    setState(
                                                                        () {
                                                                      checkedValue[
                                                                              0] =
                                                                          newValue;
                                                                      widget.category =
                                                                          1;
                                                                      filters =
                                                                          !filters;
                                                                    });
                                                                  },
                                                                ),
                                                                Text(
                                                                  "Make Up",
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        14,
                                                                    fontFamily:
                                                                        'Brandon',
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    letterSpacing:
                                                                        1,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            Row(
                                                              children: [
                                                                Checkbox(
                                                                  value:
                                                                      (checkedValue[
                                                                          1]),
                                                                  onChanged:
                                                                      (newValue) {
                                                                    setState(
                                                                        () {
                                                                      checkedValue[
                                                                              1] =
                                                                          newValue;
                                                                      widget.category =
                                                                          2;
                                                                      filters =
                                                                          !filters;
                                                                    });
                                                                  },
                                                                ),
                                                                Text(
                                                                  "Skin Care",
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        14,
                                                                    fontFamily:
                                                                        'Brandon',
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    letterSpacing:
                                                                        1,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            Row(
                                                              children: [
                                                                Checkbox(
                                                                  value:
                                                                      (checkedValue[
                                                                          2]),
                                                                  onChanged:
                                                                      (newValue) {
                                                                    setState(
                                                                        () {
                                                                      checkedValue[
                                                                              2] =
                                                                          newValue;
                                                                      widget.category =
                                                                          3;
                                                                      filters =
                                                                          !filters;
                                                                    });
                                                                  },
                                                                ),
                                                                Text(
                                                                  "Hair",
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        14,
                                                                    fontFamily:
                                                                        'Brandon',
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    letterSpacing:
                                                                        1,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            Row(
                                                              children: [
                                                                Checkbox(
                                                                  value:
                                                                      (checkedValue[
                                                                          3]),
                                                                  onChanged:
                                                                      (newValue) {
                                                                    setState(
                                                                        () {
                                                                      checkedValue[
                                                                              3] =
                                                                          newValue;
                                                                      widget.category =
                                                                          4;
                                                                      filters =
                                                                          !filters;
                                                                    });
                                                                  },
                                                                ),
                                                                Text(
                                                                  "Ponny Baute",
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        14,
                                                                    fontFamily:
                                                                        'Brandon',
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    letterSpacing:
                                                                        1,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            Row(
                                                              children: [
                                                                Checkbox(
                                                                  value:
                                                                      (checkedValue[
                                                                          4]),
                                                                  onChanged:
                                                                      (newValue) {
                                                                    setState(
                                                                        () {
                                                                      checkedValue[
                                                                              4] =
                                                                          newValue;
                                                                      widget.category =
                                                                          5;
                                                                      filters =
                                                                          !filters;
                                                                    });
                                                                  },
                                                                ),
                                                                Text(
                                                                  "Lainnya",
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        14,
                                                                    fontFamily:
                                                                        'Brandon',
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    letterSpacing:
                                                                        1,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                : Container(),
                                          ],
                                        ),
                                      ),
                                    ],
                                  )
                                : Center(
                                    child: new CircularProgressIndicator());
                          })
                    ],
                  ),
                ),
              ]),
            ),
    );
  }
}

Widget _simplePopup() => PopupMenuButton<int>(
      itemBuilder: (context) => [
        PopupMenuItem(
          value: 1,
          child: Text("First"),
        ),
        PopupMenuItem(
          value: 2,
          child: Text("Second"),
        ),
      ],
    );

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
          color: Color(0xffFBDFD2),
        ),
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        margin: EdgeInsets.symmetric(horizontal: 5),
        child: FittedBox(
          child: Text(
            tagCategory,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              fontFamily: 'Brandon',
            ),
          ),
        ),
      ),
    ],
  );
}

/*void _settingModalBottomSheet(context) {
  TextEditingController text = new TextEditingController();
  
  showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Hexcolor('#FCF8F0'),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30))),
      context: context,
      builder: (builder) {
        return StatefulBuilder(
          builder: (BuildContext context, setState) {
            return ;
          },
        );
      });
}
});
}*/
