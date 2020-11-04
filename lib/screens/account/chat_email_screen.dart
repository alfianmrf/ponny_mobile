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
import 'package:ponny/widgets/PonnyBottomNavbar.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uiblock/uiblock.dart';
import 'package:ponny/util/globalUrl.dart';

class ChatEmailScreen extends StatefulWidget {
  static const String id = "lupa_password_Screen";
  @override
  _ChatEmailStateScreen createState() => _ChatEmailStateScreen();
}

class _ChatEmailStateScreen extends State<ChatEmailScreen> {
  String dropdownValue;
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
          'Chat via Email',
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
                    Text(
                      'HUBUNGI KAMI',
                      style: TextStyle(
                        fontFamily: 'Brandon',
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 15, bottom: 20),
                      child: Text(
                        'Kami selalu menerima masukanmu dengan senang hati. Agar pesan dan masukanmu tersampaikan ke tim yang tepat, silakan pilih menu dibawah ini. Baca juga FAQ kami yang bisa menjawab pertanyaanmu.',
                        style: TextStyle(
                          fontFamily: 'Brandon',
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    TextFormField(
                      cursorColor: Color(0xffF48262),
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        filled: true,
                        hintText: 'Nama',
                        hintStyle: TextStyle(
                          fontFamily: 'Brandon',
                          color: Color(0xff959799),
                        ),
                        fillColor: Color(0xFFFDF8F0),
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
                    Container(
                      height: 10,
                    ),
                    TextFormField(
                      cursorColor: Color(0xffF48262),
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        filled: true,
                        hintText: 'Email',
                        hintStyle: TextStyle(
                          fontFamily: 'Brandon',
                          color: Color(0xff959799),
                        ),
                        fillColor: Color(0xFFFDF8F0),
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
                    Container(
                      height: 10,
                    ),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(width: 1,color: Color(0xffF48262)),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: ButtonTheme(
                          alignedDropdown: true,
                          child: DropdownButton<String>(
                            value: dropdownValue,
                            isExpanded: true,
                            icon: Icon(Icons.expand_more_rounded, color: Color(0xffF48262)),
                            iconSize: 24,
                            elevation: 16,
                            hint: Text(
                              'Perihal',
                              style: TextStyle(
                                fontFamily: 'Brandon',
                                color: Color(0xff959799),
                                fontSize: 14,
                              ),
                            ),
                            style: TextStyle(
                              fontFamily: 'Brandon',
                              color: Colors.black,
                              fontSize: 14,
                            ),
                            onChanged: (String newValue) {
                              setState(() {
                                dropdownValue = newValue;
                              });
                            },
                            items: <String>['Komplain', 'Pengembalian Barang', 'Pengembalian Dana', 'Lainnya']
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 10,
                    ),
                    TextField(
                      maxLines: 8,
                      cursorColor: Color(0xffF48262),
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                        filled: true,
                        hintText: 'Pesan',
                        hintStyle: TextStyle(
                          fontFamily: 'Brandon',
                          color: Color(0xff959799),
                        ),
                        fillColor: Color(0xFFFDF8F0),
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
                    Center(
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 25),
                        child: ButtonTheme(
                          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 70),
                          child: FlatButton(
                            onPressed: (){},
                            color: Color(0xffF48262),
                            child: Text(
                              "KIRIM",
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
