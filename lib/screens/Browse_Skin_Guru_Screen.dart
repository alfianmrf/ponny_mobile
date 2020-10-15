import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

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
          Container(margin: EdgeInsets.all(10),
            child: ButtonTheme(
              buttonColor: Hexcolor('#FCF8F0'),
              minWidth: 150.0,
              height: 150.0,
              child: RaisedButton(
                onPressed: () {},
                child: Text(
                  "SKINKLOPEDIA",
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
          ),
          Container(margin: EdgeInsets.all(10),
            child: ButtonTheme(
              buttonColor: Hexcolor('#FCF8F0'),
              minWidth: 150.0,
              height: 150.0,
              child: RaisedButton(
                onPressed: () {},
                child: Text(
                  "SKIN TYPE",
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
          ),
        ]),
        Container(margin: EdgeInsets.all(10),
          child: ButtonTheme(
            buttonColor: Hexcolor('#FCF8F0'),
            minWidth: 380.0,
            height: 180.0,
            child: RaisedButton(
              onPressed: () {},
              child: Image.asset("assets/images/blog.png")
            ),
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
