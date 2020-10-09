import 'package:flutter/material.dart';
import 'package:ponny/widgets/PonnyBottomNavbar.dart';

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
                    width: MediaQuery.of(context).size.width * 0.95,
                    padding: EdgeInsets.all(15),
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
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width * 0.25,
                            padding: EdgeInsets.only(right: 7),
                            child: Image.asset(
                              'assets/images/produk_1.png',
                              width: MediaQuery.of(context).size.width,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.35,
                            padding: EdgeInsets.only(right: 7),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Skin Game',
                                  style: TextStyle(
                                    fontFamily: 'Yeseva',
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  'Acne Warrior',
                                  style: TextStyle(
                                    fontFamily: 'Brandon',
                                    fontSize: 14,
                                  ),
                                ),
                                Text(
                                  'Rp. 125.000',
                                  style: TextStyle(
                                    fontFamily: 'Brandon',
                                    fontSize: 15,
                                    color: Color(0xffF48262),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 10),
                                  child: Text(
                                    'JUMLAH',
                                    style: TextStyle(
                                        fontFamily: 'Brandon', fontSize: 12),
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Color(0xffF48262)),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Wrap(
                                    crossAxisAlignment: WrapCrossAlignment.center,
                                    children: <Widget>[
                                      SizedBox(
                                          width: 25,
                                          height: 25,
                                          child: FloatingActionButton(
                                            backgroundColor: Color(0xffFDF8F0),
                                            elevation: 0.0,
                                            highlightElevation: 0.0,
                                            heroTag: "btnmin1",
                                            child: Text(
                                              '-',
                                              style: TextStyle(
                                                color: Color(0xffF48262),
                                                fontFamily: 'Brandon',
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                            onPressed: minus1,
                                          )
                                      ),
                                      Container(
                                        padding: EdgeInsets.symmetric(horizontal: 10),
                                        child: Text('$_n1'),
                                      ),
                                      SizedBox(
                                          width: 25,
                                          height: 25,
                                          child: FloatingActionButton(
                                            backgroundColor: Color(0xffFDF8F0),
                                            elevation: 0.0,
                                            highlightElevation: 0.0,
                                            heroTag: "btnplus1",
                                            child: Text(
                                              '+',
                                              style: TextStyle(
                                                color: Color(0xffF48262),
                                                fontFamily: 'Brandon',
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                            onPressed: add1,
                                          )
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.25,
                            child: Column(
                              children: <Widget>[
                                Container(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        'TOTAL',
                                        style: TextStyle(
                                            fontFamily: 'Brandon',
                                            fontSize: 12
                                        ),
                                      ),
                                      Text(
                                        'Rp 200.000',
                                        style: TextStyle(
                                            fontFamily: 'Brandon',
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Align(
                                    alignment: Alignment.bottomRight,
                                    child: Icon(
                                      Icons.delete_outline,
                                      color: Color(0xffF48262),
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
                    width: MediaQuery.of(context).size.width * 0.95,
                    padding: EdgeInsets.all(15),
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
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width * 0.25,
                            padding: EdgeInsets.only(right: 7),
                            child: Image.asset(
                              'assets/images/produk_1.png',
                              width: MediaQuery.of(context).size.width,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.35,
                            padding: EdgeInsets.only(right: 7),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Skin Game',
                                  style: TextStyle(
                                    fontFamily: 'Yeseva',
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  'Acne Warrior',
                                  style: TextStyle(
                                    fontFamily: 'Brandon',
                                    fontSize: 14,
                                  ),
                                ),
                                Text(
                                  'Rp. 125.000',
                                  style: TextStyle(
                                    fontFamily: 'Brandon',
                                    fontSize: 15,
                                    color: Color(0xffF48262),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 10),
                                  child: Text(
                                    'JUMLAH',
                                    style: TextStyle(
                                        fontFamily: 'Brandon', fontSize: 12),
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Color(0xffF48262)),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Wrap(
                                    crossAxisAlignment: WrapCrossAlignment.center,
                                    children: <Widget>[
                                      SizedBox(
                                          width: 25,
                                          height: 25,
                                          child: FloatingActionButton(
                                            backgroundColor: Color(0xffFDF8F0),
                                            elevation: 0.0,
                                            highlightElevation: 0.0,
                                            heroTag: "btnmin2",
                                            child: Text(
                                              '-',
                                              style: TextStyle(
                                                color: Color(0xffF48262),
                                                fontFamily: 'Brandon',
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                            onPressed: minus2,
                                          )
                                      ),
                                      Container(
                                        padding: EdgeInsets.symmetric(horizontal: 10),
                                        child: Text('$_n2'),
                                      ),
                                      SizedBox(
                                          width: 25,
                                          height: 25,
                                          child: FloatingActionButton(
                                            backgroundColor: Color(0xffFDF8F0),
                                            elevation: 0.0,
                                            highlightElevation: 0.0,
                                            heroTag: "btnplus2",
                                            child: Text(
                                              '+',
                                              style: TextStyle(
                                                color: Color(0xffF48262),
                                                fontFamily: 'Brandon',
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                            onPressed: add2,
                                          )
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.25,
                            child: Column(
                              children: <Widget>[
                                Container(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        'TOTAL',
                                        style: TextStyle(
                                            fontFamily: 'Brandon',
                                            fontSize: 12
                                        ),
                                      ),
                                      Text(
                                        'Rp 200.000',
                                        style: TextStyle(
                                            fontFamily: 'Brandon',
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Align(
                                    alignment: Alignment.bottomRight,
                                    child: Icon(
                                      Icons.delete_outline,
                                      color: Color(0xffF48262),
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
