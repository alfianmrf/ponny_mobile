import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:ponny/common/constant.dart';
import 'package:ponny/screens/home_screen.dart';
import 'package:ponny/screens/account_screen.dart';
import 'package:ponny/screens/account/pembayaran_diterima_sukses_screen.dart';
import 'package:ponny/widgets/PonnyBottomNavbar.dart';

class PembayaranDiterimaScreen extends StatefulWidget {
  static const String id = "pembayaran_diterima_Screen";
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
                        Icons.shopping_cart,
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
              // color: Colors.green,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      child: product(context),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      child: product(context),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      child: product(context),
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
                      builder: (context) => PembayaranDiterimaSuksesScreen(),
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
