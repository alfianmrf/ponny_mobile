import 'package:flutter/material.dart';
import 'package:ponny/common/constant.dart';
import 'package:ponny/model/detailForum.dart';
import 'package:readmore/readmore.dart';
import 'package:ponny/model/PostandComment.dart';
import 'package:ponny/common/constant.dart';
import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:ponny/model/App.dart';
import 'package:ponny/util/globalUrl.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:share/share.dart';
import 'package:uiblock/uiblock.dart';
import 'package:intl/intl.dart';
import 'package:ponny/widgets/PonnyBottomNavbar.dart';

class DetailKomenScreen extends StatefulWidget {
  int id;

  DetailKomenScreen({this.id});

  @override
  _DetailKomenScreenState createState() => _DetailKomenScreenState();
}

class _DetailKomenScreenState extends State<DetailKomenScreen> {
  int hours;
  int hourss;

  DateTime convertDateFromString(String strDate) {
    DateTime todayDate = DateTime.parse(strDate);

    return todayDate;
  }

  @override
  void initState() {
    super.initState();
    print(widget.id);
    // TODO: implement initState

    // hours = DateTime.now()
    //     .difference(DateTime.parse(widget.list[widget.index]["updated_at"]))
    //     .inHours;
  }

  List data;
  Future<List> roomData() async {
    var token = Provider.of<AppModel>(context).auth.access_token;
    final response = await http.get(detailforum + "${widget.id}", headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    });
    if (response.statusCode == 200) {
      print('sukses');

      data = json.decode(response.body);

      print(data);
      return data;
    } else {
      throw Exception('Failed to load data');
    }
  }

 
  Future commentChild(int id) async {
    var token = Provider.of<AppModel>(context).auth.access_token;
    final response = await http.get(detailcommentchild + "$id", headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    });
    if (response.statusCode == 200) {
      print('sukses');
      print(id);

      var data = json.decode(response.body);
     

      print(data);
      return data;
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

  Future<bool> likecomment(int idRuang) async {
    bool result = false;
    UIBlock.block(context, customLoaderChild: LoadingWidget(context));
    String accessToken =
        Provider.of<AppModel>(context).auth.access_token == null
            ? "abc"
            : Provider.of<AppModel>(context).auth.access_token;

    final value = await Provider.of<PostandComment>(context)
        .likeComment(accessToken, idRuang.toString());
    if (value) {
      UIBlock.unblock(context);
      result = value;
    }

    return result;
  }

  Future<bool> unlikecomment(int idRuang) async {
    bool result = false;
    UIBlock.block(context, customLoaderChild: LoadingWidget(context));
    String accessToken =
        Provider.of<AppModel>(context).auth.access_token == null
            ? "abc"
            : Provider.of<AppModel>(context).auth.access_token;

    final value = await Provider.of<PostandComment>(context)
        .unlikeComment(accessToken, idRuang.toString());
    if (value) {
      UIBlock.unblock(context);
      result = value;
    }

    return result;
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
        body: FutureBuilder(
            future: roomData(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                print(snapshot.error);
              }

              if (snapshot.hasData) {
                hours = DateTime.now()
                    .difference(DateTime.parse(data[0]['forum']['created_at']))
                    .inHours;
                return SingleChildScrollView(
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
                                          data[0]['forum']['room']['title']
                                              .toString(),
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
                                        ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            child: Image.network(
                                              data[0]['forum']['user'][
                                                              'avatar_original'] ==
                                                      null
                                                  ? 'https://www.tenforums.com/geek/gars/images/2/types/thumb_15951118880user.png'
                                                  : img_url +
                                                      data[0]['forum']['user'][
                                                              'avatar_original']
                                                          .toString(),
                                              height: 35,
                                              width: 35,
                                              fit: BoxFit.cover,
                                            )),
                                        Container(
                                          width: 5,
                                        ),
                                        Text(
                                          // snapshot.data.forum.user.name,
                                          data[0]['forum']['user']['name']
                                              .toString(),
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
                                                  BorderRadius.circular(5),
                                              color: Color(0xffF48262)),
                                          child: Text(
                                            data[0]['forum']['user']
                                                ['user_tier']['title'],
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
                                                  convertDateFromString(data[0]
                                                              ['forum']
                                                          ['created_at']
                                                      .toString())),
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
                                      data[0]['forum']['title'],
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: 'Yeseva',
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                    Container(height: 5),
                                    Text(
                                      data[0]['forum']['text'],
                                      style: TextStyle(fontFamily: "Brandon"),
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
                                            data[0]['forum']['is_liked'] == null
                                                ? GestureDetector(
                                                    onTap: () {
                                                      like(data[0]['forum']
                                                          ["id"]);
                                                    },
                                                    child: Icon(
                                                      Icons.favorite_border,
                                                      color: Color(0xffF48262),
                                                      size: 20,
                                                    ),
                                                  )
                                                : GestureDetector(
                                                    onTap: () {
                                                      unlike(data[0]['forum']
                                                          ["id"]);
                                                    },
                                                    child: Icon(
                                                      Icons.favorite,
                                                      color: Color(0xffF48262),
                                                      size: 20,
                                                    ),
                                                  ),
                                            Container(width: 5),
                                            Text(
                                                data[0]['forum']['like']
                                                            .length ==
                                                        0
                                                    ? "0"
                                                    : data[0]['forum']['like']
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
                                                    data[0]['forum']['id']);
                                              },
                                            ),
                                            Container(width: 5),
                                            GestureDetector(
                                              onTap: () {
                                                _settingModalBottomSheet(
                                                    data[0]['forum']['id']);
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
                                                data[0]['forum']['reply']
                                                            .length ==
                                                        0
                                                    ? '0 Balasan'
                                                    : data[0]['forum']['reply']
                                                            .length
                                                            .toString() +
                                                        " Balasan",
                                                style: TextStyle(
                                                    fontFamily: "Brandon")),
                                          ],
                                        ),
                                        IconButton(
                                            icon: Image.asset(
                                                "assets/images/shareIcon.PNG"),
                                            onPressed: () {
                                              Share.share(
                                                  urlGlobal + 'forum/' +
                                                      data[0]['forum']['slug']);
                                            }),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              ListView.builder(
                                primary: false,
                                shrinkWrap: true,
                                itemCount: data[0]['forum']['reply'].length == 0
                                    ? 0
                                    : data[0]['forum']['reply'].length,
                                itemBuilder: (context, i) {
                                  hourss = DateTime.now()
                                      .difference(DateTime.parse(data[0]
                                          ['forum']['reply'][i]['created_at']))
                                      .inHours;
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
                                                    ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(100),
                                                        child: Image.network(data[0]['forum']['reply'][i]['user'] == null
                                                            ? 'https://www.tenforums.com/geek/gars/images/2/types/thumb_15951118880user.png'
                                                            : data[0]['forum']['reply'][i]['user']['avatar_original'] == null
                                                            ? 'https://www.tenforums.com/geek/gars/images/2/types/thumb_15951118880user.png'
                                                            : img_url + data[0]['forum']['reply'][i]['user']['avatar_original'].toString(),
                                                          height: 35,
                                                          width: 35,
                                                          fit: BoxFit.cover,
                                                        )),
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
                                                              data[0]['forum'][
                                                              'reply']
                                                              [
                                                              i]['user'] == null ? 'Anonim' :
                                                              data[0]['forum'][
                                                                          'reply']
                                                                      [
                                                                      i]['user']
                                                                  ['name'],
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: TextStyle(
                                                                fontSize: 14,
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
                                                            if (data[0]['forum']
                                                            [
                                                            'reply']
                                                            [
                                                            i]['user'] != null)
                                                            Container(
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                      horizontal:
                                                                          3),
                                                              decoration: BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              5),
                                                                  color: Color(
                                                                      0xffF48262)),
                                                              child: Text(
                                                                data[0]['forum']
                                                                            [
                                                                            'reply']
                                                                        [
                                                                        i]['user']
                                                                    [
                                                                    'user_tier']['title'],
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 10,
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
                                                              "Posted " +
                                                                  DateFormat(
                                                                          'dd MMMM yyyy')
                                                                      .format(
                                                                          convertDateFromString(
                                                                    data[0]['forum']
                                                                            [
                                                                            'reply'][i]
                                                                        [
                                                                        'created_at'],
                                                                  )),
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: TextStyle(
                                                                fontSize: 10,
                                                                fontFamily:
                                                                    'Brandon',
                                                                color:
                                                                    Colors.grey,
                                                              ),
                                                            ),
                                                            Container(width: 5),
                                                            Text(
                                                              "|",
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: TextStyle(
                                                                fontSize: 10,
                                                                fontFamily:
                                                                    'Brandon',
                                                                color:
                                                                    Colors.grey,
                                                                letterSpacing:
                                                                    1,
                                                              ),
                                                            ),
                                                            Container(
                                                                width: 10),
                                                            Text(
                                                              "Diupdate " +
                                                                  hourss
                                                                      .toString() +
                                                                  " jam yang lalu",
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: TextStyle(
                                                                fontSize: 10,
                                                                fontFamily:
                                                                    'Brandon',
                                                                color:
                                                                    Colors.grey,
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
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "Reply: ",
                                                      style: TextStyle(
                                                          fontFamily: "Brandon",
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    Expanded(
                                                      child: ReadMoreText(
                                                        data[0]['forum']
                                                                ['reply'][i]
                                                            ['text'],
                                                        style: TextStyle(
                                                            fontFamily:
                                                                "Brandon"),
                                                        trimLines: 2,
                                                        colorClickableText:
                                                            Colors.blue,
                                                        trimMode: TrimMode.Line,
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
                                                        data[0]['forum']['reply']
                                                                        [i][
                                                                    'is_liked'] ==
                                                                null
                                                            ? GestureDetector(
                                                                onTap: () {
                                                                  likecomment(data[0]
                                                                              [
                                                                              'forum']
                                                                          [
                                                                          'reply']
                                                                      [
                                                                      i]['id']);
                                                                },
                                                                child: Icon(
                                                                  Icons
                                                                      .favorite_border,
                                                                  color: Color(
                                                                      0xffF48262),
                                                                  size: 20,
                                                                ),
                                                              )
                                                            : GestureDetector(
                                                                onTap: () {
                                                                  unlikecomment(data[0]
                                                                              [
                                                                              'forum']
                                                                          [
                                                                          'reply']
                                                                      [
                                                                      i]['id']);
                                                                },
                                                                child: Icon(
                                                                  Icons
                                                                      .favorite,
                                                                  color: Color(
                                                                      0xffF48262),
                                                                  size: 20,
                                                                ),
                                                              ),
                                                        Container(width: 5),
                                                        Text(
                                                            data[0]['forum']['reply'][i]
                                                                            [
                                                                            'like']
                                                                        .length ==
                                                                    0
                                                                ? '0'
                                                                : data[0]['forum']
                                                                            [
                                                                            'reply'][i]
                                                                        ['like']
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
                                                            _settingModalBottomSheet1(
                                                                data[0]['forum']
                                                                        [
                                                                        'reply']
                                                                    [i]['id']);
                                                          },
                                                        ),
                                                        Container(width: 5),
                                                        GestureDetector(
                                                          onTap: () {
                                                            _settingModalBottomSheet1(
                                                                data[0]['forum']
                                                                        [
                                                                        'reply']
                                                                    [i]['id']);
                                                          },
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
                                                         InkWell(
                                    onTap: () {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              backgroundColor: Hexcolor('#FCF8F0'),
                                              title: Container(
                                                child: Align(
                                                  alignment: Alignment.centerRight,
                                                  child: IconButton(
                                                      icon: Icon(Icons.close),
                                                      color: Color(0xffF48262),
                                                      onPressed: () {
                                                        Navigator.of(context).pop();
                                                      }),
                                                ),
                                              ),
                                              titlePadding: EdgeInsets.all(0),
                                              contentPadding: EdgeInsets.all(5),
                                              content:
                                                  setupAlertDialoadContainer(
                                                data[0]['forum']['reply'][i]
                                                    ['id'], data[0]['forum']
                                                                ['reply'][i]
                                                            ['text'],

                                              ),
                                            );
                                          });
                                    },
                                    child:
                                                        Text(
                                                            data[0]['forum']['reply'][i]
                                                                            [
                                                                            'comment']
                                                                        .length ==
                                                                    0
                                                                ? '0 Balasan'
                                                                : data[0]['forum']['reply'][i]
                                                                            [
                                                                            'comment']
                                                                        .length
                                                                        .toString() +
                                                                    " balasan",
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    "Brandon"))),
                                                      ],
                                                    ),
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
              }
              return LoadingWidgetFadingCircle(context);
            }),
        bottomNavigationBar: new PonnyBottomNavbar(selectedIndex: 3));
  }

  void _settingModalBottomSheet(int id) {
    TextEditingController text = new TextEditingController();

    Future<bool> kirimPostdanComment(BuildContext context) async {
      bool result = false;
      UIBlock.block(context, customLoaderChild: LoadingWidget(context));
      // var paramPost = {};
      var paramComment = {
        "post_id": id.toString(),
        "text": text.text,
        // "recommended_items[]": "28",
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
                                    fontSize: 18,
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
                                child: Container(
                                  padding: EdgeInsets.all(3),
                                  decoration: BoxDecoration(
                                      color: Color(0xffF48262),
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Text(
                                    "Kirim",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: "Brandon",
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                    ),
                                  ),
                                )),
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

  void _settingModalBottomSheet1(int id) {
    TextEditingController text = new TextEditingController();

    Future<bool> replyPostdanComment(BuildContext context) async {
      bool result = false;
      UIBlock.block(context, customLoaderChild: LoadingWidget(context));
      // var paramPost = {};
      print(id.toString());
      var paramComment = {
        "reply_id": id.toString(),
        "text": text.text,
      };

      /* type == 1
        ? await Provider.of<PostandComment>(context)
            .posts(Provider.of<AppModel>(context).auth.access_token, paramPost)
        :*/
      final value = await Provider.of<PostandComment>(context).replycomment(
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
                                  "Balas Komentar",
                                  style: TextStyle(
                                    fontSize: 16,
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
                              final result = await replyPostdanComment(context);

                              Navigator.pop(context, true);
                            },
                            child: FittedBox(
                                fit: BoxFit.fitWidth,
                                child: Container(
                                  padding: EdgeInsets.all(3),
                                  decoration: BoxDecoration(
                                      color: Color(0xffF48262),
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Text(
                                    "Kirim",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: "Brandon",
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                    ),
                                  ),
                                )),
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

  Widget setupAlertDialoadContainer(int id,String title) {
    print(id);
    return Padding(
      padding: EdgeInsets.only(bottom: 10.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.all(5.0),
            child: Text("Balasan untuk komentar : $title",style: TextStyle(fontSize: 14,fontFamily: "Brandon")),
          ),
          FutureBuilder(
                future: commentChild(id),
                builder: (context, snapshot) {
                  if (snapshot.hasError){
                    print(snapshot.hasError);
                    return null;
                  }
                  else if (snapshot.hasData && snapshot.data["replys"].length > 0){
                    print("JUMLAH KOMEN");
                    print(snapshot.data["replys"].length);
                    return ListView.builder(
          shrinkWrap: true,
          itemCount: snapshot.data["replys"].length,
          itemBuilder: (BuildContext context, int index) {
            return Container(

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
                            ClipRRect(
                                borderRadius:
                                BorderRadius
                                    .circular(100),
                                child: Image.network(
                                  // data[0]['forum']['reply'][i]
                                  //                     ['user']
                                  //                 [
                                  //                 'avatar_original']
                                  //             .toString() ==
                                  //         null
                                  //     ? 'https://www.tenforums.com/geek/gars/images/2/types/thumb_15951118880user.png'
                                  //     : img_url +
                                  //         data[0]['forum']
                                  //                     [
                                  //                     'reply'][i]['user']
                                  //                 [
                                  //                 'avatar_original']
                                  //             .toString(),
                                  snapshot.data["replys"][index]["user"]["avatar_original"] != null ? snapshot.data["replys"][index]["user"]["avatar_original"] :
                                  'https://www.tenforums.com/geek/gars/images/2/types/thumb_15951118880user.png',

                                  height: 25,
                                  width: 25,
                                  fit: BoxFit.cover,
                                )),
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
                                      snapshot.data["replys"][index]["user"]["name"],
                                      textAlign:
                                      TextAlign
                                          .center,
                                      style: TextStyle(
                                        fontSize: 12,
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
                                          BorderRadius
                                              .circular(
                                              5),
                                          color: Color(
                                              0xffF48262)),
                                      child: Text(
                                        snapshot.data["replys"][index]["user"]["user_tier"]["title"],
                                        textAlign:
                                        TextAlign
                                            .center,
                                        style:
                                        TextStyle(
                                          color: Colors
                                              .white,
                                          fontSize: 10,
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
                                      "Posted " +
                                          DateFormat(
                                              'dd MMMM yyyy')
                                              .format(
                                              convertDateFromString(
                                                snapshot.data["replys"][index]["created_at"]
                                              )),
                                      textAlign:
                                      TextAlign
                                          .center,
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontFamily:
                                        'Brandon',
                                        color:
                                        Colors.grey,
                                      ),
                                    ),
                                    Container(width: 5),

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
                          CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Reply: ",
                              style: TextStyle(
                                  fontFamily: "Brandon",
                                  fontWeight:
                                  FontWeight.bold,fontSize:10),
                            ),
                            Expanded(
                              child: ReadMoreText(
                                snapshot.data["replys"][index]["isi"],
                                style: TextStyle(
                                    fontFamily:
                                    "Brandon",fontSize: 11),
                                trimLines: 2,
                                colorClickableText:
                                Colors.blue,
                                trimMode: TrimMode.Line,
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
              ),

            );



          },
                    );
                  }
                  else if (snapshot.hasData && snapshot.data["replys"].length == 0){
                    return Container(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: Center(
                        child: Text(
                          "Belum Ada Komentar",
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'Brandon',
                          ),
                        ),
                      ),
                    );
                  }
                  else{
                    return LoadingWidget(context);
                  }
                }),
        ],
      ),
    );
  }
}
