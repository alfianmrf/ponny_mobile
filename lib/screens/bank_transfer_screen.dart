import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ponny/widgets/PonnyBottomNavbar.dart';
import 'package:ponny/screens/bank_transfer_detail_screen.dart';

class BankTransferScreen extends StatefulWidget {
  static const String id = "bank_transfer_screen";
  @override
  _BankTransferScreenState createState() => _BankTransferScreenState();
}

class _BankTransferScreenState extends State<BankTransferScreen> {
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
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(vertical: 20),
                    color: Color(0xffF48262),
                    child: Center(
                      child: Column(
                        children: [
                          Text(
                            'TOTAL PESANAN',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Brandon',
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            'Rp 469.000',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Brandon',
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 25, bottom: 25),
                    width: MediaQuery.of(context).size.width*0.9,
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xffF48262)),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: IntrinsicHeight(
                          child: Column(
                            children: <Widget>[
                              Container(
                                width: MediaQuery.of(context).size.width,
                                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Nama Bank',
                                      style: TextStyle(
                                        fontFamily: 'Brandon',
                                      ),
                                    ),
                                    Text(
                                      'Bank BCA',
                                      style: TextStyle(
                                        fontFamily: 'Brandon',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Nomor Rekening',
                                      style: TextStyle(
                                        fontFamily: 'Brandon',
                                      ),
                                    ),
                                    Text(
                                      '12334567890',
                                      style: TextStyle(
                                        fontFamily: 'Brandon',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                padding: EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 15),
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
                                  children: [
                                    Text(
                                      'Nama Pemilik Rekening',
                                      style: TextStyle(
                                        fontFamily: 'Brandon',
                                      ),
                                    ),
                                    Text(
                                      'Aninda Anita',
                                      style: TextStyle(
                                        fontFamily: 'Brandon',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                padding: EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 0),
                                child: Center(
                                  child: Text(
                                    'UBAH',
                                    style: TextStyle(
                                      fontFamily: 'Brandon',
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
                      onPressed: (){
                        Navigator.of(context)
                            .pushReplacementNamed(BankTransferDetailScreen.id);
                      },
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
