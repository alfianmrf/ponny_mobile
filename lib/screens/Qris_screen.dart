import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
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
import 'package:url_launcher/url_launcher.dart' as Launcher;
import 'package:ponny/util/globalUrl.dart';
import 'package:webview_flutter/webview_flutter.dart';

class QrisScreen extends StatefulWidget {
  static const String id = "qris_view_Screen";
  @required String title;
  @required String urlQR;
  QrisScreen({this.urlQR,this.title});

  @override
  _QrisStateScreen createState() => _QrisStateScreen();
}

class _QrisStateScreen extends State<QrisScreen> {

  @override
  Widget build(BuildContext context) {
    InAppWebViewController webView;

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
          widget.title,
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
      body:Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                child: Text("Pembayaran melaui "+widget.title,
                style: TextStyle(
                  fontSize: 23,
                  fontFamily: 'Yeseva',
                ),
                ),

              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 20),
                width: MediaQuery.of(context).size.width *.6,
                height: MediaQuery.of(context).size.width *.6,
                child: Image.network(widget.urlQR,
                  fit: BoxFit.fill,
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width *.8,
                child: Text("Buka aplikasi yang mendukukung pemabayara QRIS seperti GO-JEK,Link Aja, OVO. Scan QR yang tertera di layar lalu konfirmasi pembelian kamu",
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'Yeseva',
                  ),
                  textAlign: TextAlign.center,
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: new PonnyBottomNavbar(selectedIndex: 4),
    );
  }
}


