import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ponny/widgets/PonnyBottomNavbar.dart';
import 'dart:math' as math;

class ShippingScreen extends StatefulWidget {
  static const String id = "shipping_screen";

  @override
  _ShippingScreenState createState() => _ShippingScreenState();
}

class _ShippingScreenState extends State<ShippingScreen> {
  @override
  void initState() {
    super.initState();
  }

  int _n1 = 1;
  int _n2 = 1;

  void add1() {
    setState(() {
      _n1++;
    });
  }

  void add2() {
    setState(() {
      _n2++;
    });
  }

  void minus1() {
    setState(() {
      if (_n1 != 1)
        _n1--;
    });
  }

  void minus2() {
    setState(() {
      if (_n2 != 1)
        _n2--;
    });
  }

  String dropdownValue = 'One';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Stack(children: <Widget>[
        Scaffold(
          backgroundColor: Color(0xffFDF8F0),
          body: Container(
            margin: MediaQuery.of(context).padding,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Color(0xffF48262),
                          width: 1.0,
                        ),
                      ),
                    ),
                    child: Row(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(right: 10),
                          child: Icon(
                            Icons.arrow_back_ios,
                            color: Color(0xffF48262),
                          ),
                        ),
                        Text(
                          'Detail Pengiriman',
                          style: TextStyle(
                            fontFamily: 'Yeseva',
                            fontSize: 26,
                            color: Color(0xffF48262),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 25),
                    width: MediaQuery.of(context).size.width*0.9,
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xffF48262)),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Container(
                      padding: EdgeInsets.only(top: 7),
                      child: IntrinsicHeight(
                        child: Column(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(bottom: 7),
                                    child: Row(
                                      children: <Widget>[
                                        Icon(
                                          Icons.place,
                                          color: Color(0xffF48262),
                                          size: 16,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 5),
                                          child: Text(
                                            'Alamat Pengiriman',
                                            style: TextStyle(
                                              fontFamily: 'Brandon',
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text(
                                    'Aninda Anita',
                                    style: TextStyle(
                                      fontFamily: 'Brandon',
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    'Jl. Jakarta utara no.123, kecamatan Penjaringan',
                                    style: TextStyle(
                                      fontFamily: 'Brandon',
                                      fontSize: 14,
                                    ),
                                  ),
                                  Text(
                                    'Jakarta Utara, DKI Jakarta,1440',
                                    style: TextStyle(
                                      fontFamily: 'Brandon',
                                      fontSize: 14,
                                    ),
                                  ),
                                  Text(
                                    '08123456789',
                                    style: TextStyle(
                                      fontFamily: 'Brandon',
                                      fontSize: 14,
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      Icon(
                                        Icons.edit,
                                        color: Color(0xffF48262),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 5),
                                      ),
                                      Icon(
                                        Icons.delete_outline,
                                        color: Color(0xffF48262),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(top: 5),
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: Color(0xffF48262),
                                    width: 1.0,
                                  ),
                                ),
                              ),
                            ),
                            Row(
                              children: <Widget>[
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(vertical: 10),
                                    decoration: BoxDecoration(
                                      border: Border(
                                        right: BorderSide(
                                          color: Color(0xffF48262),
                                          width: 1.0,
                                        ),
                                      ),
                                    ),
                                    child: Text(
                                      'Pilih Alamat Lain',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: 'Brandon',
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(vertical: 10),
                                    child: Text(
                                      'Tambah Alamat Baru',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: 'Brandon',
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 15),
                    width: MediaQuery.of(context).size.width*0.9,
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xffF48262)),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Container(
                      padding: EdgeInsets.only(top: 7),
                      child: IntrinsicHeight(
                        child: Column(
                          children: <Widget>[
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(bottom: 7),
                                    child: Theme(
                                      data: Theme.of(context).copyWith(
                                        dividerColor: Colors.transparent,
                                        accentColor: Colors.black,
                                        unselectedWidgetColor: Colors.black,
                                      ),
                                      child: ListTileTheme(
                                        contentPadding: EdgeInsets.symmetric(horizontal: 15),
                                        child: ExpansionTile(
                                          title: Text(
                                            'Pengiriman',
                                            style: TextStyle(
                                              fontFamily: 'Brandon',
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          trailing: Transform.rotate(
                                            angle: 90 * math.pi / 180,
                                            child: Icon(
                                              Icons.chevron_right,
                                              color: Color(0xffF48262),
                                            ),
                                          ),
                                          children: [
                                            Container(
                                              padding: EdgeInsets.symmetric(horizontal: 15),
                                              decoration: BoxDecoration(
                                                border: Border(
                                                  bottom: BorderSide(
                                                    color: Color(0xffF48262),
                                                    width: 1.0,
                                                  ),
                                                ),
                                              ),
                                              child: IntrinsicHeight(
                                                child: Row(
                                                  children: <Widget>[
                                                    Expanded(
                                                      flex: 4,
                                                      child: Container(
                                                        padding: EdgeInsets.symmetric(vertical: 10),
                                                        child: Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Text(
                                                              'J&T Express',
                                                              style: TextStyle(
                                                                fontFamily: 'Brandon',
                                                                fontWeight: FontWeight.w600,
                                                              ),
                                                            ),
                                                            Text(
                                                              'Receive by 28 Jun - 4 Jul',
                                                              style: TextStyle(
                                                                fontFamily: 'Brandon',
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 3,
                                                      child: Container(
                                                        padding: EdgeInsets.symmetric(vertical: 10),
                                                        child: Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Text(
                                                              'Rp 10.000',
                                                              style: TextStyle(
                                                                fontFamily: 'Brandon',
                                                              ),
                                                            ),
                                                          ]
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Container(
                                              padding: EdgeInsets.symmetric(horizontal: 15),
                                              decoration: BoxDecoration(
                                                border: Border(
                                                  bottom: BorderSide(
                                                    color: Color(0xffF48262),
                                                    width: 1.0,
                                                  ),
                                                ),
                                              ),
                                              child: IntrinsicHeight(
                                                child: Row(
                                                  children: <Widget>[
                                                    Expanded(
                                                      flex: 4,
                                                      child: Container(
                                                        padding: EdgeInsets.symmetric(vertical: 10),
                                                        child: Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Text(
                                                              'J&T Express',
                                                              style: TextStyle(
                                                                fontFamily: 'Brandon',
                                                                fontWeight: FontWeight.w600,
                                                              ),
                                                            ),
                                                            Text(
                                                              'Receive by 28 Jun - 4 Jul',
                                                              style: TextStyle(
                                                                fontFamily: 'Brandon',
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 3,
                                                      child: Container(
                                                        padding: EdgeInsets.symmetric(vertical: 10),
                                                        child: Column(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              Text(
                                                                'Rp 10.000',
                                                                style: TextStyle(
                                                                  fontFamily: 'Brandon',
                                                                ),
                                                              ),
                                                            ]
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Container(
                                              padding: EdgeInsets.symmetric(horizontal: 15),
                                              decoration: BoxDecoration(
                                                border: Border(
                                                  bottom: BorderSide(
                                                    color: Color(0xffF48262),
                                                    width: 1.0,
                                                  ),
                                                ),
                                              ),
                                              child: IntrinsicHeight(
                                                child: Row(
                                                  children: <Widget>[
                                                    Expanded(
                                                      flex: 4,
                                                      child: Container(
                                                        padding: EdgeInsets.symmetric(vertical: 10),
                                                        child: Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Text(
                                                              'J&T Express',
                                                              style: TextStyle(
                                                                fontFamily: 'Brandon',
                                                                fontWeight: FontWeight.w600,
                                                              ),
                                                            ),
                                                            Text(
                                                              'Receive by 28 Jun - 4 Jul',
                                                              style: TextStyle(
                                                                fontFamily: 'Brandon',
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 3,
                                                      child: Container(
                                                        padding: EdgeInsets.symmetric(vertical: 10),
                                                        child: Column(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              Text(
                                                                'Rp 10.000',
                                                                style: TextStyle(
                                                                  fontFamily: 'Brandon',
                                                                ),
                                                              ),
                                                            ]
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Container(
                                              padding: EdgeInsets.symmetric(horizontal: 15),
                                              decoration: BoxDecoration(
                                                border: Border(
                                                  bottom: BorderSide(
                                                    color: Color(0xffF48262),
                                                    width: 1.0,
                                                  ),
                                                ),
                                              ),
                                              child: IntrinsicHeight(
                                                child: Row(
                                                  children: <Widget>[
                                                    Expanded(
                                                      flex: 4,
                                                      child: Container(
                                                        padding: EdgeInsets.symmetric(vertical: 10),
                                                        child: Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Text(
                                                              'J&T Express',
                                                              style: TextStyle(
                                                                fontFamily: 'Brandon',
                                                                fontWeight: FontWeight.w600,
                                                              ),
                                                            ),
                                                            Text(
                                                              'Receive by 28 Jun - 4 Jul',
                                                              style: TextStyle(
                                                                fontFamily: 'Brandon',
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 3,
                                                      child: Container(
                                                        padding: EdgeInsets.symmetric(vertical: 10),
                                                        child: Column(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              Text(
                                                                'Rp 10.000',
                                                                style: TextStyle(
                                                                  fontFamily: 'Brandon',
                                                                ),
                                                              ),
                                                            ]
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Container(
                                              padding: EdgeInsets.symmetric(horizontal: 15),
                                              decoration: BoxDecoration(
                                                border: Border(
                                                  bottom: BorderSide(
                                                    color: Color(0xffF48262),
                                                    width: 1.0,
                                                  ),
                                                ),
                                              ),
                                              child: IntrinsicHeight(
                                                child: Row(
                                                  children: <Widget>[
                                                    Expanded(
                                                      flex: 4,
                                                      child: Container(
                                                        padding: EdgeInsets.symmetric(vertical: 10),
                                                        child: Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Text(
                                                              'J&T Express',
                                                              style: TextStyle(
                                                                fontFamily: 'Brandon',
                                                                fontWeight: FontWeight.w600,
                                                              ),
                                                            ),
                                                            Text(
                                                              'Receive by 28 Jun - 4 Jul',
                                                              style: TextStyle(
                                                                fontFamily: 'Brandon',
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 3,
                                                      child: Container(
                                                        padding: EdgeInsets.symmetric(vertical: 10),
                                                        child: Column(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              Text(
                                                                'Rp 10.000',
                                                                style: TextStyle(
                                                                  fontFamily: 'Brandon',
                                                                ),
                                                              ),
                                                            ]
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
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
                    margin: EdgeInsets.only(top: 15, bottom: 25),
                    width: MediaQuery.of(context).size.width*0.9,
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xffF48262)),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 7),
                      child: IntrinsicHeight(
                        child: Column(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    'SUB TOTAL',
                                    style: TextStyle(
                                      fontFamily: 'Brandon',
                                      fontSize: 14,
                                    ),
                                  ),
                                  Text(
                                    'Rp 400.000',
                                    style: TextStyle(
                                      fontFamily: 'Brandon',
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 12),
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: Color(0xffF48262),
                                    width: 1.0,
                                  ),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    'BIAYA PENGIRIMAN',
                                    style: TextStyle(
                                      fontFamily: 'Brandon',
                                      fontSize: 14,
                                    ),
                                  ),
                                  Text(
                                    'Rp 10.000',
                                    style: TextStyle(
                                      fontFamily: 'Brandon',
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 15, right: 15, top: 12, bottom: 5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    'TOTAL PESANAN',
                                    style: TextStyle(
                                      fontFamily: 'Brandon',
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Text(
                                    'Rp 360.000',
                                    style: TextStyle(
                                      fontFamily: 'Brandon',
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 12),
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: Color(0xffF48262),
                                    width: 1.0,
                                  ),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    'Poin yang didapat',
                                    style: TextStyle(
                                      fontFamily: 'Brandon',
                                      fontSize: 14,
                                    ),
                                  ),
                                  Text(
                                    '+ 50',
                                    style: TextStyle(
                                      fontFamily: 'Brandon',
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 15, right: 15, top: 12, bottom: 5),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Gratis ongkir dengan pembelian minimal Rp 250.000',
                                  style: TextStyle(
                                    fontFamily: 'Brandon',
                                    fontSize: 12,
                                    color: Color(0xffF48262),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      ]),
      bottomNavigationBar: Wrap(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              color: Color(0xfffdf8f0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Center(
              child: Container(
                width: MediaQuery.of(context).size.width*0.95,
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'TOTAL PESANAN',
                          style: TextStyle(
                            fontFamily: 'Brandon',
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          'Rp 360.000',
                          style: TextStyle(
                            fontFamily: 'Brandon',
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    Center(
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: FlatButton(
                          color: Color(0xffF48262),
                          child: Text(
                            'LANJUT PEMBAYARAN',
                            style: TextStyle(
                              fontFamily: 'Brandon',
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(7.0),
                          ),
                          onPressed: (){},
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          new PonnyBottomNavbar(selectedIndex: 1),
        ],
      ),
    );
  }
}
