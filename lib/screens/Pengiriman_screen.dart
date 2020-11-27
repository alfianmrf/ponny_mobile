import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:ponny/model/App.dart';
import 'package:ponny/model/FaqHeader.dart';
import 'package:ponny/screens/Keuntungan_HappyReward_screen.dart';
import 'package:ponny/widgets/PonnyBottomNavbar.dart';
import 'package:provider/provider.dart';

class PengirimanScreen extends StatefulWidget {
  static const String id = "Pengiriman_screen";

  @override
  _PengirimanScreenState createState() => _PengirimanScreenState();
}

class _PengirimanScreenState extends State<PengirimanScreen> {
  @override
  Widget build(BuildContext context) {
    final faq = Provider.of<AppModel>(context,listen: false).listFaq.firstWhere((element) => element.id == 3);
    return SafeArea(
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Hexcolor('#FCF8F0'),
          body: Column(
            children: [
              Container(
                margin: EdgeInsets.all(5),
                child: Row(
                  children: [
                    Container(
                      child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.arrow_back_ios,
                            color: Color(0xffF48262),
                            size: 26,
                          )),
                    ),
                    Container(
                      child: Text(
                        "Pengiriman",
                        style: TextStyle(
                          fontSize: 24,
                          fontFamily: "Yeseva",
                          fontWeight: FontWeight.w500,
                          color: Color(0xffF48262),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 1,
                color: Color(0xffF48262),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(children: [
                    Container(
                      margin: EdgeInsets.only(
                        top: 20,
                      ),
                      child: Text(
                        "GRATIS ONGKOS KIRIM JABODETABEK",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: 'Brandon',
                            fontSize: 22,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(top: 30, right: 20, left: 20),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: Color(0xffF48262),
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Container(
                        margin: EdgeInsets.only(top: 10, bottom: 20),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Dengan minimum pembelanjaan Rp 250.000,-",
                                style: TextStyle(
                                    fontFamily: 'Brandon',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w800),
                              ),
                              Container(height: 20),
                              Text(
                                "Kamu bisa dapet gratis ongkos kirim dengan maksimal subsidi dari ongkos kirim Rp.20.000,-",
                                style: TextStyle(
                                  fontFamily: 'Brandon',
                                  fontSize: 14,
                                ),
                              ),
                              Container(height: 20),
                              Text(
                                "Tidak terbatas untuk seluruh partner logistik yang tersedia. Jika ongkos kirim melebihi Rp 20.000, kamu cukup membayar selisihnya saja.",
                                style: TextStyle(
                                  fontFamily: 'Brandon',
                                  fontSize: 14,
                                ),
                              ),
                            ]),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 20),
                      child: Text(
                        "FAQs",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 24,
                          fontFamily: "Yeseva",
                        ),
                      ),
                    ),
                    for(Faq item in faq.faq)
                      faqCollapsed(item),
                    Container(
                      height: 20,
                    )
                  ]),
                ),
              ),
            ],
          ),
          bottomNavigationBar: new PonnyBottomNavbar(selectedIndex: 4)),
    );
  }
}
