import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:ponny/screens/home_screen.dart';
import 'package:ponny/screens/account_screen.dart';
import 'package:ponny/screens/terkirim_sukses_screen.dart';
import 'package:ponny/widgets/PonnyBottomNavbar.dart';

class TerkirimScreen extends StatefulWidget {
  static const String id = "terkirim_Screen";
  @override
  _TerkirimStateScreen createState() => _TerkirimStateScreen();
}

class _TerkirimStateScreen extends State<TerkirimScreen> {
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
                      "Terkirim",
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
              padding: EdgeInsets.only(top: 20, left: 15, right: 15),
              child: Container(
                decoration: new BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  border: Border.all(
                    width: 1,
                    color: Color(0xffF3C1B5),
                  ),
                ),
                height: 280,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: Icon(
                        Icons.directions_car,
                        size: 60,
                        color: Hexcolor("#F59379"),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      child: Text(
                        "Ups, kamu belum ,melakukan pembelian di Ponny Beaute",
                        style: TextStyle(
                          fontFamily: "Brandon",
                          fontSize: 12,
                        ),
                      ),
                    ),
                    Container(
                      child: Text(
                        "yuk mulai berbelanja.",
                        style: TextStyle(
                          fontFamily: "Brandon",
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 38, left: 15, right: 15),
              height: 30,
              // color: Colors.green,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Text(
                      "NEW ARRIVALS",
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: "Brandon",
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Container(
                    child: Text(
                      "view more",
                      style: TextStyle(
                        fontFamily: "Brandon",
                        fontSize: 16,
                        fontWeight: FontWeight.w200,
                        color: Colors.blueGrey,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10, left: 15, right: 15),
              height: 320,
              // color: Colors.green,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Column(
                      children: [
                        Container(
                          height: 150,
                          width: 120,
                          child: Stack(
                            overflow: Overflow.visible,
                            children: <Widget>[
                              Container(
                                width: MediaQuery.of(context).size.width,
                                child: Image.asset(
                                  "assets/images/produk.png",
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 10, right: 5),
                                alignment: Alignment.topRight,
                                child: Icon(
                                  Icons.favorite_border,
                                  size: 20,
                                  color: Color(0xffF3C1B5),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 15),
                                width: 50,
                                height: 30,
                                color: Color(0xffF48262),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "35%",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontFamily: "Brandon",
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 7, bottom: 7),
                          width: 120,
                          color: Color(0xffF3C1B5),
                          child: Text(
                            "ADD TO BAG",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: "Brandon",
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          width: 120,
                          child: Text(
                            "Skin Game",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: "Yeseva",
                              fontSize: 14,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 0),
                          width: 120,
                          child: Text(
                            "Acne Warrior",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: "Brandon",
                              fontWeight: FontWeight.w200,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 0),
                          width: 120,
                          child: Text(
                            "Rp 100.000",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: "Brandon",
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 2),
                          child: Row(
                            children: [
                              Container(
                                child: Text(
                                  "Rp 125.000",
                                  style: TextStyle(
                                    decoration: TextDecoration.lineThrough,
                                    fontFamily: "Brandon",
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 3),
                                child: Text(
                                  "(35%)",
                                  style: TextStyle(
                                    color: Color(0xffF48262),
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 4),
                          child: Row(
                            children: [
                              Container(
                                child: Icon(
                                  Icons.favorite,
                                  size: 15,
                                  color: Color(0xffF48262),
                                ),
                              ),
                              Container(
                                child: Icon(
                                  Icons.favorite,
                                  size: 15,
                                  color: Color(0xffF48262),
                                ),
                              ),
                              Container(
                                child: Icon(
                                  Icons.favorite,
                                  size: 15,
                                  color: Color(0xffF48262),
                                ),
                              ),
                              Container(
                                child: Icon(
                                  Icons.favorite,
                                  size: 15,
                                  color: Color(0xffF48262),
                                ),
                              ),
                              Container(
                                child: Icon(
                                  Icons.favorite,
                                  size: 15,
                                  color: Color(0xffF3C1B5),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 4),
                                child: Text(
                                  "(5)",
                                  style: TextStyle(
                                    fontFamily: "Brandon",
                                    fontSize: 14,
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
                    child: Column(
                      children: [
                        Container(
                          height: 150,
                          width: 120,
                          child: Stack(
                            overflow: Overflow.visible,
                            children: <Widget>[
                              Container(
                                width: MediaQuery.of(context).size.width,
                                child: Image.asset(
                                  "assets/images/produk.png",
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 10, right: 5),
                                alignment: Alignment.topRight,
                                child: Icon(
                                  Icons.favorite_border,
                                  size: 20,
                                  color: Color(0xffF3C1B5),
                                ),
                              ),
                              // Container(
                              //   margin: EdgeInsets.only(top: 15),
                              //   width: 50,
                              //   height: 30,
                              //   color: Color(0xffF48262),
                              //   child: Row(
                              //     mainAxisAlignment: MainAxisAlignment.center,
                              //     children: [
                              //       Text(
                              //         "35%",
                              //         style: TextStyle(
                              //           fontSize: 12,
                              //           fontFamily: "Brandon",
                              //           color: Colors.white,
                              //           fontWeight: FontWeight.w700,
                              //         ),
                              //       ),
                              //     ],
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 7, bottom: 7),
                          width: 120,
                          color: Color(0xffF3C1B5),
                          child: Text(
                            "ADD TO BAG",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: "Brandon",
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          width: 120,
                          child: Text(
                            "Skin Game",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: "Yeseva",
                              fontSize: 14,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 0),
                          width: 120,
                          child: Text(
                            "Acne Warrior",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: "Brandon",
                              fontWeight: FontWeight.w200,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 0),
                          width: 120,
                          child: Text(
                            "Rp 125.000",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: "Brandon",
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 4),
                          child: Row(
                            children: [
                              Container(
                                child: Icon(
                                  Icons.favorite,
                                  size: 15,
                                  color: Color(0xffF48262),
                                ),
                              ),
                              Container(
                                child: Icon(
                                  Icons.favorite,
                                  size: 15,
                                  color: Color(0xffF48262),
                                ),
                              ),
                              Container(
                                child: Icon(
                                  Icons.favorite,
                                  size: 15,
                                  color: Color(0xffF48262),
                                ),
                              ),
                              Container(
                                child: Icon(
                                  Icons.favorite,
                                  size: 15,
                                  color: Color(0xffF48262),
                                ),
                              ),
                              Container(
                                child: Icon(
                                  Icons.favorite,
                                  size: 15,
                                  color: Color(0xffF3C1B5),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 4),
                                child: Text(
                                  "(5)",
                                  style: TextStyle(
                                    fontFamily: "Brandon",
                                    fontSize: 14,
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
                    child: Column(
                      children: [
                        Container(
                          height: 150,
                          width: 120,
                          child: Stack(
                            overflow: Overflow.visible,
                            children: <Widget>[
                              Container(
                                width: MediaQuery.of(context).size.width,
                                child: Image.asset(
                                  "assets/images/produk.png",
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 10, right: 5),
                                alignment: Alignment.topRight,
                                child: Icon(
                                  Icons.favorite_border,
                                  size: 20,
                                  color: Color(0xffF3C1B5),
                                ),
                              ),
                              // Container(
                              //   margin: EdgeInsets.only(top: 15),
                              //   width: 50,
                              //   height: 30,
                              //   color: Color(0xffF48262),
                              //   child: Row(
                              //     mainAxisAlignment: MainAxisAlignment.center,
                              //     children: [
                              //       Text(
                              //         "35%",
                              //         style: TextStyle(
                              //           fontSize: 12,
                              //           fontFamily: "Brandon",
                              //           color: Colors.white,
                              //           fontWeight: FontWeight.w700,
                              //         ),
                              //       ),
                              //     ],
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 7, bottom: 7),
                          width: 120,
                          color: Color(0xffF3C1B5),
                          child: Text(
                            "ADD TO BAG",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: "Brandon",
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          width: 120,
                          child: Text(
                            "Skin Game",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: "Yeseva",
                              fontSize: 14,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 0),
                          width: 120,
                          child: Text(
                            "Acne Warrior",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: "Brandon",
                              fontWeight: FontWeight.w200,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 0),
                          width: 120,
                          child: Text(
                            "Rp 125.000",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: "Brandon",
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 4),
                          child: Row(
                            children: [
                              Container(
                                child: Icon(
                                  Icons.favorite,
                                  size: 15,
                                  color: Color(0xffF48262),
                                ),
                              ),
                              Container(
                                child: Icon(
                                  Icons.favorite,
                                  size: 15,
                                  color: Color(0xffF48262),
                                ),
                              ),
                              Container(
                                child: Icon(
                                  Icons.favorite,
                                  size: 15,
                                  color: Color(0xffF48262),
                                ),
                              ),
                              Container(
                                child: Icon(
                                  Icons.favorite,
                                  size: 15,
                                  color: Color(0xffF48262),
                                ),
                              ),
                              Container(
                                child: Icon(
                                  Icons.favorite,
                                  size: 15,
                                  color: Color(0xffF3C1B5),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 4),
                                child: Text(
                                  "(5)",
                                  style: TextStyle(
                                    fontFamily: "Brandon",
                                    fontSize: 14,
                                  ),
                                ),
                              )
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
              child: RaisedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TerkirimSuksesScreen(),
                    ),
                  );
                },
                child: Text(
                  "Selanjutnya",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
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
