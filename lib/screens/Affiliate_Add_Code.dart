import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:ponny/screens/Affiliate_CairkanDana_screen.dart';
import 'package:ponny/widgets/PonnyBottomNavbar.dart';

class AddCodeAffiliate extends StatefulWidget {
  @override
  _AddCodeAffiliateState createState() => _AddCodeAffiliateState();
}

class _AddCodeAffiliateState extends State<AddCodeAffiliate> {
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
                      "Yuk, bikin sendiri kode kamu",
                      style: TextStyle(
                        fontFamily: "Brandon",
                        fontWeight: FontWeight.w600,
                        fontSize: size.height * 0.023,
                      ),
                    ),
                  ),
                  Container(
                    width: size.width,
                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 7),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Color(0xffF48262),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        Container(
                            width: double.infinity,
                            margin: EdgeInsets.only(
                                left: size.width * 0.050,
                                top: size.width * 0.020,
                                bottom: size.width * 0.020),
                            child: Text(
                              "KODE DISKON",
                              style: TextStyle(
                                fontFamily: "Brandon",
                                fontWeight: FontWeight.w600,
                                fontSize: size.height * 0.023,
                              ),
                            )),
                        Column(
                          children: [
                            Container(
                                decoration: BoxDecoration(
                                  border: Border(
                                    top: BorderSide(
                                      color: Color(0xffF48262),
                                      width: 1,
                                    ),
                                  ),
                                ),
                                child: TextFormField(
                                  cursorColor: Colors.black,
                                  decoration: new InputDecoration(
                                      border: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      errorBorder: InputBorder.none,
                                      disabledBorder: InputBorder.none,
                                      contentPadding: EdgeInsets.only(
                                          left: 15,
                                          bottom: 11,
                                          top: 11,
                                          right: 15),
                                      hintText: "PHOEBEXTITAN"),
                                )),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Container(
                child: RaisedButton(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    elevation: 0,
                    child: Text("SIMPAN",
                        style: TextStyle(
                            fontFamily: "Brandon",
                            color: Colors.white,
                            fontSize: size.width * 0.034,
                            fontWeight: FontWeight.w700)),
                    color: Color(0xffF48262)),
              ),
            ],
          ),
        ),
        bottomNavigationBar: new PonnyBottomNavbar(selectedIndex: 4));
  }
}
