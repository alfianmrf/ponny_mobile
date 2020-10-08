import 'package:flutter/material.dart';
import 'package:ponny/screens/terkirim_screen.dart';
import 'package:ponny/widgets/PonnyBottomNavbar.dart';

class CartScreen extends StatefulWidget {
  static const String id = "cart_screen";

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
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
                    child: Text(
                      'Keranjang Belanja',
                      style: TextStyle(
                        fontFamily: 'Yeseva',
                        fontSize: 26,
                        color: Color(0xffF48262),
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
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.all(15),
                    child: IntrinsicHeight(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                            width: MediaQuery.of(context).size.width*0.4,
                            decoration: BoxDecoration(
                              color: Color(0xffF48262),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Image.asset("assets/images/pilih_sample.png"),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      'PILIH SAMPLE',
                                      style: TextStyle(
                                          fontFamily: 'Brandon',
                                          fontSize: 12,
                                          color: Colors.white
                                      ),
                                    ),
                                    Text(
                                      'YANG KAMU',
                                      style: TextStyle(
                                          fontFamily: 'Brandon',
                                          fontSize: 12,
                                          color: Colors.white
                                      ),
                                    ),
                                    Text(
                                      'INGINKAN: 2/2',
                                      style: TextStyle(
                                          fontFamily: 'Brandon',
                                          fontSize: 12,
                                          color: Colors.white
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                            width: MediaQuery.of(context).size.width*0.4,
                            decoration: BoxDecoration(
                              color: Color(0xffF48262),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Image.asset("assets/images/tukar_poin.png"),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      'TUKAR POIN MU',
                                      style: TextStyle(
                                          fontFamily: 'Brandon',
                                          fontSize: 12,
                                          color: Colors.white
                                      ),
                                    ),
                                  ],
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
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 7),
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'KODE PROMO',
                                  style: TextStyle(
                                    fontFamily: 'Brandon',
                                    fontSize: 14,
                                  ),
                                ),
                                Text(
                                  'HBDPHOEBE',
                                  style: TextStyle(
                                    fontFamily: 'Brandon',
                                    fontSize: 16,
                                  ),
                                ),
                              ]
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              Expanded(
                                child: Align(
                                  alignment: Alignment.bottomRight,
                                  child: Text(
                                    'PAKAI',
                                    style: TextStyle(
                                      fontFamily: 'Brandon',
                                      fontSize: 14,
                                      color: Color(0xffF48262),
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
                  Container(
                    width: MediaQuery.of(context).size.width * 0.95,
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 7),
                    child: IntrinsicHeight(
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 5),
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
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  'POTONGAN DISKON',
                                  style: TextStyle(
                                    fontFamily: 'Brandon',
                                    fontSize: 14,
                                  ),
                                ),
                                Text(
                                  'Rp 50.000',
                                  style: TextStyle(
                                    fontFamily: 'Brandon',
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  'TOTAL',
                                  style: TextStyle(
                                    fontFamily: 'Brandon',
                                    fontSize: 14,
                                  ),
                                ),
                                Text(
                                  'Rp 350.000',
                                  style: TextStyle(
                                    fontFamily: 'Brandon',
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  'Poin yang didapat',
                                  style: TextStyle(
                                    fontFamily: 'Brandon',
                                    fontSize: 14,
                                    color: Color(0xffF48262),
                                  ),
                                ),
                                Text(
                                  '+ 2000',
                                  style: TextStyle(
                                    fontFamily: 'Brandon',
                                    fontSize: 14,
                                    color: Color(0xffF48262),
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
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 7),
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
                ],
              ),
            ),
          ),
        )
      ]),
      bottomNavigationBar: new PonnyBottomNavbar(selectedIndex: 1),
    );
  }
}
