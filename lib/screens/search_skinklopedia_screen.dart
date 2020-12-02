import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:ponny/common/constant.dart';
import 'package:ponny/model/App.dart';
import 'package:ponny/model/Cart.dart';
import 'package:ponny/model/ItemSkinklopedia.dart';
import 'package:ponny/model/Product.dart';
import 'package:ponny/model/WishProduct.dart';
import 'package:ponny/screens/Skinklopedia_Screen.dart';
import 'package:ponny/screens/home_screen.dart';
import 'package:ponny/screens/account_screen.dart';
import 'package:ponny/screens/account/daftar_keinginan_sukses_screen.dart';
import 'package:ponny/util/globalUrl.dart';
import 'package:ponny/widgets/PonnyBottomNavbar.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:uiblock/uiblock.dart';

class SearchSkinklopediaScreen extends StatefulWidget {
  static const String id = "search_skinklopedia_Screen";
  String q;
  SearchSkinklopediaScreen({this.q});
  @override
  _SearchSkinklopediaStateScreen createState() => _SearchSkinklopediaStateScreen();
}

class _SearchSkinklopediaStateScreen extends State<SearchSkinklopediaScreen>{
  List<ItemSkinklopedia> result;
  bool loading=true;
  final _search = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      setState(() {
        _search.text = widget.q;
      });
      _searchData();

    });
  }
  void _searchData(){
    if(_search.text.isNotEmpty){
      setState(() {
        loading =true;
      });
      var param={
        "q":_search.value.text
      };
      Provider.of<AppModel>(context).searchSkinklopedia(param).then((value){
        setState(() {
          result = value;
          loading =false;
        });
      });
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0.0,
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            color: Color(0xffF48262),
          ),
        ),
        title: Text(
          'SKINKLOPEDIA',
          style: TextStyle(
            fontSize: 24,
            fontFamily: 'Yeseva',
            color: Hexcolor('#F48262'),
          ),
        ),
        bottom: PreferredSize(
            child: Container(
              color: Color(0xffF48262),
              height: 1.0,
            ),
            preferredSize: Size.fromHeight(1.0)),
      ),
      resizeToAvoidBottomInset: false,
      backgroundColor: Hexcolor('#FCF8F0'),
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Colors.white),
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            margin: EdgeInsets.all(15),
            child: Row(children: [
              Icon(Icons.search, color: Color(0xffF48262)),
              Expanded(
                  child: TextField(
                    controller: _search,
                    onSubmitted: (String q){
                      FocusScope.of(context).requestFocus(new FocusNode());
                      setState(() {
                        loading=true;
                      });
                      _searchData();
                    },
                    cursorColor: Colors.black,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.go,
                    decoration:
                    new InputDecoration.collapsed(),
                  )),
              InkWell(
                onTap: (){
                  Navigator.pushNamedAndRemoveUntil(
                      context,
                      Skinklopedia.id,(_) => false
                  );
                },
                child: Icon(Icons.close, color: Color(0xffF48262)),
              ),
            ]),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: loading ?  Container(
                child: Center(
                  child: LoadingWidgetFadingCircle(context),
                ),
              ) : Column(
                children: [
                  Container(
                    width: double.infinity,
                    color: Color(0xffFBDFD2),
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                    child: Text(
                      'Hasil Pencarian Terbanyak',
                      style: TextStyle(
                          fontFamily: 'Brandon',
                          fontSize: 15
                      ),
                    ),
                  ),
                  for(ItemSkinklopedia item in result)
                  InkWell(
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                      child: Text(
                        item.title,
                        style: TextStyle(
                          fontFamily: 'Brandon',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: new PonnyBottomNavbar(selectedIndex: 0),
    );
  }
}
