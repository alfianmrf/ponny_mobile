import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:ponny/widgets/PonnyBottomNavbar.dart';

class SyaratKetentuanScreen extends StatefulWidget {
  static const String id = "Syarat_Ketentuan_screen";

  @override
  _SyaratKetentuanScreenState createState() => _SyaratKetentuanScreenState();
}

class _SyaratKetentuanScreenState extends State<SyaratKetentuanScreen> {
  @override
  Widget build(BuildContext context) {
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
                        "Syarat & Ketentuan",
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
                                  child: Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(top: 30, right: 20, left: 20,bottom:30),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Color(0xffF48262),
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Container(
                      margin: EdgeInsets.only(top: 10, bottom: 20),
                      padding: EdgeInsets.all(10),
                      child: Column(children: [
                        syaratKetentuanText(),
                        syaratKetentuanText(),
                        syaratKetentuanText(),
                        syaratKetentuanText(),
                      ]),
                    ),
                  ),
                ),
              ),
            ],
          ),
          bottomNavigationBar: new PonnyBottomNavbar(selectedIndex: 4)),
    );
  }
}

Widget syaratKetentuanText() {
  return Container(
    margin: EdgeInsets.only(top: 10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "1. General",
          style: TextStyle(
            fontFamily: 'Brandon',
            fontSize: 14,
          ),
        ),
        Container(height: 10),
        Text(
          "Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat. Ut wisi enim ad minim veniam, quis nostrud exerci tation ullamcorper suscipit lobortis nisl ut aliquip ex ea commodo consequat.",
          style: TextStyle(
            fontFamily: 'Brandon',
            fontSize: 14,
          ),
        )
      ],
    ),
  );
}
