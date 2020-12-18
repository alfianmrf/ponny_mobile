import 'package:flutter/material.dart';
import 'package:ponny/common/constant.dart';
import 'package:readmore/readmore.dart';
import 'package:ponny/model/PostandComment.dart';
import 'package:ponny/common/constant.dart';
import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:ponny/model/App.dart';
import 'package:ponny/util/globalUrl.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:uiblock/uiblock.dart';
import 'package:intl/intl.dart';
import 'package:ponny/widgets/PonnyBottomNavbar.dart';

class DetailKomenScreen extends StatefulWidget {
  List list;
  int index;
  int roomIdx;
  DetailKomenScreen({Key key, this.list, this.index, this.roomIdx})
      : super(key: key);

  @override
  _DetailKomenScreenState createState() => _DetailKomenScreenState();
}

class _DetailKomenScreenState extends State<DetailKomenScreen> {
  int hours;

  DateTime convertDateFromString(String strDate) {
    DateTime todayDate = DateTime.parse(strDate);

    return todayDate;
  }

  @override
  void initState() {
    // TODO: implement initState

    hours = DateTime.now()
        .difference(DateTime.parse(widget.list[widget.index]["updated_at"]))
        .inHours;
  }

  Future<List> roomData() async {
    final response = await http.get(roomUrl);

    Map<String, dynamic> map = json.decode(response.body);
    List<dynamic> data = map["room"];
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
                      resizeToAvoidBottomInset: false,
                      backgroundColor: Hexcolor('#FCF8F0'),
                      appBar: AppBar(
                        elevation: 0,
                        titleSpacing: 0,
                        leading: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.arrow_back_ios,
                            color: Color(0xffF48262),
                            size: 26,
                          ),
                        ),
                        title: Text(
                          "Kembali",
                          style: TextStyle(
                            fontSize: 24,
                            fontFamily: "Yeseva",
                            fontWeight: FontWeight.w500,
                            color: Color(0xffF48262),
                          ),
                        ),
                        bottom: PreferredSize(
                            child: Container(
                              color: Color(0xffF48262),
                              height: 1.0,
                            ),
                            preferredSize: Size.fromHeight(1.0)),
                      ),
                      body:  FutureBuilder(
        future: roomData(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          widget.list = snapshot.data;
          if(snapshot.hasData) 
              return   SingleChildScrollView(
                        child: Column(
                          children: [
                            Container(
                              height: 1,
                              color: Color(0xffF3C1B5),
                            ),
                            Container(
                              color: Hexcolor('#FCF8F0'),
                              margin: EdgeInsets.symmetric(vertical: 10),
                              child: Container(
                                color: Hexcolor('#FCF8F0'),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(10),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                "Balasan terbaru di ",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontSize: 10,
                                                  fontFamily: 'Brandon',
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              Text(
                                                widget.list[widget.roomIdx]
                                                    ["title"],
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontSize: 10,
                                                  fontFamily: 'Brandon',
                                                  fontWeight: FontWeight.w800,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Container(
                                                height: 35,
                                                width: 35,
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: Color(0xffF48262)),
                                              ),
                                              Container(
                                                width: 5,
                                              ),
                                              Text(
                                                "Phoebe",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontFamily: 'Brandon',
                                                  fontWeight: FontWeight.w800,
                                                ),
                                              ),
                                              Container(
                                                width: 5,
                                              ),
                                              Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 3),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    color: Color(0xffF48262)),
                                                child: Text(
                                                  "Dewy Skin",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 10,
                                                    fontFamily: 'Brandon',
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Container(
                                            height: 5,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                "Posted " +
                                                    DateFormat('dd MMMM yyyy').format(
                                                        convertDateFromString(
                                                            widget.list[widget
                                                                    .index][
                                                                "created_at"])),
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontSize: 10,
                                                  fontFamily: 'Brandon',
                                                  color: Colors.grey,
                                                ),
                                              ),
                                              Container(width: 5),
                                              Text(
                                                "|",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontSize: 10,
                                                  fontFamily: 'Brandon',
                                                  color: Colors.grey,
                                                  letterSpacing: 1,
                                                ),
                                              ),
                                              Container(width: 10),
                                              Text(
                                                "Diupdate " +
                                                    hours.toString() +
                                                    " jam yang lalu",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontSize: 10,
                                                  fontFamily: 'Brandon',
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Text(
                                            widget.list[widget.roomIdx]["posts"]
                                                [widget.index]["title"],
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontFamily: 'Yeseva',
                                              fontWeight: FontWeight.w800,
                                            ),
                                          ),
                                          Container(height: 5),
                                          Text(
                                            widget.list[widget.roomIdx]["posts"]
                                                [widget.index]["text"],
                                            style: TextStyle(
                                                fontFamily: "Brandon"),
                                          ),
                                          Container(
                                            height: 5,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {},
                                                    child: Icon(
                                                      Icons.favorite_border,
                                                      color: Color(0xffF48262),
                                                      size: 20,
                                                    ),
                                                  ),
                                                  Container(width: 5),
                                                  Text(
                                                      widget
                                                          .list[widget.roomIdx]
                                                              ["posts"]
                                                              [widget.index]
                                                              ["like"]
                                                          .length
                                                          .toString(),
                                                      style: TextStyle(
                                                          fontFamily:
                                                              "Brandon")),
                                                  Container(width: 10),
                                                  GestureDetector(
                                                    child: Image.asset(
                                                      'assets/images/forum/balas.png',
                                                      height: 14,
                                                    ),
                                                    onTap: () {
                                                      _settingModalBottomSheet(
                                                          context,
                                                          widget.list,
                                                          widget.list[widget
                                                                      .roomIdx]
                                                                  ["posts"][
                                                              widget
                                                                  .index]["id"]);
                                                    },
                                                  ),
                                                  Container(width: 5),
                                                  GestureDetector(
                                                    onTap: () {_settingModalBottomSheet(
                                                          context,
                                                          widget.list,
                                                          widget.list[widget
                                                                      .roomIdx]
                                                                  ["posts"][
                                                              widget
                                                                  .index]["id"]);},
                                                    child: Text("Balas",
                                                        style: TextStyle(
                                                            fontFamily:
                                                                "Brandon")),
                                                  ),
                                                  Container(width: 10),
                                                  Text("|",
                                                      style: TextStyle(
                                                          fontFamily:
                                                              "Brandon")),
                                                  Container(width: 10),
                                                  Text(
                                                      widget
                                                              .list[widget
                                                                      .roomIdx]
                                                                  ["posts"]
                                                                  [widget.index]
                                                                  ["reply"]
                                                              .length
                                                              .toString() +
                                                          " Balasan",
                                                      style: TextStyle(
                                                          fontFamily:
                                                              "Brandon")),
                                                ],
                                              ),
                                              IconButton(
                                                  icon: Image.asset(
                                                      "assets/images/shareIcon.PNG"),
                                                  onPressed: () {}),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    ListView.builder(
                                      primary: false,
                                      shrinkWrap: true,
                                      itemCount: widget
                                          .list[widget.roomIdx]["posts"]
                                              [widget.index]["reply"]
                                          .length,
                                      itemBuilder: (context, i) {
                                        return Container(
                                          padding: EdgeInsets.only(bottom: 10),
                                          child: Column(
                                            children: [
                                              Container(
                                                height: 7,
                                                color: Colors.white,
                                              ),
                                              Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 10),
                                                child: Column(
                                                  children: [
                                                    Container(
                                                      height: 20,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Container(
                                                          height: 35,
                                                          width: 35,
                                                          decoration: BoxDecoration(
                                                              shape: BoxShape
                                                                  .circle,
                                                              color: Color(
                                                                  0xffF48262)),
                                                        ),
                                                        Container(
                                                          width: 5,
                                                        ),
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Row(
                                                              children: [
                                                                Text(
                                                                  "Phoebe",
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
                                                                            .w800,
                                                                  ),
                                                                ),
                                                                Container(
                                                                  width: 5,
                                                                ),
                                                                Container(
                                                                  padding: EdgeInsets
                                                                      .symmetric(
                                                                          horizontal:
                                                                              3),
                                                                  decoration: BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              5),
                                                                      color: Color(
                                                                          0xffF48262)),
                                                                  child: Text(
                                                                    "Dewy Skin",
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    style:
                                                                        TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          10,
                                                                      fontFamily:
                                                                          'Brandon',
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            Row(
                                                              children: [
                                                                Text(
                                                                  "Posted 20-07-2020",
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        10,
                                                                    fontFamily:
                                                                        'Brandon',
                                                                    color: Colors
                                                                        .grey,
                                                                  ),
                                                                ),
                                                                Container(
                                                                    width: 5),
                                                                Text(
                                                                  "|",
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        10,
                                                                    fontFamily:
                                                                        'Brandon',
                                                                    color: Colors
                                                                        .grey,
                                                                    letterSpacing:
                                                                        1,
                                                                  ),
                                                                ),
                                                                Container(
                                                                    width: 10),
                                                                Text(
                                                                  "12.27",
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        10,
                                                                    fontFamily:
                                                                        'Brandon',
                                                                    color: Colors
                                                                        .grey,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                    Container(
                                                      height: 5,
                                                    ),
                                                    Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          "Reply: ",
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  "Brandon",
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        Expanded(
                                                          child: ReadMoreText(
                                                            widget.list[widget
                                                                            .roomIdx]
                                                                        [
                                                                        "posts"]
                                                                    [
                                                                    widget
                                                                        .index][
                                                                "reply"][i]["text"],
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    "Brandon"),
                                                            trimLines: 2,
                                                            colorClickableText:
                                                                Colors.blue,
                                                            trimMode:
                                                                TrimMode.Line,
                                                            trimCollapsedText:
                                                                '...baca selengkapnya',
                                                            trimExpandedText:
                                                                ' show less',
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            GestureDetector(
                                                              onTap: () {},
                                                              child: Icon(
                                                                Icons
                                                                    .favorite_border,
                                                                color: Color(
                                                                    0xffF48262),
                                                                size: 20,
                                                              ),
                                                            ),
                                                            Container(width: 5),
                                                            Text("52",
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        "Brandon")),
                                                            Container(
                                                                width: 10),
                                                            GestureDetector(
                                                              child:
                                                                  Image.asset(
                                                                'assets/images/forum/balas.png',
                                                                height: 14,
                                                              ),
                                                              onTap: () {
                                                                _settingModalBottomSheet(
                                                                    context,
                                                                    widget.list,
                                                                    widget.list[
                                                                        widget
                                                                            .roomIdx]["posts"][widget
                                                                        .index]["id"]);
                                                              },
                                                            ),
                                                            Container(width: 5),
                                                            GestureDetector(onTap:(){_settingModalBottomSheet(
                                                          context,
                                                          widget.list,
                                                          widget.list[widget
                                                                      .roomIdx]
                                                                  ["posts"][
                                                              widget
                                                                  .index]["id"]);},
                                                                                                                          child: Text("Balas",
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                          "Brandon")),
                                                            ),
                                                            Container(
                                                                width: 10),
                                                            Text("|",
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        "Brandon")),
                                                            Container(
                                                                width: 10),
                                                            Text("39 Balasan",
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        "Brandon")),
                                                          ],
                                                        ),
                                                        IconButton(
                                                            icon: Image.asset(
                                                                "assets/images/shareIcon.PNG"),
                                                            onPressed: () {}),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                      return  LoadingWidgetFadingCircle(context);
                     
                
            
        }) ,bottomNavigationBar:
                          new PonnyBottomNavbar(selectedIndex: 3));
  }

  void _settingModalBottomSheet(
    context,
    List list,
    int index,
  ) {
    TextEditingController text = new TextEditingController();

    Future<bool> kirimPostdanComment(BuildContext context) async {
      bool result = false;
      UIBlock.block(context, customLoaderChild: LoadingWidget(context));
      // var paramPost = {};
      var paramComment = {
        "post_id": index.toString(),
        "text": text.text,
        "recommended_items[]": "28",
        "notifmail": "1"
      };

      /* type == 1
        ? await Provider.of<PostandComment>(context)
            .posts(Provider.of<AppModel>(context).auth.access_token, paramPost)
        :*/
      final value = await Provider.of<PostandComment>(context).comment(
          Provider.of<AppModel>(context).auth.access_token, paramComment);

      if (value) {
        UIBlock.unblock(context);
        result = value;
      }
      return result;
    }

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
            return Container(
              padding: EdgeInsets.all(10),
              height: MediaQuery.of(context).size.height * 0.75,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.all(5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Container(
                              child: IconButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  icon: Icon(
                                    Icons.arrow_back_ios,
                                    color: Color(0xffF48262),
                                    size: 26,
                                  )),
                            ),
                          ),
                          Expanded(
                            flex: 4,
                            child: Container(
                              margin: EdgeInsets.only(right: 10),
                              child: FittedBox(
                                fit: BoxFit.fitWidth,
                                child: Text(
                                  "Tambahkan Komentar",
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontFamily: "Yeseva",
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xffF48262),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () async {
                              final result = await kirimPostdanComment(context);

                              Navigator.pop(context, true);
                            },
                            child: FittedBox(
                              fit: BoxFit.fitWidth,
                              child: Text(
                                "Kirim",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: "Brandon",
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      height: 1,
                      color: Color(0xffF3C1B5),
                    ),
                    Container(
                      margin: EdgeInsets.all(10),
                      child: TextField(
                        controller: text,
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        cursorColor: Colors.black,
                        textInputAction: TextInputAction.go,
                        decoration: new InputDecoration.collapsed(
                            hintStyle: TextStyle(fontFamily: "Brandon"),
                            hintText: "Tambahkan Komentar"),
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        );
      },
    ).then((value) {
      setState(() {});
    });
  }
}
