import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:ponny/widgets/PonnyBottomNavbar.dart';
import 'package:flutter_html/flutter_html.dart';

class BlogDetailScreen extends StatefulWidget {
  final List list;
  final int i;
  BlogDetailScreen({this.list, this.i});

  @override
  _BlogDetailScreenState createState() => _BlogDetailScreenState();
}

class _BlogDetailScreenState extends State<BlogDetailScreen> {
  bool onSearch = false;

  @override
  Widget build(BuildContext context) {
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
                                "assets/images/blog.png",
                                color: Colors.white,
                              )),
                            ),
                            Expanded(flex: 1, child: Container())
                          ],
                        ),
                      ),
                Container(
                  width: double.infinity,
                  color: Color(0xffF48262),
                  child: TabBar(
                    isScrollable: true,
                    indicatorColor: Colors.transparent,
                    tabs: [
                      Container(
                        padding: EdgeInsets.all(10),
                        width: 50,
                        child: Column(
                          children: [
                            Icon(
                              Icons.ac_unit,
                              color: Colors.white,
                            ),
                            Text(
                              "ALL",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 12,
                                  fontFamily: "Brandon",
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          Icon(
                            Icons.ac_unit,
                            color: Colors.white,
                          ),
                          Text(
                            "BASIC SKINCARE",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 12,
                                fontFamily: "Brandon",
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Icon(
                            Icons.ac_unit,
                            color: Colors.white,
                          ),
                          Text(
                            "SKIN CONCERN",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 12,
                                fontFamily: "Brandon",
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Icon(
                            Icons.ac_unit,
                            color: Colors.white,
                          ),
                          Text(
                            "SKINCARE ROUTINE",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 12,
                                fontFamily: "Brandon",
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Icon(
                            Icons.ac_unit,
                            color: Colors.white,
                          ),
                          Text(
                            "MITOS ATAU FAKTA",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 12,
                                fontFamily: "Brandon",
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          ),
                        ],
                      ),
                    ],
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
                                    child: Image.asset(
                                      "assets/images/blogImage.png",
                                      fit: BoxFit.fill,
                                    )),
                                Container(height: 10),
                                Container(
                                  child: Text(
                                    widget.list[widget.i]["category"]["title"],
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
                                    widget.list[widget.i]["title"],
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
                                        tileColor: Colors.white,
                                        leading: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(Icons.account_circle),
                                          ],
                                        ),
                                        title: Text(
                                          "Sisca Lalala",
                                          style: TextStyle(
                                            letterSpacing: 1,
                                            fontSize: 12,
                                            fontFamily: "Brandon",
                                            fontWeight: FontWeight.w800,
                                          ),
                                        ),
                                        subtitle: Text(
                                          widget.list[widget.i]["created_at"],
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
                                Container(height: 10),
                                Text(widget.list[widget.i]["content"],
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontFamily: "Brandon",
                                      fontWeight: FontWeight.w500,
                                    )),
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
                                    Container(
                                      width: 5,
                                    ),
                                    IconButton(
                                        icon: Image.asset(
                                            "assets/images/pinterestBlack.PNG")),
                                    IconButton(
                                        icon: Image.asset(
                                            "assets/images/facebookBlack.PNG")),
                                    IconButton(
                                        icon: Image.asset(
                                            "assets/images/twitterBlack.PNG"))
                                  ],
                                ),
                                Container(height: 30),
                              ]),
                            )
                          ],
                        ),
                        Container(
                          width: double.infinity,
                          color: Color(0xffF3C1B5),
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
                              Container(
                                child: Row(
                                  children: [
                                    Expanded(child: product(context)),
                                    Container(
                                      width: 10,
                                    ),
                                    Expanded(child: product(context)),
                                    Container(
                                      width: 10,
                                    ),
                                    Expanded(child: product(context))
                                  ],
                                ),
                              )
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

Widget product(context) {
  return Column(
    children: <Widget>[
      Container(
        child: Stack(
          children: <Widget>[
            GestureDetector(
              onTap: () {},
              child: Image.asset(
                "assets/images/produk.png",
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10.0),
              child: Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.0),
                      child: const Text(
                        '35%',
                        style: TextStyle(
                            color: Colors.white, fontFamily: 'Brandon'),
                      ),
                    ),
                    color: Color(0xffF48262),
                  )),
            ),
            Padding(
              padding: EdgeInsets.all(5.0),
              child: Align(
                alignment: Alignment.topRight,
                child: Icon(
                  Icons.favorite_border,
                  color: Color(0xffF48262),
                  size: 20,
                ),
              ),
            ),
          ],
        ),
      ),
      Container(
        alignment: Alignment.bottomCenter,
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: const Text(
            'ADD TO BAG',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontFamily: 'Brandon'),
          ),
          color: Color(0xffF3C1B5),
        ),
      ),
      Padding(
        padding: EdgeInsets.only(top: 7.0),
        child: Text(
          'Skin Game',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Yeseva',
            fontSize: 16,
          ),
        ),
      ),
      Text(
        'Acne Warrior',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontFamily: 'Brandon',
          fontSize: 14,
        ),
      ),
      Text(
        'Rp. 125.000',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontFamily: 'Brandon',
          fontSize: 14,
        ),
      ),
      Center(
        child: RichText(
          text: TextSpan(
              text: 'Rp. 125.000',
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'Brandon',
                fontSize: 12,
                decoration: TextDecoration.lineThrough,
              ),
              children: [
                TextSpan(
                  text: '(35%)',
                  style: TextStyle(
                    color: Color(0xffF48262),
                    fontFamily: 'Brandon',
                    fontSize: 12,
                    decoration: TextDecoration.none,
                  ),
                ),
              ]),
        ),
      ),
      Text.rich(TextSpan(children: <InlineSpan>[
        WidgetSpan(
          child: RatingBar(
            initialRating: 4,
            minRating: 1,
            direction: Axis.horizontal,
            allowHalfRating: true,
            itemCount: 5,
            itemSize: 14.0,
            itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
            itemBuilder: (context, index) => Icon(
              Icons.favorite,
              color: Color(0xffF48262),
            ),
            unratedColor: Color(0xffFBD2CD),
          ),
        ),
        TextSpan(
            text: '(5)',
            style: TextStyle(
              fontSize: 12,
            ))
      ])),
    ],
  );
}
