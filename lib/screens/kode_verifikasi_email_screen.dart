import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:ponny/common/constant.dart';
import 'package:ponny/model/App.dart';
import 'package:ponny/model/User.dart';
import 'package:ponny/screens/account_screen.dart';
import 'package:ponny/screens/pra_daftar.dart';
import 'package:ponny/screens/home_screen.dart';
import 'package:ponny/screens/login_otp.dart';
import 'package:keyboard_attachable/keyboard_attachable.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uiblock/uiblock.dart';
import 'package:ponny/util/globalUrl.dart';

class KodeVerifikasiEmailScreen extends StatefulWidget {
  static const String id = "kode_verifikasi_email_Screen";
  @override
  _KodeVerifikasiEmailStateScreen createState() => _KodeVerifikasiEmailStateScreen();
}

class _KodeVerifikasiEmailStateScreen extends State<KodeVerifikasiEmailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0.0,
        title: Text(
          'Atur ulang kata sandi',
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
                margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 40.0),
                child: Form(
                  child: Center(
                    child: Column(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(bottom: 10),
                          child: Icon(
                            Icons.mail_outline,
                            color: Color(0xffF48262),
                            size: 50,
                          ),
                        ),
                        Text(
                          'Masukkan Kode Verifikasi',
                          style: TextStyle(
                            fontFamily: 'Brandon',
                            fontSize: 22,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 25),
                          child: Text(
                            'Kode verifikasi telah dikirim melalui email ke\nj************@g***.com',
                            style: TextStyle(
                              fontFamily: 'Brandon',
                              fontSize: 16,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Container(
                          width: 350,
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Container(
                                  margin: EdgeInsets.only(top: 5, bottom: 40),
                                  padding: EdgeInsets.symmetric(horizontal: 5),
                                  child: TextFormField(
                                    cursorColor: Colors.white,
                                    keyboardType: TextInputType.number,
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                    textAlign: TextAlign.center,
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(1),
                                    ],
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Color(0xffF48262),
                                      isDense: true,
                                      contentPadding: EdgeInsets.all(10),
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
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Container(
                                  margin: EdgeInsets.only(top: 5, bottom: 40),
                                  padding: EdgeInsets.symmetric(horizontal: 5),
                                  child: TextFormField(
                                    cursorColor: Colors.white,
                                    keyboardType: TextInputType.number,
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                    textAlign: TextAlign.center,
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(1),
                                    ],
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Color(0xffF48262),
                                      isDense: true,
                                      contentPadding: EdgeInsets.all(10),
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
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Container(
                                  margin: EdgeInsets.only(top: 5, bottom: 40),
                                  padding: EdgeInsets.symmetric(horizontal: 5),
                                  child: TextFormField(
                                    cursorColor: Colors.white,
                                    keyboardType: TextInputType.number,
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                    textAlign: TextAlign.center,
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(1),
                                    ],
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Color(0xffF48262),
                                      isDense: true,
                                      contentPadding: EdgeInsets.all(10),
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
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Container(
                                  margin: EdgeInsets.only(top: 5, bottom: 40),
                                  padding: EdgeInsets.symmetric(horizontal: 5),
                                  child: TextFormField(
                                    cursorColor: Colors.white,
                                    keyboardType: TextInputType.number,
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                    textAlign: TextAlign.center,
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(1),
                                    ],
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Color(0xffF48262),
                                      isDense: true,
                                      contentPadding: EdgeInsets.all(10),
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
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Container(
                                  margin: EdgeInsets.only(top: 5, bottom: 40),
                                  padding: EdgeInsets.symmetric(horizontal: 5),
                                  child: TextFormField(
                                    cursorColor: Colors.white,
                                    keyboardType: TextInputType.number,
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                    textAlign: TextAlign.center,
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(1),
                                    ],
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Color(0xffF48262),
                                      isDense: true,
                                      contentPadding: EdgeInsets.all(10),
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
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Container(
                                  margin: EdgeInsets.only(top: 5, bottom: 40),
                                  padding: EdgeInsets.symmetric(horizontal: 5),
                                  child: TextFormField(
                                    cursorColor: Colors.white,
                                    keyboardType: TextInputType.number,
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                    textAlign: TextAlign.center,
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(1),
                                    ],
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Color(0xffF48262),
                                      isDense: true,
                                      contentPadding: EdgeInsets.all(10),
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
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 30, bottom: 20),
                          child: ButtonTheme(
                            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 70),
                            child: FlatButton(
                              onPressed: (){},
                              color: Color(0xffF48262),
                              child: Text(
                                "VERIFIKASI",
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
                        RichText(
                          text: TextSpan(
                            text: 'Tunggu dalam ',
                            style: TextStyle(fontFamily: 'Brandon', fontSize: 16, color: Color(0xff57585B)),
                            children: <TextSpan>[
                              TextSpan(text: '15 detik', style: TextStyle(fontWeight: FontWeight.bold)),
                              TextSpan(text: '\nsebelum kirim ulang'),
                            ],
                          ),
                          textAlign: TextAlign.center,
                        ),
                        GestureDetector(
                          onTap: (){},
                          child: Text(
                            'Kirim ulang kode',
                            style: TextStyle(fontFamily: 'Brandon', fontSize: 16, color: Color(0xffF48262), decoration: TextDecoration.underline),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
