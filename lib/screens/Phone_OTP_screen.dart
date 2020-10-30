import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sms_autofill/sms_autofill.dart';

class PhoneOTPScreen extends StatefulWidget {
  String nomorTfn;
  PhoneOTPScreen({Key Key, this.nomorTfn});
  @override
  _PhoneOTPScreenState createState() => _PhoneOTPScreenState();
}

class _PhoneOTPScreenState extends State<PhoneOTPScreen> {
  String code;

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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "DAFTAR SEBAGAI ANGGOTA PHOEBE'S SQUAD",
                    style: TextStyle(
                      fontSize: 22,
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
                  Container(height: 20),
                  Text(
                    "Nomor Telepon",
                    style: TextStyle(
                      fontSize: 15,
                      fontFamily: 'Brandon',
                      letterSpacing: 1,
                    ),
                  ),
                  Container(height: 20),
                  Text(
                    "+62857123456",
                    style: TextStyle(
                      fontSize: 15,
                      fontFamily: 'Brandon',
                      letterSpacing: 1,
                    ),
                  ),
                  Container(height: 20),
                  Container(
                    height: 30,
                    width: double.infinity,
                    child: PinFieldAutoFill(
                      codeLength: 6,
                      onCodeChanged: (value){
                        print(value);
                      },
                      onCodeSubmitted: (value){
                        print(value);
                      },
                    ),
                  ),
                  Container(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        child: Text(
                          "Kirim ulang kode",
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              fontSize: 15,
                              fontFamily: 'Brandon',
                              letterSpacing: 1,
                              color: Colors.grey),
                        ),
                      ),
                      rectanglebutton(context, "LANJUT"),
                    ],
                  ),
                ],
              ),
              Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Row(
                      children: [
                        Icon(Icons.arrow_back_ios,color: Hexcolor('#F48262')),
                        Text(
                          "Kembali",
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'Brandon',
                            letterSpacing: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 20,
                  ),
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
    child: RaisedButton(
      onPressed: () {

      },
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

Widget otpTextField() {
  return Expanded(
      child: Container(
    margin: EdgeInsets.symmetric(horizontal: 5),
    child: TextField(
      keyboardType: TextInputType.number,
      inputFormatters: [
        LengthLimitingTextInputFormatter(1),
      ],
      decoration: InputDecoration(
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
  ));
}
