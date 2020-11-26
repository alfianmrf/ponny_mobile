import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'dart:io';
import 'package:readmore/readmore.dart';
import 'package:file_picker/file_picker.dart';
import 'Forum_screen.dart';
import 'package:ponny/common/constant.dart';
import 'package:ponny/widgets/PonnyBottomNavbar.dart';
import 'package:file_picker/file_picker.dart';
import 'package:provider/provider.dart';
import 'package:uiblock/uiblock.dart';
import 'Detail_komen_screen.dart';
import 'package:http_parser/http_parser.dart';
import 'Ruang_screen.dart';
import 'package:ponny/util/globalUrl.dart';
import 'package:ponny/model/PostandComment.dart';
import 'package:ponny/common/constant.dart';
import 'package:ponny/model/App.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:date_format/date_format.dart';

import 'package:ponny/model/RuangToken.dart';

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
  Future<List> roomRefresh;
  File _image;
  TextEditingController title = new TextEditingController();
  TextEditingController post = new TextEditingController();

  addBoolToSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('GabungValue', widget.gabung);
  }

  addIntToSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('intValue', widget.index);
  }

  Future getImage() async {
    FilePickerResult result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'png'],
    );
    setState(() {
      if (result != null) {
        _image = File(result.files.single.path);
        // print(_image.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Widget _imageFile() {
    return InkWell(
      onTap: getImage,
      child: _image != null
          ? Image.file(_image)
          : Image.network(
              "https://www.google.com/url?sa=i&url=https%3A%2F%2Fviewplus.com%2F41763258-warning-symbol%2F&psig=AOvVaw1KLjN3L9AASS3dCMBuJJrM&ust=1605629204199000&source=images&cd=vfe&ved=0CAIQjRxqFwoTCMCiioi5h-0CFQAAAAAdAAAAABAD"),
    );
  }

  DateTime convertDateFromString(String strDate) {
    DateTime todayDate = DateTime.parse(strDate);

    return todayDate;
  }

  Future<bool> kirimPost(BuildContext context) async {
    bool result = false;
    UIBlock.block(context, customLoaderChild: LoadingWidget(context));
    // var paramPost = {};
    var paramPost = {
      "title": title.text,
      "text": post.text,
      "room_id": widget.list[widget.index]["id"],
      "thumbnail": base64Encode(_image.readAsBytesSync())
    };

    final value = await Provider.of<PostandComment>(context)
        .posts(Provider.of<AppModel>(context).auth.access_token, paramPost);

    if (value) {
      UIBlock.unblock(context);
      result = value;
    }
    return result;
  }

  Widget _iconUpload() {
    return InkWell(
      onTap: getImage,
      child: Icon(
        Icons.add,
        size: 50,
        color: Colors.black12,
      ),
    );
  }

  List<dynamic> _users = [];

  /* Future<dynamic> fetchUsers() async {
    var result = await http.get(roomUrl);
    setState(() {
      _users = json.decode(result.body)["room"];
      print(_users);
    });
  }*/
  Future<List> roomData() async {
    final response = await http.get(roomUrl);

    Map<String, dynamic> map = json.decode(response.body);
    List<dynamic> data = map["room"];
    return data;
  }

  @override
  void initState() {
    roomRefresh = roomData();
    _users = widget.list;
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
        children: [
          Container(color: Hexcolor('#FCF8F0'),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(height: 20),
                  Row(
                    children: [
                      Expanded(
                        flex: 4,
                        child: Container(
                          width: double.infinity,
                          alignment: Alignment.centerRight,
                          padding: EdgeInsets.only(right: 20),
                          child: Container(
                            height: 80,
                            width: 80,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Colors.white,
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                      "http://via.placeholder.com/350x150")
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 7,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.filters
                                  ? widget.listFilter[widget.indexFilter]
                                      ["title"]
                                  : widget.list[widget.index]["title"],
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'Yeseva',
                                fontWeight: FontWeight.w800,
                                letterSpacing: 1,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 5),
                              child: Row(
                                children: [
                                  Image.asset(
                                    'assets/images/forum/member.png',
                                    height: 16,
                                  ),
                                  Container(width: 5),
                                  Text(
                                    widget.list[widget.index]["total_user"]
                                        .toString(),
                                    style: TextStyle(
                                        color: Color(0xffF48262),
                                        fontSize: 14),
                                  ),
                                  Container(width: 20),
                                  Image.asset(
                                    'assets/images/forum/komen.png',
                                    height: 16,
                                  ),
                                  Container(width: 5),
                                  Text(
                                      widget.list[widget.index]["posts"]
                                          .length
                                          .toString(),
                                      style: TextStyle(
                                          color: Color(0xffF48262),
                                          fontSize: 14))
                                ],
                              ),
                            ),
                            Text(
                              widget.filters
                                  ? widget.listFilter[widget.indexFilter]
                                      ["sub_title"]
                                  : widget.list[widget.index]
                                      ["sub_title"],
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'Brandon',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 5),
                              child: Row(
                                children: [
                                  widget.gabung
                                      ? FlatButton(
                                    color: Color(0xffFBDFD2),
                                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                    minWidth: 85,
                                    height: 0,
                                    padding: EdgeInsets.symmetric(vertical: 3, horizontal: 15),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                          onPressed: () {
                                            setState(() {
                                              widget.gabung = false;
                                              addBoolToSF();
                                              addIntToSF();
                                            });
                                          },
                                          child: Text(
                                            "Member",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontFamily: "Brandon",
                                              fontSize: 12,
                                            ),
                                          ),
                                        )
                                      : FlatButton(
                                    color: Color(0xffF48262),
                                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                    minWidth: 85,
                                    height: 0,
                                    padding: EdgeInsets.symmetric(vertical: 3, horizontal: 15),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                          onPressed: () {
                                            setState(() {
                                              widget.gabung = true;
                                              addBoolToSF();
                                              addIntToSF();
                                            });
                                          },
                                          child: Text(
                                            "Bergabung",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: "Brandon",
                                              fontSize: 12,
                                            ),
                                          ),
                                        ),
                                  Container(width: 5),
                                  FlatButton(
                                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                    minWidth: 85,
                                    height: 0,
                                    padding: EdgeInsets.symmetric(vertical: 3),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                      side: BorderSide(width: 1, color: Color(0xffF48262)),
                                    ),
                                    onPressed: () {
                                      Scaffold.of(context)
                                          .showBottomSheet<void>(
                                              (BuildContext context) {
                                        return Container(
                                            padding: EdgeInsets.all(10),
                                            height:
                                                MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.75,
                                            child:
                                                SingleChildScrollView(
                                              child: Column(
                                                mainAxisSize:
                                                    MainAxisSize.min,
                                                children: [
                                                  Container(
                                                    margin:
                                                        EdgeInsets.all(
                                                            5),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Container(
                                                          child:
                                                              IconButton(
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.pop(context);
                                                                  },
                                                                  icon:
                                                                      Icon(
                                                                    Icons.arrow_back_ios,
                                                                    color:
                                                                        Color(0xffF48262),
                                                                    size:
                                                                        26,
                                                                  )),
                                                        ),
                                                        Container(
                                                          margin: EdgeInsets
                                                              .only(
                                                                  right:
                                                                      10),
                                                          child:
                                                              FittedBox(
                                                            fit: BoxFit
                                                                .fitWidth,
                                                            child: Text(
                                                              "Mulai Obrolan",
                                                              style:
                                                                  TextStyle(
                                                                fontSize:
                                                                    24,
                                                                fontFamily:
                                                                    "Yeseva",
                                                                fontWeight:
                                                                    FontWeight.w500,
                                                                color: Color(
                                                                    0xffF48262),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    height: 1,
                                                    color: Color(
                                                        0xffF3C1B5),
                                                  ),
                                                  Container(
                                                    margin:
                                                        EdgeInsets.all(
                                                            10),
                                                    child: TextField(
                                                      controller: title,
                                                      decoration: new InputDecoration(
                                                          contentPadding:
                                                              EdgeInsets
                                                                  .all(
                                                                      10),
                                                          border: OutlineInputBorder(
                                                              borderSide: BorderSide(
                                                                  color: Colors
                                                                      .grey)),
                                                          hintStyle: TextStyle(
                                                              fontFamily:
                                                                  "Brandon"),
                                                          hintText:
                                                              "Title"),
                                                    ),
                                                  ),
                                                  ClipRRect(
                                                    borderRadius:
                                                        BorderRadius
                                                            .circular(
                                                                5),
                                                    child: Container(
                                                      padding: EdgeInsets
                                                          .symmetric(
                                                              vertical:
                                                                  30),
                                                      child: Column(
                                                        children: [
                                                          InkWell(
                                                            onTap:
                                                                () {},
                                                            child:
                                                                Container(
                                                              padding: EdgeInsets.only(
                                                                  bottom:
                                                                      10),
                                                              child: _image !=
                                                                      null
                                                                  ? _imageFile()
                                                                  : _iconUpload(),
                                                            ),
                                                          ),
                                                          Text(
                                                            'Letakkan Thumbnail Post disini',
                                                            style:
                                                                TextStyle(
                                                              fontFamily:
                                                                  'Brandon',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontSize:
                                                                  12,
                                                            ),
                                                          ),
                                                          Text(
                                                            '(max. 5MB)',
                                                            style:
                                                                TextStyle(
                                                              fontFamily:
                                                                  'Brandon',
                                                              fontSize:
                                                                  12,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    margin:
                                                        EdgeInsets.all(
                                                            10),
                                                    child: TextField(
                                                      controller: post,
                                                      decoration: new InputDecoration(
                                                          contentPadding:
                                                              EdgeInsets
                                                                  .all(
                                                                      10),
                                                          border: OutlineInputBorder(
                                                              borderSide: BorderSide(
                                                                  color: Color(
                                                                      0xffF48262))),
                                                          hintStyle: TextStyle(
                                                              fontFamily:
                                                                  "Brandon"),
                                                          hintText:
                                                              "Balas"),
                                                    ),
                                                  ),
                                                  Row(
                                                    children: [
                                                      Container(
                                                        margin:
                                                            EdgeInsets
                                                                .all(
                                                                    10),
                                                        alignment:
                                                            Alignment
                                                                .center,
                                                        padding:
                                                            EdgeInsets
                                                                .all(
                                                                    10),
                                                        decoration: BoxDecoration(
                                                            border: Border.all(
                                                                color: Color(
                                                                    0xffF48262))),
                                                        child: Text(
                                                          "BATAL",
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  "Brandon"),
                                                        ),
                                                      ),
                                                      Container(
                                                          width: 10),
                                                      InkWell(
                                                          onTap: () {
                                                            setState(
                                                                () async {
                                                              final result =
                                                                  await kirimPost(
                                                                      context);

                                                              Navigator.pop(
                                                                  context,
                                                                  true);
                                                            });
                                                          },
                                                          child:
                                                              Container(
                                                            margin: EdgeInsets
                                                                .all(
                                                                    10),
                                                            alignment:
                                                                Alignment
                                                                    .center,
                                                            padding:
                                                                EdgeInsets.all(
                                                                    10),
                                                            color: Color(
                                                                0xffF48262),
                                                            child: Text(
                                                              "POST",
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      "Brandon",
                                                                  color:
                                                                      Colors.white),
                                                            ),
                                                          )),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ));
                                      });
                                    },
                                    child: Text(
                                      "Mulai Obrolan",
                                      style: TextStyle(
                                        fontFamily: "Brandon",
                                        fontSize: 12,
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
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    height: 1,
                    color: Color(0xffF48262),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          listCategory("Trending"),
                          listCategory("Popular"),
                          listCategory("Terbaru"),
                        ],
                      ),
                    ),
                  ),
                ],
              )),
          Expanded(
            child: ListView.builder(
              itemCount: widget.list[widget.index]["posts"].length,
              itemBuilder: (context, i) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DetailKomenScreen(
                                  list: widget.list,
                                  index: i,
                                  roomIdx: widget.index,
                                )));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Hexcolor('#FCF8F0'),
                      border: Border(
                        top: BorderSide(width: 7, color: Colors.white)
                      ),
                    ),
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                              widget.list[widget.index]["title"],
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 10,
                                fontFamily: 'Brandon',
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ],
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DetailKomenScreen(
                                          list: widget.list,
                                          index: i,
                                          roomIdx: widget.index,
                                        )));
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
                                fontFamily: 'Brandon',
                                fontWeight: FontWeight.w800,
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
                        new FutureBuilder<List>(
                            future: roomRefresh,
                            builder: (context, snapshot) {
                              if (snapshot.hasError) print(snapshot.error);
                              List lists = snapshot.data;
                              return snapshot.hasData
                                  ? ListView.builder(
                                      primary: false,
                                      itemCount: lists[widget.index]
                                              ["posts"][i]["reply"]
                                          .length,
                                      shrinkWrap: true,
                                      itemBuilder: (context, idx) {
                                        return Column(
                                          children: [
                                            Container(
                                              margin: EdgeInsets.only(top: 10),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  border: Border.all(
                                                      color: Color(0xffF48262))),
                                              padding: EdgeInsets.all(5),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Container(
                                                        height: 35,
                                                        width: 35,
                                                        decoration:
                                                            BoxDecoration(
                                                                shape: BoxShape
                                                                    .circle,
                                                                color: Color(
                                                                    0xffF48262)),
                                                      ),
                                                      Container(
                                                        width: 5,
                                                      ),
                                                      Text(
                                                        "Phobe",
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                          fontSize: 14,
                                                          fontFamily: 'Brandon',
                                                          fontWeight:
                                                              FontWeight.w800,
                                                        ),
                                                      ),
                                                      Container(
                                                        width: 5,
                                                      ),
                                                      Container(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal: 3),
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5),
                                                            color: Color(
                                                                0xffF48262)),
                                                        child: Text(
                                                          "Dewy Skin",
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 10,
                                                            fontFamily:
                                                                'Brandon',
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
                                                          lists[widget.index]
                                                                      ["posts"]
                                                                  [i]["reply"]
                                                              [idx]["text"],
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
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.symmetric(vertical: 10),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      GestureDetector(
                                                        onTap: (){},
                                                        child: Icon(
                                                          Icons.favorite_border,
                                                          color:
                                                          Color(0xffF48262),
                                                          size: 20,
                                                        ),
                                                      ),
                                                      Container(width: 5),
                                                      Text(
                                                          lists[widget.index]
                                                          ["posts"]
                                                          [i]["like"]
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
                                                              widget.index,
                                                              2,
                                                              idx,
                                                              lists[widget.index]
                                                              ["posts"]
                                                              [i]["id"],
                                                              roomRefresh,
                                                              roomData);
                                                        },
                                                      ),
                                                      Container(width: 5),
                                                      Text("Balas",
                                                          style: TextStyle(
                                                              fontFamily:
                                                              "Brandon")),
                                                      Container(width: 10),
                                                      Text("|",
                                                          style: TextStyle(
                                                              fontFamily:
                                                              "Brandon")),
                                                      Container(width: 10),
                                                      Text("39 Balasan",
                                                          style: TextStyle(
                                                              fontFamily:
                                                              "Brandon")),
                                                    ],
                                                  ),
                                                  GestureDetector(
                                                    onTap: (){},
                                                    child: Image.asset(
                                                        "assets/images/shareIcon.PNG"),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        );
                                      })
                                  : Center(
                                      child:
                                          new CircularProgressIndicator());
                            })
                      ],
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

void _settingModalBottomSheet(context, List list, int index, int type,
    int postIndex, int postId, roomRefresh, roomData) {
  TextEditingController text = new TextEditingController();

  Future<bool> kirimPostdanComment(BuildContext context) async {
    bool result = false;
    UIBlock.block(context, customLoaderChild: LoadingWidget(context));
    // var paramPost = {};
    var paramComment = {
      "post_id": postId.toString(),
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
        builder: (BuildContext context, StateSetter setState) {
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
                            setState(() async {
                              final result = await kirimPostdanComment(context);
                            
                              Navigator.pop(context, true);
                            });
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
  );
}

void _mulaiObrolan(
  context,
  List list,
  int index,
) {
  TextEditingController title = new TextEditingController();
  TextEditingController post = new TextEditingController();

  final imageUpload = _DetailForumState();

  Future<bool> kirimPost(BuildContext context) async {
    bool result = false;
    UIBlock.block(context, customLoaderChild: LoadingWidget(context));
    // var paramPost = {};
    var paramPost = {
      "title": title.text,
      "text": post.text,
      "room_id": list[index]["id"],
      "thumbnail": base64Encode(imageUpload._image.readAsBytesSync())
    };

    final value = await Provider.of<PostandComment>(context)
        .posts(Provider.of<AppModel>(context).auth.access_token, paramPost);

    if (value) {
      UIBlock.unblock(context);
      result = value;
    }
    return result;
  }

  final detaiForum = _DetailForumState();

  showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Hexcolor('#FCF8F0'),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30))),
      context: context,
      builder: (builder) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Container(
                padding: EdgeInsets.all(10),
                height: MediaQuery.of(context).size.height * 0.75,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        margin: EdgeInsets.all(5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
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
                            Container(
                              margin: EdgeInsets.only(right: 10),
                              child: FittedBox(
                                fit: BoxFit.fitWidth,
                                child: Text(
                                  "Mulai Obrolan",
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontFamily: "Yeseva",
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xffF48262),
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
                          controller: title,
                          decoration: new InputDecoration(
                              contentPadding: EdgeInsets.all(10),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey)),
                              hintStyle: TextStyle(fontFamily: "Brandon"),
                              hintText: "Title"),
                        ),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 30),
                          child: Column(
                            children: [
                              InkWell(
                                onTap: () {},
                                child: Container(
                                  padding: EdgeInsets.only(bottom: 10),
                                  child: detaiForum._image != null
                                      ? detaiForum._imageFile()
                                      : detaiForum._iconUpload(),
                                ),
                              ),
                              Text(
                                'Letakkan Thumbnail Post disini',
                                style: TextStyle(
                                  fontFamily: 'Brandon',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                '(max. 5MB)',
                                style: TextStyle(
                                  fontFamily: 'Brandon',
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(10),
                        child: TextField(
                          controller: post,
                          decoration: new InputDecoration(
                              contentPadding: EdgeInsets.all(10),
                              border: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xffF48262))),
                              hintStyle: TextStyle(fontFamily: "Brandon"),
                              hintText: "Balas"),
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                            margin: EdgeInsets.all(10),
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                border: Border.all(color: Color(0xffF48262))),
                            child: Text(
                              "BATAL",
                              style: TextStyle(fontFamily: "Brandon"),
                            ),
                          ),
                          Container(width: 10),
                          InkWell(
                              onTap: () {
                                setState(() async {
                                  final result = await kirimPost(context);

                                  Navigator.pop(context, true);
                                });
                              },
                              child: Container(
                                margin: EdgeInsets.all(10),
                                alignment: Alignment.center,
                                padding: EdgeInsets.all(10),
                                color: Color(0xffF48262),
                                child: Text(
                                  "POST",
                                  style: TextStyle(
                                      fontFamily: "Brandon",
                                      color: Colors.white),
                                ),
                              )),
                        ],
                      )
                    ],
                  ),
                ));
          },
        );
      });
}
