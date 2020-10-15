import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:ponny/screens/account_screen.dart';
import 'package:ponny/widgets/PonnyBottomNavbar.dart';

class HappySkinRewardScreen extends StatefulWidget {
  static const String id = "Happy_Skin_Reward_Screen";
  @override
  _HappySkinRewardStateScreen createState() => _HappySkinRewardStateScreen();
}

class _HappySkinRewardStateScreen extends State<HappySkinRewardScreen>
    with SingleTickerProviderStateMixin {
  int tabIndex = 0;
  TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(vsync: this, length: 2, initialIndex: 0);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      // initialIndex: tabIndex,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Hexcolor('#FCF8F0'),
        body: Container(
          child: Column(
            children: <Widget>[
              Container(
                height: 70,
              ),
              Container(
                padding: EdgeInsets.only(left: 20, bottom: 20),
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 14),
                      child: GestureDetector(
                        child: Icon(
                          Icons.arrow_back_ios,
                          color: Color(0xffF48262),
                          size: 26,
                        ),
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    Container(
                      child: Text(
                        "Happy Skin Reward",
                        style: TextStyle(
                          fontSize: 24,
                          fontFamily: "Yeseva",
                          fontWeight: FontWeight.w500,
                          color: Color(0xffF48262),
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
                padding: EdgeInsets.only(top: 20, bottom: 20),
                color: Hexcolor('#FDEDE4'),
                child: Column(
                  children: [
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            child: Text(
                              "POIN KAMU ADA",
                              style: TextStyle(
                                fontFamily: "Brandon",
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            child: RichText(
                              text: TextSpan(
                                text: "100",
                                style: TextStyle(
                                  color: Color(0xffF48262),
                                  fontFamily: 'Brandon',
                                  fontSize: 28,
                                  fontWeight: FontWeight.w600,
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: ' POIN',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'Brandon',
                                      fontSize: 28,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      width: 1,
                      color: Hexcolor("#F59379"),
                    ),
                  ),
                ),
                child: TabBar(
                  indicatorColor: Color(0xffF48262),
                  tabs: [
                    Tab(
                      child: Text(
                        "100 - 250 POIN",
                        style: TextStyle(
                          fontFamily: "Brandon",
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    Tab(
                      child: Text(
                        "251 - 500 POIN",
                        style: TextStyle(
                          fontFamily: "Brandon",
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    seratus_point(),
                    lebih_duaratus_point(),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: new PonnyBottomNavbar(selectedIndex: 4),
      ),
    );
  }
}

class seratus_point extends StatefulWidget {
  @override
  _SeratusPointScreen createState() => _SeratusPointScreen();
}

class _SeratusPointScreen extends State<seratus_point> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 30),
              padding: EdgeInsets.only(left: 25, right: 25, top: 0, bottom: 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 300,
                    width: 160,
                    // color: Colors.red,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 160,
                          height: 210,
                          child: Image.asset(
                            "assets/images/produk_2.png",
                            fit: BoxFit.fill,
                          ),
                        ),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                margin: EdgeInsets.only(
                                  top: 5,
                                ),
                                child: Text(
                                  "Skin Game",
                                  style: TextStyle(
                                    fontFamily: "Yeseva",
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            top: 5,
                          ),
                          child: Text(
                            "Acne Warrior",
                            style: TextStyle(
                              fontFamily: "Brandon",
                              fontSize: 14,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            top: 5,
                          ),
                          child: Text(
                            "100 POIN",
                            style: TextStyle(
                              fontFamily: "Brandon",
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 300,
                    width: 160,
                    // color: Colors.red,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 160,
                          height: 210,
                          child: Image.asset(
                            "assets/images/produk_2.png",
                            fit: BoxFit.fill,
                          ),
                        ),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                margin: EdgeInsets.only(
                                  top: 5,
                                ),
                                child: Text(
                                  "Skin Game",
                                  style: TextStyle(
                                    fontFamily: "Yeseva",
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            top: 5,
                          ),
                          child: Text(
                            "Acne Warrior",
                            style: TextStyle(
                              fontFamily: "Brandon",
                              fontSize: 14,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            top: 5,
                          ),
                          child: Text(
                            "100 POIN",
                            style: TextStyle(
                              fontFamily: "Brandon",
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 25, right: 25, top: 0, bottom: 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 300,
                    width: 160,
                    // color: Colors.red,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 160,
                          height: 210,
                          child: Image.asset(
                            "assets/images/produk_2.png",
                            fit: BoxFit.fill,
                          ),
                        ),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                margin: EdgeInsets.only(
                                  top: 5,
                                ),
                                child: Text(
                                  "Skin Game",
                                  style: TextStyle(
                                    fontFamily: "Yeseva",
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            top: 5,
                          ),
                          child: Text(
                            "Acne Warrior",
                            style: TextStyle(
                              fontFamily: "Brandon",
                              fontSize: 14,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            top: 5,
                          ),
                          child: Text(
                            "100 POIN",
                            style: TextStyle(
                              fontFamily: "Brandon",
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 300,
                    width: 160,
                    // color: Colors.red,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 160,
                          height: 210,
                          child: Image.asset(
                            "assets/images/produk_2.png",
                            fit: BoxFit.fill,
                          ),
                        ),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                margin: EdgeInsets.only(
                                  top: 5,
                                ),
                                child: Text(
                                  "Skin Game",
                                  style: TextStyle(
                                    fontFamily: "Yeseva",
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            top: 5,
                          ),
                          child: Text(
                            "Acne Warrior",
                            style: TextStyle(
                              fontFamily: "Brandon",
                              fontSize: 14,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            top: 5,
                          ),
                          child: Text(
                            "100 POIN",
                            style: TextStyle(
                              fontFamily: "Brandon",
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              decoration: new BoxDecoration(
                color: Color(0xffF48262),
                borderRadius: BorderRadius.all(Radius.circular(5)),
              ),
              margin: EdgeInsets.only(top: 10, right: 25, left: 25, bottom: 30),
              padding: EdgeInsets.only(top: 15, bottom: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: Text(
                      "TUKAR",
                      style: TextStyle(
                        fontFamily: "Brandon",
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: Colors.white,
                        letterSpacing: 1,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class lebih_duaratus_point extends StatefulWidget {
  @override
  _LebihDuaRatusPointScreen createState() => _LebihDuaRatusPointScreen();
}

class _LebihDuaRatusPointScreen extends State<lebih_duaratus_point> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 30),
              padding: EdgeInsets.only(left: 25, right: 25, top: 0, bottom: 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 300,
                    width: 160,
                    // color: Colors.red,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 160,
                          height: 210,
                          child: Image.asset(
                            "assets/images/produk_2.png",
                            fit: BoxFit.fill,
                          ),
                        ),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                margin: EdgeInsets.only(
                                  top: 5,
                                ),
                                child: Text(
                                  "Skin Game",
                                  style: TextStyle(
                                    fontFamily: "Yeseva",
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            top: 5,
                          ),
                          child: Text(
                            "Acne Warrior",
                            style: TextStyle(
                              fontFamily: "Brandon",
                              fontSize: 14,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            top: 5,
                          ),
                          child: Text(
                            "100 POIN",
                            style: TextStyle(
                              fontFamily: "Brandon",
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 300,
                    width: 160,
                    // color: Colors.red,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 160,
                          height: 210,
                          child: Image.asset(
                            "assets/images/produk_2.png",
                            fit: BoxFit.fill,
                          ),
                        ),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                margin: EdgeInsets.only(
                                  top: 5,
                                ),
                                child: Text(
                                  "Skin Game",
                                  style: TextStyle(
                                    fontFamily: "Yeseva",
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            top: 5,
                          ),
                          child: Text(
                            "Acne Warrior",
                            style: TextStyle(
                              fontFamily: "Brandon",
                              fontSize: 14,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            top: 5,
                          ),
                          child: Text(
                            "100 POIN",
                            style: TextStyle(
                              fontFamily: "Brandon",
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 25, right: 25, top: 0, bottom: 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 300,
                    width: 160,
                    // color: Colors.red,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 160,
                          height: 210,
                          child: Image.asset(
                            "assets/images/produk_2.png",
                            fit: BoxFit.fill,
                          ),
                        ),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                margin: EdgeInsets.only(
                                  top: 5,
                                ),
                                child: Text(
                                  "Skin Game",
                                  style: TextStyle(
                                    fontFamily: "Yeseva",
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            top: 5,
                          ),
                          child: Text(
                            "Acne Warrior",
                            style: TextStyle(
                              fontFamily: "Brandon",
                              fontSize: 14,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            top: 5,
                          ),
                          child: Text(
                            "100 POIN",
                            style: TextStyle(
                              fontFamily: "Brandon",
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 300,
                    width: 160,
                    // color: Colors.red,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 160,
                          height: 210,
                          child: Image.asset(
                            "assets/images/produk_2.png",
                            fit: BoxFit.fill,
                          ),
                        ),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                margin: EdgeInsets.only(
                                  top: 5,
                                ),
                                child: Text(
                                  "Skin Game",
                                  style: TextStyle(
                                    fontFamily: "Yeseva",
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            top: 5,
                          ),
                          child: Text(
                            "Acne Warrior",
                            style: TextStyle(
                              fontFamily: "Brandon",
                              fontSize: 14,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            top: 5,
                          ),
                          child: Text(
                            "100 POIN",
                            style: TextStyle(
                              fontFamily: "Brandon",
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              decoration: new BoxDecoration(
                color: Color(0xffF48262),
                borderRadius: BorderRadius.all(Radius.circular(5)),
              ),
              margin: EdgeInsets.only(top: 10, right: 25, left: 25, bottom: 30),
              padding: EdgeInsets.only(top: 15, bottom: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: Text(
                      "TUKAR",
                      style: TextStyle(
                        fontFamily: "Brandon",
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: Colors.white,
                        letterSpacing: 1,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
