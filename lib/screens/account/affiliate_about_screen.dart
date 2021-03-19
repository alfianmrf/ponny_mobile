import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:ponny/screens/Affiliate_CairkanDana_screen.dart';
import 'package:ponny/widgets/PonnyBottomNavbar.dart';

class AboutRefund extends StatefulWidget {
  @override
  _AboutRefundState createState() => _AboutRefundState();
}

class _AboutRefundState extends State<AboutRefund> {
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
            'About Refund',
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
                  height: size.height * 0.46,
                  decoration: BoxDecoration(color: Hexcolor('#FCF8F0')),
                  child: Stack(
                    children: [
                      Container(
                        width: size.width,
                        child: Image.network(
                          "https://via.placeholder.com/288x188",
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        left: 0,
                        child: Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: size.width * 0.05),
                          width: size.width,
                          height: size.height * 0.14,
                          decoration: BoxDecoration(
                              color: Hexcolor('#FCF8F0'),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          child: Padding(
                            padding: EdgeInsets.only(top: size.height * 0.021),
                            child: Column(
                              children: [
                                Text(
                                  "Tentang Refund",
                                  style: TextStyle(
                                    fontFamily: "Yeseva",
                                    fontSize: size.height * 0.034,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
            ],
          ),
        ),
        bottomNavigationBar: new PonnyBottomNavbar(selectedIndex: 4));
  }
}
