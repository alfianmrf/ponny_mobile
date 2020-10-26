import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:ponny/widgets/PonnyBottomNavbar.dart';
import 'package:ponny/screens/Blog_Detail_screen.dart';

class BasicSkincare extends StatefulWidget {
  static const String id = "Basic_SkinCare";

  @override
  _BasicSkincareState createState() => _BasicSkincareState();
}

class _BasicSkincareState extends State<BasicSkincare> {
  bool onSearch = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        setState(() {
          onSearch = false;
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
                Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                    width: double.infinity,
                    color: Color(0xffF3C1B5),
                    child: Text(
                      "BASIC SKINCARE",
                      style: TextStyle(color: Color(0xffF48262), fontSize: 20),
                    )),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          child: GridView.builder(
                              primary: false,
                              shrinkWrap: true,
                              itemCount: 16,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2),
                              itemBuilder: (BuildContext context, int i) {
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                BlogDetailScreen()));
                                  },
                                  child: Container(
                                    margin: EdgeInsets.all(5),
                                    child: Column(children: [
                                      Expanded(
                                          flex: 3,
                                          child: Container(
                                              width: double.infinity,
                                              child: Image.asset(
                                                "assets/images/blogImage.png",
                                                fit: BoxFit.cover,
                                              ))),
                                      Container(height: 5),
                                      Expanded(
                                        flex: 1,
                                        child: Text(
                                          "Beda Eye Gel, Eye Cream, dan Eye Serum",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontFamily: "Brandon",
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ]),
                                  ),
                                );
                              }),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 30, bottom: 30),
                          height: 1,
                          color: Color(0xffF3C1B5),
                        ),
                        Container(
                          child: Text(
                            "TRENDING",
                            style: TextStyle(
                                color: Color(0xffF48262), fontSize: 20),
                          ),
                          margin: EdgeInsets.only(bottom: 30),
                        ),
                        ListView.builder(
                            itemCount: 6,
                            shrinkWrap: true,
                            primary: false,
                            itemBuilder: (context, i) {
                              return Container(
                                  margin: EdgeInsets.only(bottom: 10),
                                  child: ListTile(
                                    leading: Image.asset(
                                      "assets/images/blogImage.png",
                                      fit: BoxFit.cover,
                                    ),
                                    title: Text(
                                      "Beda Eye Gel, Eye Cream, dan Eye Serum",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: "Brandon",
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    subtitle: Text(
                                      "Sisca Lalala\n15 Januari, 2020",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: "Brandon",
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ));
                            })
                      ],
                    ),
                  ),
                ),
              ],
            ),
            bottomNavigationBar: new PonnyBottomNavbar(selectedIndex: 0)),
      ),
    );
  }
}
