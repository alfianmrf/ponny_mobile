import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class DaftarLoginScreen extends StatefulWidget {
  static const String id = "daftarLogin";

  @override
  _DaftarLoginScreenState createState() => _DaftarLoginScreenState();
}

class _DaftarLoginScreenState extends State<DaftarLoginScreen> {
  bool masuk = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Hexcolor('#FCF8F0'),
        body: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.all(20),
              child: FittedBox(
                fit: BoxFit.fitWidth,
                child: Text(
                  'Akun Saya',
                  style: TextStyle(
                      fontSize: 30,
                      fontFamily: 'Yeseva',
                      color: Hexcolor('#F48262'),
                      fontWeight: FontWeight.w500,
                      letterSpacing: 1),
                ),
              ),
            ),
            Container(
              color: Color(0xffF3C1B5),
              height: 2,
            ),
            Expanded(
              flex: 2,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.all(10),
                        child: ButtonTheme(
                          buttonColor:
                              masuk ? Hexcolor('#F48262') : Hexcolor('#FCF8F0'),
                          minWidth: 180.0,
                          height: 45.0,
                          child: RaisedButton(
                            onPressed: () {
                              setState(() {
                                masuk = true;
                              });
                            },
                            child: FittedBox(
                              fit: BoxFit.fitWidth,
                              child: Text(
                                "MASUK",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontFamily: 'Brandon',
                                    fontWeight: FontWeight.w800,
                                    letterSpacing: 1,
                                    color: masuk
                                        ? Colors.white
                                        : Hexcolor('#F48262')),
                              ),
                            ),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                            side: BorderSide(color: Hexcolor('#F48262')),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.all(10),
                        child: ButtonTheme(
                          buttonColor:
                              masuk ? Hexcolor('#FCF8F0') : Hexcolor('#F48262'),
                          minWidth: 180.0,
                          height: 45.0,
                          child: RaisedButton(
                            onPressed: () {
                              setState(() {
                                masuk = false;
                              });
                            },
                            child: FittedBox(
                              fit: BoxFit.fitWidth,
                              child: Text(
                                "DAFTAR",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontFamily: 'Brandon',
                                    fontWeight: FontWeight.w800,
                                    letterSpacing: 1,
                                    color: masuk
                                        ? Hexcolor('#F48262')
                                        : Colors.white),
                              ),
                            ),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                            side: BorderSide(color: Hexcolor('#F48262')),
                          ),
                        ),
                      ),
                    ),
                  ]),
            ),
            Expanded(
                flex: 2,
                child: Container(
                  margin: EdgeInsets.only(left: 10, right: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Expanded(
                              child: Container(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Nomor Ponsel atau Email",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontFamily: 'Brandon',
                                    fontWeight: FontWeight.w800,
                                    letterSpacing: 1,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  border: Border.all(color: Color(0xffF48262)),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  color: Colors.white),
                              padding: EdgeInsets.all(10),
                              child: TextField(
                                cursorColor: Colors.black,
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.go,
                                decoration: new InputDecoration.collapsed(),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  "Contoh: 08123456789",
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontFamily: 'Brandon',
                                      fontWeight: FontWeight.w800,
                                      letterSpacing: 1,
                                      color: Colors.grey),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      
                    ],
                  ),
                )),masuk
                          ? Expanded(flex:1,
                              child: Container(padding: EdgeInsets.symmetric(vertical: 5),
                                alignment: Alignment.center,
                                
                                child: ButtonTheme(
                                  buttonColor: Hexcolor('#F48262'),
                                  minWidth: 180.0,
                                  height: 45.0,
                                  child: RaisedButton(
                                    onPressed: () {},
                                    child: FittedBox(
                                      fit: BoxFit.fitWidth,
                                      child: Text(
                                        "MASUK",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontFamily: 'Brandon',
                                            fontWeight: FontWeight.w800,
                                            letterSpacing: 1,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                    side:
                                        BorderSide(color: Hexcolor('#F48262')),
                                  ),
                                ),
                              ),
                            )
                          : Container(),
            Expanded(
              flex: 1,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      color: Color(0xffF3C1B5),
                      height: 2,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      "atau masuk dengan",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 12,
                          fontFamily: 'Brandon',
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1,
                          color: Color(0xffF3C1B5)),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      color: Color(0xffF3C1B5),
                      height: 2,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 4,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    socMedButton("assets/images/googleLogo.png", "GOOGLE"),
                    socMedButton("assets/images/facebookLogo.png", "FACEBOOK"),
                    socMedButton("assets/images/twitterLogo.png", "TWITTER"),
                  ],
                ),
              ),
            ),
           masuk ? Container() : Expanded(flex:2,
              child: Container(
                alignment: Alignment.center,padding: EdgeInsets.symmetric(vertical: 20),
                child: ButtonTheme(
                  buttonColor: Hexcolor('#F48262'),
                  minWidth: 180.0,
                  height: 45.0,
                  child: RaisedButton(
                    onPressed: () {},
                    child: FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Text(
                        "DAFTAR",
                        style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'Brandon',
                            fontWeight: FontWeight.w800,
                            letterSpacing: 1,
                            color: Colors.white),
                      ),
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    side: BorderSide(color: Hexcolor('#F48262')),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

Widget socMedButton(String logoPath, String mediaName) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 5),
    child: Row(
      children: [
        Expanded(flex: 1, child: Container()),
        Expanded(
          flex: 3,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Color(0xffF3C1B5),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Color(0xffF3C1B5),
                      ),
                    ),
                    child: IconButton(
                      onPressed: () {},
                      icon: Image.asset(logoPath),
                    ),
                  ),
                ),
                 Expanded(
                  flex: 2,
                  child: FlatButton(
                    onPressed: () {},
                    child: FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Text(
                        mediaName,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'Brandon',
                            fontWeight: FontWeight.w800,
                            letterSpacing: 1,
                            color: Color(0xffF3C1B5)),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        Expanded(flex: 1, child: Container()),
      ],
    ),
  );
}
