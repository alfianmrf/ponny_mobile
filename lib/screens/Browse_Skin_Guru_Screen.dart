import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:ponny/screens/Blog_screen.dart';
import 'package:ponny/screens/Skinklopedia_Screen.dart';
import 'package:ponny/screens/skin_type_screen.dart';

class Browse_Skin_Guru extends StatefulWidget {
  Browse_Skin_Guru({Key key}) : super(key: key);

  @override
  _Browse_Skin_GuruState createState() => _Browse_Skin_GuruState();
}

class _Browse_Skin_GuruState extends State<Browse_Skin_Guru> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          Container(
            margin: EdgeInsets.all(10),
            child: ButtonTheme(
              buttonColor: Hexcolor('#FCF8F0'),
              minWidth: 150.0,
              height: 150.0,
              child: RaisedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Skinklopedia()));
                },
                color: Colors.white,
                child: Column(
                  children: [
                    Image.asset("assets/images/bb-skinklopedia.png", width: 80,),
                    Container(height: 10,),
                    Text(
                      "SKINKLOPEDIA",
                      style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'Brandon',
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1,
                          color: Hexcolor('#F48262')),
                    ),
                  ],
                ),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
                side: BorderSide(color: Hexcolor('#F48262')),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: ButtonTheme(
              buttonColor: Hexcolor('#FCF8F0'),
              minWidth: 150.0,
              height: 150.0,
              child: RaisedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SkinTypeScreen()));
                },
                color: Colors.white,
                child: Column(
                  children: [
                    Image.asset("assets/images/bb-jenis kulit.png", width: 80,),
                    Container(height: 10,),
                    Text(
                      "JENIS KULIT",
                      style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'Brandon',
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1,
                          color: Hexcolor('#F48262')),
                    ),
                  ],
                ),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
                side: BorderSide(color: Hexcolor('#F48262')),
              ),
            ),
          ),
        ]),
        Container(
          margin: EdgeInsets.all(10),
          child: ButtonTheme(
            buttonColor: Hexcolor('#FCF8F0'),
            minWidth: 380.0,
            height: 150.0,
            child: RaisedButton( 
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Blog(category: 0,tag: "ALL",)));
                },
                color: Colors.white,
                child: Container(padding: EdgeInsets.symmetric(horizontal: 50), child: Image.asset("assets/images/blogTitle.png"))),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
              side: BorderSide(color: Hexcolor('#F48262')),
            ),
          ),
        ),
      ]),
    );
  }
}
