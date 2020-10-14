import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ponny/widgets/PonnyBottomNavbar.dart';

class KonfirmasiPembayaranScreen extends StatefulWidget {
  static const String id = "konfirmasi_pembayaran_screen";

  @override
  _KonfirmasiPembayaranScreenState createState() => _KonfirmasiPembayaranScreenState();
}

class _KonfirmasiPembayaranScreenState extends State<KonfirmasiPembayaranScreen> {
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
                          'Konfirmasi Pembayaran',
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
                    color: Color(0xffF48262),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                            padding: EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'NOMOR PESANAN',
                                  style: TextStyle(
                                    fontFamily: 'Brandon',
                                    color: Colors.white,
                                    fontSize: 14,
                                  ),
                                ),
                                Text(
                                  'WKSKDKAL',
                                  style: TextStyle(
                                    fontFamily: 'Brandon',
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            padding: EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  'TOTAL PESANAN',
                                  style: TextStyle(
                                    fontFamily: 'Brandon',
                                    color: Colors.white,
                                    fontSize: 14,
                                  ),
                                ),
                                Text(
                                  'Rp 469.000',
                                  style: TextStyle(
                                    fontFamily: 'Brandon',
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
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
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                    child: IntrinsicHeight(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Metode Pembayaran',
                                style: TextStyle(
                                  fontFamily: 'Brandon',
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                'Transfer Bank BCA',
                                style: TextStyle(
                                  fontFamily: 'Brandon',
                                ),
                              ),
                            ],
                          ),
                          Image.asset(
                            'assets/images/payment/bca-02.png',
                            height: 40,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
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
                    margin: EdgeInsets.symmetric(vertical: 10),
                    width: MediaQuery.of(context).size.width*0.9,
                    decoration: BoxDecoration(
                      color: Color(0xffFDEDE3),
                      border: Border.all(color: Color(0xffF48262)),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 30),
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.only(bottom: 10),
                              child: Icon(
                                Icons.add,
                                size: 50,
                              ),
                            ),
                            Text(
                              'Upload Bukti Pembayaran',
                              style: TextStyle(
                                fontFamily: 'Brandon',
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              '(max. 5MB)',
                              style: TextStyle(
                                fontFamily: 'Brandon',
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.95,
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Padding(
                            padding: EdgeInsets.only(right: 10),
                            child: FlatButton(
                              color: Color(0xffF48262),
                              child: Text(
                                'BATAL',
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
                        Expanded(
                          flex: 1,
                          child: Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: FlatButton(
                              color: Color(0xffF48262),
                              child: Text(
                                'KONFIRMASI',
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
