import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ponny/model/OrderResult.dart';
import 'package:ponny/model/listCabangModel.dart';
import 'package:ponny/screens/account_screen.dart';
import 'package:ponny/screens/konsultasi_screen.dart';
import 'package:ponny/widgets/PonnyBottomNavbar.dart';
import 'package:ponny/screens/home_screen.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:ponny/screens/Order_Screen.dart';
import 'package:intl/intl.dart';
import 'dart:convert';

import 'package:provider/provider.dart';

class PesananBerhasilScreen extends StatefulWidget {
  static const String id = "pesanan_berhasil_screen";

  String code;
  int typeDigital;
  OrderResult nota;
  PesananBerhasilScreen({Key key, this.code, this.typeDigital, this.nota});

  @override
  _PesananBerhasilScreenState createState() => _PesananBerhasilScreenState();
}

class _PesananBerhasilScreenState extends State<PesananBerhasilScreen> {
  @override
  void initState() {
    super.initState();
  }

  Future<bool> _onWillPop() async {
    if (widget.typeDigital == 1) {
      return Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => KonsultasiScreen(),
        ),
      );
    } else {
      return Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => OrderScreen(
            type: OrderScreen.unpaid,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    print("objectaaaaaaaaaaaa" + widget.nota.codParam.toString());
    final formatCurrency = new NumberFormat.simpleCurrency(locale: 'id_ID');
    int _moneyCounter;
    var cabang = Provider.of<ListCabang>(context).cabangClick;
    return new WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
          appBar: AppBar(
            titleSpacing: 0.0,
            elevation: 0.0,
            leading: IconButton(
              onPressed: () {
                if (widget.typeDigital == 1) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => KonsultasiScreen(),
                    ),
                  );
                } else {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OrderScreen(
                        type: OrderScreen.unpaid,
                      ),
                    ),
                  );
                }
              },
              icon: Icon(
                Icons.arrow_back_ios_rounded,
                color: Color(0xffF48262),
              ),
            ),
            title: Text(
              'Pesanan Berhasil',
              style: TextStyle(
                fontSize: 24,
                fontFamily: 'Yeseva',
                color: Hexcolor('#F48262'),
              ),
            ),
            bottom: PreferredSize(
                child: Container(
                  color: Color(0xffF48262),
                  height: 1.0,
                ),
                preferredSize: Size.fromHeight(1.0)),
          ),
          resizeToAvoidBottomInset: false,
          backgroundColor: Hexcolor('#FCF8F0'),
          body: Stack(children: <Widget>[
            Scaffold(
              backgroundColor: Color(0xffFDF8F0),
              body: Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: 30),
                      child: Icon(
                        Icons.check_circle,
                        color: Color(0xffF48262),
                        size: 65,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 14),
                      child: Text(
                        'TERIMA KASIH!',
                        style: TextStyle(
                          fontFamily: 'Brandon',
                          fontSize: 22,
                        ),
                      ),
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        'Transaksi #' + widget.code,
                        style: TextStyle(
                          fontFamily: 'Brandon',
                          fontSize: 12,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      child: Column(
                        children: [
                          Text(
                            // "10000",
                            cabang != null
                                ? widget.nota.mitransRequest != null
                                    ? 'Total Pembayaran Rp ${widget.nota.mitransRequest.grossAmount.substring(0, widget.nota.mitransRequest.grossAmount.lastIndexOf('.'))}'
                                    : "Total Pembayaran  ${formatCurrency.format(widget.nota.codParam)}"
                                : 'Total Pembayaran Rp ${widget.nota.mitransRequest.grossAmount.substring(0, widget.nota.mitransRequest.grossAmount.lastIndexOf('.'))}',
                            // 'Total Pembayaran Rp ${widget.nota.mitransRequest.grossAmount.substring(0, widget.nota.mitransRequest.grossAmount.lastIndexOf('.'))}',
                            style: TextStyle(
                              fontFamily: 'Brandon',
                              fontSize: 12,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            cabang != null
                                ? widget.nota.mitrans_val != null
                                    ? 'Metode Pembayaran ${widget.nota.mitrans_val.mitrans_val}'
                                    : "Metode Pembayaran COD (Cash on Delivery)"
                                : "Metode Pembayaran " +
                                    widget.nota.mitrans_val.mitrans_val,
                            // 'Metode Pembayaran ${widget.nota.mitrans_val.mitrans_val} ',
                            style: TextStyle(
                              fontFamily: 'Brandon',
                              fontSize: 12,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Provider.of<ListCabang>(context).cabangClick == null
                              ? SizedBox()
                              : Text(
                                  "Lokasi Pengambilan :",
                                  style: TextStyle(
                                      fontFamily: 'Brandon',
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600),
                                  textAlign: TextAlign.center,
                                ),
                          Provider.of<ListCabang>(context).cabangClick == null
                              ? SizedBox()
                              : Container(
                                  margin: EdgeInsets.only(top: 6),
                                  child: Text(
                                    Provider.of<ListCabang>(context)
                                        .cabangClick
                                        .namaCabang,
                                    style: TextStyle(
                                        fontFamily: 'Brandon',
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                          Provider.of<ListCabang>(context).cabangClick == null
                              ? SizedBox()
                              : Text(
                                  Provider.of<ListCabang>(context)
                                      .cabangClick
                                      .alamatCabang,
                                  style: TextStyle(
                                    fontFamily: 'Brandon',
                                    fontSize: 12,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      child: Text(
                        'Pesananmu sudah kami terima.\nCek email untuk lihat bukti pembelanjaanmu.\nTerima kasih sudah berbelanja di Ponny Beaute.\nPhoebe tunggu review-mu'
                            .toUpperCase(),
                        style: TextStyle(
                          fontFamily: 'Brandon',
                          fontSize: 12,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Expanded(
                      child: Align(
                        alignment: FractionalOffset.bottomCenter,
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.95,
                          padding: EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          child: FlatButton(
                            color: Color(0xffF48262),
                            child: Text(
                              'BELANJA LAGI',
                              style: TextStyle(
                                fontFamily: 'Brandon',
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(7.0),
                            ),
                            onPressed: () {
                              Provider.of<ListCabang>(context).cabangClick =
                                  null;
                              Provider.of<ListCabang>(context).isDelivery =
                                  null;
                              Provider.of<ListCabang>(context).pointValue =
                                  false;
                              Navigator.of(context)
                                  .pushReplacementNamed(HomeScreen.id);
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ]),
          bottomNavigationBar: new PonnyBottomNavbar(selectedIndex: 1),
        ));
  }
}
