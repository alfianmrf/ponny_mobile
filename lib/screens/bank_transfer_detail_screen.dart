import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ponny/widgets/PonnyBottomNavbar.dart';

class BankTransferDetailScreen extends StatefulWidget {
  static const String id = "bank_transfer_detail_screen";

  @override
  _BankTransferDetailScreenState createState() => _BankTransferDetailScreenState();
}

class _BankTransferDetailScreenState extends State<BankTransferDetailScreen> {
  @override
  void initState() {
    super.initState();
  }

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
                          'Bank Transfer',
                          style: TextStyle(
                            fontFamily: 'Yeseva',
                            fontSize: 22,
                            color: Color(0xffF48262),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    child: Text(
                      'SELESAIKAN PEMBAYARAN',
                      style: TextStyle(
                        fontFamily: 'Yeseva',
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    color: Color(0xffF48262),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 20),
                            decoration: BoxDecoration(
                              border: Border(
                                right: BorderSide( //                   <--- left side
                                  color: Colors.white,
                                  width: 3.0,
                                ),
                              ),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  'NOMOR PESANAN',
                                  style: TextStyle(
                                    fontFamily: 'Brandon',
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  'WKSKDKAL',
                                  style: TextStyle(
                                    fontFamily: 'Brandon',
                                    color: Colors.white,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 20),
                            child: Column(
                              children: [
                                Text(
                                  'TOTAL PESANAN',
                                  style: TextStyle(
                                    fontFamily: 'Brandon',
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  'Rp 469.000',
                                  style: TextStyle(
                                    fontFamily: 'Brandon',
                                    color: Colors.white,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 20),
                            decoration: BoxDecoration(
                              border: Border(
                                left: BorderSide( //                   <--- left side
                                  color: Colors.white,
                                  width: 3.0,
                                ),
                              ),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  'KODE UNIK',
                                  style: TextStyle(
                                    fontFamily: 'Brandon',
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  'Rp 21',
                                  style: TextStyle(
                                    fontFamily: 'Brandon',
                                    color: Colors.white,
                                    fontSize: 14,
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
                    padding: EdgeInsets.only(top: 15),
                    child: Text(
                      'TRANSFER KE',
                      style: TextStyle(
                        fontFamily: 'Brandon',
                      ),
                    ),
                  ),
                  Image.asset(
                    'assets/images/payment/bca-02.png',
                    height: 40,
                  ),
                  Text(
                    'a/n PT.Ponny Beaute Indonesia',
                    style: TextStyle(
                      fontFamily: 'Brandon',
                    ),
                  ),
                  Text(
                    '1234567899',
                    style: TextStyle(
                      fontFamily: 'Brandon',
                      fontSize: 18,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 10),
                    child: SizedBox(
                      height: 20,
                      width: 70,
                      child: OutlineButton(
                        color: Color(0xffF48262),
                        child: Text(
                          'Salin',
                          style: TextStyle(
                            fontFamily: 'Brandon',
                            fontSize: 12,
                          ),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        borderSide: BorderSide(
                          color: Color(0xffF48262),
                          style: BorderStyle.solid,
                          width: 1,
                        ),
                        highlightedBorderColor: Color(0xffF48262),
                        onPressed: (){},
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 15),
                    child: Text(
                      'JUMLAH YANG HARUS DIBAYAR',
                      style: TextStyle(
                        fontFamily: 'Brandon',
                      ),
                    ),
                  ),
                  Text(
                    'Rp 469.021',
                    style: TextStyle(
                      fontFamily: 'Brandon',
                      fontSize: 18,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 10),
                    child: SizedBox(
                      height: 20,
                      width: 70,
                      child: OutlineButton(
                        color: Color(0xffF48262),
                        child: Text(
                          'Salin',
                          style: TextStyle(
                            fontFamily: 'Brandon',
                            fontSize: 12,
                          ),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        borderSide: BorderSide(
                          color: Color(0xffF48262),
                          style: BorderStyle.solid,
                          width: 1,
                        ),
                        highlightedBorderColor: Color(0xffF48262),
                        onPressed: (){},
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 15),
                    child: Text(
                      'Pastikan kamu melakukan pembayaran dalam waktu 24 jam\nsetelah pesanan dibuat untuk menghindari pembatalan otomatis\ndan silahkan lakukan konfirmasi pembayaran jika kamu sudah\nmelakukan pembayaran di halaman my account.',
                      style: TextStyle(
                        fontFamily: 'Brandon',
                        fontSize: 12,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.95,
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    child: FlatButton(
                      color: Color(0xffF48262),
                      child: Text(
                        'KONFIRMASI PEMBAYARAN',
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
