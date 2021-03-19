import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:ponny/screens/Affiliate_CairkanDana_screen.dart';
import 'package:ponny/screens/account/affiliate_about_screen.dart';
import 'package:ponny/widgets/PonnyBottomNavbar.dart';

class CairkanDanaTotalScreen extends StatefulWidget {
  @override
  _CairkanDanaTotalScreenState createState() => _CairkanDanaTotalScreenState();
}

class _CairkanDanaTotalScreenState extends State<CairkanDanaTotalScreen> {
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
            'Dalam Perjalanan',
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
                                  "Hallo,",
                                  style: TextStyle(
                                    fontFamily: "Yeseva",
                                    fontSize: size.height * 0.034,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  "tytan tyra".toUpperCase(),
                                  style: TextStyle(
                                    color: Hexcolor('#ffF48262'),
                                    fontFamily: "Yeseva",
                                    fontSize: size.height * 0.037,
                                    fontWeight: FontWeight.w600,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
              Column(
                children: [
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(left: size.width * 0.04),
                    child: Text(
                      "Result from campaigns",
                      style: TextStyle(
                        fontFamily: "Brandon",
                        fontWeight: FontWeight.w600,
                        fontSize: size.height * 0.023,
                      ),
                    ),
                  ),
                  Container(
                    width: size.width,
                    margin:
                        EdgeInsets.symmetric(horizontal: size.width * 0.027),
                    padding: EdgeInsets.only(top: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 5),
                            padding: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                color: Color(0xffF48262),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Sessions",
                                  style: TextStyle(
                                    fontFamily: "Brandon",
                                    fontSize: 12,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                                Text(
                                  "4.500",
                                  style: TextStyle(
                                    fontFamily: "Brandon",
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 5),
                            padding: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                color: Color(0xffF48262),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Yang Terpakai",
                                  style: TextStyle(
                                    fontFamily: "Brandon",
                                    fontSize: 12,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                                Text(
                                  "56",
                                  style: TextStyle(
                                    fontFamily: "Brandon",
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 5),
                            padding: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                color: Color(0xffF48262),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Pendapatan",
                                  style: TextStyle(
                                    fontFamily: "Brandon",
                                    fontSize: 12,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                                Text(
                                  "3.560.000",
                                  style: TextStyle(
                                    fontFamily: "Brandon",
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: size.width,
                    margin: EdgeInsets.symmetric(
                        horizontal: size.width * 0.037,
                        vertical: size.height * 0.037),
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Color(0xffF48262),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(top: size.height * 0.02),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              ImageIcon(
                                AssetImage('assets/images/wallet.png'),
                                color: Color(0xffF48262),
                              ),
                              Padding(
                                padding:
                                    EdgeInsets.only(left: size.width * 0.03),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "TOTAL",
                                      style: TextStyle(
                                          color: Colors.black45,
                                          fontFamily: "Brandon",
                                          fontSize: size.width * 0.035,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Text(
                                      "Rp. 3.560.000",
                                      style: TextStyle(
                                          fontFamily: "Brandon",
                                          fontSize: size.width * 0.046,
                                          fontWeight: FontWeight.w700),
                                    )
                                  ],
                                ),
                              ),
                              Spacer(),
                              Container(
                                child: RaisedButton(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 5),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              CairkanDanaScreen(),
                                        ),
                                      );
                                    },
                                    elevation: 0,
                                    child: Text("CAIRKAN DANA",
                                        style: TextStyle(
                                            fontFamily: "Brandon",
                                            color: Colors.white,
                                            fontSize: size.width * 0.034,
                                            fontWeight: FontWeight.w700)),
                                    color: Color(0xffF48262)),
                              ),
                            ],
                          ),
                          Divider(
                            color: Color(0xffF48262),
                          ),
                          Row(
                            children: [
                              Text(
                                "Pelajari lebih lengkap mengenai pencarian dana,",
                                style: TextStyle(
                                    fontFamily: "Brandon",
                                    fontSize: size.height * 0.02),
                                textAlign: TextAlign.left,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => AboutRefund(),
                                    ),
                                  );
                                },
                                child: Container(
                                  width: 40,
                                  height: size.height * 0.03,
                                  child: Text(
                                    " disini",
                                    style: TextStyle(
                                        color: Hexcolor('#ffF48262'),
                                        fontFamily: "Brandon",
                                        fontSize: size.height * 0.02),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        bottomNavigationBar: new PonnyBottomNavbar(selectedIndex: 4));
  }
}
