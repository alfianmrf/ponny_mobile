import 'dart:io';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:ponny/screens/Affiliate_CairkanDana_screen.dart';
import 'package:ponny/util/globalUrl.dart';
import 'package:ponny/widgets/PonnyBottomNavbar.dart';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ponny/common/constant.dart';

class AboutRefund extends StatefulWidget {
  @override
  String img;
  AboutRefund(this.img);
  _AboutRefundState createState() => _AboutRefundState();
}

String konten;

class _AboutRefundState extends State<AboutRefund> {
  @override
  void initState() {
    super.initState();
    getContent();
  }

  Future<void> getContent() async {
    final res = await http.get(affiliateAbout,
        headers: {HttpHeaders.contentTypeHeader: 'application/json'});

    if (res.statusCode == 200) {
      final responeJson = json.decode(res.body);
      setState(() {
        konten = responeJson["content"];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Hexcolor('#FCF8F0'),
        appBar: AppBar(
          elevation: 0,
          titleSpacing: 0,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Color(0xffF48262),
              size: 26,
            ),
          ),
          title: Text(
            'PENCAIRAN DANA',
            style: TextStyle(
              fontSize: 24,
              fontFamily: "Yeseva",
              fontWeight: FontWeight.w500,
              color: Color(0xffF48262),
            ),
          ),
          bottom: PreferredSize(
              child: Container(
                color: Color(0xffF48262),
                height: 1.0,
              ),
              preferredSize: Size.fromHeight(1.0)),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                  width: size.width,
                  height: 226,
                  decoration: BoxDecoration(color: Hexcolor('#FCF8F0')),
                  child: Stack(
                    children: [
                      Container(
                        width: size.width,
                        height: 180,
                        color: Hexcolor('#FCF8F0'),
                        child: CachedNetworkImage(
                          imageUrl: "$img_url${widget.img}",
                          placeholder: (context, url) =>
                              LoadingWidgetPulse(context),
                          errorWidget: (context, url, error) =>
                              Image.asset('assets/images/basic.jpg'),
                          fit: BoxFit.fill,
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        left: 0,
                        child: Container(
                          padding: EdgeInsets.all(20),
                          margin: EdgeInsets.symmetric(
                              horizontal: size.width * 0.05),
                          width: size.width,
                          decoration: BoxDecoration(
                              color: Hexcolor('#FCF8F0'),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          child: Column(
                            children: [
                              Text(
                                "INFORMASI LENGKAP MENGENAI PENCAIRAN DANA",
                                style: TextStyle(
                                  fontFamily: "Yeseva",
                                  fontSize: 19,
                                  fontWeight: FontWeight.w600,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )),
              Container(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  width: double.infinity,
                  child: Text(konten))
            ],
          ),
        ),
        bottomNavigationBar: new PonnyBottomNavbar(selectedIndex: 4));
  }
}
