import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import 'package:ponny/screens/Daftar_Phone_screen.dart';

class RegisEmailScreen extends StatefulWidget {
  static const String id = "Register_Email_screen";

  @override
  _RegisEmailScreenState createState() => _RegisEmailScreenState();
}

class _RegisEmailScreenState extends State<RegisEmailScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Hexcolor('#FCF8F0'),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          margin: EdgeInsets.symmetric(vertical: 40, horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text(
                    "SELAMAT DATANG DI PONNY BEAUTE !",
                    style: TextStyle(
                      fontSize: 24,
                      fontFamily: 'Brandon',
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1,
                    ),
                  ),
                  Text(
                    "Masukkan alamat email kamu untuk masuk atau mendaftar",
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'Brandon',
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1,
                    ),
                  ),
                  Container(height: 50),
                  TextField(
                    decoration: InputDecoration(
                      hintText: "Email",
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 2,
                          color: Color(0xffF3C1B5),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 2,
                          color: Color(0xffF3C1B5),
                        ),
                      ),
                    ),
                  ),
                  Container(height: 30),
                  rectanglebutton(context, "LANJUTKAN DENGAN EMAIL"),
                  Container(height: 30),
                  socialMediaButton("assets/images/facebook.png", Colors.blue,
                      "Login with Facebook", context, () {}),
                  socialMediaButton("assets/images/google.png", Colors.red,
                      "Login with Google", context, () {}),
                  socialMediaButton("assets/images/twitter.png",
                      Colors.lightBlue, "Login with Twitter", context, () {}),
                  socialMediaButton("assets/images/phones.png", Colors.grey,
                      "Login with Phone Number", context, DaftarPhoneScreen()),
                ],
              ),
              Container(height: 30),
              Column(
                children: [
                  Text(
                    "Dengan melakukan pendaftaran kamu telah menyetujui",
                    style: TextStyle(
                        fontSize: 11,
                        fontFamily: 'Brandon',
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1,
                        color: Colors.grey),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        child: Text(
                          "Kebijakan Privasi ",
                          style: TextStyle(
                              fontSize: 11,
                              fontFamily: 'Brandon',
                              fontWeight: FontWeight.w800,
                              letterSpacing: 1,
                              color: Colors.blue),
                        ),
                      ),
                      Text(
                        "dan ",
                        style: TextStyle(
                            fontSize: 11,
                            fontFamily: 'Brandon',
                            fontWeight: FontWeight.w800,
                            letterSpacing: 1,
                            color: Colors.grey),
                      ),
                      InkWell(
                        child: Text(
                          "Syarat dan Ketentuan",
                          style: TextStyle(
                              fontSize: 11,
                              fontFamily: 'Brandon',
                              fontWeight: FontWeight.w800,
                              letterSpacing: 1,
                              color: Colors.blue),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget rectanglebutton(context, String subtext) {
  return ButtonTheme(
    buttonColor: Hexcolor('#F48262'),
    minWidth: double.infinity,
    child: RaisedButton(
      onPressed: () {},
      child: Text(
        subtext,
        style: TextStyle(
            fontSize: 14,
            fontFamily: 'Brandon',
            fontWeight: FontWeight.w500,
            letterSpacing: 1,
            color: Colors.white),
      ),
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(5.0),
      side: BorderSide(color: Hexcolor('#F48262')),
    ),
  );
}

Widget socialMediaButton(
    String imagePath, Color buttonColor, String title, context, var screen) {
  return GestureDetector(
    onTap: () {
      Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
    },
    child: Card(
      elevation: 2,
      child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(2)),
            color: buttonColor,
          ),
          height: 40,
          width: double.infinity,
          child: Row(children: [
            Expanded(
              flex: 1,
              child: Container(
                color: Colors.black12,
                height: double.infinity,
                child: Center(child: Image.asset(imagePath)),
              ),
            ),
            Expanded(
              flex: 5,
              child: Container(
                height: double.infinity,
                child: Center(
                  child: Text(
                    title,
                    style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'Brandon',
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1,
                        color: Colors.white),
                  ),
                ),
              ),
            )
          ])),
    ),
  );
}
