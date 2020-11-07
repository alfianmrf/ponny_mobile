import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:ponny/widgets/PonnyBottomNavbar.dart';

class KartuScreen extends StatefulWidget {
  static const String id = "kartu_screen";

  @override
  _KartuScreenState createState() => _KartuScreenState();
}

class _KartuScreenState extends State<KartuScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Hexcolor('#FCF8F0'),
          body: Column(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  margin: EdgeInsets.all(5),
                  child: Row(
                    children: [
                      Container(
                        child: IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.arrow_back_ios,
                              color: Color(0xffF48262),
                              size: 26,
                            )),
                      ),
                      Container(
                        child: Text(
                          "Kartu Kredit/Debit",
                          style: TextStyle(
                            fontSize: 24,
                            fontFamily: "Yeseva",
                            fontWeight: FontWeight.w500,
                            color: Color(0xffF48262),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                height: 1,
                color: Color(0xffF3C1B5),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  width: double.infinity,
                  color: Color(0xffF48262),
                  child: Column(
                    children: [
                      Expanded(
                        child: FittedBox(
                          fit: BoxFit.fitWidth,
                          child: Text(
                            "Total Pesanan",
                            style: TextStyle(
                                fontSize: 24,
                                fontFamily: "Brandon",
                                color: Colors.white),
                          ),
                        ),
                      ),
                      Expanded(
                        child: FittedBox(
                          fit: BoxFit.fitWidth,
                          child: Text(
                            "Rp. 469.000",
                            style: TextStyle(
                                fontSize: 24,
                                fontFamily: "Brandon",
                                color: Colors.white,
                                fontWeight: FontWeight.w800),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Expanded(
                                flex: 1,
                                child: Image.asset(
                                    "assets/images/payment/visa-02.png")),
                            Expanded(
                                flex: 1,
                                child: Image.asset(
                                    "assets/images/payment/mastercard-02.png")),
                            Expanded(flex: 2, child: Container()),
                            Expanded(
                                flex: 1,
                                child: Image.asset(
                                    "assets/images/secureGuarantee.PNG")),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(10),
                        child: Text(
                          "Kartu Kredit/Debit",
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: "Brandon",
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(10),
                        child: Text(
                          "Kamu akan dialihkan ke laman Veritrans untuk menyelesaikan proses pembayaran",
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: "Brandon",
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 5,
                child: Wrap(
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      color: Color(0xffF3C1B5),
                      width: double.infinity,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.favorite,
                            color: Color(0xffF48262),
                          ),
                          Container(
                            width: 280,
                            child: Text(
                              "Catatan: Voucher dan bentuk promosi lainnya tidak dapat digabungkan untuk pembelian kamu.",
                              style: TextStyle(
                                fontSize: 14,
                                fontFamily: "Brandon",
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                  flex: 1,
                  child: Card(
                    child: Container(
                        color: Hexcolor('#FCF8F0'),
                        width: double.infinity,
                        padding: EdgeInsets.all(5),
                        child: RaisedButton(
                          color: Color(0xffF48262),
                          onPressed: () {},
                          child: FittedBox(
                            fit: BoxFit.fitWidth,
                            child: Text(
                              "LANJUT PEMBAYARAN",
                              style: TextStyle(
                                  color: Colors.white, fontFamily: "Brandon"),
                            ),
                          ),
                        )),
                  ))
            ],
          ),
          bottomNavigationBar: new PonnyBottomNavbar(selectedIndex: 4)),
    );
  }
}
