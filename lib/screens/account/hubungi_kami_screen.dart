import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:ponny/common/constant.dart';
import 'package:ponny/model/App.dart';
import 'package:ponny/model/User.dart';
import 'package:ponny/screens/account/chat_email_screen.dart';
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

class HubungiKamiScreen extends StatefulWidget {
  static const String id = "hubungi_kami_Screen";
  @override
  _HubungiKamiStateScreen createState() => _HubungiKamiStateScreen();
}

class _HubungiKamiStateScreen extends State<HubungiKamiScreen> {
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
          'Hubungi Kami',
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
                      'Halo, Teman Phoebe',
                      style: TextStyle(
                        fontFamily: 'Yeseva',
                        fontSize: 20,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 25, bottom: 20),
                      child: Text(
                        'Kami selalu menerima masukanmu dengan senang hati. Agar pesan dan masukanmu tersampaikan ke tim yang tepat, silakan pilih menu dibawah ini. Baca juga FAQ kami yang bisa menjawab pertanyaanmu.',
                        style: TextStyle(
                          fontFamily: 'Brandon',
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    Text(
                      'Phoebe punya tiga solusi nih buat teman Phoebe:',
                      style: TextStyle(
                        fontFamily: 'Brandon',
                        fontSize: 16,
                      ),
                    ),
                    Container(
                      height: 15,
                    ),
                    InkWell(
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChatEmailScreen(),
                          ),
                        );
                      },
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: Border.all(width: 1,color: Color(0xffF48262)),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                        child: Text(
                          'Chat via Email',
                          style: TextStyle(
                            fontFamily: 'Brandon',
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 10,
                    ),
                    InkWell(
                      onTap: (){},
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: Border.all(width: 1,color: Color(0xffF48262)),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                        child: Text(
                          'Chat via Whatsapp',
                          style: TextStyle(
                            fontFamily: 'Brandon',
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 10,
                    ),
                    InkWell(
                      onTap: (){},
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: Border.all(width: 1,color: Color(0xffF48262)),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                        child: Text(
                          'Video call dengan Phoebe Advisor',
                          style: TextStyle(
                            fontFamily: 'Brandon',
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 30),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Ink(
                        color: Color(0xffFEEDE5),
                        child: InkWell(
                          onTap: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ChatEmailScreen(),
                              ),
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 25),
                            child: Column(
                              children: [
                                Image.asset(
                                  'assets/images/contact/email.png',
                                  height: 25,
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 10),
                                  child: Text(
                                    'CHAT VIA EMAIL',
                                    style: TextStyle(
                                      fontFamily: 'Brandon',
                                      color: Color(0xffF48262),
                                      fontSize: 11,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Ink(
                        color: Color(0xffFEEDE5),
                        child: InkWell(
                          onTap: (){},
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 25),
                            child: Column(
                              children: [
                                Image.asset(
                                  'assets/images/contact/wa.png',
                                  height: 25,
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 10),
                                  child: Text(
                                    'CHAT VIA WHATSAPP',
                                    style: TextStyle(
                                      fontFamily: 'Brandon',
                                      color: Color(0xffF48262),
                                      fontSize: 11,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Ink(
                        color: Color(0xffFEEDE5),
                        child: InkWell(
                          onTap: (){},
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 25),
                            child: Column(
                              children: [
                                Image.asset(
                                  'assets/images/contact/vc.png',
                                  height: 25,
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 10),
                                  child: Text(
                                    'VIDEO CALL',
                                    style: TextStyle(
                                      fontFamily: 'Brandon',
                                      color: Color(0xffF48262),
                                      fontSize: 11,
                                    ),
                                  ),
                                ),
                              ],
                            ),
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
