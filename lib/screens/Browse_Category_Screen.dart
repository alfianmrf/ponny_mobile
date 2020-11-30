import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:lodash_dart/lodash_dart.dart';
import 'package:ponny/common/constant.dart';
import 'package:ponny/model/Category.dart';
import 'package:ponny/screens/Skincare_Screen.dart';
import 'package:ponny/screens/HairAndMakeup_Screen.dart';
import 'package:ponny/screens/Tools_Screen.dart';
import 'package:ponny/screens/Localpride_Screen.dart';
import 'package:ponny/screens/ShopSale_Screen.dart';
import 'package:ponny/screens/Promotion_screen.dart';
import 'package:http/http.dart' as http;
import 'package:ponny/util/globalUrl.dart';

import 'SkinConcern_Screen.dart';

class Browse_Category extends StatefulWidget {
  Browse_Category({Key key}) : super(key: key);

  @override
  _Browse_CategoryState createState() => _Browse_CategoryState();
}

class _Browse_CategoryState extends State<Browse_Category> {

  Future<List<Category>> getCategory() async {
    List<Category> categoris = List<Category>();
    final res = await http.get(categoryList);
    if(res.statusCode == 200){
      final responejson = json.decode(res.body);
      responejson.forEach((v) {
        categoris.add(new Category.fromJson(v));
      });
    }
    return categoris;
  }

  List<Widget> getViewCategory(List<dynamic> data){
    List<Widget> _tmp =[];
    for(List<Category> item in data){
      if(item.length == 2){
        _tmp.add(
          Container(
            margin: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: item.map((e) => ButtonTheme(
                buttonColor: Hexcolor('#FCF8F0'),
                minWidth: 150.0,
                height: 150.0,
                child: RaisedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Skincare(category: e,)));
                  },
                  child: Text(
                    e.name,
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
              )).toList()
            ),
          ),
        );
      }else{
        _tmp.add(Container(
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
                    item[0].name,
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
        ));

      }
    }
    if(data[data.length-1].length == 2){
      _tmp.add(Container(
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
                      MaterialPageRoute(builder: (context) => LocalPride()));
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
            ButtonTheme(
              buttonColor: Hexcolor('#FCF8F0'),
              minWidth: 150.0,
              height: 150.0,
              child: RaisedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ShopSale()));
                },
                child: Text(
                  "SHOP SALE",
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
      ));
    }else{
      _tmp.add(Container(
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
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ShopSale()));
                },
                child: Text(
                  "SHOP SALE",
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
            Container(
              width: 150.0,
              height: 150.0,
              child: Container(
                child: Container(),
              ),
            ),
          ],
        ),
      ));
    }

    _tmp.add(
      Container(
        margin: EdgeInsets.only(top: 10, bottom: 40, left: 15, right: 15),
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
      )
    );
    return _tmp;

  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: FutureBuilder<List<Category>>(
        future: getCategory(),
        builder: (BuildContext context, AsyncSnapshot<List<Category>> snapshot){
         if(snapshot.hasData){
           return Column(
             children: getViewCategory(Lodash().chunk(array: snapshot.data, size: 2).toList()),
           );
         }else{
           return Container(
             height: MediaQuery.of(context).size.height*.5,
             child: Center(
               child: LoadingWidgetFadingCircle(context),
             ),
           );
         }
        })

    );
  }
}
