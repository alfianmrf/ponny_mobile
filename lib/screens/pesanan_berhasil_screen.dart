import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ponny/model/OrderResult.dart';
import 'package:ponny/screens/account_screen.dart';
import 'package:ponny/screens/konsultasi_screen.dart';
import 'package:ponny/widgets/PonnyBottomNavbar.dart';
import 'package:ponny/screens/home_screen.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:ponny/screens/Order_Screen.dart';
import 'dart:convert';

class PesananBerhasilScreen extends StatefulWidget {
  static const String id = "pesanan_berhasil_screen";

  String code;
  int typeDigital;
  OrderResult nota;
  PesananBerhasilScreen({Key key,this.code,this.typeDigital,this.nota});

  @override
  _PesananBerhasilScreenState createState() => _PesananBerhasilScreenState();
}

class _PesananBerhasilScreenState extends State<PesananBerhasilScreen> {
  @override
  void initState() {
    super.initState();
  }

  Future<bool> _onWillPop() async {
    if(widget.typeDigital == 1){
      return Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => KonsultasiScreen(
          ),
        ),
      );
    }else{
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
    return new WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
      appBar: AppBar(
        titleSpacing: 0.0,
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {
            if(widget.typeDigital == 1){
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => KonsultasiScreen(
                  ),
                ),
              );
            }else{
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
                    size: 75,
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 20),
                  child: Text(
                    'TERIMA KASIH!',
                    style: TextStyle(
                      fontFamily: 'Brandon',
                      fontSize: 22,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                    'Transaksi #'+widget.code,
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
                        'Total Pembayaran Rp'+widget.nota.mitransRequest.grossAmount.substring(0, widget.nota.mitransRequest.grossAmount.lastIndexOf('.')),
                        style: TextStyle(
                          fontFamily: 'Brandon',
                          fontSize: 12,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        'Metode Pembayaran '+widget.nota.mitrans_val.mitrans_val,
                        style: TextStyle(
                          fontFamily: 'Brandon',
                          fontSize: 12,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      // Text(
                      //   'No Virtual '+widget.nota.mitransRequest.actions.toString(),
                      //   style: TextStyle(
                      //     fontFamily: 'Brandon',
                      //     fontSize: 12,
                      //   ),
                      //   textAlign: TextAlign.center,
                      // ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  child: Text(
                    'Pesananmu sudah kami terima.\nCek email untuk lihat bukti pembelanjaanmu.\nTerima kasih sudah berbelanja di Ponny Beaute.\nPhoebe tunggu review-mu'.toUpperCase(),
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
                      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
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
                        onPressed: (){
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
      )
    );
  }
}
