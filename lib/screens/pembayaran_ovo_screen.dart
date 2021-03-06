import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ponny/widgets/PonnyBottomNavbar.dart';
import 'package:ponny/screens/pesanan_berhasil_screen.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';

class PembayaranOvoScreen extends StatefulWidget {
  static const String id = "pembayaran_ovo_screen";

  @override
  _PembayaranOvoScreenState createState() => _PembayaranOvoScreenState();
}

class _PembayaranOvoScreenState extends State<PembayaranOvoScreen> {
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
                        'Ovo',
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
                  margin: EdgeInsets.only(top: 10),
                  width: MediaQuery.of(context).size.width*0.9,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Image.asset(
                      'assets/images/payment/ovo-02.png',
                      height: 40,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  width: MediaQuery.of(context).size.width*0.9,
                  child: Html(
                    data: """
                      <div>
                        <p>Cara Pembayaran Melalui OVO</p>
                        <ol>
                          <li>Pastikan kamu sudah login di aplikasi OVO</li>
                          <li>Pembayaran dengan OVO akan kadaluarsa dalam 30 detik setelah kamu klik ‘”Lanjut Pembayaran”</li>
                          <li>Buka aplikasi OVO dan lihat pada bagian notifikasi untuk melakukan pembayaran</li>
                          <li>Pilih cara pembayaran dengan “OVO CASH” atau “OVO POINT” atau kombinasi keduanya, kemudian klik “Bayar”</li>
                          <li>Pembayaranmu diverifikasi secara otomatis, kamu akan langsung menerima konfirmasi di layar gadget-mu jika pembayaran dengan OVO berhasil</li>
                        </ol>
                      </div>
                    """,
                    style: {
                      "div": Style(
                        fontFamily: 'Brandon',
                        textAlign: TextAlign.justify,
                      ),
                    },
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: FractionalOffset.bottomCenter,
                    child: Container(
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
                              .pushReplacementNamed(PesananBerhasilScreen.id);
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
    );
  }
}
