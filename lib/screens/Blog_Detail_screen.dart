import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:ponny/common/constant.dart';
import 'package:ponny/model/Product.dart';
import 'package:ponny/widgets/PonnyBottomNavbar.dart';
import 'package:ponny/util/globalUrl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:css_text/css_text.dart';
import 'package:intl/intl.dart';

import 'Blog_screen.dart';

class BlogDetailScreen extends StatefulWidget {
  final int i;
  final Map title;

  BlogDetailScreen({this.i, this.title});

  @override
  _BlogDetailScreenState createState() => _BlogDetailScreenState();
}

class _BlogDetailScreenState extends State<BlogDetailScreen> {
  String currentTag;
  int categoryId;
  bool onSearch = false;

  DateTime convertDateFromString(String strDate) {
    DateTime todayDate = DateTime.parse(strDate);

    return todayDate;
  }

  Future<List> getRecom() async {
    final response = await http.get(recomProduct);
    // Map<String, dynamic> map = json.decode(response.body);
    //List<dynamic> data = map[0];
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    categoryId = widget.title["category"]["id"];
    return WillPopScope(
      onWillPop: () {
        setState(() {
          onSearch = false;
          if (onSearch == false) {
            Navigator.pop(context);
          }
        });
      },
      child: DefaultTabController(
        length: 5,
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Hexcolor('#FCF8F0'),
            body: Column(
              children: [
                Container(
                  color: Color(0xffF48262),
                  height: 35,
                ),
                onSearch
                    ? Container(
                        width: double.infinity,
                        color: Color(0xffF48262),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              color: Colors.white),
                          padding: EdgeInsets.all(10),
                          margin: EdgeInsets.all(10),
                          child: Row(children: [
                            Icon(Icons.search, color: Color(0xffF48262)),
                            Expanded(
                                child: TextField(
                              cursorColor: Colors.black,
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.go,
                              decoration: new InputDecoration.collapsed(
                                  hintText: "Search..."),
                            ))
                          ]),
                        ),
                      )
                    : Container(
                        width: double.infinity,
                        color: Color(0xffF48262),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Container(
                                alignment: Alignment.centerLeft,
                                child: IconButton(
                                  icon: Icon(
                                    Icons.search,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      onSearch = true;
                                    });
                                  },
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Container(
                                  child: Image.asset(
                                "assets/images/blogTitle.png",
                                color: Colors.white,
                              )),
                            ),
                            Expanded(flex: 1, child: Container())
                          ],
                        ),
                      ),
                Container(
                  width: double.infinity,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) => Blog(category: 0, tag: "ALL",)));
                          },
                          child: Container(
                            height: 50,
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            alignment: Alignment.center,
                            color: categoryId == 0 ? Color(0xffFBDFD2) : null,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "ALL",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontFamily: "Brandon",
                                      fontWeight: FontWeight.bold,
                                      color: categoryId == 0 ? Colors.black : Color(0xffF48262)),
                                ),
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) => Blog(category: 1, tag: "BASIC SKINCARE",)));
                          },
                          child: Container(
                            height: 50,
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            alignment: Alignment.center,
                            color: categoryId == 1 ? Color(0xffFBDFD2) : null,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "BASIC\nSKINCARE",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontFamily: "Brandon",
                                      fontWeight: FontWeight.bold,
                                      color: categoryId == 1 ? Colors.black : Color(0xffF48262)),
                                ),
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) => Blog(category: 2, tag: "MASALAH KULIT",)));
                          },
                          child: Container(
                            height: 50,
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            alignment: Alignment.center,
                            color: categoryId == 2 ? Color(0xffFBDFD2) : null,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "MASALAH\nKULIT",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontFamily: "Brandon",
                                      fontWeight: FontWeight.bold,
                                      color: categoryId == 2 ? Colors.black : Color(0xffF48262)),
                                ),
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) => Blog(category: 3, tag: "SKINCARE ROUTINE",)));
                          },
                          child: Container(
                            height: 50,
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            alignment: Alignment.center,
                            color: categoryId == 3 ? Color(0xffFBDFD2) : null,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "SKINCARE\nROUTINE",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontFamily: "Brandon",
                                      fontWeight: FontWeight.bold,
                                      color: categoryId == 3 ? Colors.black : Color(0xffF48262)),
                                ),
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) => Blog(category: 4, tag: "MITOS ATAU FAKTA",)));
                          },
                          child: Container(
                            height: 50,
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            alignment: Alignment.center,
                            color: categoryId == 4 ? Color(0xffFBDFD2) : null,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "MITOS\nATAU FAKTA",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontFamily: "Brandon",
                                      fontWeight: FontWeight.bold,
                                      color: categoryId == 4 ? Colors.black : Color(0xffF48262)),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            Container(
                              color: Color(0xffF48262),
                              width: double.infinity,
                              height: 180,
                            ),
                            Container(
                              margin: EdgeInsets.all(20),
                              child: Column(children: [
                                Container(
                                    width: double.infinity,
                                    height: 200,
                                    child: CachedNetworkImage(
                                      imageUrl:img_url+"blog/thumbnail/"+widget.title["thumbnail"].toString(),
                                      placeholder: (context, url) => LoadingWidgetPulse(context),
                                      errorWidget: (context, url, error) => Image.asset('assets/images/basic.jpg'),
                                      width: MediaQuery.of(context).size.width,
                                      fit: BoxFit.contain,
                                    )),
                                Container(height: 10),
                                Container(
                                  child: Text(
                                    widget.title["category"]["title"],
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: "Yeseva",
                                        fontWeight: FontWeight.w800,
                                        color: Color(0xffF48262)),
                                  ),
                                ),
                                Container(height: 10),
                                Container(
                                  child: Text(
                                    widget.title["title"],
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      letterSpacing: 1,
                                      fontSize: 20,
                                      fontFamily: "Yeseva",
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                Container(height: 10),
                                Row(
                                  children: [
                                    Expanded(flex: 1, child: Container()),
                                    Expanded(
                                      flex: 5,
                                      child: ListTile(
                                        leading: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(Icons.account_circle),
                                          ],
                                        ),
                                        title: Text(
                                          widget.title["user"]["name"],
                                          style: TextStyle(
                                            letterSpacing: 1,
                                            fontSize: 12,
                                            fontFamily: "Brandon",
                                            fontWeight: FontWeight.w800,
                                          ),
                                        ),
                                        subtitle: Text(
                                          DateFormat('dd MMMM yyyy').format(
                                              convertDateFromString(
                                                  widget.title["created_at"])),
                                          style: TextStyle(
                                            letterSpacing: 1,
                                            fontSize: 14,
                                            fontFamily: "Brandon",
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(flex: 1, child: Container()),
                                  ],
                                ),
                                Container(
                                    height:
                                        10), //HT
                                Html(
                                  data: widget.title["content"],
                                  style: {
                                    "html" :Style(
                                      fontSize: FontSize.medium,
                                      fontFamily: "Brandon",
                                      fontWeight: FontWeight.w500,
                                    )
                                  },
                                ),
                                /*Container(height: 30),
                                Container(
                                  height: 400,
                                  child: Image.network(
                                    "https://via.placeholder.com/288x188",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Container(height: 30),
                                Text(
                                  "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
                                  style: TextStyle(
                                    letterSpacing: 1,
                                    fontSize: 14,
                                    fontFamily: "Brandon",
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),*/
                                Container(height: 30),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      "SHARE",
                                      style: TextStyle(
                                        letterSpacing: 1,
                                        fontSize: 14,
                                        fontFamily: "Brandon",
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: (){},
                                      icon: Icon(Icons.share, color: Color(0xffF48262),),),
                                  ],
                                ),
                                Container(height: 30),
                              ]),
                            )
                          ],
                        ),
                        Container(
                          width: double.infinity,
                          color: Color(0xffFBDFD2),
                          padding: EdgeInsets.all(10),
                          child: Column(
                            children: [
                              Text(
                                "REKOMENDASI PRODUK",
                                style: TextStyle(
                                    letterSpacing: 1,
                                    fontSize: 20,
                                    fontFamily: "Brandon",
                                    fontWeight: FontWeight.w800,
                                    color: Color(0xffF48262)),
                              ),
                              new FutureBuilder<List>(
                                  future: getRecom(),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasError)
                                      print(snapshot.error);
                                    return snapshot.hasData
                                        ? recommendationSection(
                                            context,
                                            snapshot.data,
                                          )
                                        : Center(
                                            child:
                                                new CircularProgressIndicator());
                                  })
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            bottomNavigationBar: new PonnyBottomNavbar(selectedIndex: 0)),
      ),
    );
  }
}

class BlogDetailData extends StatefulWidget {
  final contentId;

  BlogDetailData({this.contentId});

  @override
  _BlogDetailDataState createState() => _BlogDetailDataState();
}

class _BlogDetailDataState extends State<BlogDetailData> {
  Future<Map<String, dynamic>> getTitle() async {
    final response =
        await http.get(blogUrl + "/" + widget.contentId.toString());
    // Map<String, dynamic> map = json.decode(response.body);
    //List<dynamic> data = map[0];

    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return new FutureBuilder<Map>(
        future: getTitle(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          return snapshot.hasData
              ? BlogDetailScreen(
                  title: snapshot.data,
                )
              : Center(child: new CircularProgressIndicator());
        });
  }
}

Widget recommendationSection(context, List list) {
  // print(list[0]);
  return Container(
    child: Row(
      children: [
        Expanded(
          flex: 1,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: getProduct(context,
                  Product.fromJson(list[0]["data"][0])),
            )),
        Expanded(
          flex: 1,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: getProduct(context,
                  Product.fromJson(list[0]["data"][1])),
            )),
        Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: getProduct(context,
                  Product.fromJson(list[0]["data"][1])),
            )),
      ],
    ),
  );
}


