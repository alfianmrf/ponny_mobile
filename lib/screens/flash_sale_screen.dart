import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:ponny/screens/account_screen.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:waterfall_flow/waterfall_flow.dart';
import 'package:ponny/widgets/PonnyBottomNavbar.dart';

class FlashSaleScreen extends StatefulWidget {
  static const String id = "Flash_Sale_Screen";
  @override
  _FlashSaleStateScreen createState() => _FlashSaleStateScreen();
}

class _FlashSaleStateScreen extends State<FlashSaleScreen> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
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
                      "Skincare",
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
              padding: EdgeInsets.only(top: 10, bottom: 10),
              color: Hexcolor('#FACAC3'),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: Text(
                      "FLASH SALE",
                      style: TextStyle(
                        fontFamily: "Brandon",
                        fontWeight: FontWeight.w600,
                        fontSize: 22,
                        color: Color(0xffF48262),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 150,
              color: Colors.grey,
            ),
            Container(
              padding: EdgeInsets.only(top: 15, bottom: 15),
              // color: Colors.green,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: Text(
                      "DIMULAI DALAM",
                      style: TextStyle(
                        fontFamily: "Brandon",
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: Container(
                // color: Colors.green,
                margin: EdgeInsets.only(left: 20, right: 20, bottom: 5),
                child: WaterfallFlow.count(
                  crossAxisCount: 3,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 10,
                  children: [
                    Container(
                      // width: (screenWidth - 50) / 3,
                      // color: Colors.purpleAccent,
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              Image.asset(
                                "assets/images/produk.png",
                                width: MediaQuery.of(context).size.width,
                                fit: BoxFit.cover,
                              ),
                              Positioned(
                                top: 12,
                                child: Container(
                                  height: 25,
                                  width: 40,
                                  color: Color(0xffF48262),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        child: Text(
                                          "35%",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontFamily: "Brandon",
                                            fontSize: 11,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 5,
                                right: 5,
                                child: Icon(
                                  Icons.favorite_border,
                                  size: 16,
                                  color: Color(0xffF48262),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 2, bottom: 2),
                            color: Hexcolor('#FACAC3'),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  child: Text(
                                    "ADD TO BAG",
                                    style: TextStyle(
                                      fontFamily: "Brandon",
                                      fontWeight: FontWeight.w700,
                                      fontSize: 12,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 10, bottom: 5),
                            // color: Colors.red,
                            child: Column(
                              children: [
                                Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        child: Text(
                                          "Skin Game",
                                          style: TextStyle(
                                            fontFamily: "Yeseva",
                                            fontSize: 13,
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
                                          "Acne Warrior",
                                          style: TextStyle(
                                            fontFamily: "Brandon",
                                            fontSize: 13,
                                            fontWeight: FontWeight.w300,
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
                                          "Rp 100.000",
                                          style: TextStyle(
                                            fontFamily: "Brandon",
                                            fontSize: 13,
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
                                        child: RichText(
                                          text: TextSpan(
                                            children: <TextSpan>[
                                              TextSpan(
                                                text: "Rp 125.000",
                                                style: TextStyle(
                                                  fontFamily: "Brandon",
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.w400,
                                                  decoration: TextDecoration
                                                      .lineThrough,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              TextSpan(
                                                text: "(35%)",
                                                style: TextStyle(
                                                  fontFamily: "Brandon",
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.w400,
                                                  color: Color(0xffF48262),
                                                ),
                                              )
                                            ],
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
                                        child: Icon(
                                          Icons.favorite,
                                          color: Color(0xffF48262),
                                          size: 12,
                                        ),
                                      ),
                                      Container(
                                        child: Icon(
                                          Icons.favorite,
                                          color: Color(0xffF48262),
                                          size: 12,
                                        ),
                                      ),
                                      Container(
                                        child: Icon(
                                          Icons.favorite,
                                          color: Color(0xffF48262),
                                          size: 12,
                                        ),
                                      ),
                                      Container(
                                        child: Icon(
                                          Icons.favorite,
                                          color: Color(0xffF48262),
                                          size: 12,
                                        ),
                                      ),
                                      Container(
                                        child: Icon(
                                          Icons.favorite_border,
                                          color: Color(0xffF48262),
                                          size: 12,
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(left: 2),
                                        child: Text(
                                          "(5)",
                                          style: TextStyle(
                                            fontFamily: "Brandon",
                                            fontWeight: FontWeight.w300,
                                            fontSize: 11,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 6, bottom: 4),
                                  child: LinearPercentIndicator(
                                    lineHeight: 8.0,
                                    percent: 0.7,
                                    progressColor: Color(0xffF48262),
                                  ),
                                ),
                                Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        child: Text(
                                          "Tersisa 19",
                                          style: TextStyle(
                                            fontFamily: "Brandon",
                                            fontSize: 12,
                                            fontWeight: FontWeight.w300,
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
                      // width: (screenWidth - 50) / 3,
                      // color: Colors.purpleAccent,
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              Image.asset(
                                "assets/images/produk.png",
                                width: MediaQuery.of(context).size.width,
                                fit: BoxFit.cover,
                              ),
                              Positioned(
                                top: 12,
                                child: Container(
                                  height: 25,
                                  width: 40,
                                  color: Color(0xffF48262),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        child: Text(
                                          "35%",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontFamily: "Brandon",
                                            fontSize: 11,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 5,
                                right: 5,
                                child: Icon(
                                  Icons.favorite_border,
                                  size: 16,
                                  color: Color(0xffF48262),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 2, bottom: 2),
                            color: Hexcolor('#FACAC3'),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  child: Text(
                                    "ADD TO BAG",
                                    style: TextStyle(
                                      fontFamily: "Brandon",
                                      fontWeight: FontWeight.w700,
                                      fontSize: 12,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 10, bottom: 5),
                            // color: Colors.red,
                            child: Column(
                              children: [
                                Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        child: Text(
                                          "Skin Game",
                                          style: TextStyle(
                                            fontFamily: "Yeseva",
                                            fontSize: 13,
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
                                          "Acne Warrior",
                                          style: TextStyle(
                                            fontFamily: "Brandon",
                                            fontSize: 13,
                                            fontWeight: FontWeight.w300,
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
                                          "Rp 100.000",
                                          style: TextStyle(
                                            fontFamily: "Brandon",
                                            fontSize: 13,
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
                                        child: RichText(
                                          text: TextSpan(
                                            children: <TextSpan>[
                                              TextSpan(
                                                text: "Rp 125.000",
                                                style: TextStyle(
                                                  fontFamily: "Brandon",
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.w400,
                                                  decoration: TextDecoration
                                                      .lineThrough,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              TextSpan(
                                                text: "(35%)",
                                                style: TextStyle(
                                                  fontFamily: "Brandon",
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.w400,
                                                  color: Color(0xffF48262),
                                                ),
                                              )
                                            ],
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
                                        child: Icon(
                                          Icons.favorite,
                                          color: Color(0xffF48262),
                                          size: 12,
                                        ),
                                      ),
                                      Container(
                                        child: Icon(
                                          Icons.favorite,
                                          color: Color(0xffF48262),
                                          size: 12,
                                        ),
                                      ),
                                      Container(
                                        child: Icon(
                                          Icons.favorite,
                                          color: Color(0xffF48262),
                                          size: 12,
                                        ),
                                      ),
                                      Container(
                                        child: Icon(
                                          Icons.favorite,
                                          color: Color(0xffF48262),
                                          size: 12,
                                        ),
                                      ),
                                      Container(
                                        child: Icon(
                                          Icons.favorite_border,
                                          color: Color(0xffF48262),
                                          size: 12,
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(left: 2),
                                        child: Text(
                                          "(5)",
                                          style: TextStyle(
                                            fontFamily: "Brandon",
                                            fontWeight: FontWeight.w300,
                                            fontSize: 11,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 6, bottom: 4),
                                  child: LinearPercentIndicator(
                                    lineHeight: 8.0,
                                    percent: 0.7,
                                    progressColor: Color(0xffF48262),
                                  ),
                                ),
                                Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        child: Text(
                                          "Masih Tersedia",
                                          style: TextStyle(
                                            fontFamily: "Brandon",
                                            fontSize: 11,
                                            fontWeight: FontWeight.w300,
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
                      // width: (screenWidth - 50) / 3,
                      // color: Colors.purpleAccent,
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              Image.asset(
                                "assets/images/produk.png",
                                width: MediaQuery.of(context).size.width,
                                fit: BoxFit.cover,
                              ),
                              Positioned(
                                top: 5,
                                right: 5,
                                child: Icon(
                                  Icons.favorite_border,
                                  size: 16,
                                  color: Color(0xffF48262),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 2, bottom: 2),
                            color: Color(0xffF48262),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  child: Text(
                                    "TERJUAL HABIS",
                                    style: TextStyle(
                                      fontFamily: "Brandon",
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 10, bottom: 5),
                            // color: Colors.red,
                            child: Column(
                              children: [
                                Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        child: Text(
                                          "Skin Game",
                                          style: TextStyle(
                                            fontFamily: "Yeseva",
                                            fontSize: 13,
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
                                          "Acne Warrior",
                                          style: TextStyle(
                                            fontFamily: "Brandon",
                                            fontSize: 13,
                                            fontWeight: FontWeight.w300,
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
                                          "Rp 125.000",
                                          style: TextStyle(
                                            fontFamily: "Brandon",
                                            fontSize: 13,
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
                                        child: Icon(
                                          Icons.favorite,
                                          color: Color(0xffF48262),
                                          size: 12,
                                        ),
                                      ),
                                      Container(
                                        child: Icon(
                                          Icons.favorite,
                                          color: Color(0xffF48262),
                                          size: 12,
                                        ),
                                      ),
                                      Container(
                                        child: Icon(
                                          Icons.favorite,
                                          color: Color(0xffF48262),
                                          size: 12,
                                        ),
                                      ),
                                      Container(
                                        child: Icon(
                                          Icons.favorite,
                                          color: Color(0xffF48262),
                                          size: 12,
                                        ),
                                      ),
                                      Container(
                                        child: Icon(
                                          Icons.favorite_border,
                                          color: Color(0xffF48262),
                                          size: 12,
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(left: 2),
                                        child: Text(
                                          "(5)",
                                          style: TextStyle(
                                            fontFamily: "Brandon",
                                            fontWeight: FontWeight.w300,
                                            fontSize: 11,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 37,
                                ),
                                Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        child: Text(
                                          "Tersedia dalam harga normal",
                                          style: TextStyle(
                                            fontFamily: "Brandon",
                                            fontSize: 9,
                                            fontWeight: FontWeight.w300,
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
                      // width: (screenWidth - 50) / 3,
                      // color: Colors.purpleAccent,
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              Image.asset(
                                "assets/images/produk.png",
                                width: MediaQuery.of(context).size.width,
                                fit: BoxFit.cover,
                              ),
                              Positioned(
                                top: 12,
                                child: Container(
                                  height: 25,
                                  width: 40,
                                  color: Color(0xffF48262),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        child: Text(
                                          "35%",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontFamily: "Brandon",
                                            fontSize: 11,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 5,
                                right: 5,
                                child: Icon(
                                  Icons.favorite_border,
                                  size: 16,
                                  color: Color(0xffF48262),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 2, bottom: 2),
                            color: Hexcolor('#FACAC3'),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  child: Text(
                                    "ADD TO BAG",
                                    style: TextStyle(
                                      fontFamily: "Brandon",
                                      fontWeight: FontWeight.w700,
                                      fontSize: 12,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 10, bottom: 5),
                            // color: Colors.red,
                            child: Column(
                              children: [
                                Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        child: Text(
                                          "Skin Game",
                                          style: TextStyle(
                                            fontFamily: "Yeseva",
                                            fontSize: 13,
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
                                          "Acne Warrior",
                                          style: TextStyle(
                                            fontFamily: "Brandon",
                                            fontSize: 13,
                                            fontWeight: FontWeight.w300,
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
                                          "Rp 100.000",
                                          style: TextStyle(
                                            fontFamily: "Brandon",
                                            fontSize: 13,
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
                                        child: RichText(
                                          text: TextSpan(
                                            children: <TextSpan>[
                                              TextSpan(
                                                text: "Rp 125.000",
                                                style: TextStyle(
                                                  fontFamily: "Brandon",
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.w400,
                                                  decoration: TextDecoration
                                                      .lineThrough,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              TextSpan(
                                                text: "(35%)",
                                                style: TextStyle(
                                                  fontFamily: "Brandon",
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.w400,
                                                  color: Color(0xffF48262),
                                                ),
                                              )
                                            ],
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
                                        child: Icon(
                                          Icons.favorite,
                                          color: Color(0xffF48262),
                                          size: 12,
                                        ),
                                      ),
                                      Container(
                                        child: Icon(
                                          Icons.favorite,
                                          color: Color(0xffF48262),
                                          size: 12,
                                        ),
                                      ),
                                      Container(
                                        child: Icon(
                                          Icons.favorite,
                                          color: Color(0xffF48262),
                                          size: 12,
                                        ),
                                      ),
                                      Container(
                                        child: Icon(
                                          Icons.favorite,
                                          color: Color(0xffF48262),
                                          size: 12,
                                        ),
                                      ),
                                      Container(
                                        child: Icon(
                                          Icons.favorite_border,
                                          color: Color(0xffF48262),
                                          size: 12,
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(left: 2),
                                        child: Text(
                                          "(5)",
                                          style: TextStyle(
                                            fontFamily: "Brandon",
                                            fontWeight: FontWeight.w300,
                                            fontSize: 11,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 6, bottom: 4),
                                  child: LinearPercentIndicator(
                                    lineHeight: 8.0,
                                    percent: 0.7,
                                    progressColor: Color(0xffF48262),
                                  ),
                                ),
                                Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        child: Text(
                                          "Masih Tersedia",
                                          style: TextStyle(
                                            fontFamily: "Brandon",
                                            fontSize: 12,
                                            fontWeight: FontWeight.w300,
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
                      // width: (screenWidth - 50) / 3,
                      // color: Colors.purpleAccent,
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              Image.asset(
                                "assets/images/produk.png",
                                width: MediaQuery.of(context).size.width,
                                fit: BoxFit.cover,
                              ),
                              Positioned(
                                top: 5,
                                right: 5,
                                child: Icon(
                                  Icons.favorite_border,
                                  size: 16,
                                  color: Color(0xffF48262),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 2, bottom: 2),
                            color: Color(0xffF48262),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  child: Text(
                                    "TERJUAL HABIS",
                                    style: TextStyle(
                                      fontFamily: "Brandon",
                                      fontWeight: FontWeight.w700,
                                      fontSize: 12,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 10, bottom: 5),
                            // color: Colors.red,
                            child: Column(
                              children: [
                                Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        child: Text(
                                          "Skin Game",
                                          style: TextStyle(
                                            fontFamily: "Yeseva",
                                            fontSize: 13,
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
                                          "Acne Warrior",
                                          style: TextStyle(
                                            fontFamily: "Brandon",
                                            fontSize: 13,
                                            fontWeight: FontWeight.w300,
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
                                          "Rp 100.000",
                                          style: TextStyle(
                                            fontFamily: "Brandon",
                                            fontSize: 13,
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
                                        child: Icon(
                                          Icons.favorite,
                                          color: Color(0xffF48262),
                                          size: 12,
                                        ),
                                      ),
                                      Container(
                                        child: Icon(
                                          Icons.favorite,
                                          color: Color(0xffF48262),
                                          size: 12,
                                        ),
                                      ),
                                      Container(
                                        child: Icon(
                                          Icons.favorite,
                                          color: Color(0xffF48262),
                                          size: 12,
                                        ),
                                      ),
                                      Container(
                                        child: Icon(
                                          Icons.favorite,
                                          color: Color(0xffF48262),
                                          size: 12,
                                        ),
                                      ),
                                      Container(
                                        child: Icon(
                                          Icons.favorite_border,
                                          color: Color(0xffF48262),
                                          size: 12,
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(left: 2),
                                        child: Text(
                                          "(5)",
                                          style: TextStyle(
                                            fontFamily: "Brandon",
                                            fontWeight: FontWeight.w300,
                                            fontSize: 11,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 37,
                                ),
                                Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        child: Text(
                                          "Tersedia dalam harga normal",
                                          style: TextStyle(
                                            fontFamily: "Brandon",
                                            fontSize: 9,
                                            fontWeight: FontWeight.w300,
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
                      // width: (screenWidth - 50) / 3,
                      // color: Colors.purpleAccent,
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              Image.asset(
                                "assets/images/produk.png",
                                width: MediaQuery.of(context).size.width,
                                fit: BoxFit.cover,
                              ),
                              Positioned(
                                top: 12,
                                child: Container(
                                  height: 25,
                                  width: 40,
                                  color: Color(0xffF48262),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        child: Text(
                                          "35%",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontFamily: "Brandon",
                                            fontSize: 11,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 5,
                                right: 5,
                                child: Icon(
                                  Icons.favorite_border,
                                  size: 16,
                                  color: Color(0xffF48262),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 2, bottom: 2),
                            color: Hexcolor('#FACAC3'),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  child: Text(
                                    "ADD TO BAG",
                                    style: TextStyle(
                                      fontFamily: "Brandon",
                                      fontWeight: FontWeight.w700,
                                      fontSize: 12,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 10, bottom: 5),
                            // color: Colors.red,
                            child: Column(
                              children: [
                                Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        child: Text(
                                          "Skin Game",
                                          style: TextStyle(
                                            fontFamily: "Yeseva",
                                            fontSize: 13,
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
                                          "Acne Warrior",
                                          style: TextStyle(
                                            fontFamily: "Brandon",
                                            fontSize: 13,
                                            fontWeight: FontWeight.w300,
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
                                          "Rp 100.000",
                                          style: TextStyle(
                                            fontFamily: "Brandon",
                                            fontSize: 13,
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
                                        child: RichText(
                                          text: TextSpan(
                                            children: <TextSpan>[
                                              TextSpan(
                                                text: "Rp 125.000",
                                                style: TextStyle(
                                                  fontFamily: "Brandon",
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.w400,
                                                  decoration: TextDecoration
                                                      .lineThrough,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              TextSpan(
                                                text: "(35%)",
                                                style: TextStyle(
                                                  fontFamily: "Brandon",
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.w400,
                                                  color: Color(0xffF48262),
                                                ),
                                              )
                                            ],
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
                                        child: Icon(
                                          Icons.favorite,
                                          color: Color(0xffF48262),
                                          size: 12,
                                        ),
                                      ),
                                      Container(
                                        child: Icon(
                                          Icons.favorite,
                                          color: Color(0xffF48262),
                                          size: 12,
                                        ),
                                      ),
                                      Container(
                                        child: Icon(
                                          Icons.favorite,
                                          color: Color(0xffF48262),
                                          size: 12,
                                        ),
                                      ),
                                      Container(
                                        child: Icon(
                                          Icons.favorite,
                                          color: Color(0xffF48262),
                                          size: 12,
                                        ),
                                      ),
                                      Container(
                                        child: Icon(
                                          Icons.favorite_border,
                                          color: Color(0xffF48262),
                                          size: 12,
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(left: 2),
                                        child: Text(
                                          "(5)",
                                          style: TextStyle(
                                            fontFamily: "Brandon",
                                            fontWeight: FontWeight.w300,
                                            fontSize: 11,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 6, bottom: 4),
                                  child: LinearPercentIndicator(
                                    lineHeight: 8.0,
                                    percent: 0.7,
                                    progressColor: Color(0xffF48262),
                                  ),
                                ),
                                Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        child: Text(
                                          "Tersisa 19",
                                          style: TextStyle(
                                            fontFamily: "Brandon",
                                            fontSize: 12,
                                            fontWeight: FontWeight.w300,
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
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: new PonnyBottomNavbar(selectedIndex: 1),
    );
  }
}
