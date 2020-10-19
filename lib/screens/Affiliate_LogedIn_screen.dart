import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:ponny/widgets/PonnyBottomNavbar.dart';

class AffiliateLogedIn extends StatefulWidget {
  static const String id = "Affiliate_LogedIn_screen";

  @override
  _AffiliateLogedInState createState() => _AffiliateLogedInState();
}

class _AffiliateLogedInState extends State<AffiliateLogedIn> {
  bool cairkan = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        setState(() {
          cairkan = false;
        });
      },
      child: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: Hexcolor('#FCF8F0'),
          body: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(new FocusNode());
            },
            child: Column(
              children: [
                Container(
                  height: 35,
                ),
                Container(
                  margin: EdgeInsets.all(5),
                  child: Row(
                    children: [
                      Container(
                        child: IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.arrow_back_ios,
                              color: Color(0xffF48262),
                              size: 26,
                            )),
                      ),
                      Container(
                        child: Text(
                          "Affiliate Home",
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
                  margin: EdgeInsets.only(),
                  height: 1,
                  color: Color(0xffF3C1B5),
                ),
                Expanded(
                    child: SingleChildScrollView(
                        child: Stack(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Image.network(
                        "https://via.placeholder.com/288x188",
                        fit: BoxFit.cover,
                      ),
                    ),
                    Column(
                      children: [
                        Container(
                          width: double.infinity,
                          margin: EdgeInsets.fromLTRB(20, 180, 20, 0),
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Hexcolor('#FCF8F0'),
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          child: Column(
                            children: [
                              Text(
                                "HALO,",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontFamily: "Yeseva",
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                'TITAN TYRA',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: "Yeseva",
                                  fontSize: 20,
                                  color: Color(0xffF48262),
                                ),
                              ),
                              Container(height: 20),
                            ],
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Results from campaigns',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    fontFamily: "Brandon",
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500),
                              ),
                              Container(
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        padding: EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(2),
                                          ),
                                          border: Border.all(
                                              color: Color(0xffF48262)),
                                        ),
                                        child: Column(children: [
                                          Text(
                                            'Sessions',
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                                fontFamily: "Brandon",
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          Text(
                                            '4.500',
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                                fontFamily: "Brandon",
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ]),
                                      ),
                                    ),
                                    Container(width: 10),
                                    Expanded(
                                      child: Container(
                                        padding: EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(2),
                                          ),
                                          border: Border.all(
                                              color: Color(0xffF48262)),
                                        ),
                                        child: Column(children: [
                                          Text(
                                            'Total Used',
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                                fontFamily: "Brandon",
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          Text(
                                            '56',
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                                fontFamily: "Brandon",
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ]),
                                      ),
                                    ),
                                    Container(width: 10),
                                    Expanded(
                                      child: Container(
                                        padding: EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(2),
                                          ),
                                          border: Border.all(
                                              color: Color(0xffF48262)),
                                        ),
                                        child: Column(children: [
                                          Text(
                                            'Sales',
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                                fontFamily: "Brandon",
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          Text(
                                            '3.560.000',
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                                fontFamily: "Brandon",
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ]),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Container(height: 20),
                              cairkan
                                  ? Container(
                                      padding: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(2),
                                        ),
                                        border: Border.all(
                                            color: Color(0xffF48262)),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          ListTile(
                                            leading:
                                                Icon(Icons.wallet_giftcard),
                                            title: Text(
                                              'TOTAL',
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                  fontFamily: "Brandon",
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w800),
                                            ),
                                            subtitle: Text(
                                              'Rp.3.560.000',
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                  fontFamily: "Brandon",
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w800),
                                            ),
                                            trailing: ButtonTheme(
                                              buttonColor: Hexcolor('#F48262'),
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10, vertical: 5),
                                              child: RaisedButton(
                                                onPressed: () {
                                                  setState(() {
                                                    cairkan = true;
                                                  });
                                                },
                                                child: Text(
                                                  "CAIRKAN DANA",
                                                  style: TextStyle(
                                                      fontSize: 10,
                                                      fontFamily: 'Brandon',
                                                      fontWeight:
                                                          FontWeight.w800,
                                                      letterSpacing: 1,
                                                      color: Colors.white),
                                                ),
                                              ),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5.0),
                                                side: BorderSide(
                                                    color: Hexcolor('#F48262')),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(
                                                top: 10, bottom: 10),
                                            height: 1,
                                            color: Color(0xffF3C1B5),
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                "Pelajari lebih lengkap tentang pencairan dana, ",
                                                style: TextStyle(
                                                  fontSize: 10,
                                                  fontFamily: 'Brandon',
                                                  fontWeight: FontWeight.w800,
                                                  letterSpacing: 1,
                                                ),
                                              ),
                                              InkWell(
                                                child: Text(
                                                  "di sini",
                                                  style: TextStyle(
                                                    fontSize: 10,
                                                    fontFamily: 'Brandon',
                                                    fontWeight: FontWeight.w800,
                                                    letterSpacing: 1,
                                                    color: Color(0xffF48262),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ))
                                  : Container(
                                      padding: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(2),
                                        ),
                                        border: Border.all(
                                            color: Color(0xffF48262)),
                                      ),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Expanded(
                                                flex: 2,
                                                child: Text(
                                                  'Campaigns',
                                                  textAlign: TextAlign.start,
                                                  style: TextStyle(
                                                      fontFamily: "Brandon",
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w800),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: Text(
                                                  'Status',
                                                  textAlign: TextAlign.start,
                                                  style: TextStyle(
                                                      fontFamily: "Brandon",
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w800),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 2,
                                                child: Text(
                                                  'Sales',
                                                  textAlign: TextAlign.start,
                                                  style: TextStyle(
                                                      fontFamily: "Brandon",
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w800),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: Text(
                                                  'Total Used',
                                                  textAlign: TextAlign.start,
                                                  style: TextStyle(
                                                      fontFamily: "Brandon",
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w800),
                                                ),
                                              ),
                                            ],
                                          ),
                                          ListView.builder(
                                            shrinkWrap: true,
                                            itemCount: 5,
                                            itemBuilder: (context, i) {
                                              return Column(
                                                children: [
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        top: 10, bottom: 10),
                                                    height: 1,
                                                    color: Color(0xffF3C1B5),
                                                  ),
                                                  Row(children: [
                                                    Expanded(
                                                      flex: 2,
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            'Code',
                                                            textAlign:
                                                                TextAlign.start,
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    "Brandon",
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w800),
                                                          ),
                                                          Text(
                                                            'PHOEBEXTITAN',
                                                            textAlign:
                                                                TextAlign.start,
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    "Brandon",
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w800),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 1,
                                                      child: Wrap(
                                                        children: [
                                                          Container(
                                                            padding: EdgeInsets
                                                                .fromLTRB(
                                                                    8, 3, 8, 3),
                                                            decoration: BoxDecoration(
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            20)),
                                                                color: Colors
                                                                    .yellowAccent),
                                                            child: Text(
                                                              'Active',
                                                              textAlign:
                                                                  TextAlign
                                                                      .start,
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      "Brandon",
                                                                  fontSize: 10,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w800),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 2,
                                                      child: Text(
                                                        'Rp.2.000.000',
                                                        textAlign:
                                                            TextAlign.start,
                                                        style: TextStyle(
                                                            fontFamily:
                                                                "Brandon",
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w800),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 1,
                                                      child: Text(
                                                        '25',
                                                        textAlign:
                                                            TextAlign.start,
                                                        style: TextStyle(
                                                            fontFamily:
                                                                "Brandon",
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w800),
                                                      ),
                                                    ),
                                                  ]),
                                                ],
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    )
                            ],
                          ),
                        ),
                        Container(height: 10),
                        cairkan
                            ? Container()
                            : ButtonTheme(
                                buttonColor: Hexcolor('#F48262'),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 30, vertical: 10),
                                child: RaisedButton(
                                  onPressed: () {
                                    setState(() {
                                      cairkan = true;
                                    });
                                  },
                                  child: Text(
                                    "CAIRKAN",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: 'Brandon',
                                        fontWeight: FontWeight.w800,
                                        letterSpacing: 1,
                                        color: Colors.white),
                                  ),
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                  side: BorderSide(color: Hexcolor('#F48262')),
                                ),
                              ),
                        Container(height: 30),
                      ],
                    )
                  ],
                )))
              ],
            ),
          ),
          bottomNavigationBar: new PonnyBottomNavbar(selectedIndex: 4)),
    );
  }
}
