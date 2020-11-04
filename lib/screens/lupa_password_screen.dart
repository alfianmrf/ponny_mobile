import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uiblock/uiblock.dart';
import 'package:ponny/util/globalUrl.dart';

class LupaPasswordScreen extends StatefulWidget {
  static const String id = "lupa_password_Screen";
  @override
  _LupaPasswordStateScreen createState() => _LupaPasswordStateScreen();
}

class _LupaPasswordStateScreen extends State<LupaPasswordScreen> {
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(top: 25, bottom: 10),
                        child: Text(
                          'Masukkan email yang terdaftar. Tim Phoebe akan mengirimkan kode verifikasi untuk atur ulang kata sandi',
                          style: TextStyle(
                            fontFamily: 'Brandon',
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Text(
                        'Nomor Ponsel atau Email',
                        style: TextStyle(
                          fontFamily: 'Brandon',
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 5, bottom: 40),
                        child: TextFormField(
                          cursorColor: Color(0xffF48262),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            isDense: true,
                            contentPadding: EdgeInsets.all(15),
                            labelStyle: TextStyle(color: Colors.black),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide: BorderSide(
                                color: Hexcolor('#F48262'),
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: BorderSide(
                                color: Hexcolor('#F48262'),
                                width: 1.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Center(
                        child: ButtonTheme(
                          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 70),
                          child: FlatButton(
                            onPressed: (){
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MetodeVerifikasiScreen(),
                                ),
                              );
                            },
                            color: Color(0xffF48262),
                            child: Text(
                              "LANJUT",
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
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
