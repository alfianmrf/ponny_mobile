import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:ponny/screens/home_screen.dart';
import 'package:ponny/screens/login.dart';
import 'package:ponny/screens/register.dart';

class PraDaftarScreen extends StatefulWidget {
  static const String id = "pradaftar_Screen";
  @override
  _PraDaftarScreen createState() => _PraDaftarScreen();
}

class _PraDaftarScreen extends State<PraDaftarScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Hexcolor('#FCF8F0'),
      body: Column(
        children: <Widget>[
          Container(
            height: 70.0,
          ),
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: 20.0),
            child: Text(
              'Akun Saya',
              style: TextStyle(
                  fontSize: 30,
                  fontFamily: 'Yeseva',
                  color: Hexcolor('#F48262'),
                  fontWeight: FontWeight.w500,
                  letterSpacing: 1),
            ),
          ),
          Container(
            color: Hexcolor('#F48262'),
            margin: EdgeInsets.only(top: 20),
            height: 2,
          ),
          Container(
            margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  ButtonTheme(
                    buttonColor: Hexcolor('#FCF8F0'),
                    minWidth: 180.0,
                    height: 45.0,
                    child: RaisedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()),
                        );
                      },
                      child: Text(
                        "MASUK",
                        style: TextStyle(
                            fontSize: 18,
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
                    buttonColor: Hexcolor('#F48262'),
                    minWidth: 180.0,
                    height: 45.0,
                    child: RaisedButton(
                      onPressed: () {},
                      child: Text(
                        "DAFTAR",
                        style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'Brandon',
                            fontWeight: FontWeight.w800,
                            letterSpacing: 1,
                            color: Colors.white),
                      ),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                ]),
          ),
          Container(
            height: 50,
          ),
          Container(
            decoration: new BoxDecoration(
              color: Hexcolor('#F48262'),
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 2.0),
            height: 140,
            alignment: Alignment.center,
            // color: Hexcolor('#F48262'),
            width: 220.0,
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 20),
                  alignment: Alignment.center,
                  child: Text(
                    "HAPPY",
                    style: TextStyle(
                      fontSize: 45,
                      fontFamily: "Brandon",
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 0),
                  alignment: Alignment.center,
                  child: Text(
                    "SKIN",
                    style: TextStyle(
                      fontSize: 25,
                      fontFamily: "Yeseva",
                      fontWeight: FontWeight.w300,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 30,
          ),
          Container(
            alignment: Alignment.center,
            child: Column(
              children: <Widget>[
                Text(
                  "Yuk gabung menjadi",
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: "Yeseva",
                  ),
                ),
                Container(
                  height: 8,
                ),
                Text(
                  "HAPPY SKIN REWARD",
                  style: TextStyle(fontSize: 18, fontFamily: 'Yeseva'),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            alignment: Alignment.center,
            child: Column(
              children: <Widget>[
                Text(
                  "Wujudkan impian happy skin dan dapatkan keuntungan",
                  style: TextStyle(fontSize: 12, fontFamily: 'Brandon'),
                ),
                Text("menarik lainnya melalui poin yang bisa kamu dapatkan",
                    style: TextStyle(fontSize: 12, fontFamily: 'Brandon')),
              ],
            ),
          ),
          Container(
            height: 70,
          ),
          Container(
            child: ButtonTheme(
              buttonColor: Hexcolor('#F48262'),
              minWidth: 180.0,
              height: 45.0,
              child: RaisedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RegisterScreen()),
                  );
                },
                child: Text(
                  "MASUK",
                  style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'Brandon',
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1,
                      color: Colors.white),
                ),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
