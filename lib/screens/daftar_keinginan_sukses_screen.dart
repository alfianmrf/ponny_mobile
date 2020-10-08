import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:ponny/screens/account_screen.dart';
import 'package:ponny/widgets/PonnyBottomNavbar.dart';

class DaftarKeinginanSuksesScreen extends StatefulWidget {
  static const String id = "daftar_keinginan_sukses_Screen";
  @override
  _DaftarKeinginanSuksesStateScreen createState() =>
      _DaftarKeinginanSuksesStateScreen();
}

class _DaftarKeinginanSuksesStateScreen
    extends State<DaftarKeinginanSuksesScreen> {
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
                      "Wishlist",
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
              height: 30,
            ),
            Container(
              margin: EdgeInsets.only(left: 20, right: 20, bottom: 3),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 85,
                    height: 135,
                    child: Image.asset(
                      "assets/images/produk.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      left: 5,
                    ),
                    width: 90,
                    height: 150,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          width: 120,
                          child: Text(
                            "Skin Game",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontFamily: "Yeseva",
                              fontSize: 12,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 0),
                          width: 120,
                          child: Text(
                            "Acne Warrior",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontFamily: "Brandon",
                              fontWeight: FontWeight.w200,
                              fontSize: 10,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 0),
                          width: 120,
                          child: Text(
                            "Rp 125.000",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontFamily: "Brandon",
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
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
                                  size: 13,
                                  color: Color(0xffF48262),
                                ),
                              ),
                              Container(
                                child: Icon(
                                  Icons.favorite,
                                  size: 13,
                                  color: Color(0xffF48262),
                                ),
                              ),
                              Container(
                                child: Icon(
                                  Icons.favorite,
                                  size: 13,
                                  color: Color(0xffF48262),
                                ),
                              ),
                              Container(
                                child: Icon(
                                  Icons.favorite,
                                  size: 13,
                                  color: Color(0xffF48262),
                                ),
                              ),
                              Container(
                                child: Icon(
                                  Icons.favorite,
                                  size: 13,
                                  color: Color(0xffF3C1B5),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 4),
                                child: Text(
                                  "(5)",
                                  style: TextStyle(
                                    fontFamily: "Brandon",
                                    fontSize: 12,
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
                    width: 180,
                    height: 150,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Color(0xffF48262),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          height: 35,
                          width: 150,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                child: Text(
                                  "MASUKKAN KERANJANG",
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontFamily: "Brandon",
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 30,
                          width: 30,
                          child: Icon(
                            Icons.delete,
                            color: Color(0xffF48262),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 20, right: 20, bottom: 3),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 85,
                    height: 135,
                    child: Image.asset(
                      "assets/images/produk.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      left: 5,
                    ),
                    width: 90,
                    height: 150,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          width: 120,
                          child: Text(
                            "Skin Game",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontFamily: "Yeseva",
                              fontSize: 12,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 0),
                          width: 120,
                          child: Text(
                            "Acne Warrior",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontFamily: "Brandon",
                              fontWeight: FontWeight.w200,
                              fontSize: 10,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 0),
                          width: 120,
                          child: Text(
                            "Rp 125.000",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontFamily: "Brandon",
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
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
                                  size: 13,
                                  color: Color(0xffF48262),
                                ),
                              ),
                              Container(
                                child: Icon(
                                  Icons.favorite,
                                  size: 13,
                                  color: Color(0xffF48262),
                                ),
                              ),
                              Container(
                                child: Icon(
                                  Icons.favorite,
                                  size: 13,
                                  color: Color(0xffF48262),
                                ),
                              ),
                              Container(
                                child: Icon(
                                  Icons.favorite,
                                  size: 13,
                                  color: Color(0xffF48262),
                                ),
                              ),
                              Container(
                                child: Icon(
                                  Icons.favorite,
                                  size: 13,
                                  color: Color(0xffF3C1B5),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 4),
                                child: Text(
                                  "(5)",
                                  style: TextStyle(
                                    fontFamily: "Brandon",
                                    fontSize: 12,
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
                    width: 180,
                    height: 150,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Color(0xffF48262),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          height: 35,
                          width: 150,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                child: Text(
                                  "MASUKKAN KERANJANG",
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontFamily: "Brandon",
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 30,
                          width: 30,
                          child: Icon(
                            Icons.delete,
                            color: Color(0xffF48262),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 20, right: 20, bottom: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 85,
                    height: 135,
                    child: Image.asset(
                      "assets/images/produk.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      left: 5,
                    ),
                    width: 90,
                    height: 150,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          width: 120,
                          child: Text(
                            "Skin Game",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontFamily: "Yeseva",
                              fontSize: 12,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 0),
                          width: 120,
                          child: Text(
                            "Acne Warrior",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontFamily: "Brandon",
                              fontWeight: FontWeight.w200,
                              fontSize: 10,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 0),
                          width: 120,
                          child: Text(
                            "Rp 125.000",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontFamily: "Brandon",
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
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
                                  size: 13,
                                  color: Color(0xffF48262),
                                ),
                              ),
                              Container(
                                child: Icon(
                                  Icons.favorite,
                                  size: 13,
                                  color: Color(0xffF48262),
                                ),
                              ),
                              Container(
                                child: Icon(
                                  Icons.favorite,
                                  size: 13,
                                  color: Color(0xffF48262),
                                ),
                              ),
                              Container(
                                child: Icon(
                                  Icons.favorite,
                                  size: 13,
                                  color: Color(0xffF48262),
                                ),
                              ),
                              Container(
                                child: Icon(
                                  Icons.favorite,
                                  size: 13,
                                  color: Color(0xffF3C1B5),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 4),
                                child: Text(
                                  "(5)",
                                  style: TextStyle(
                                    fontFamily: "Brandon",
                                    fontSize: 12,
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
                    width: 180,
                    height: 150,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Color(0xffF48262),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          height: 35,
                          width: 150,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                child: Text(
                                  "MASUKKAN KERANJANG",
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontFamily: "Brandon",
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 30,
                          width: 30,
                          child: Icon(
                            Icons.delete,
                            color: Color(0xffF48262),
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
      bottomNavigationBar: new PonnyBottomNavbar(selectedIndex: 4),
    );
  }
}
