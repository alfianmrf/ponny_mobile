import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:readmore/readmore.dart';
import 'Forum_screen.dart';
import 'Detail_komen_screen.dart';
import 'package:ponny/util/globalUrl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:date_format/date_format.dart';

class DetailForum extends StatefulWidget {
  bool gabung = false;
  int index;
  List list;
  List listFilter;
  int indexFilter;
  bool filters;

  DetailForum(
      {this.gabung,
      this.index,
      this.list,
      this.listFilter,
      this.indexFilter,
      this.filters});

  @override
  _DetailForumState createState() => _DetailForumState();
}

class _DetailForumState extends State<DetailForum> {
  int hours;

  addBoolToSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('GabungValue', widget.gabung);
  }

  addIntToSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('intValue', widget.index);
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            flex: 1,
            child: Container(
                color: Hexcolor('#FCF8F0'),
                child: Column(
                  children: [
                    Container(height: 20),
                    Expanded(
                      flex: 2,
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.grey),
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                    widget.filters
                                        ? widget.listFilter[widget.indexFilter]
                                            ["title"]
                                        : widget.list[widget.index]["title"],
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
                                      Icon(Icons.people,
                                          size: 12, color: Color(0xffF48262)),
                                      Text(
                                        widget.list[widget.index]["total_user"]
                                            .toString(),
                                        style: TextStyle(
                                            color: Color(0xffF48262),
                                            fontSize: 12),
                                      ),
                                      Container(width: 10),
                                      Icon(Icons.comment,
                                          size: 12, color: Color(0xffF48262)),
                                      Text(
                                          widget.list[widget.index]["posts"]
                                              .length
                                              .toString(),
                                          style: TextStyle(
                                              color: Color(0xffF48262),
                                              fontSize: 12))
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    widget.filters
                                        ? widget.listFilter[widget.indexFilter]
                                            ["title"]
                                        : widget.list[widget.index]
                                            ["sub_title"],
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
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Container(
                                          width: double.infinity,
                                          child: widget.gabung
                                              ? RaisedButton(
                                                  color: Color(0xffF3C1B5),
                                                  onPressed: () {
                                                    setState(() {
                                                      widget.gabung = false;
                                                      addBoolToSF();
                                                      addIntToSF();
                                                    });
                                                  },
                                                  child: FittedBox(
                                                    fit: BoxFit.fitWidth,
                                                    child: Text(
                                                      "MEMBER",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontFamily:
                                                              "Brandon"),
                                                    ),
                                                  ),
                                                )
                                              : RaisedButton(
                                                  color: Color(0xffF48262),
                                                  onPressed: () {
                                                    setState(() {
                                                      widget.gabung = true;
                                                      addBoolToSF();
                                                      addIntToSF();
                                                    });
                                                  },
                                                  child: FittedBox(
                                                    fit: BoxFit.fitWidth,
                                                    child: Text(
                                                      "Bergabung",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontFamily:
                                                              "Brandon"),
                                                    ),
                                                  ),
                                                ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: Colors.transparent,
                                              border: Border.all(
                                                  color: Color(0xffF48262))),
                                          width: double.infinity,
                                          child: RaisedButton(
                                            onPressed: () {
                                              setState(() {
                                                _settingModalBottomSheet(
                                                    context,
                                                    widget.list,
                                                    widget.index,
                                                    1,
                                                    0);
                                              });
                                            },
                                            child: FittedBox(
                                              fit: BoxFit.fitWidth,
                                              child: Text(
                                                "Mulai Obrolan",
                                                style: TextStyle(
                                                    fontFamily: "Brandon"),
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 20),
                      height: 1,
                      color: Color(0xffF3C1B5),
                    ),
                    Expanded(
                        flex: 1,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            listCategory("Trending"),
                            listCategory("Popular"),
                            listCategory("Terbaru"),
                          ],
                        )),
                  ],
                )),
          ),
          Expanded(
            flex: 2,
            child: ListView.builder(
              itemCount: widget.list[widget.index]["posts"].length,
              itemBuilder: (context, i) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DetailKomenScreen()));
                  },
                  child: Container(
                    color: Hexcolor('#FCF8F0'),
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: Card(
                      child: Container(
                        color: Hexcolor('#FCF8F0'),
                        padding: EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Balasan terbaru di",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontFamily: 'Brandon',
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 1,
                                  ),
                                ),
                                Text(
                                  widget.list[widget.index]["title"],
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontFamily: 'Brandon',
                                    fontWeight: FontWeight.w800,
                                    letterSpacing: 1,
                                  ),
                                ),
                              ],
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            DetailKomenScreen()));
                              },
                              child: Text(
                                widget.list[widget.index]["posts"][i]["title"],
                                style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: 'Yeseva',
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: 1,
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  "Posted " +
                                      DateFormat('dd MMMM yyyy').format(
                                          convertDateFromString(
                                              widget.list[widget.index]
                                                  ["created_at"])),
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
                                  DateFormat('Hm').format(convertDateFromString(
                                      widget.list[widget.index]["created_at"])),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontFamily: 'Brandon',
                                    color: Colors.grey,
                                    letterSpacing: 1,
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
                                    letterSpacing: 1,
                                  ),
                                ),
                              ],
                            ),
                            Container(height: 5),
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
                                  "Phobe",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: 'Yeseva',
                                    fontWeight: FontWeight.w800,
                                    letterSpacing: 1,
                                  ),
                                ),
                                Container(
                                  width: 5,
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 3),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Color(0xffF48262)),
                                  child: Text(
                                    "Dewy Skin",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 11,
                                      fontFamily: 'Brandon',
                                      fontWeight: FontWeight.w800,
                                      letterSpacing: 1,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              height: 5,
                            ),
                            ReadMoreText(
                              widget.list[widget.index]["posts"][i]["text"],
                              style: TextStyle(fontFamily: "Brandon"),
                              trimLines: 2,
                              colorClickableText: Colors.blue,
                              trimMode: TrimMode.Line,
                              trimCollapsedText: '...baca selengkapnya',
                              trimExpandedText: ' show less',
                            ),
                            Container(
                              height: 5,
                            ),
                            ListView.builder(
                                primary: false,
                                itemCount: widget
                                    .list[widget.index]["posts"][i]["reply"]
                                    .length,
                                shrinkWrap: true,
                                itemBuilder: (context, idx) {
                                  return Container(
                                    margin: EdgeInsets.only(top: 10),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(
                                            color: Color(0xffF3C1B5))),
                                    padding: EdgeInsets.all(5),
                                    child: Column(
                                      children: [
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
                                              "Phobe",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontFamily: 'Yeseva',
                                                fontWeight: FontWeight.w800,
                                                letterSpacing: 1,
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
                                                      BorderRadius.circular(5),
                                                  color: Color(0xffF48262)),
                                              child: Text(
                                                "Dewy Skin",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 11,
                                                  fontFamily: 'Brandon',
                                                  fontWeight: FontWeight.w800,
                                                  letterSpacing: 1,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Container(
                                          height: 5,
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Reply: ",
                                              style: TextStyle(
                                                  fontFamily: "Brandon",
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Expanded(
                                              child: ReadMoreText(
                                                widget.list[widget.index]
                                                        ["posts"][i]["reply"]
                                                    [idx]["text"],
                                                style: TextStyle(
                                                    fontFamily: "Brandon"),
                                                trimLines: 2,
                                                colorClickableText: Colors.blue,
                                                trimMode: TrimMode.Line,
                                                trimCollapsedText:
                                                    '...baca selengkapnya',
                                                trimExpandedText: ' show less',
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.favorite,
                                              color: Color(0xffF48262),
                                            ),
                                            Text("52",
                                                style: TextStyle(
                                                    fontFamily: "Brandon")),
                                            Container(width: 10),
                                            IconButton(
                                              icon: Icon(Icons.reply),
                                              color: Color(0xffF48262),
                                              onPressed: () {
                                                _settingModalBottomSheet(
                                                    context,
                                                    widget.list,
                                                    widget.index,
                                                    2,
                                                    idx);
                                              },
                                            ),
                                            Text("Balas",
                                                style: TextStyle(
                                                    fontFamily: "Brandon")),
                                            Container(width: 10),
                                            Text("|",
                                                style: TextStyle(
                                                    fontFamily: "Brandon")),
                                            Container(width: 10),
                                            Text("39 Balasan",
                                                style: TextStyle(
                                                    fontFamily: "Brandon")),
                                          ],
                                        )
                                      ],
                                    ),
                                  );
                                })
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          )
        ],
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
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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

void _settingModalBottomSheet(
    context, List list, int index, int type, int postIndex) {
  TextEditingController text = new TextEditingController();

  void createPost() {
    http.post(newPost, body: {
      "title": list[index]["title"],
      "text": text.text,
      "room_id": list[index]["id"].toString(),
    });
  }

  void addComment() {
    http.post(newPost, body: {
      "post_id": list[index]["title"],
      "text": text.text,
    });
  }

  showModalBottomSheet(
    isScrollControlled: true,
    backgroundColor: Hexcolor('#FCF8F0'),
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30), topRight: Radius.circular(30))),
    context: context,
    builder: (builder) {
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
                      onTap: () {
                        if (type == 1) {
                          createPost();
                        } else if (type == 2) {}
                        addComment();
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
                    ),
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
}
