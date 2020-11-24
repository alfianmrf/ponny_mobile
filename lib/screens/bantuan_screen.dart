import 'package:flutter/material.dart';
import 'package:ponny/common/constant.dart';
import 'package:ponny/model/App.dart';
import 'package:ponny/model/Order.dart';
import 'package:ponny/model/Voucher.dart';
import 'package:ponny/screens/WaitingPage.dart';
import 'package:ponny/screens/konsultasi_screen.dart';
import 'package:ponny/screens/payment_voucher_screen.dart';
import 'package:ponny/util/globalUrl.dart';
import 'package:ponny/widgets/PonnyBottomNavbar.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart' as Launcher;

import 'account/hubungi_kami_screen.dart';

class BantuanScreen extends StatefulWidget {
  static const String id = "bantuan_screen";
  @override
  _BantuanState createState() => _BantuanState();
}

class _BantuanState extends State<BantuanScreen> {

  final VoidCallback onError = null;
  void _launch(String url) async {
    if (await Launcher.canLaunch(url)) {
      await Launcher.launch(url, forceWebView: true,);
    } else {
      if (onError != null) {
        onError();
      }
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFDF8F0),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Container(
                color: Color(0xffF48262),
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 30),
                child: Column(
                  children: [
                    Text(
                      'BUTUH BANTUAN?',
                      style: TextStyle(
                        fontFamily: 'Brandon',
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        letterSpacing: 1,
                      ),
                    ),
                    Text(
                      'Phoebe nggak akan membiarkanmu kebingungan.\nKamu boleh tanya-tanya di sini, kok.',
                      style: TextStyle(
                        fontFamily: 'Brandon',
                        color: Colors.white,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              Container(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 150,
                    height: 120,
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    child: Ink(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(width: 1, color: Color(0xffF48262)),
                      ),
                      child: InkWell(
                        onTap: () => _launch("https://wa.me/6283831450890?text=Halo%20Phoebe's"),
                        borderRadius: BorderRadius.circular(15),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Image.asset(
                              'assets/images/bantuan/hubungi kami.png',
                              width: 60,
                            ),
                            Container(
                              height: 10,
                            ),
                            Text(
                              'HUBUNGI KAMI',
                              style: TextStyle(
                                fontFamily: 'Brandon',
                                color: Color(0xffF48262),
                                fontWeight: FontWeight.w500,
                                fontSize: 18,
                              ),
                            ),
                            Container(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 150,
                    height: 120,
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    child: Ink(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(width: 1, color: Color(0xffF48262)),
                      ),
                      child: InkWell(
                        onTap: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => KonsultasiScreen(),
                            ),
                          );
                        },
                        borderRadius: BorderRadius.circular(15),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Image.asset(
                              'assets/images/bantuan/tanya ahli.png',
                              width: 45,
                            ),
                            Container(
                              height: 10,
                            ),
                            Text(
                              'TANYA AHLI',
                              style: TextStyle(
                                fontFamily: 'Brandon',
                                color: Color(0xffF48262),
                                fontWeight: FontWeight.w500,
                                fontSize: 18,
                              ),
                            ),
                            Container(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: new PonnyBottomNavbar(selectedIndex: 2),
    );
  }

}
