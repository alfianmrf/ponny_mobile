import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:ponny/screens/home_screen.dart';
import 'package:ponny/screens/account_screen.dart';
import 'package:ponny/screens/ubah_password_screen.dart';
import 'package:ponny/widgets/PonnyBottomNavbar.dart';

class UbahPasswordScreen extends StatefulWidget {
  static const String id = "ubah_password_Screen";
  @override
  _UbahPasswordStateScreen createState() => _UbahPasswordStateScreen();
}

class _UbahPasswordStateScreen extends State<UbahPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Hexcolor('#FCF8F0'),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 70,
            ),
            Container(
              padding: EdgeInsets.only(left: 15, bottom: 15),
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 14),
                    child: GestureDetector(
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: Color(0xffF48262),
                        size: 26,
                      ),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  Container(
                    child: Text(
                      "Change Password",
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
              color: Color(0xffF3C1B5),
            ),
            Container(
              margin: EdgeInsets.only(left: 20, top: 20, right: 20),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Color(0xffF48262),
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(7),
              ),
              padding: EdgeInsets.only(
                right: 20,
                left: 20,
                top: 15,
                bottom: 15,
              ),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(bottom: 8),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Color(0xffF48262),
                          width: 1,
                        ),
                      ),
                    ),
                    child: TextFormField(
                      obscureText: true,
                      style: TextStyle(
                        fontFamily: "Brandon",
                        fontSize: 17,
                        fontWeight: FontWeight.w300,
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Current Password',
                        isDense: true,
                      ),
                      maxLines: 1,
                      minLines: 1,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(bottom: 8),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Color(0xffF48262),
                          width: 1,
                        ),
                      ),
                    ),
                    child: TextFormField(
                      obscureText: true,
                      style: TextStyle(
                        fontFamily: "Brandon",
                        fontSize: 17,
                        fontWeight: FontWeight.w300,
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'New Password',
                        isDense: true,
                      ),
                      maxLines: 1,
                      minLines: 1,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(bottom: 8),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Color(0xffF48262),
                          width: 1,
                        ),
                      ),
                    ),
                    child: TextFormField(
                      obscureText: true,
                      style: TextStyle(
                        fontFamily: "Brandon",
                        fontSize: 17,
                        fontWeight: FontWeight.w300,
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Retype new Password',
                        isDense: true,
                      ),
                      maxLines: 1,
                      minLines: 1,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 15, bottom: 0),
                    child: GestureDetector(
                      onTap: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => EditAkunScreen(),
                        //   ),
                        // );
                      },
                      child: Text(
                        "Save",
                        style: TextStyle(
                          fontFamily: "Brandon",
                          color: Color(0xffF48262),
                          fontSize: 17,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: new PonnyBottomNavbar(selectedIndex: 4),
    );
  }
}
