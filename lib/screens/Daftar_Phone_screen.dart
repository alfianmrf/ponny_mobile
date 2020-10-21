import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:ponny/screens/Phone_OTP_screen.dart';

class DaftarPhoneScreen extends StatefulWidget {
  @override
  _DaftarPhoneScreenState createState() => _DaftarPhoneScreenState();
}

class _DaftarPhoneScreenState extends State<DaftarPhoneScreen> {
  String dropdownValue = '+62';

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
                    "Masukkan nomor telepon kamu untuk masuk",
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'Brandon',
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1,
                    ),
                  ),
                  Container(height: 50),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          height: 58,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  width: 2, color: Color(0xffF3C1B5)),
                              borderRadius: BorderRadius.circular(2.0)),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              underline: null,
                              value: dropdownValue,
                              icon: Icon(Icons.keyboard_arrow_down),
                              elevation: 16,
                              onChanged: (String newValue) {
                                setState(() {
                                  dropdownValue = newValue;
                                });
                              },
                              items: <String>[
                                '+62',
                                '+72',
                                '+01',
                                '+54'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: "Nomor Handphone",
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
                      ),
                    ],
                  ),
                  Container(height: 30),
                  rectanglebutton(context, "DAFTAR"),
                  Container(height: 30),
                ],
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.arrow_back_ios,
                      color: Hexcolor('#F48262'),
                    ),
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
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => PhoneOTPScreen()));
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
