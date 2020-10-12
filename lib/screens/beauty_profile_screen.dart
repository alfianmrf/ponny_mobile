import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:ponny/screens/home_screen.dart';
import 'package:ponny/screens/account_screen.dart';
import 'package:ponny/screens/edit_beauty_profile_screen.dart';
import 'package:ponny/widgets/PonnyBottomNavbar.dart';

class BeautyProfileScreen extends StatefulWidget {
  static const String id = "beauty_profile_Screen";
  @override
  _BeautyProfileStateScreen createState() => _BeautyProfileStateScreen();
}

class _BeautyProfileStateScreen extends State<BeautyProfileScreen> {
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
                      "Beauty Profile",
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
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Color(0xffF3C1B5),
                    width: 3,
                  ),
                ),
                // color: Colors.cyanAccent,
              ),
              margin: EdgeInsets.only(
                left: 20,
                right: 20,
                top: 10,
              ),
              padding: EdgeInsets.only(top: 0, bottom: 20),
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 10),
                    width: 140,
                    height: 120,
                    // color: Colors.redAccent,
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        "WARNA KULIT",
                        style: TextStyle(
                          fontFamily: "Brandon",
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 220,
                    height: 120,
                    // color: Colors.redAccent,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                            top: 30,
                          ),
                          decoration: BoxDecoration(
                            color: Hexcolor('#F1D7C3'),
                            borderRadius:
                                BorderRadius.all(Radius.circular(100)),
                          ),
                          width: 65,
                          height: 60,
                        ),
                        Container(
                          padding: EdgeInsets.only(
                            top: 5,
                          ),
                          width: 65,
                          height: 30,
                          child: Text(
                            "Putih",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: "Brandon",
                              fontSize: 12,
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
                    color: Color(0xffF3C1B5),
                    width: 3,
                  ),
                ),
                // color: Colors.cyanAccent,
              ),
              margin: EdgeInsets.only(
                left: 20,
                right: 20,
                top: 10,
              ),
              padding: EdgeInsets.only(top: 20, bottom: 20),
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 10),
                    width: 140,
                    height: 120,
                    // color: Colors.redAccent,
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        "JENIS KULIT",
                        style: TextStyle(
                          fontFamily: "Brandon",
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 220,
                    height: 120,
                    // color: Colors.redAccent,
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Color(0xffF3C1B5),
                                width: 2,
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4)),
                            ),
                            width: 65,
                            height: 90,
                            child: Image.asset(
                              'assets/images/kulit-normal.png',
                              width: 30,
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Color(0xffF3C1B5),
                              border: Border.all(
                                color: Color(0xffF3C1B5),
                                width: 2,
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(3)),
                            ),
                            padding: EdgeInsets.only(
                              top: 5,
                            ),
                            width: 65,
                            height: 30,
                            child: Text(
                              "Putih",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: "Brandon",
                                fontSize: 12,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Color(0xffF3C1B5),
                    width: 3,
                  ),
                ),
                // color: Colors.cyanAccent,
              ),
              margin: EdgeInsets.only(
                left: 20,
                right: 20,
                top: 10,
              ),
              padding: EdgeInsets.only(top: 20, bottom: 20),
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 10),
                    width: 140,
                    height: 120,
                    // color: Colors.redAccent,
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        "KONDISI KULIT",
                        style: TextStyle(
                          fontFamily: "Brandon",
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 220,
                    height: 120,
                    // color: Colors.redAccent,
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                            right: 5,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Color(0xffF3C1B5),
                                    width: 2,
                                  ),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4)),
                                ),
                                width: 65,
                                height: 90,
                                child: Image.asset(
                                  'assets/images/jerawat.png',
                                  width: 30,
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Color(0xffF3C1B5),
                                  border: Border.all(
                                    color: Color(0xffF3C1B5),
                                    width: 2,
                                  ),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(3)),
                                ),
                                padding: EdgeInsets.only(
                                  top: 5,
                                ),
                                width: 65,
                                height: 30,
                                child: Text(
                                  "Jerawat",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: "Brandon",
                                    fontSize: 12,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            right: 5,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Color(0xffF3C1B5),
                                    width: 2,
                                  ),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4)),
                                ),
                                width: 65,
                                height: 90,
                                child: Image.asset(
                                  'assets/images/keriput.png',
                                  width: 30,
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Color(0xffF3C1B5),
                                  border: Border.all(
                                    color: Color(0xffF3C1B5),
                                    width: 2,
                                  ),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(3)),
                                ),
                                padding: EdgeInsets.only(
                                  top: 5,
                                ),
                                width: 65,
                                height: 30,
                                child: Text(
                                  "Garis Halus Keriput",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: "Brandon",
                                    fontSize: 7,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            right: 5,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Color(0xffF3C1B5),
                                    width: 2,
                                  ),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4)),
                                ),
                                width: 65,
                                height: 90,
                                child: Image.asset(
                                  'assets/images/komedo.png',
                                  width: 30,
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Color(0xffF3C1B5),
                                  border: Border.all(
                                    color: Color(0xffF3C1B5),
                                    width: 2,
                                  ),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(3)),
                                ),
                                padding: EdgeInsets.only(
                                  top: 5,
                                ),
                                width: 65,
                                height: 30,
                                child: Text(
                                  "Komedo",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: "Brandon",
                                    fontSize: 12,
                                    color: Colors.white,
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
            Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Color(0xffF3C1B5),
                    width: 3,
                  ),
                ),
                // color: Colors.cyanAccent,
              ),
              margin: EdgeInsets.only(
                left: 20,
                right: 20,
                top: 10,
              ),
              padding: EdgeInsets.only(top: 20, bottom: 20),
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 10),
                    width: 140,
                    height: 120,
                    // color: Colors.redAccent,
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        "KONDISI RAMBUT",
                        style: TextStyle(
                          fontFamily: "Brandon",
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 220,
                    height: 120,
                    // color: Colors.redAccent,
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                            right: 5,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Color(0xffF3C1B5),
                                    width: 2,
                                  ),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4)),
                                ),
                                width: 65,
                                height: 90,
                                child: Image.asset(
                                  'assets/images/ketombe.png',
                                  width: 30,
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Color(0xffF3C1B5),
                                  border: Border.all(
                                    color: Color(0xffF3C1B5),
                                    width: 2,
                                  ),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(3)),
                                ),
                                padding: EdgeInsets.only(
                                  top: 5,
                                ),
                                width: 65,
                                height: 30,
                                child: Text(
                                  "Ketombe",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: "Brandon",
                                    fontSize: 12,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            right: 5,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Color(0xffF3C1B5),
                                    width: 2,
                                  ),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4)),
                                ),
                                width: 65,
                                height: 90,
                                child: Image.asset(
                                  'assets/images/rontok.png',
                                  width: 30,
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Color(0xffF3C1B5),
                                  border: Border.all(
                                    color: Color(0xffF3C1B5),
                                    width: 2,
                                  ),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(3)),
                                ),
                                padding: EdgeInsets.only(
                                  top: 5,
                                ),
                                width: 65,
                                height: 30,
                                child: Text(
                                  "Rontok",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: "Brandon",
                                    fontSize: 12,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            right: 5,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Color(0xffF3C1B5),
                                    width: 2,
                                  ),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4)),
                                ),
                                width: 65,
                                height: 90,
                                child: Image.asset(
                                  'assets/images/bercabang.png',
                                  width: 30,
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Color(0xffF3C1B5),
                                  border: Border.all(
                                    color: Color(0xffF3C1B5),
                                    width: 2,
                                  ),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(3)),
                                ),
                                padding: EdgeInsets.only(
                                  top: 5,
                                ),
                                width: 65,
                                height: 30,
                                child: Text(
                                  "Bercabang",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: "Brandon",
                                    fontSize: 12,
                                    color: Colors.white,
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
            Container(
              margin: EdgeInsets.only(
                left: 20,
                right: 20,
                top: 10,
              ),
              padding: EdgeInsets.only(top: 20, bottom: 20),
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 10),
                    width: 140,
                    height: 120,
                    // color: Colors.redAccent,
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "PREFERENSI PRODUK",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontFamily: "Brandon",
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 220,
                    height: 120,
                    // color: Colors.redAccent,
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                            right: 5,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Color(0xffF3C1B5),
                                    width: 2,
                                  ),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4)),
                                ),
                                width: 65,
                                height: 90,
                                child: Image.asset(
                                  'assets/images/jerawat.png',
                                  width: 30,
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Color(0xffF3C1B5),
                                  border: Border.all(
                                    color: Color(0xffF3C1B5),
                                    width: 2,
                                  ),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(3)),
                                ),
                                padding: EdgeInsets.only(
                                  top: 5,
                                ),
                                width: 65,
                                height: 30,
                                child: Text(
                                  "Jerawat",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: "Brandon",
                                    fontSize: 12,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            right: 5,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Color(0xffF3C1B5),
                                    width: 2,
                                  ),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4)),
                                ),
                                width: 65,
                                height: 90,
                                child: Image.asset(
                                  'assets/images/keriput.png',
                                  width: 30,
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Color(0xffF3C1B5),
                                  border: Border.all(
                                    color: Color(0xffF3C1B5),
                                    width: 2,
                                  ),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(3)),
                                ),
                                padding: EdgeInsets.only(
                                  top: 5,
                                ),
                                width: 65,
                                height: 30,
                                child: Text(
                                  "Garis Halus Keriput",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: "Brandon",
                                    fontSize: 7,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            right: 5,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Color(0xffF3C1B5),
                                    width: 2,
                                  ),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4)),
                                ),
                                width: 65,
                                height: 90,
                                child: Image.asset(
                                  'assets/images/komedo.png',
                                  width: 30,
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Color(0xffF3C1B5),
                                  border: Border.all(
                                    color: Color(0xffF3C1B5),
                                    width: 2,
                                  ),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(3)),
                                ),
                                padding: EdgeInsets.only(
                                  top: 5,
                                ),
                                width: 65,
                                height: 30,
                                child: Text(
                                  "Komedo",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: "Brandon",
                                    fontSize: 12,
                                    color: Colors.white,
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
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditBeautyProfileScreen(),
                  ),
                );
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Color(0xffF3C1B5),
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
                margin:
                    EdgeInsets.only(right: 20, left: 20, bottom: 20, top: 10),
                padding: EdgeInsets.only(top: 10, bottom: 10),
                child: Text(
                  "EDIT",
                  style: TextStyle(
                    fontFamily: "Brandon",
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: new PonnyBottomNavbar(selectedIndex: 4),
    );
  }
}
