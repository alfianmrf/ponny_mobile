import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'dart:io';
import 'package:readmore/readmore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:share/share.dart';
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

import 'package:ponny/model/App.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:date_format/date_format.dart';

import 'package:ponny/model/RuangToken.dart';

class DetailForum extends StatefulWidget {
  int id;

  DetailForum({
    this.id,
  });

  @override
  _DetailForumState createState() => _DetailForumState();
}

class _DetailForumState extends State<DetailForum> {
  int hours;
  Future<List> roomRefresh;
  File _image;
  TextEditingController title = new TextEditingController();
  TextEditingController post = new TextEditingController();
  int replyIndex;
  bool refresh = false;
  // addBoolToSF() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.setBool('GabungValue', widget.gabung);
  // }

  // addIntToSF() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.setInt('intValue', widget.index);
  // }

  Future getImage() async {
    FilePickerResult result = await FilePicker.platform.pickFiles(
      type: FileType.image,
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
  // final picker = ImagePicker();
  // Future getImage() async {
  //   final pickedFile = await picker.getImage(source: ImageSource.gallery);

  //   setState(() {
  //     if (pickedFile != null) {
  //       _image = File(pickedFile.path);
  //       print(pickedFile.path);
  //     } else {
  //       print('No image selected.');
  //     }
  //   });
  // }

  Widget _imageFile() {
    return InkWell(
      onTap: getImage,
      child: _image != null
          ? Image.file(_image)
          : Image.network(
              "https://www.google.com/url?sa=i&url=https%3A%2F%2Fviewplus.com%2F41763258-warning-symbol%2F&psig=AOvVaw1KLjN3L9AASS3dCMBuJJrM&ust=1605629204199000&source=images&cd=vfe&ved=0CAIQjRxqFwoTCMCiioi5h-0CFQAAAAAdAAAAABAD"),
    );
  }

  Future<bool> postData(int idRuang) async {
    bool result = false;
    UIBlock.block(context, customLoaderChild: LoadingWidget(context));

    var paramComment = {
      "room_id": idRuang.toString(),
    };
    String accessToken =
        Provider.of<AppModel>(context, listen: false).auth.access_token == null
            ? "abc"
            : Provider.of<AppModel>(context, listen: false).auth.access_token;

    final value = await Provider.of<PostandComment>(context)
        .postRoomModel(accessToken, paramComment);
    if (value) {
      UIBlock.unblock(context);
      result = value;
    }

    return result;
  }

  Future<bool> leaveData(int idRuang) async {
    bool result = false;
    UIBlock.block(context, customLoaderChild: LoadingWidget(context));

    var paramComment = {
      "room_id": idRuang.toString(),
    };

    String accessToken =
        Provider.of<AppModel>(context, listen: false).auth.access_token == null
            ? "abc"
            : Provider.of<AppModel>(context, listen: false).auth.access_token;

    final value = await Provider.of<PostandComment>(context)
        .leaveRoomModel(accessToken, paramComment);
    if (value) {
      UIBlock.unblock(context);
      result = value;
    }

    return result;
  }

  List data;
  Future<List> roomData() async {
    var accessToken = Provider.of<AppModel>(context).auth.access_token;
    print(accessToken);
    final response = await http.get(
      detailRoom,
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader: "Bearer $accessToken"
      },
    );

    Map<String, dynamic> map = json.decode(response.body);
    List<dynamic> data = map["room"];
    return data;
  }

  DateTime convertDateFromString(String strDate) {
    DateTime todayDate = DateTime.parse(strDate);

    return todayDate;
  }

  List dataa;
  Future detailroomData() async {
    var accessToken = Provider.of<AppModel>(context).auth.access_token;
    final response = await http.get(
      detailRoom + "${widget.id}",
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader: "Bearer $accessToken"
      },
    );
    if (response.statusCode == 200) {
      print('sukses');

      var datas = json.decode(response.body);

      print(datas);
      return datas;
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<bool> like(int idRuang) async {
    bool result = false;
    UIBlock.block(context, customLoaderChild: LoadingWidget(context));
    String accessToken =
        Provider.of<AppModel>(context).auth.access_token == null
            ? "abc"
            : Provider.of<AppModel>(context).auth.access_token;

    final value = await Provider.of<PostandComment>(context)
        .likePost(accessToken, idRuang.toString());
    if (value) {
      UIBlock.unblock(context);
      result = value;
    }

    return result;
  }

  Future<bool> unlike(int idRuang) async {
    bool result = false;
    UIBlock.block(context, customLoaderChild: LoadingWidget(context));
    String accessToken =
        Provider.of<AppModel>(context).auth.access_token == null
            ? "abc"
            : Provider.of<AppModel>(context).auth.access_token;

    final value = await Provider.of<PostandComment>(context)
        .unlikePost(accessToken, idRuang.toString());
    if (value) {
      UIBlock.unblock(context);
      result = value;
    }

    return result;
  }

  /*Future<bool> kirimPost(BuildContext context) async {
    bool result = false;
    UIBlock.block(context, customLoaderChild: LoadingWidget(context));
    // var paramPost = {};
    print(title.text);
    print(post.text);
    print(widget.list[widget.index]["id"]);
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
  }*/

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

  /* Future<dynamic> fetchUsers() async {
    var result = await http.get(roomUrl);
    setState(() {
      _users = json.decode(result.body)["room"];
      print(_users);
    });
  }*/

  @override
  void initState() {
    // print(widget.filters);
    print(widget.id);
    // _users = widget.list;
    // TODO: implement initState
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: detailroomData(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print(snapshot.error);
          }
          // widget.list = snapshot.data;
          if (snapshot.connectionState == ConnectionState.waiting) {
            return LoadingWidgetFadingCircle(context);
          }
          if (snapshot.hasData) {
            return Scaffold(
              resizeToAvoidBottomInset: false,
              body: Column(
                children: [
                  Container(
                      color: Hexcolor('#FCF8F0'),
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
                                      shape: BoxShape.circle,
                                      color: Colors.white,
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                              img_url + snapshot.data['img'])),
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
                                      snapshot.data['title'],
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: 'Yeseva',
                                        fontWeight: FontWeight.w800,
                                        letterSpacing: 1,
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 5),
                                      child: Row(
                                        children: [
                                          Image.asset(
                                            'assets/images/forum/member.png',
                                            height: 16,
                                          ),
                                          Container(width: 5),
                                          Text(
                                            snapshot.data['total_user']
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
                                              snapshot.data['post'].length == 0
                                                  ? "0"
                                                  : snapshot.data['post'].length
                                                      .toString(),
                                              style: TextStyle(
                                                  color: Color(0xffF48262),
                                                  fontSize: 14))
                                        ],
                                      ),
                                    ),
                                    Text(
                                      snapshot.data['sub_title'],
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
                                          snapshot.data['join'] == 'LEAVE'
                                              ? FlatButton(
                                                  color: Color(0xffFBDFD2),
                                                  materialTapTargetSize:
                                                      MaterialTapTargetSize
                                                          .shrinkWrap,
                                                  minWidth: 85,
                                                  height: 0,
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 3,
                                                      horizontal: 15),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                  ),
                                                  onPressed: () async {
                                                    final result =
                                                        await leaveData(
                                                            widget.id);
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
                                                  materialTapTargetSize:
                                                      MaterialTapTargetSize
                                                          .shrinkWrap,
                                                  minWidth: 85,
                                                  height: 0,
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 3,
                                                      horizontal: 15),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                  ),
                                                  onPressed: () async {
                                                    final result =
                                                        await postData(
                                                            widget.id);
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
                                            materialTapTargetSize:
                                                MaterialTapTargetSize
                                                    .shrinkWrap,
                                            minWidth: 85,
                                            height: 0,
                                            padding: EdgeInsets.symmetric(
                                                vertical: 3),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              side: BorderSide(
                                                  width: 1,
                                                  color: Color(0xffF48262)),
                                            ),
                                            onPressed: () {
                                              mulaiObrolan();
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
                    //Revise this
                    child: ListView.builder(
                        itemCount: snapshot.data["post"].length == 0
                            ? 0
                            : snapshot.data["post"].length,
                        itemBuilder: (context, i) {
                          hours = DateTime.now()
                              .difference(DateTime.parse(
                                  snapshot.data["post"][i]["created_at"]))
                              .inHours;

                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DetailKomenScreen(
                                            id: snapshot.data["post"][i]['id'],
                                          )));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Hexcolor('#FCF8F0'),
                                border: Border(
                                    top: BorderSide(
                                        width: 7, color: Colors.white)),
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
                                        snapshot.data["title"],
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
                                              builder: (context) =>
                                                  DetailKomenScreen(
                                                      id: snapshot.data["post"]
                                                          [i]['id'])));
                                    },
                                    child: Text(
                                      snapshot.data["post"][i]["title"],
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
                                                convertDateFromString(snapshot
                                                    .data["post"][i]
                                                        ["created_at"]
                                                    .toString())),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontFamily: 'Brandon',
                                          color: Colors.grey,
                                        ),
                                      ),
                                      Container(width: 10),
                                      Text(
                                        DateFormat('Hm').format(
                                            convertDateFromString(
                                                snapshot.data["post"][i]
                                                    ["created_at"])),
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
                                      ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          child: Image.network(
                                            snapshot.data["post"][i]['user']
                                                        ["avatar_original"] ==
                                                    null
                                                ? 'https://www.tenforums.com/geek/gars/images/2/types/thumb_15951118880user.png'
                                                : img_url +
                                                    snapshot.data["post"][i]
                                                            ['user']
                                                            ["avatar_original"]
                                                        .toString(),
                                            height: 35,
                                            width: 35,
                                            fit: BoxFit.cover,
                                          )),
                                      Container(
                                        width: 5,
                                      ),
                                      Text(
                                        snapshot.data["post"][i]['user']
                                            ["name"],
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
                                        padding:
                                            EdgeInsets.symmetric(horizontal: 3),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            color: Color(0xffF48262)),
                                        child: Text(
                                          snapshot.data["post"][i]['user']
                                              ["user_tier"]["title"],
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
                                    snapshot.data["post"][i]['text'],
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
                                      itemCount: snapshot
                                                  .data["post"][i]['reply']
                                                  .length ==
                                              0
                                          ? 0
                                          : snapshot
                                              .data["post"][i]['reply'].length,
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
                                                      color:
                                                          Color(0xffF48262))),
                                              padding: EdgeInsets.all(5),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      100),
                                                          child: Image.network(snapshot.data["post"][i]['reply'][idx]["user"] == null
                                                              ? 'https://www.tenforums.com/geek/gars/images/2/types/thumb_15951118880user.png'
                                                              : snapshot.data["post"][i]['reply'][idx]["user"]["avatar_original"] == null
                                                              ? 'https://www.tenforums.com/geek/gars/images/2/types/thumb_15951118880user.png'
                                                              : img_url + snapshot.data["post"][i]['reply'][idx]["user"]["avatar_original"],
                                                            height: 35,
                                                            width: 35,
                                                            fit: BoxFit.cover,
                                                          )),
                                                      Container(
                                                        width: 5,
                                                      ),
                                                      Text(
                                                        snapshot.data["post"][i]['reply'][idx]["user"] == null ? 'Anonim' :
                                                        snapshot.data["post"][i]['reply'][idx]["user"]["name"].toString(),
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
                                                      if(snapshot.data["post"][i]['reply'][idx]["user"] != null )
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
                                                          snapshot.data["post"]
                                                                          [i]
                                                                      ['reply']
                                                                  [idx]["user"][
                                                              "user_tier"]["title"],
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
                                                          snapshot.data["post"]
                                                                  [i]['reply']
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
                                          ],
                                        );
                                      }),
                                  Padding(
                                    padding: EdgeInsets.symmetric(vertical: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            snapshot.data["post"][i]
                                                        ['is_liked'] ==
                                                    null
                                                ? GestureDetector(
                                                    onTap: () {
                                                      like(snapshot.data["post"]
                                                          [i]['id']);
                                                    },
                                                    child: Icon(
                                                      Icons.favorite_border,
                                                      color: Color(0xffF48262),
                                                      size: 20,
                                                    ),
                                                  )
                                                : GestureDetector(
                                                    onTap: () {
                                                      unlike(
                                                          snapshot.data["post"]
                                                              [i]['id']);
                                                    },
                                                    child: Icon(
                                                      Icons.favorite,
                                                      color: Color(0xffF48262),
                                                      size: 20,
                                                    ),
                                                  ),
                                            Container(width: 5),
                                            Text(
                                                snapshot.data["post"][i]['like']
                                                            .length ==
                                                        0
                                                    ? "0"
                                                    : snapshot
                                                        .data["post"][i]['like']
                                                        .length
                                                        .toString(),
                                                style: TextStyle(
                                                    fontFamily: "Brandon")),
                                            Container(width: 10),
                                            GestureDetector(
                                              child: Image.asset(
                                                'assets/images/forum/balas.png',
                                                height: 14,
                                              ),
                                              onTap: () {
                                                _settingModalBottomSheet(
                                                    context,
                                                    snapshot.data["post"][i]
                                                        ['id']);
                                              },
                                            ),
                                            Container(width: 5),
                                            GestureDetector(
                                              onTap: () {
                                                _settingModalBottomSheet(
                                                    context,
                                                    snapshot.data["post"][i]
                                                        ['id']);
                                              },
                                              child: Text("Balas",
                                                  style: TextStyle(
                                                      fontFamily: "Brandon")),
                                            ),
                                            Container(width: 10),
                                            Text("|",
                                                style: TextStyle(
                                                    fontFamily: "Brandon")),
                                            Container(width: 10),
                                            Text(
                                                snapshot
                                                            .data["post"][i]
                                                                ['reply']
                                                            .length ==
                                                        0
                                                    ? "0 Balasan"
                                                    : snapshot
                                                            .data["post"][i]
                                                                ['reply']
                                                            .length
                                                            .toString() +
                                                        " Balasan",
                                                style: TextStyle(
                                                    fontFamily: "Brandon")),
                                          ],
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            Share.share(
                                                'https://ponnybeaute.co.id/' +
                                                    snapshot.data["post"][i]
                                                            ['slug']
                                                        .toString());
                                          },
                                          child: Image.asset(
                                              "assets/images/shareIcon.PNG"),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        }),
                  )
                ],
              ),
            );
          }

          return LoadingWidgetFadingCircle(context);
        });
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

  void _settingModalBottomSheet(context, int postId) {
    TextEditingController text = new TextEditingController();
    final _scaffoldKey = GlobalKey<ScaffoldState>();

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
      String accessToken =
          Provider.of<AppModel>(context).auth.access_token == null
              ? "abc"
              : Provider.of<AppModel>(context).auth.access_token;

      final value = await Provider.of<PostandComment>(context)
          .comment(accessToken, paramComment);
      if (value) {
        UIBlock.unblock(context);
        result = value;
      } else {
        _scaffoldKey.currentState.showSnackBar(snackBarError);
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
                                final result =
                                    await kirimPostdanComment(context);
                                if (result) {
                                  print("success");
                                } else {
                                  print("failed");
                                }
                                refresh = true;
                                Navigator.pop(context);
                                /*Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => DetailForum(
                                            gabung: widget.gabung,
                                            list: widget.list,
                                            index: index,
                                            indexFilter: widget.indexFilter,
                                            listFilter: widget.listFilter,
                                            filters: widget.filters)));*/
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
    ).then((value) {
      setState(() {});
    });
  }

  void mulaiObrolan() {
    List<File> files = [];
    TextEditingController title = new TextEditingController();
    TextEditingController post = new TextEditingController();
    final _scaffoldKey = GlobalKey<ScaffoldState>();

    Future<bool> kirimPost(BuildContext context) async {
      bool result = false;
      UIBlock.block(context, customLoaderChild: LoadingWidget(context));
      // var paramPost = {};
      String accessToken =
          Provider.of<AppModel>(context).auth.access_token == null
              ? "abc"
              : Provider.of<AppModel>(context).auth.access_token;
      Map<String, String> headers = {"Authorization": "Bearer $accessToken"};
      var request = http.MultipartRequest("POST", Uri.parse(newPost));

      var multipartFile =
          await http.MultipartFile.fromPath("thumbnail", _image.path,
              contentType: MediaType(
                'image',
                'jpeg',
              ));
      request.files.add(multipartFile);

      request.fields["title"] = title.text;
      request.fields["text"] = post.text;
      request.fields["room_id"] = widget.id.toString();
      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        UIBlock.unblock(context);
        result = true;
      } else {
        _scaffoldKey.currentState.showSnackBar(snackBarError);
      }
      return result;
      /* var paramPost = {
        "title": title.text,
        "text": post.text,
        "room_id": list[index]["id"],
       //"thumbnail": base64Encode(_image.readAsBytesSync())
      };

      final value = await Provider.of<PostandComment>(context)
          .posts(Provider.of<AppModel>(context).auth.access_token, paramPost);

      if (value) {
        UIBlock.unblock(context);
        result = value;
      }
      return result;*/
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
                  height: MediaQuery.of(context).size.height * 0.90,
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
                                hintText: "Judul"),
                          ),
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Column(
                              children: [
                                InkWell(
                                  onTap: () {},
                                  child: Container(
                                    child: _image != null
                                        ? Container(
                                            height: 80,
                                            width: 40,
                                            child: Image.file(_image))
                                        : _iconUpload(),
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
                                border: Border.all(color: Color(0xffF48262)),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                "BATAL",
                                style: TextStyle(fontFamily: "Brandon"),
                              ),
                            ),
                            Container(width: 10),
                            _image != null
                                ? InkWell(
                                    onTap: () async {
                                      final result = await kirimPost(context);
                                      /*setState() {
                                    
                                    if (result) {
                                      print("success");
                                    } else {
                                      print("failed");
                                    }

                                    
                                  });*/
                                      Navigator.pop(context);
                                    },
                                    child: Container(
                                      margin: EdgeInsets.all(10),
                                      alignment: Alignment.center,
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: Color(0xffF48262),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Text(
                                        "POST",
                                        style: TextStyle(
                                            fontFamily: "Brandon",
                                            color: Colors.white),
                                      ),
                                    ))
                                : Container(),
                          ],
                        )
                      ],
                    ),
                  ));
            },
          );
        }).then((value) {
      setState(() {
        // roomData();
      });
    });
  }
}

/*class DetailForumData extends StatefulWidget {
  bool gabung = false;
  int index;
  List list = [];
  List listFilter;
  int indexFilter;
  bool filters;

  DetailForumData(
      {this.gabung,
      this.index,
      this.list,
      this.listFilter,
      this.indexFilter,
      this.filters});

  @override
  _DetailForumDataState createState() => _DetailForumDataState();
}

class _DetailForumDataState extends State<DetailForumData> {
  Future<List> roomData() async {
    final response = await http.get(roomUrl);

    Map<String, dynamic> map = json.decode(response.body);
    List<dynamic> data = map["room"];
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: roomData(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
       
          return snapshot.hasData
              ? DetailForum(
                  list: snapshot.data,
                  gabung: widget.gabung,
                  listFilter: widget.listFilter,
                  filters: widget.filters,
                  indexFilter: widget.indexFilter,
                  index: widget.index,
                )
              : Center(child: CircularProgressIndicator());
        });
  }
}*/
