import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ponny/common/constant.dart';
import 'package:ponny/model/Address.dart';
import 'package:ponny/model/App.dart';
import 'package:ponny/model/Cart.dart';
import 'package:ponny/model/Voucher.dart';
import 'package:ponny/widgets/PonnyBottomNavbar.dart';
import 'package:ponny/screens/pesanan_berhasil_screen.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:provider/provider.dart';
import 'package:uiblock/uiblock.dart';
import 'package:url_launcher/url_launcher.dart';

class PembayaranGopayVoucherScreen extends StatefulWidget {
  static const String id = "pembayaran_gopay_voucher_screen";
  static const String ovo ="ovo";
  static const String shopeepay ="shopeepay";
  static const String gopay ="gopay";

  Voucher voucher;
  int qty;
  String method;
  PembayaranGopayVoucherScreen({Key key, this.method,this.voucher,this.qty});

  @override
  _PembayaranGopayVoucherScreenState createState() => _PembayaranGopayVoucherScreenState();
}

class _PembayaranGopayVoucherScreenState extends State<PembayaranGopayVoucherScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
  }

  _launchURL(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    final card = Provider.of<CartModel>(context,listen: false);

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Stack(children: <Widget>[
        Scaffold(
          key: scaffoldKey,
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
                        'Gopay',
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
                          nm_format.format( int.parse(widget.voucher.harga)*widget.qty),
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
                      'assets/images/payment/gopay-02.png',
                      height: 40,
                    ),
                  ),
                ),
                if(widget.method == PembayaranGopayVoucherScreen.gopay)
                  Container(
                    alignment: Alignment.centerLeft,
                    width: MediaQuery.of(context).size.width*0.9,
                    child: Html(
                      data: """
                      <div>
                        <p>Cara Pembayaran Melalui GOPAY</p>
                        <ol>
                          <li>Pastikan kamu sudah login di aplikasi GOPAY</li>
                          <li>Kamu akan dialihkan ke aplikasi GOJEK. untuk menyelesaikan proses pembayaran</li>
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
                if(widget.method == PembayaranGopayVoucherScreen.ovo)
                  Container(
                    alignment: Alignment.centerLeft,
                    width: MediaQuery.of(context).size.width*0.9,
                    child: Html(
                      data: """
                       <div>
                        <p>Cara Pembayaran Melalui OVO</p>
                        <ol>
                          <li>Screenshot layar ponsel anda yang terdapat QR code.</li>
                          <li>Buka aplikasi OVO pada layar ponsel anda.</li>
                          <li>Tekan tombol SCAN/PINDAI pada aplikasi OVO anda.</li>
                          <li>Lalu tekan tombol "add photo" lalu pilih screenshot QR code anda.</li>
                          <li>Sistem OVO dengan otomatis akan membaca QR code anda.</li>
                          <li>Konfirmasi rincian pesanan anda. Jika sudah sesuai, klik Konfirmasi untuk melanjutkan.</li>
                          <li>Masukan pin OVO anda.</li>
                          <li>Transaksi selesai.</li>
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
                if(widget.method == PembayaranGopayVoucherScreen.shopeepay)
                  Container(
                    alignment: Alignment.centerLeft,
                    width: MediaQuery.of(context).size.width*0.9,
                    child: Html(
                      data: """
                       <div>
                        <p>Cara Pembayaran Melalui SHOPEEPAY</p>
                        <ol>
                          <li>Screenshot layar ponsel anda yang terdapat QR code.</li>
                          <li>Buka aplikasi SHOPEE pada layar ponsel anda.</li>
                          <li>Tekan tombol SCAN/PINDAI pada aplikasi SHOPEE anda.</li>
                          <li>Lalu tekan tombol "add photo" lalu pilih screenshot QR code anda.</li>
                          <li>Sistem OVO dengan otomatis akan membaca QR code anda.</li>
                          <li>Konfirmasi rincian pesanan anda. Jika sudah sesuai, klik Konfirmasi untuk melanjutkan.</li>
                          <li>Masukan pin SHOPEE anda.</li>
                          <li>Transaksi selesai.</li>
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
                        onPressed: () async {
                          UIBlock.block(context,customLoaderChild: LoadingWidget(context));
                          var param ={
                            "qty" : widget.qty,
                            "payment":widget.method
                          };
                          Provider.of<VoucherModel>(context).checkOut(Provider.of<AppModel>(context).auth.access_token,  param).then((value) {
                            UIBlock.unblock(context);
                            if(value!= null && value.success){
                              if(widget.method == PembayaranGopayVoucherScreen.gopay){
                                print(value.mitransRequest.actions.length);
                                final redirect = value.mitransRequest.actions.firstWhere((element) => element.name == "deeplink-redirect");
                                print(redirect.name);
                                if(redirect != null){
                                  _launchURL(redirect.url);
                                }

                              }

                            }else{
                              UIBlock.unblock(context);
                              print(value.message);
                              final snackBar = SnackBar(
                                content: Text('Terjadi kesalah Pada Server, Silakan coba kembali nanti!',style: TextStyle(color: Colors.white)),
                                backgroundColor: Colors.redAccent,
                              );
                              scaffoldKey.currentState.showSnackBar(snackBar);
                            }
                          }).catchError((onError){
                            UIBlock.unblock(context);
                            final snackBar = SnackBar(
                              content: Text('Terjadi kesalah Pada Server, Silakan coba kembali nanti!',style: TextStyle(color: Colors.white)),
                              backgroundColor: Colors.redAccent,
                            );
                            scaffoldKey.currentState.showSnackBar(snackBar);
                            print(onError);
                          });

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
