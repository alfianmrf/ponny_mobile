import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:ponny/common/constant.dart';
import 'package:ponny/model/App.dart';
import 'package:ponny/model/User.dart';
import 'package:ponny/screens/account_screen.dart';
import 'package:ponny/screens/metode_verifikasi_screen.dart';
import 'package:ponny/screens/pra_daftar.dart';
import 'package:ponny/screens/home_screen.dart';
import 'package:ponny/screens/login_otp.dart';
import 'package:keyboard_attachable/keyboard_attachable.dart';
import 'package:http/http.dart' as http;
import 'package:ponny/widgets/PonnyBottomNavbar.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uiblock/uiblock.dart';
import 'package:ponny/util/globalUrl.dart';

enum BeliProduk { beli, tidak }

class ReviewScreen extends StatefulWidget {
  static const String id = "review_Screen";
  @override
  _ReviewStateScreen createState() => _ReviewStateScreen();
}

class _ReviewStateScreen extends State<ReviewScreen> {
  BeliProduk _status;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0.0,
        elevation: 0.0,
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            color: Color(0xffF48262),
          ),
        ),
        title: Text(
          'Review',
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
            preferredSize: Size.fromHeight(1.0)
        ),
      ),
      resizeToAvoidBottomInset: false,
      backgroundColor: Hexcolor('#FCF8F0'),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    IntrinsicHeight(
                      child: Row(
                        children: [
                          Image.asset(
                            'assets/images/produk.png',
                            width: 80,
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'AERIS',
                                  style: TextStyle(
                                    fontFamily: 'Yeseva',
                                    fontSize: 20,
                                  ),
                                ),
                                Text(
                                  'Sister Blendie',
                                  style: TextStyle(
                                    fontFamily: 'Brandon',
                                    fontSize: 20,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: 20),
                                      margin: EdgeInsets.only(right: 10),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(width: 1, color: Color(0xffF48262))
                                      ),
                                      child: Text(
                                        '60 ml',
                                        style: TextStyle(fontFamily: 'Brandon',fontSize: 12),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: 20),
                                      margin: EdgeInsets.only(right: 10),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(5),
                                          color: Color(0xffF48262),
                                          border: Border.all(width: 1, color: Color(0xffF48262))
                                      ),
                                      child: Text(
                                        '100 ml',
                                        style: TextStyle(fontFamily: 'Brandon',fontSize: 12,color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      child: Text(
                        'Nilai produk ini',
                        style: TextStyle(
                          fontFamily: 'Brandon',
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Container(
                              padding: EdgeInsets.only(right: 7.5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Kemasan',
                                    style: TextStyle(fontFamily: 'Brandon',fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    'Buka produk ini ribet nggak, sih?',
                                    style: TextStyle(fontFamily: 'Brandon'),
                                  ),
                                  RatingBar(
                                    initialRating: 0,
                                    minRating: 1,
                                    direction: Axis.horizontal,
                                    allowHalfRating: false,
                                    itemCount: 5,
                                    itemSize: 18.0,
                                    itemPadding: EdgeInsets.only(right: 3, top: 3),
                                    itemBuilder: (context, index) => Icon(
                                      Icons.favorite,
                                      color: Color(0xffF48262),
                                    ),
                                    unratedColor: Color(0xffFBD2CD),
                                    onRatingUpdate: (rating) {
                                      print(rating);
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              padding: EdgeInsets.only(left: 7.5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Kegunaan',
                                    style: TextStyle(fontFamily: 'Brandon',fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    'Produk ini bekerja optimal nggak?',
                                    style: TextStyle(fontFamily: 'Brandon'),
                                  ),
                                  RatingBar(
                                    initialRating: 0,
                                    minRating: 1,
                                    direction: Axis.horizontal,
                                    allowHalfRating: false,
                                    itemCount: 5,
                                    itemSize: 18.0,
                                    itemPadding: EdgeInsets.only(right: 3, top: 3),
                                    itemBuilder: (context, index) => Icon(
                                      Icons.favorite,
                                      color: Color(0xffF48262),
                                    ),
                                    unratedColor: Color(0xffFBD2CD),
                                    onRatingUpdate: (rating) {
                                      print(rating);
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Container(
                              padding: EdgeInsets.only(right: 7.5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Efektif',
                                    style: TextStyle(fontFamily: 'Brandon',fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    'Apa kamu dapat hasil yang cocok dengan kulitmu?',
                                    style: TextStyle(fontFamily: 'Brandon'),
                                  ),
                                  RatingBar(
                                    initialRating: 0,
                                    minRating: 1,
                                    direction: Axis.horizontal,
                                    allowHalfRating: false,
                                    itemCount: 5,
                                    itemSize: 18.0,
                                    itemPadding: EdgeInsets.only(right: 3, top: 3),
                                    itemBuilder: (context, index) => Icon(
                                      Icons.favorite,
                                      color: Color(0xffF48262),
                                    ),
                                    unratedColor: Color(0xffFBD2CD),
                                    onRatingUpdate: (rating) {
                                      print(rating);
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              padding: EdgeInsets.only(left: 7.5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Harga',
                                    style: TextStyle(fontFamily: 'Brandon',fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    'Sesuai dengan kualitasnya, harga produk ini...',
                                    style: TextStyle(fontFamily: 'Brandon'),
                                  ),
                                  RatingBar(
                                    initialRating: 0,
                                    minRating: 1,
                                    direction: Axis.horizontal,
                                    allowHalfRating: false,
                                    itemCount: 5,
                                    itemSize: 18.0,
                                    itemPadding: EdgeInsets.only(right: 3, top: 3),
                                    itemBuilder: (context, index) => Icon(
                                      Icons.favorite,
                                      color: Color(0xffF48262),
                                    ),
                                    unratedColor: Color(0xffFBD2CD),
                                    onRatingUpdate: (rating) {
                                      print(rating);
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20, bottom: 5),
                      child: Text(
                        'Review',
                        style: TextStyle(
                          fontFamily: 'Brandon',
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    TextField(
                      maxLines: 6,
                      cursorColor: Color(0xffF48262),
                      keyboardType: TextInputType.multiline,
                      style: TextStyle(
                        fontFamily: 'Brandon',
                        fontSize: 12,
                      ),
                      decoration: InputDecoration(
                        filled: true,
                        hintText: 'Tulis review kamu',
                        hintStyle: TextStyle(
                          fontFamily: 'Brandon',
                          fontSize: 12,
                        ),
                        fillColor: Color(0xFFFDEDE3),
                        isDense: true,
                        contentPadding: EdgeInsets.symmetric(horizontal: 17, vertical: 10),
                        labelStyle: TextStyle(color: Colors.black),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: BorderSide(
                            color: Hexcolor('#F48262'),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: BorderSide(
                            color: Hexcolor('#F48262'),
                            width: 1.0,
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        'Minimum 50 karakter',
                        style: TextStyle(
                          fontFamily: 'Brandon',
                          fontSize: 12,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20, bottom: 5),
                      child: RichText(
                        text: TextSpan(
                          text: 'Upload Foto ',
                          style: TextStyle(
                            fontFamily: 'Brandon',
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                          children: [
                            TextSpan(
                              text: '(max. 5MB)',
                              style: TextStyle(
                                fontFamily: 'Brandon',
                                fontSize: 12,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ]
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            Container(
                              width: 100,
                              height: 140,
                              margin: EdgeInsets.only(right: 20),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.blue,
                              ),
                              child: Stack(
                                fit: StackFit.expand,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(5),
                                    child: Image.asset(
                                      'assets/images/produk.png',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(5.0),
                                    child: Align(
                                      alignment: Alignment.topRight,
                                      child: Transform.rotate(
                                        angle: 45 * pi / 180,
                                        child: Icon(
                                          Icons.add_circle,
                                          color: Color(0xffF48262),
                                          size: 20,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: 100,
                              height: 140,
                              decoration: BoxDecoration(
                                color: Color(0xFFFDEDE3),
                                border: Border.all(width: 1,color: Color(0xffF48262)),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.add,
                                  color: Colors.black,
                                  size: 40,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        'Apa kamu akan merekomendasikan produk ini?',
                        style: TextStyle(fontFamily: 'Brandon'),
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(bottom: 15, right: 10),
                          child: ButtonTheme(
                            child: FlatButton(
                              onPressed: (){},
                              height: 24,
                              minWidth: 100,
                              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              color: Color(0xffF48262),
                              child: Text(
                                "YA",
                                style: TextStyle(
                                  fontFamily: 'Brandon',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  color: Colors.white),
                              ),
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 15),
                          child: ButtonTheme(
                            child: FlatButton(
                              onPressed: (){},
                              height: 24,
                              minWidth: 100,
                              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              color: Color(0xffF48262),
                              child: Text(
                                "TIDAK",
                                style: TextStyle(
                                    fontFamily: 'Brandon',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
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
                    Row(
                      children: [
                        Theme(
                          data: Theme.of(context).copyWith(
                            unselectedWidgetColor: Color(0xffF48262),
                          ),
                          child: Radio(
                            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            value: BeliProduk.beli,
                            groupValue: _status,
                            activeColor: Color(0xffF48262),
                            onChanged: (BeliProduk value) {
                              setState(() {
                                _status = value;
                              });
                            },
                          ),
                        ),
                        Expanded(
                          child: Text(
                            'Ya, Saya membeli produk ini di Ponny Beaute',
                            style: TextStyle(
                              fontFamily: 'Brandon',
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Theme(
                          data: Theme.of(context).copyWith(
                            unselectedWidgetColor: Color(0xffF48262),
                          ),
                          child: Radio(
                            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            value: BeliProduk.tidak,
                            groupValue: _status,
                            activeColor: Color(0xffF48262),
                            onChanged: (BeliProduk value) {
                              setState(() {
                                _status = value;
                              });
                            },
                          ),
                        ),
                        Expanded(
                          child: Text(
                            'Tidak, saya tidak membeli produk ini di Ponny Beaute',
                            style: TextStyle(
                              fontFamily: 'Brandon',
                            ),
                          ),
                        ),
                      ],
                    ),
                    Center(
                      child: Container(
                        width: double.infinity,
                        margin: EdgeInsets.symmetric(vertical: 25),
                        child: ButtonTheme(
                          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 70),
                          child: FlatButton(
                            onPressed: (){},
                            color: Color(0xffF48262),
                            child: Text(
                              "SAVE",
                              style: TextStyle(
                                  fontSize: 16,
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
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: new PonnyBottomNavbar(selectedIndex: 4),
    );
  }
}
