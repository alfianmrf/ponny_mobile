import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:ponny/model/User.dart';
import 'package:ponny/screens/pra_daftar.dart';
import 'package:ponny/screens/login.dart';
import 'package:ponny/screens/account/menunggu_pembayaran_screen.dart';
import 'package:ponny/screens/account/pembayaran_diterima_screen.dart';
import 'package:ponny/screens/account/dalam_perjalanan_screen.dart';
import 'package:ponny/screens/account/terkirim_screen.dart';
import 'package:ponny/screens/account/pesanan_selesai_screen.dart';
import 'package:ponny/screens/account/ulasan_produk_screen.dart';
import 'package:ponny/screens/account/daftar_keinginan_screen.dart';
import 'package:ponny/screens/account/detail_akun_screen.dart';
import 'package:ponny/screens/account/beauty_profile_screen.dart';
import 'package:ponny/screens/account/happy_skin_reward_screen.dart';
import 'package:ponny/screens/account/affiliate_us_screen.dart';
import 'package:ponny/widgets/PonnyBottomNavbar.dart';
import 'package:provider/provider.dart';

class AccountScreen extends StatefulWidget {
  static const String id = "account_screen";
  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  void initState() {
    super.initState();
  }

  List<String> judul = [
    "Dalam Perjalanan",
    "Pesanan Selesai",
    "Ulasan Produk",
    "Daftar Keinginan",
    "Detail Akun",
  ];

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    List<Widget> _widgetOptions = <Widget>[
      Text(
        'Index 1: Browse',
        style: optionStyle,
      ),
      Text(
        'Index 2: Consultation',
        style: optionStyle,
      ),
      Text(
        'Index 3: Forums',
        style: optionStyle,
      ),
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text('Hello World!',
              style: TextStyle(fontSize: 28, color: Colors.black)),
          RaisedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
            },
            textColor: Colors.deepOrange,
            padding: const EdgeInsets.all(0.0),
            child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(colors: <Color>[
                    Color(0xFF0D474A1),
                    Color(0xFF1976D2),
                    Color(0xFF42A5F5)
                  ]),
                ),
                padding: const EdgeInsets.all(10.0),
                child: const Text(
                  'Login!',
                  style: TextStyle(fontSize: 31),
                )),
          )
        ],
      ),
    ];
    Row flatButton = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        FlatButton(
          child: Text('Saya FlatButton'),
          onPressed: () => debugPrint('FlatButton di tekan'),
        )
      ],
    );

    final _user = Provider.of<UserModel>(context).user;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Hexcolor('#FCF8F0'),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 100,
            ),
            Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    child: Text(
                      _user.email != null ?
                      "Hi, "+_user.name : "Guest" ,
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Yeseva',
                        color: Hexcolor("#F59379"),
                      ),
                    ),
                  ),
                  Container(
                    child: Text(
                      "Logout",
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: Hexcolor("#F59379"),
                        fontFamily: 'Yeseva',
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 10,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 330,
              color: Hexcolor("#F59379"),
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    padding: EdgeInsets.only(right: 20, left: 20),
                    decoration: new BoxDecoration(
                      color: Hexcolor('#FCF8F0'),
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    width: 300,
                    height: 190,
                    child: Column(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(top: 7),
                          child: Text(
                            "DEWY",
                            style: TextStyle(
                              color: Hexcolor("#F59379"),
                              fontFamily: "Brandon",
                              fontSize: 45,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 3,
                            ),
                          ),
                        ),
                        Container(
                          child: Text(
                            "SKIN",
                            style: TextStyle(
                              fontSize: 20,
                              color: Hexcolor("#F59379"),
                              fontFamily: "Yeseva",
                              fontWeight: FontWeight.w300,
                              letterSpacing: 1,
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          margin: EdgeInsets.only(top: 10),
                          child: Text(
                            "Aninda Anita",
                            style: TextStyle(
                              fontFamily: "Yeseva",
                              fontSize: 12,
                              color: Hexcolor("#F59379"),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            top: 6,
                          ),
                          height: 1,
                          color: Hexcolor("#F59379"),
                        ),
                        Container(
                          // margin: EdgeInsets.only(top: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                child: Text(
                                  "170 POINTS",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: 'Brandon',
                                    color: Hexcolor("#F59379"),
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 2),
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      child: Column(
                                        children: <Widget>[
                                          Container(
                                            child: Text(
                                              "Berlaku",
                                              style: TextStyle(
                                                fontFamily: "Brandon",
                                                fontSize: 11,
                                                color: Hexcolor("#F59379"),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            child: Text(
                                              "Hingga",
                                              style: TextStyle(
                                                fontFamily: "Brandon",
                                                fontSize: 11,
                                                color: Hexcolor("#F59379"),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      child: Column(
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(left: 5),
                                            child: Text(
                                              "Desember",
                                              style: TextStyle(
                                                fontFamily: "Brandon",
                                                fontSize: 11,
                                                color: Hexcolor("#F59379"),
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            // margin: EdgeInsets.only(left: 10),
                                            child: Text(
                                              "2021",
                                              style: TextStyle(
                                                fontFamily: "Brandon",
                                                fontSize: 11,
                                                color: Hexcolor('#F48262'),
                                                fontWeight: FontWeight.w600,
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
                  Container(
                    height: 20,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 45, right: 45),
                    height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Container(
                          child: Column(
                            children: <Widget>[
                              Container(
                                child: Text(
                                  "DEWY",
                                  style: TextStyle(
                                    fontFamily: "Brandon",
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                    fontSize: 12,
                                    letterSpacing: 1,
                                  ),
                                ),
                              ),
                              Container(
                                child: Text(
                                  "SKIN",
                                  style: TextStyle(
                                    fontFamily: "Yeseva",
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          child: LinearPercentIndicator(
                            width: 210.0,
                            lineHeight: 8.0,
                            percent: 0.4,
                            progressColor: Colors.white,
                          ),
                        ),
                        Container(
                          child: Column(
                            children: <Widget>[
                              Container(
                                child: Text(
                                  "HEALTHY",
                                  style: TextStyle(
                                    fontFamily: "Brandon",
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                              Container(
                                child: Text(
                                  "SKIN",
                                  style: TextStyle(
                                    fontFamily: "Yeseva",
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                    fontSize: 12,
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
                    child: Column(
                      children: <Widget>[
                        Container(
                          child: Text(
                            "Belanja 1.750.000 lagi untuk naik tingkat",
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.white,
                              fontWeight: FontWeight.w800,
                              fontFamily: "Brandon",
                            ),
                          ),
                        ),
                        Container(
                          child: Text("ke Healthy Skin",
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.white,
                                fontWeight: FontWeight.w800,
                                fontFamily: "Brandon",
                              )),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                top: 0,
                left: 30,
                right: 30,
                bottom: 20,
              ),
              height: 560,
              child: ListView(
                physics: NeverScrollableScrollPhysics(),
                primary: false,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MenungguPembayaranScreen()),
                      );
                    },
                    child: Container(
                      decoration: new BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            width: 2,
                            color: Hexcolor("#F59379"),
                          ),
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            margin:
                                EdgeInsets.only(bottom: 5, left: 15, right: 15),
                            child: Icon(
                              Icons.watch_later,
                              size: 35,
                              color: Hexcolor("#F59379"),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(left: 0),
                                  child: Text(
                                    "Menunggu Pembayaran",
                                    style: TextStyle(
                                      fontFamily: "Brandon",
                                      fontWeight: FontWeight.w700,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                                Container(
                                  // width: 150,
                                  child: Text(
                                    "Purchased Items",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontFamily: "Brandon",
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PembayaranDiterimaScreen()),
                      );
                    },
                    child: Container(
                      decoration: new BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            width: 2,
                            color: Hexcolor("#F59379"),
                          ),
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            margin:
                                EdgeInsets.only(bottom: 5, left: 15, right: 15),
                            child: Icon(
                              Icons.shopping_cart,
                              size: 35,
                              color: Hexcolor("#F59379"),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 5, bottom: 5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(left: 0),
                                  child: Text(
                                    "Pembayaran Diterima",
                                    style: TextStyle(
                                      fontFamily: "Brandon",
                                      fontWeight: FontWeight.w700,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                                Container(
                                  // width: 150,
                                  child: Text(
                                    "Purchased Items",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontFamily: "Brandon",
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DalamPerjalananScreen()),
                      );
                    },
                    child: Container(
                      decoration: new BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            width: 2,
                            color: Hexcolor("#F59379"),
                          ),
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            margin:
                                EdgeInsets.only(bottom: 5, left: 15, right: 15),
                            child: Image.asset(
                              'assets/images/Asset 7.png',
                              width: 30,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 5, bottom: 5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(left: 0),
                                  child: Text(
                                    "Dalam Perjalanan",
                                    style: TextStyle(
                                      fontFamily: "Brandon",
                                      fontWeight: FontWeight.w700,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                                Container(
                                  // width: 150,
                                  child: Text(
                                    "Purchased Items",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontFamily: "Brandon",
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TerkirimScreen()),
                      );
                    },
                    child: Container(
                      decoration: new BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            width: 2,
                            color: Hexcolor("#F59379"),
                          ),
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            margin:
                                EdgeInsets.only(bottom: 5, left: 15, right: 15),
                            child: Icon(
                              Icons.directions_car,
                              size: 35,
                              color: Hexcolor("#F59379"),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 5, bottom: 5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(left: 0),
                                  child: Text(
                                    "Terkirim",
                                    style: TextStyle(
                                      fontFamily: "Brandon",
                                      fontWeight: FontWeight.w700,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                                Container(
                                  // width: 150,
                                  child: Text(
                                    "Purchased Items",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontFamily: "Brandon",
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PesananSelesaiScreen()),
                      );
                    },
                    child: Container(
                      decoration: new BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            width: 2,
                            color: Hexcolor("#F59379"),
                          ),
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(
                                bottom: 10, left: 15, right: 15, top: 10),
                            child: Image.asset(
                              'assets/images/Asset 8.png',
                              width: 32,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 5, top: 5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(top: 0),
                                  child: Text(
                                    "Pesanan Selesai",
                                    style: TextStyle(
                                      fontFamily: "Brandon",
                                      fontWeight: FontWeight.w700,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                                Container(
                                  // width: 150,
                                  child: Text(
                                    "Purchased Items",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontFamily: "Brandon",
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => UlasanProdukScreen()),
                      );
                    },
                    child: Container(
                      decoration: new BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            width: 2,
                            color: Hexcolor("#F59379"),
                          ),
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(
                                bottom: 10, left: 15, right: 15, top: 10),
                            child: Image.asset(
                              'assets/images/Asset 9.png',
                              width: 34,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 5, top: 5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(left: 0),
                                  child: Text(
                                    "Ulasan Produk",
                                    style: TextStyle(
                                      fontFamily: "Brandon",
                                      fontWeight: FontWeight.w700,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                                Container(
                                  // width: 150,
                                  child: Text(
                                    "Purchased Items",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontFamily: "Brandon",
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DaftarKeinginanScreen()),
                      );
                    },
                    child: Container(
                      decoration: new BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            width: 2,
                            color: Hexcolor("#F59379"),
                          ),
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(
                                bottom: 10, left: 15, right: 15, top: 10),
                            child: Image.asset(
                              'assets/images/Asset 10.png',
                              width: 30,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 5, top: 5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(left: 0),
                                  child: Text(
                                    "Daftar Keinginan",
                                    style: TextStyle(
                                      fontFamily: "Brandon",
                                      fontWeight: FontWeight.w700,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                                Container(
                                  // width: 150,
                                  child: Text(
                                    "Purchased Items",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontFamily: "Brandon",
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DetailAkunScreen()),
                      );
                    },
                    child: Container(
                      child: Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(
                                bottom: 10, left: 15, right: 15, top: 10),
                            child: Image.asset(
                              'assets/images/Asset 11.png',
                              width: 30,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 5, top: 5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(left: 0),
                                  child: Text(
                                    "Detail Akun",
                                    style: TextStyle(
                                      fontFamily: "Brandon",
                                      fontWeight: FontWeight.w700,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                                Container(
                                  // width: 150,
                                  child: Text(
                                    "Purchased Items",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontFamily: "Brandon",
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 20,
              color: Colors.white,
              width: MediaQuery.of(context).size.width,
            ),
            Container(
              margin: EdgeInsets.only(
                top: 0,
                left: 30,
                right: 30,
                bottom: 10,
              ),
              height: 300,
              child: ListView(
                physics: NeverScrollableScrollPhysics(),
                primary: false,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BeautyProfileScreen()),
                      );
                    },
                    child: Container(
                      decoration: new BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            width: 2,
                            color: Hexcolor("#F59379"),
                          ),
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            margin:
                                EdgeInsets.only(bottom: 5, left: 15, right: 15),
                            child: Image.asset(
                              'assets/images/Asset 12.png',
                              width: 30,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(left: 0),
                                  child: Text(
                                    "Beauty Profile",
                                    style: TextStyle(
                                      fontFamily: "Brandon",
                                      fontWeight: FontWeight.w700,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                                Container(
                                  // width: 150,
                                  child: Text(
                                    "Purchased Items",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontFamily: "Brandon",
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HappySkinRewardScreen()),
                      );
                    },
                    child: Container(
                      decoration: new BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            width: 2,
                            color: Hexcolor("#F59379"),
                          ),
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(
                                bottom: 10, left: 15, right: 15, top: 10),
                            child: Image.asset(
                              'assets/images/Asset 13.png',
                              width: 30,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 5, top: 5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(top: 0),
                                  child: Text(
                                    "Happy Skin Reward",
                                    style: TextStyle(
                                      fontFamily: "Brandon",
                                      fontWeight: FontWeight.w700,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                                Container(
                                  // width: 150,
                                  child: Text(
                                    "Purchased Items",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontFamily: "Brandon",
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    decoration: new BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          width: 2,
                          color: Hexcolor("#F59379"),
                        ),
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                              bottom: 10, left: 15, right: 15, top: 10),
                          child: Image.asset(
                            'assets/images/Asset 14.png',
                            width: 30,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 5, top: 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 0),
                                child: Text(
                                  "Keuntungan Happy Skin Reward",
                                  style: TextStyle(
                                    fontFamily: "Brandon",
                                    fontWeight: FontWeight.w700,
                                    fontSize: 17,
                                  ),
                                ),
                              ),
                              Container(
                                // width: 150,
                                child: Text(
                                  "Purchased Items",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontFamily: "Brandon",
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey,
                                    fontSize: 16,
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
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                              bottom: 10, left: 15, right: 15, top: 10),
                          child: Image.asset(
                            'assets/images/Asset 15.png',
                            width: 30,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 5, top: 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 0),
                                child: Text(
                                  "Rincian Point",
                                  style: TextStyle(
                                    fontFamily: "Brandon",
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                              Container(
                                // width: 150,
                                child: Text(
                                  "Purchased Items",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontFamily: "Brandon",
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey,
                                    fontSize: 16,
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
            Container(
              height: 20,
              color: Colors.white,
              width: MediaQuery.of(context).size.width,
            ),
            Container(
              margin: EdgeInsets.only(
                top: 0,
                left: 30,
                right: 30,
                bottom: 0,
              ),
              height: 570,
              child: ListView(
                physics: NeverScrollableScrollPhysics(),
                primary: false,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(bottom: 10),
                    decoration: new BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          width: 2,
                          color: Hexcolor("#F59379"),
                        ),
                      ),
                    ),
                    child: Text(
                      "BUTUH BANTUAN ?",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        fontFamily: "Brandon",
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(bottom: 15, top: 15),
                    decoration: new BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          width: 2,
                          color: Hexcolor("#F59379"),
                        ),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Text(
                            "Tentang Ponny Beaute",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w200,
                              fontFamily: "Brandon",
                            ),
                          ),
                        ),
                        Container(
                          child: Icon(
                            Icons.arrow_forward_ios,
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(bottom: 15, top: 15),
                    decoration: new BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          width: 2,
                          color: Hexcolor("#F59379"),
                        ),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Text(
                            "Pengiriman",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w200,
                              fontFamily: "Brandon",
                            ),
                          ),
                        ),
                        Container(
                          child: Icon(
                            Icons.arrow_forward_ios,
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(bottom: 15, top: 15),
                    decoration: new BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          width: 2,
                          color: Hexcolor("#F59379"),
                        ),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Text(
                            "FAQ",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w200,
                              fontFamily: "Brandon",
                            ),
                          ),
                        ),
                        Container(
                          child: Icon(
                            Icons.arrow_forward_ios,
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(bottom: 15, top: 15),
                    decoration: new BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          width: 2,
                          color: Hexcolor("#F59379"),
                        ),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Text(
                            "Hubungi Kami",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w200,
                              fontFamily: "Brandon",
                            ),
                          ),
                        ),
                        Container(
                          child: Icon(
                            Icons.arrow_forward_ios,
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(bottom: 15, top: 15),
                    decoration: new BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          width: 2,
                          color: Hexcolor("#F59379"),
                        ),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Text(
                            "Konsultasi",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w200,
                              fontFamily: "Brandon",
                            ),
                          ),
                        ),
                        Container(
                          child: Icon(
                            Icons.arrow_forward_ios,
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(bottom: 15, top: 15),
                    decoration: new BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          width: 2,
                          color: Hexcolor("#F59379"),
                        ),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Text(
                            "Syarat dan Ketentuan",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w200,
                              fontFamily: "Brandon",
                            ),
                          ),
                        ),
                        Container(
                          child: Icon(
                            Icons.arrow_forward_ios,
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(bottom: 15, top: 15),
                    decoration: new BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          width: 2,
                          color: Hexcolor("#F59379"),
                        ),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Text(
                            "Kebijakan Privasi",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w200,
                              fontFamily: "Brandon",
                            ),
                          ),
                        ),
                        Container(
                          child: Icon(
                            Icons.arrow_forward_ios,
                          ),
                        )
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AffiliateUsScreen()),
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.only(bottom: 15, top: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Text(
                              "Affiliate with us",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w200,
                                fontFamily: "Brandon",
                              ),
                            ),
                          ),
                          Container(
                            child: Icon(
                              Icons.arrow_forward_ios,
                            ),
                          )
                        ],
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
