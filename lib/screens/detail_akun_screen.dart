import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:ponny/screens/home_screen.dart';
import 'package:ponny/screens/account_screen.dart';
import 'package:ponny/screens/edit_akun_screen.dart';
import 'package:ponny/screens/edit_alamat_screen.dart';
import 'package:ponny/screens/ubah_password_screen.dart';
import 'package:ponny/widgets/PonnyBottomNavbar.dart';

class DetailAkunScreen extends StatefulWidget {
  static const String id = "detail_akun_Screen";
  @override
  _DetailAkunStateScreen createState() => _DetailAkunStateScreen();
}

class _DetailAkunStateScreen extends State<DetailAkunScreen> {
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
                      "Detail Akun",
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Text(
                            "Account",
                            style: TextStyle(
                              fontFamily: "Brandon",
                              fontSize: 15,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                        Container(
                          child: Text(
                            "carlastarla@gmail.com",
                            style: TextStyle(
                              fontFamily: "Brandon",
                              fontSize: 15,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(bottom: 8, top: 8),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Color(0xffF48262),
                          width: 1,
                        ),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Text(
                            "First Name",
                            style: TextStyle(
                              fontFamily: "Brandon",
                              fontSize: 15,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                        Container(
                          child: Text(
                            "Carla",
                            style: TextStyle(
                              fontFamily: "Brandon",
                              fontSize: 15,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(bottom: 8, top: 8),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Color(0xffF48262),
                          width: 1,
                        ),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Text(
                            "Last Name",
                            style: TextStyle(
                              fontFamily: "Brandon",
                              fontSize: 15,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                        Container(
                          child: Text(
                            "Starla",
                            style: TextStyle(
                              fontFamily: "Brandon",
                              fontSize: 15,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(bottom: 8, top: 8),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Color(0xffF48262),
                          width: 1,
                        ),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Text(
                            "Gender",
                            style: TextStyle(
                              fontFamily: "Brandon",
                              fontSize: 15,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                        Container(
                          child: Text(
                            "Female",
                            style: TextStyle(
                              fontFamily: "Brandon",
                              fontSize: 15,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(bottom: 8, top: 8),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Color(0xffF48262),
                          width: 1,
                        ),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Text(
                            "Date of Birth",
                            style: TextStyle(
                              fontFamily: "Brandon",
                              fontSize: 15,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                        Container(
                          child: Text(
                            "11/05/1990",
                            style: TextStyle(
                              fontFamily: "Brandon",
                              fontSize: 15,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(bottom: 8, top: 8),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Color(0xffF48262),
                          width: 1,
                        ),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Text(
                            "Phone Number",
                            style: TextStyle(
                              fontFamily: "Brandon",
                              fontSize: 15,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                        Container(
                          child: Text(
                            "+62 8123456910",
                            style: TextStyle(
                              fontFamily: "Brandon",
                              fontSize: 15,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 15, bottom: 0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditAkunScreen(),
                          ),
                        );
                      },
                      child: Text(
                        "Edit Akun",
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
            Container(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UbahPasswordScreen(),
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Color(0xffF48262),
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(7),
                  ),
                  margin: EdgeInsets.only(
                    top: 18,
                    right: 20,
                    left: 20,
                  ),
                  padding: EdgeInsets.only(
                    top: 15,
                    bottom: 15,
                    left: 15,
                    right: 15,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Text(
                          "Ubah Password",
                          style: TextStyle(
                            fontFamily: "Brandon",
                            fontSize: 15,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ),
                      Container(
                        child: Row(
                          children: [
                            Container(
                              child: Row(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(right: 5),
                                    child: Icon(
                                      Icons.brightness_1,
                                      color: Color(0xffF48262),
                                      size: 10,
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(right: 5),
                                    child: Icon(
                                      Icons.brightness_1,
                                      color: Color(0xffF48262),
                                      size: 10,
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(right: 5),
                                    child: Icon(
                                      Icons.brightness_1,
                                      color: Color(0xffF48262),
                                      size: 10,
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(right: 5),
                                    child: Icon(
                                      Icons.brightness_1,
                                      color: Color(0xffF48262),
                                      size: 10,
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(right: 5),
                                    child: Icon(
                                      Icons.brightness_1,
                                      color: Color(0xffF48262),
                                      size: 10,
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(right: 10),
                                    child: Icon(
                                      Icons.brightness_1,
                                      color: Color(0xffF48262),
                                      size: 10,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              child: Icon(
                                Icons.arrow_forward_ios,
                                color: Color(0xffF48262),
                                size: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(right: 20, left: 20, top: 25, bottom: 10),
              child: Text(
                "SAVED ADDRESSES",
                style: TextStyle(
                  fontFamily: "Brandon",
                  fontWeight: FontWeight.w800,
                  fontSize: 18,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                right: 20,
                left: 20,
                bottom: 35,
              ),
              padding: EdgeInsets.only(
                right: 15,
                left: 15,
                top: 15,
                bottom: 10,
              ),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Color(0xffF48262),
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(7),
              ),
              child: Column(
                children: [
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 30,
                                padding: EdgeInsets.only(top: 10),
                                child: Text(
                                  "Carla Starla",
                                  style: TextStyle(
                                    fontFamily: "Brandon",
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(top: 1),
                                height: 24,
                                child: Text(
                                  "8123456910",
                                  style: TextStyle(
                                    fontFamily: "Brandon",
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              Container(
                                height: 24,
                                child: Text(
                                  "jl. dimana aja bebas no. 123",
                                  style: TextStyle(
                                    fontFamily: "Brandon",
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              Container(
                                height: 24,
                                child: Text(
                                  "Penjaringan",
                                  style: TextStyle(
                                    fontFamily: "Brandon",
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              Container(
                                height: 24,
                                child: Text(
                                  "DKI Jakarta",
                                  style: TextStyle(
                                    fontFamily: "Brandon",
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              Container(
                                height: 24,
                                child: Text(
                                  "Indonesia",
                                  style: TextStyle(
                                    fontFamily: "Brandon",
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              Container(
                                height: 24,
                                child: Text(
                                  "12345",
                                  style: TextStyle(
                                    fontFamily: "Brandon",
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 15, right: 20),
                          height: 170,
                          decoration: BoxDecoration(
                            border: Border(
                              left: BorderSide(
                                color: Color(0xffF48262),
                                width: 1,
                              ),
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            EditAlamatScreen(),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(bottom: 30),
                                    child: Text(
                                      "EDIT",
                                      style: TextStyle(
                                        fontFamily: "Brandon",
                                        fontWeight: FontWeight.w700,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {},
                                child: Container(
                                  child: Text(
                                    "DELETE",
                                    style: TextStyle(
                                      fontFamily: "Brandon",
                                      fontWeight: FontWeight.w700,
                                      fontSize: 15,
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
                  Container(
                    margin: EdgeInsets.only(top: 5),
                    height: 2,
                    color: Color(0xffF48262),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 15, bottom: 5),
                    child: GestureDetector(
                      onTap: () {},
                      child: Text(
                        "+ Tambah Alamat Baru",
                        style: TextStyle(
                          fontFamily: "Brandon",
                          fontSize: 17,
                          color: Color(0xffF48262),
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
