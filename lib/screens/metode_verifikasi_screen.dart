import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:ponny/common/constant.dart';
import 'package:ponny/model/App.dart';
import 'package:ponny/model/User.dart';
import 'package:ponny/screens/account_screen.dart';
import 'package:ponny/screens/kode_verifikasi_email_screen.dart';
import 'package:ponny/screens/pra_daftar.dart';
import 'package:ponny/screens/home_screen.dart';
import 'package:ponny/screens/login_otp.dart';
import 'package:keyboard_attachable/keyboard_attachable.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uiblock/uiblock.dart';
import 'package:ponny/util/globalUrl.dart';

class MetodeVerifikasiScreen extends StatefulWidget {
  static const String id = "metode_verifikasi_Screen";
  @override
  _MetodeVerifikasiStateScreen createState() => _MetodeVerifikasiStateScreen();
}

class _MetodeVerifikasiStateScreen extends State<MetodeVerifikasiScreen> {
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
                        Text(
                          'Pilih Metode Verifikasi',
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
                            'Pilih salah satu metode dibawah ini untuk\nmendapatkan kode verifikasi',
                            style: TextStyle(
                              fontFamily: 'Brandon',
                              fontSize: 16,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        InkWell(
                          onTap: (){},
                          child: Container(
                            padding: EdgeInsets.all(10),
                            width: 250,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                width: 1,
                                color: Color(0xffF48262),
                              ),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.phone_android_outlined,
                                  color: Color(0xffF48262),
                                  size: 50,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 15),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'SMS ke',
                                        style: TextStyle(
                                          fontFamily: 'Brandon',
                                          fontWeight: FontWeight.w600,
                                          fontSize: 18,
                                          color: Color(0xffF48262),
                                        ),
                                      ),
                                      Text(
                                        '***-***-*234',
                                        style: TextStyle(
                                          fontFamily: 'Brandon',
                                          fontWeight: FontWeight.w400,
                                          fontSize: 18,
                                          color: Color(0xffF48262),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          height: 10,
                        ),
                        InkWell(
                          onTap: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => KodeVerifikasiEmailScreen(),
                              ),
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.all(10),
                            width: 250,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                width: 1,
                                color: Color(0xffF48262),
                              ),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.mail_outline,
                                  color: Color(0xffF48262),
                                  size: 50,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 15),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'EMAIL ke',
                                        style: TextStyle(
                                          fontFamily: 'Brandon',
                                          fontWeight: FontWeight.w600,
                                          fontSize: 18,
                                          color: Color(0xffF48262),
                                        ),
                                      ),
                                      Text(
                                        'j************@g***.com',
                                        style: TextStyle(
                                          fontFamily: 'Brandon',
                                          fontWeight: FontWeight.w400,
                                          fontSize: 18,
                                          color: Color(0xffF48262),
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
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
