import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:ponny/screens/account_screen.dart';
import 'package:ponny/widgets/PonnyBottomNavbar.dart';

class AffiliateUsScreen extends StatefulWidget {
  static const String id = "Affiliate_Us_Screen";
  @override
  _AffiliateUsStateScreen createState() => _AffiliateUsStateScreen();
}

class _AffiliateUsStateScreen extends State<AffiliateUsScreen> {
  bool link = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Hexcolor('#FCF8F0'),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 70,
            ),
            Container(
              padding: EdgeInsets.only(left: 15, bottom: 15),
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
                      "Dalam Perjalanan",
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
            Stack(
              children: [
                Container(
                  color: Colors.grey,
                  height: 230,
                  width: MediaQuery.of(context).size.width,
                ),
                Container(
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Hexcolor('#FDEDE4'),
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                        margin: EdgeInsets.only(right: 30, left: 30, top: 160),
                        height: 130,
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    child: Text(
                                      "Halo,",
                                      style: TextStyle(
                                        fontFamily: "Yeseva",
                                        fontSize: 22,
                                        fontWeight: FontWeight.w600,
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
                                    child: Text(
                                      "TITAN TYRA",
                                      style: TextStyle(
                                        fontFamily: "Yeseva",
                                        fontSize: 22,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xffF48262),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              // padding: EdgeInsets.only(top: 20, bottom: 20),
              margin: EdgeInsets.only(top: 50),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Color(0xffF48262),
                        width: 1,
                      ),
                    ),
                    margin: EdgeInsets.only(right: 30, left: 30),
                    padding: EdgeInsets.only(left: 15, top: 5, bottom: 5),
                    child: Row(
                      children: [
                        Container(
                          child: Text(
                            "AFFILIATE URL",
                            style: TextStyle(
                              fontFamily: "Brandon",
                              fontWeight: FontWeight.w600,
                              fontSize: 13,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Color(0xffF48262),
                          width: 1,
                        ),
                        left: BorderSide(
                          color: Color(0xffF48262),
                          width: 1,
                        ),
                        right: BorderSide(
                          color: Color(0xffF48262),
                          width: 1,
                        ),
                      ),
                    ),
                    margin: EdgeInsets.only(right: 30, left: 30),
                    padding: EdgeInsets.only(left: 15, top: 5, bottom: 5),
                    child: Row(
                      children: [
                        Container(
                          child: Text(
                            "Link",
                            style: TextStyle(
                              fontFamily: "Brandon",
                              fontWeight: FontWeight.w500,
                              fontSize: 13,
                              color: Colors.grey,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              // padding: EdgeInsets.only(top: 20, bottom: 20),
              margin: EdgeInsets.only(top: 10),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Color(0xffF48262),
                        width: 1,
                      ),
                    ),
                    margin: EdgeInsets.only(right: 30, left: 30),
                    padding: EdgeInsets.only(left: 10, top: 5, bottom: 5),
                    child: Row(
                      children: [
                        Container(
                          child: Text(
                            "Salin tautan di bawah ini untuk digunakan di website mu",
                            style: TextStyle(
                              fontFamily: "Brandon",
                              fontWeight: FontWeight.w600,
                              fontSize: 13,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Color(0xffF48262),
                          width: 1,
                        ),
                        left: BorderSide(
                          color: Color(0xffF48262),
                          width: 1,
                        ),
                        right: BorderSide(
                          color: Color(0xffF48262),
                          width: 1,
                        ),
                      ),
                    ),
                    margin: EdgeInsets.only(right: 30, left: 30),
                    padding: EdgeInsets.only(left: 15, top: 5, bottom: 5),
                    child: Row(
                      children: [
                        Container(
                          child: Text(
                            "Link",
                            style: TextStyle(
                              fontFamily: "Brandon",
                              fontWeight: FontWeight.w500,
                              fontSize: 13,
                              color: Colors.grey,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 30, right: 30),
              padding: EdgeInsets.only(top: 0, bottom: 0),
              child: Row(
                children: [
                  Container(
                    width: 20,
                    height: 40,
                    child: Checkbox(
                      activeColor: Color(0xffF48262),
                      checkColor: Colors.black,
                      value: link,
                      onChanged: (bool value) {
                        setState(() {
                          link = value;
                        });
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Text(
                      "Ringkas URL",
                      style: TextStyle(
                        fontFamily: "Brandon",
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Color(0xffF48262),
                borderRadius: BorderRadius.all(Radius.circular(4)),
              ),
              margin: EdgeInsets.only(left: 30, right: 30, top: 20),
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: Text(
                      "SALIN TAUTAN",
                      style: TextStyle(
                        fontFamily: "Brandon",
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: new PonnyBottomNavbar(selectedIndex: 4),
    );
  }
}
