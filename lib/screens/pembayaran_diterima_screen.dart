import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:ponny/screens/account_screen.dart';
import 'package:ponny/widgets/PonnyBottomNavbar.dart';

class PembayaranDiterimaScreen extends StatefulWidget {
  static const String id = "Pembayaran_Diterima_Screen";
  @override
  _PembayaranDiterimaStateScreen createState() =>
      _PembayaranDiterimaStateScreen();
}

class _PembayaranDiterimaStateScreen extends State<PembayaranDiterimaScreen> {
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
                      "Pembayaran Diterima",
                      style: TextStyle(
                        fontSize: 22,
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
              margin: EdgeInsets.only(
                top: 20,
                left: 15,
                right: 15,
              ),

              // height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.only(
                      top: 5,
                      bottom: 5,
                    ),
                    child: Text(
                      "#70212",
                      style: TextStyle(
                        fontFamily: "Brandon",
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                      top: 5,
                      left: 25,
                      bottom: 5,
                    ),
                    child: Text(
                      "29/04/2020",
                      style: TextStyle(
                        fontFamily: "Brandon",
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 5, bottom: 5, right: 15),
                    child: Text(
                      "Proses",
                      style: TextStyle(
                        fontFamily: "Brandon",
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                      top: 5,
                      bottom: 5,
                    ),
                    child: Text(
                      "Rp 329.000",
                      style: TextStyle(
                        fontFamily: "Brandon",
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                      top: 5,
                      bottom: 5,
                    ),
                    child: Icon(
                      Icons.keyboard_arrow_up,
                      size: 26,
                      color: Color(0xffF48262),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                top: 10,
                left: 15,
                right: 15,
              ),
              height: 1,
              color: Color(0xffF3C1B5),
            ),
            Container(
              margin: EdgeInsets.only(
                top: 20,
                left: 15,
                right: 15,
              ),
              // color: Colors.greenAccent,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    child: Image.asset(
                      "assets/images/produk.png",
                      width: 85,
                    ),
                  ),
                  Container(
                    alignment: Alignment.topCenter,
                    height: 105,
                    // color: Colors.yellowAccent,
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 0),
                          // color: Colors.redAccent,
                          width: 93,
                          child: Text(
                            "Skin Game",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontFamily: "Yeseva",
                              fontSize: 14,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 1),
                          width: 93,
                          child: Text(
                            "Acne Warrior",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontFamily: "Brandon",
                              fontWeight: FontWeight.w200,
                              fontSize: 13,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 1),
                          width: 93,
                          child: Text(
                            "Rp. 125.000",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontFamily: "Brandon",
                              fontWeight: FontWeight.w600,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    // color: Colors.yellowAccent,
                    height: 100,
                    child: Column(
                      children: [
                        Container(
                          width: 80,
                          child: Text(
                            "TOTAL",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontFamily: "Brandon",
                              fontWeight: FontWeight.w500,
                              fontSize: 13,
                            ),
                          ),
                        ),
                        Container(
                          width: 80,
                          child: Text(
                            "Rp. 329.000",
                            style: TextStyle(
                              fontFamily: "Brandon",
                              fontWeight: FontWeight.w300,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    // color: Colors.yellowAccent,
                    child: Column(
                      children: [
                        Container(
                          width: 100,
                          child: Text(
                            "Payment Method",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              fontFamily: "Brandon",
                            ),
                          ),
                        ),
                        Container(
                          width: 100,
                          child: Text(
                            "BCA Virtual",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              fontFamily: "Brandon",
                            ),
                          ),
                        ),
                        Container(
                          width: 100,
                          margin: EdgeInsets.only(top: 10),
                          child: Text(
                            "Payment Method",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              fontFamily: "Brandon",
                            ),
                          ),
                        ),
                        Container(
                          width: 100,
                          child: Text(
                            "Cikini,",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              fontFamily: "Brandon",
                            ),
                          ),
                        ),
                        Container(
                          width: 100,
                          child: Text(
                            "Jakarta Pusat",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              fontFamily: "Brandon",
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
              margin: EdgeInsets.only(top: 30, left: 15, right: 15),
              padding: EdgeInsets.only(left: 15, right: 15),
              width: MediaQuery.of(context).size.width,
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      // border: Border.all(
                      //   color: Colors.red[500],
                      // ),
                      color: Color(0xffF3C1B5),
                      borderRadius: BorderRadius.all(
                        Radius.circular(5),
                      ),
                    ),
                    width: 160,
                    height: 35,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          child: Text(
                            "Lacak Pesanan",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: "Brandon",
                              color: Colors.white,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Color(0xffF3C1B5),
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(5),
                      ),
                    ),
                    width: 160,
                    height: 35,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          child: Text(
                            "Komplain",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: "Brandon",
                              color: Colors.black,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
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
