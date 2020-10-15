import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:ponny/screens/home_screen.dart';
import 'package:ponny/screens/account_screen.dart';
import 'package:ponny/widgets/PonnyBottomNavbar.dart';

class UlasanProdukSuksesScreen extends StatefulWidget {
  static const String id = "pesanan_selesai_Screen";
  @override
  _UlasanProdukSuksesStateScreen createState() =>
      _UlasanProdukSuksesStateScreen();
}

class _UlasanProdukSuksesStateScreen extends State<UlasanProdukSuksesScreen> {
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
                      "Ulasan Produk",
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
              color: Color(0xffF48262),
            ),
            Container(
              margin: EdgeInsets.only(
                top: 30,
                left: 20,
                right: 20,
              ),
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Text(
                      "Carla",
                      style: TextStyle(
                        fontFamily: "Yeseva",
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: 5,
                    ),
                    height: 25,
                    child: Row(
                      children: [
                        Container(
                          child: Icon(
                            Icons.favorite,
                            color: Color(0xffF48262),
                            size: 22,
                          ),
                        ),
                        Container(
                          child: Icon(
                            Icons.favorite,
                            color: Color(0xffF48262),
                            size: 22,
                          ),
                        ),
                        Container(
                          child: Icon(
                            Icons.favorite,
                            color: Color(0xffF48262),
                            size: 22,
                          ),
                        ),
                        Container(
                          child: Icon(
                            Icons.favorite,
                            color: Color(0xffF48262),
                            size: 22,
                          ),
                        ),
                        Container(
                          child: Icon(
                            Icons.favorite_border,
                            color: Color(0xffF48262),
                            size: 22,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            left: 15,
                          ),
                          alignment: Alignment.topCenter,
                          child: Text(
                            "4.3",
                            style: TextStyle(
                              color: Color(0xffF48262),
                              fontFamily: "Brandon",
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            left: 12,
                          ),
                          child: Text(
                            "Verified by Phoebe",
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: "Brandon",
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: Text(
                            "Kualitas barangnya baik, pengiriman cukup cepat,",
                            style: TextStyle(
                              fontFamily: "Brandon",
                              fontWeight: FontWeight.w400,
                              fontSize: 15,
                            ),
                          ),
                        ),
                        Container(
                          child: Text(
                            "produk diterima dengan baik.",
                            style: TextStyle(
                              fontFamily: "Brandon",
                              fontWeight: FontWeight.w400,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    child: Row(
                      children: [
                        Container(
                          width: 70,
                          height: 100,
                          child: Image.asset(
                            "assets/images/produk.png",
                            fit: BoxFit.cover,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 10, right: 10),
                          width: 70,
                          height: 100,
                          child: Image.asset(
                            "assets/images/produk.png",
                            fit: BoxFit.cover,
                          ),
                        ),
                        Container(
                          width: 70,
                          height: 100,
                          child: Image.asset(
                            "assets/images/produk.png",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    height: 1,
                    color: Color(0xffF48262),
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
