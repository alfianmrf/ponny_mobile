import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:ponny/screens/Skincare_Screen.dart';
import 'package:ponny/screens/HairAndMakeup_Screen.dart';
import 'package:ponny/screens/Tools_Screen.dart';
import 'package:ponny/screens/Localpride_Screen.dart';
import 'package:ponny/screens/ShopSale_Screen.dart';
import 'package:ponny/screens/Promotion_screen.dart';

import 'SkinConcern_Screen.dart';

class Browse_Category extends StatefulWidget {
  Browse_Category({Key key}) : super(key: key);

  @override
  _Browse_CategoryState createState() => _Browse_CategoryState();
}

class _Browse_CategoryState extends State<Browse_Category> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ButtonTheme(
                  buttonColor: Hexcolor('#FCF8F0'),
                  minWidth: 150.0,
                  height: 150.0,
                  child: RaisedButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Skincare()));
                    },
                    child: Text(
                      "SKINCARE",
                      style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'Brandon',
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1,
                          color: Hexcolor('#F48262')),
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    side: BorderSide(color: Hexcolor('#F48262')),
                  ),
                ),
                ButtonTheme(
                  buttonColor: Hexcolor('#FCF8F0'),
                  minWidth: 150.0,
                  height: 150.0,
                  child: RaisedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HairAndMakeup()));
                    },
                    child: Text(
                      "HAIR & MAKE UP",
                      style: TextStyle(
                          fontSize: 13,
                          fontFamily: 'Brandon',
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1,
                          color: Hexcolor('#F48262')),
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    side: BorderSide(color: Hexcolor('#F48262')),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ButtonTheme(
                  buttonColor: Hexcolor('#FCF8F0'),
                  minWidth: 150.0,
                  height: 150.0,
                  child: RaisedButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Tools()));
                    },
                    child: Text(
                      "TOOLS",
                      style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'Brandon',
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1,
                          color: Hexcolor('#F48262')),
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    side: BorderSide(color: Hexcolor('#F48262')),
                  ),
                ),
                ButtonTheme(
                  buttonColor: Hexcolor('#FCF8F0'),
                  minWidth: 150.0,
                  height: 150.0,
                  child: RaisedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LocalPride()));
                    },
                    child: Text(
                      "LOCAL PRIDE",
                      style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'Brandon',
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1,
                          color: Hexcolor('#F48262')),
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    side: BorderSide(color: Hexcolor('#F48262')),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ButtonTheme(
                  buttonColor: Hexcolor('#FCF8F0'),
                  minWidth: 150.0,
                  height: 150.0,
                  child: RaisedButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => SkinConcern()));
                    },
                    child: Text(
                      "SKIN CONCERN",
                      style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'Brandon',
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1,
                          color: Hexcolor('#F48262')),
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    side: BorderSide(color: Hexcolor('#F48262')),
                  ),
                ),
                ButtonTheme(
                  buttonColor: Hexcolor('#FCF8F0'),
                  minWidth: 150.0,
                  height: 150.0,
                  child: RaisedButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => ShopSale()));
                    },
                    child: Text(
                      "SHOP SALE",
                      style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'Brandon',
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1,
                          color: Hexcolor('#F48262')),
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    side: BorderSide(color: Hexcolor('#F48262')),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10, bottom: 40),
            child: ButtonTheme(
              buttonColor: Hexcolor('#FCF8F0'),
              minWidth: 380.0,
              height: 60.0,
              child: RaisedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PromotionScreen()));
                },
                child: Text(
                  "PROMOTION",
                  style: TextStyle(
                      fontSize: 15,
                      fontFamily: 'Brandon',
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1,
                      color: Hexcolor('#F48262')),
                ),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
                side: BorderSide(color: Hexcolor('#F48262')),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
