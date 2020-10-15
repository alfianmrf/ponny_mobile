import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:ponny/screens/account_screen.dart';
import 'package:ponny/widgets/PonnyBottomNavbar.dart';

class KomplainDalamPerjalananScreen extends StatefulWidget {
  static const String id = "Komplain_Dalam_Perjalanan_Screen";
  @override
  _KomplainDalamPerjalananStateScreen createState() =>
      _KomplainDalamPerjalananStateScreen();
}

class _KomplainDalamPerjalananStateScreen
    extends State<KomplainDalamPerjalananScreen> {
  bool _value1 = false;
  bool _value2 = false;

  //we omitted the brackets '{}' and are using fat arrow '=>' instead, this is dart syntax
  void _value1Changed(bool value) => setState(() => _value1 = value);
  void _value2Changed(bool value) => setState(() => _value2 = value);

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
                      "Komplain",
                      style: TextStyle(
                        fontSize: 22,
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
              padding: EdgeInsets.only(top: 27, bottom: 27),
              width: MediaQuery.of(context).size.width,
              color: Hexcolor("#F59379"),
              child: Column(
                children: [
                  Container(
                    child: Text(
                      "Pengajuan Komplain",
                      style: TextStyle(
                        fontFamily: "Yeseva",
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 25, right: 25, top: 30),
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Text(
                      "Masalah apa yang kamu hadapi ?",
                      style: TextStyle(
                        fontFamily: "Brandon",
                        fontWeight: FontWeight.w600,
                        fontSize: 17,
                      ),
                    ),
                  ),
                  Container(
                    height: 35,
                    width: 300,
                    child: Row(
                      children: [
                        Container(
                          width: 30,
                          margin: EdgeInsets.only(top: 0),
                          child: Checkbox(
                            onChanged: (bool value) {
                              setState(() => this._value1 = value);
                            },
                            value: this._value1,
                            checkColor: Hexcolor("#F59379"),
                            activeColor: Hexcolor('#FCF8F0'),
                          ),
                        ),
                        Container(
                          child: Text(
                            "Barang belum saya terima",
                            style: TextStyle(
                              fontFamily: "Brandon",
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 35,
                    width: 300,
                    child: Row(
                      children: [
                        Container(
                          width: 30,
                          margin: EdgeInsets.only(top: 0),
                          child: Checkbox(
                            onChanged: (bool value) {
                              setState(() => this._value1 = value);
                            },
                            value: this._value1,
                            checkColor: Hexcolor("#F59379"),
                            activeColor: Hexcolor('#FCF8F0'),
                          ),
                        ),
                        Container(
                          child: Text(
                            "Barang rusak/cacat/pecah",
                            style: TextStyle(
                              fontFamily: "Brandon",
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 35,
                    width: 300,
                    child: Row(
                      children: [
                        Container(
                          width: 30,
                          margin: EdgeInsets.only(top: 0),
                          child: Checkbox(
                            onChanged: (bool value) {
                              setState(() => this._value1 = value);
                            },
                            value: this._value1,
                            checkColor: Hexcolor("#F59379"),
                            activeColor: Hexcolor('#FCF8F0'),
                          ),
                        ),
                        Container(
                          child: Text(
                            "Jumlah barang kurang",
                            style: TextStyle(
                              fontFamily: "Brandon",
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 35,
                    width: 300,
                    child: Row(
                      children: [
                        Container(
                          width: 30,
                          margin: EdgeInsets.only(top: 0),
                          child: Checkbox(
                            onChanged: (bool value) {
                              setState(() => this._value1 = value);
                            },
                            value: this._value1,
                            checkColor: Hexcolor("#F59379"),
                            activeColor: Hexcolor('#FCF8F0'),
                          ),
                        ),
                        Container(
                          child: Text(
                            "Barang tidak sesuai pesanan",
                            style: TextStyle(
                              fontFamily: "Brandon",
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 35,
                    width: 300,
                    child: Row(
                      children: [
                        Container(
                          width: 30,
                          margin: EdgeInsets.only(top: 0),
                          child: Checkbox(
                            onChanged: (bool value) {
                              setState(() => this._value1 = value);
                            },
                            value: this._value1,
                            checkColor: Hexcolor("#F59379"),
                            activeColor: Hexcolor('#FCF8F0'),
                          ),
                        ),
                        Container(
                          child: Text(
                            "Lainnya",
                            style: TextStyle(
                              fontFamily: "Brandon",
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: 35,
                      bottom: 10,
                    ),
                    child: Text(
                      "Foto barang komplain",
                      style: TextStyle(
                        fontFamily: "Brandon",
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Container(
                    child: Row(
                      children: [
                        Container(
                          child: Stack(
                            // overflow: Overflow.visible,
                            children: [
                              Container(
                                // width: MediaQuery.of(context).size.width,
                                child: Image.asset(
                                  "assets/images/produk.png",
                                  width: MediaQuery.of(context).size.width,
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 10, right: 5),
                                alignment: Alignment.topRight,
                                child: Icon(
                                  Icons.close,
                                  size: 20,
                                  color: Hexcolor("#F59379"),
                                ),
                              ),
                            ],
                          ),
                          width: 100,
                          height: 125,
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 20),
                          height: 125,
                          width: 100,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Hexcolor("#F59379"),
                              width: 2,
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(5.0),
                            ),
                            color: Hexcolor("#FDEDE3"),
                          ),
                          child: Stack(
                            children: [
                              Container(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      alignment: Alignment.center,
                                      child: Icon(
                                        Icons.add,
                                        color: Hexcolor("#F59379"),
                                        size: 45,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: 15,
                      bottom: 10,
                    ),
                    child: Text(
                      "Solusi Komplain",
                      style: TextStyle(
                        fontFamily: "Brandon",
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Container(
                    child: Row(
                      children: [
                        Container(
                          width: 30,
                          height: 25,
                          child: Checkbox(
                            onChanged: (bool value) {
                              setState(() => this._value1 = value);
                            },
                            value: this._value1,
                            checkColor: Hexcolor("#F59379"),
                            activeColor: Hexcolor('#FCF8F0'),
                          ),
                        ),
                        Container(
                          child: Text(
                            "Pengembalian Dana",
                            style: TextStyle(
                              fontFamily: "Brandon",
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Row(
                      children: [
                        Container(
                          width: 30,
                          height: 25,
                          child: Checkbox(
                            onChanged: (bool value) {
                              setState(() => this._value1 = value);
                            },
                            value: this._value1,
                            checkColor: Hexcolor("#F59379"),
                            activeColor: Hexcolor('#FCF8F0'),
                          ),
                        ),
                        Container(
                          child: Text(
                            "Penggantian Barang",
                            style: TextStyle(
                              fontFamily: "Brandon",
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: 25,
                      bottom: 25,
                    ),
                    height: 1,
                    color: Hexcolor("#F59379"),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      bottom: 25,
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 30,
                          height: 25,
                          child: Checkbox(
                            onChanged: (bool value) {
                              setState(() => this._value1 = value);
                            },
                            value: this._value1,
                            checkColor: Hexcolor("#F59379"),
                            activeColor: Hexcolor('#FCF8F0'),
                          ),
                        ),
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                child: Text(
                                  "Saya setuju dan menanggung ongkos kirim",
                                  style: TextStyle(
                                    fontFamily: "Brandon",
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                              Container(
                                child: Text(
                                  "jika harus mengembalikan barang",
                                  style: TextStyle(
                                    fontFamily: "Brandon",
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
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
