import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ponny/common/constant.dart';
import 'package:ponny/model/Address.dart';
import 'package:ponny/model/App.dart';
import 'package:ponny/model/Cart.dart';
import 'package:ponny/model/Order.dart';
import 'package:ponny/model/Voucher.dart';
import 'package:ponny/screens/Qris_screen.dart';
import 'package:ponny/screens/account/menunggu_pembayaran_sukses_screen.dart';
import 'package:ponny/screens/home_screen.dart';
import 'package:ponny/screens/pesanan_berhasil_screen.dart';
import 'package:ponny/widgets/PonnyBottomNavbar.dart';
import 'package:ponny/screens/bank_transfer_screen.dart';
import 'package:ponny/screens/pembayaran_ovo_screen.dart';
import 'package:ponny/screens/pembayaran_gopay_screen.dart';
import 'package:provider/provider.dart';
import 'package:uiblock/uiblock.dart';

class PaymentVoucherScreen extends StatefulWidget {
  static const String id = "payment_screen_voucher";
  Voucher voucher;
  int qty;
  PaymentVoucherScreen({Key key,@required this.voucher,@required this.qty});

  @override
  _PaymentVoucherScreenState createState() => _PaymentVoucherScreenState();
}

class _PaymentVoucherScreenState extends State<PaymentVoucherScreen> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
  }

  Future<bool> chekOut(BuildContext context,String method) async {
    bool result =false;
    UIBlock.block(context,customLoaderChild: LoadingWidget(context));
    var param ={
      "qty" : widget.qty,
      "payment":method
    };

    final value = await Provider.of<VoucherModel>(context).checkOut(Provider.of<AppModel>(context).auth.access_token,  param);
      if(value != null){
        UIBlock.unblock(context);
        result =true;
          if(method == "qris"){
            Navigator.pushAndRemoveUntil(context,new MaterialPageRoute(
              builder: (BuildContext context) => new QrisScreen(title: "QRIS",urlQR: value.mitransRequest.actions.firstWhere((element) => element.name == "generate-qr-code").url,type:QrisScreen.qris),
            ),(_) => false);
          }else if(method == "ovo"){
            Navigator.pushAndRemoveUntil(context,new MaterialPageRoute(
              builder: (BuildContext context) => new QrisScreen(title: "OVO",urlQR: value.mitransRequest.actions.firstWhere((element) => element.name == "generate-qr-code").url, type:QrisScreen.ovo),
            ),(_) => false);
          }else if(method == "shopeepay"){
            Navigator.pushAndRemoveUntil(context,new MaterialPageRoute(
              builder: (BuildContext context) => new QrisScreen(title: "SHOPEEPAY",urlQR: value.mitransRequest.actions.firstWhere((element) => element.name == "generate-qr-code").url,type:QrisScreen.shopee),
            ),(_) => false);
          }
          else{
            Navigator.pushAndRemoveUntil(context,new MaterialPageRoute(
              builder: (BuildContext context) => new PesananBerhasilScreen(code: value.orderCode,),
            ),(_) => false);
          }

      }else{
        final snackBar = SnackBar(
          content: Text('Terjadi kesalah Pada Server, Silakan coba kembali nanti!',style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.redAccent,
        );
        scaffoldKey.currentState.showSnackBar(snackBar);
      }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
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
                          'Metode Pembayaran',
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
                    margin: EdgeInsets.only(top: 25, bottom: 25),
                    width: MediaQuery.of(context).size.width*0.9,
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xffF48262)),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Container(
                        child: IntrinsicHeight(
                          child: Column(
                            children: <Widget>[
                              Container(
                                color: Color(0xffFDEDE4),
                                width: MediaQuery.of(context).size.width,
                                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                                child: Text(
                                  'VIRTUAL ACCOUNT (Konfirmasi Otomatis)',
                                  style: TextStyle(
                                    fontFamily: 'Brandon',
                                    fontSize: 14,
                                    color: Color(0xffF48262),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () async {
                                  final result = await chekOut(context,"mt_tf_bca");
                                  if(result){
                                    Navigator.pop(context,true);
                                  }
                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Image.asset(
                                            'assets/images/payment/bca-02.png',
                                            height: 40,
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(left: 10),
                                            child: Text(
                                              'BCA Virtual Account',
                                              style: TextStyle(
                                                fontFamily: 'Brandon',
                                                fontSize: 14,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Icon(
                                        Icons.chevron_right,
                                        color: Color(0xffF48262),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () async {
                                  final result = await chekOut(context,"mt_tf_mdr");
                                  if(result){
                                    Navigator.pop(context,true);
                                  }
                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Image.asset(
                                            'assets/images/payment/mandiri-02.png',
                                            height: 40,
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(left: 10),
                                            child: Text(
                                              'Mandiri Virtual Account',
                                              style: TextStyle(
                                                fontFamily: 'Brandon',
                                                fontSize: 14,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Icon(
                                        Icons.chevron_right,
                                        color: Color(0xffF48262),
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              InkWell(
                                onTap: () async {

                                  final result = await chekOut(context,"mt_tf_bni");
                                  if(result){
                                    Navigator.pop(context,true);
                                  }
                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Image.asset(
                                            'assets/images/payment/bni-02.png',
                                            height: 40,
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(left: 10),
                                            child: Text(
                                              'BNI Virtual Account',
                                              style: TextStyle(
                                                fontFamily: 'Brandon',
                                                fontSize: 14,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Icon(
                                        Icons.chevron_right,
                                        color: Color(0xffF48262),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  chekOut(context,"mt_tf_bri");
                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Image.asset(
                                            'assets/images/payment/bri-02.png',
                                            height: 40,
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(left: 10),
                                            child: Text(
                                              'BRI Virtual Account (BRIVA)',
                                              style: TextStyle(
                                                fontFamily: 'Brandon',
                                                fontSize: 14,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Icon(
                                        Icons.chevron_right,
                                        color: Color(0xffF48262),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () async {
                                  final result = await chekOut(context,"mt_tf_permata");
                                  if(result){
                                    Navigator.pop(context,true);
                                  }
                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Image.asset(
                                            'assets/images/payment/permata-02.png',
                                            height: 40,
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(left: 10),
                                            child: Text(
                                              'Permata Virtual Account',
                                              style: TextStyle(
                                                fontFamily: 'Brandon',
                                                fontSize: 14,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Icon(
                                        Icons.chevron_right,
                                        color: Color(0xffF48262),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                color: Color(0xffFDEDE4),
                                width: MediaQuery.of(context).size.width,
                                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                                child: Text(
                                  'OVER THE COUNTER (Alfamart/Indomart)',
                                  style: TextStyle(
                                    fontFamily: 'Brandon',
                                    fontSize: 14,
                                    color: Color(0xffF48262),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              /*
                              InkWell(
                                onTap: () {
                                  chekOut(context,"Indomaret");
                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Image.asset(
                                            'assets/images/payment/indomaret-02.png',
                                            height: 40,
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(left: 10),
                                            child: Text(
                                              'Indomaret',
                                              style: TextStyle(
                                                fontFamily: 'Brandon',
                                                fontSize: 14,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Icon(
                                        Icons.chevron_right,
                                        color: Color(0xffF48262),
                                      ),
                                    ],
                                  ),
                                ),
                              ),*/
                              InkWell(
                                onTap: () {
                                  chekOut(context,"alfamart");
                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Image.asset(
                                            'assets/images/payment/alfamart-02.png',
                                            height: 40,
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(left: 10),
                                            child: Text(
                                              'Alfamart',
                                              style: TextStyle(
                                                fontFamily: 'Brandon',
                                                fontSize: 14,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Icon(
                                        Icons.chevron_right,
                                        color: Color(0xffF48262),
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              Container(
                                color: Color(0xffFDEDE4),
                                width: MediaQuery.of(context).size.width,
                                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                                child: Text(
                                  'MOBILE PAYMENT',
                                  style: TextStyle(
                                    fontFamily: 'Brandon',
                                    fontSize: 14,
                                    color: Color(0xffF48262),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  chekOut(context,"ovo");
                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Image.asset(
                                            'assets/images/payment/ovo-02.png',
                                            height: 40,
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(left: 10),
                                            child: Text(
                                              'OVO',
                                              style: TextStyle(
                                                fontFamily: 'Brandon',
                                                fontSize: 14,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Icon(
                                        Icons.chevron_right,
                                        color: Color(0xffF48262),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.push(context,new MaterialPageRoute(
                                    builder: (BuildContext context) => new PembayaranGopayScreen(method:PembayaranGopayScreen.gopay,),
                                  ));
                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Image.asset(
                                            'assets/images/payment/gopay-02.png',
                                            height: 40,
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(left: 10),
                                            child: Text(
                                              'GOPAY',
                                              style: TextStyle(
                                                fontFamily: 'Brandon',
                                                fontSize: 14,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Icon(
                                        Icons.chevron_right,
                                        color: Color(0xffF48262),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  chekOut(context,"shopeepay");
                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Image.asset(
                                            'assets/images/payment/shopee_pay.png',
                                            height: 25,
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(left: 10),
                                            child: Text(
                                              'SHOPEEPAY',
                                              style: TextStyle(
                                                fontFamily: 'Brandon',
                                                fontSize: 14,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Icon(
                                        Icons.chevron_right,
                                        color: Color(0xffF48262),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              /*Container(
                                color: Color(0xffFDEDE4),
                                width: MediaQuery.of(context).size.width,
                                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                                child: Text(
                                  'KARTU KREDIT/DEBIT',
                                  style: TextStyle(
                                    fontFamily: 'Brandon',
                                    fontSize: 14,
                                    color: Color(0xffF48262),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Image.asset(
                                          'assets/images/payment/visa-02.png',
                                          height: 20,
                                        ),
                                        Image.asset(
                                          'assets/images/payment/mastercard-02.png',
                                          height: 20,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 10),
                                          child: Text(
                                            'Credit Card / Debit Card',
                                            style: TextStyle(
                                              fontFamily: 'Brandon',
                                              fontSize: 14,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Icon(
                                      Icons.chevron_right,
                                      color: Color(0xffF48262),
                                    ),
                                  ],
                                ),
                              ),*/
                              Container(
                                color: Color(0xffFDEDE4),
                                width: MediaQuery.of(context).size.width,
                                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                                child: Text(
                                  'METODE PEMBAYARAN LAINNYA',
                                  style: TextStyle(
                                    fontFamily: 'Brandon',
                                    fontSize: 14,
                                    color: Color(0xffF48262),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: (){
                                  chekOut(context,"qris");
                                },
                                child:Container(
                                  width: MediaQuery.of(context).size.width,
                                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(left: 5),
                                            child: Text(
                                              'QRIS',
                                              style: TextStyle(
                                                fontFamily: 'Brandon',
                                                fontSize: 14,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Icon(
                                        Icons.chevron_right,
                                        color: Color(0xffF48262),
                                      ),
                                    ],
                                  ),
                                ) ,
                              ),
                            ],
                          ),
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
      bottomNavigationBar: new PonnyBottomNavbar(selectedIndex: 1),
    );
  }
}
