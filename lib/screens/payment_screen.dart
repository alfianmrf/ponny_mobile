import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:ponny/common/constant.dart';
import 'package:ponny/model/Address.dart';
import 'package:ponny/model/App.dart';
import 'package:ponny/model/Cart.dart';
import 'package:ponny/model/Order.dart';
import 'package:ponny/model/PaymentMethod.dart';
import 'package:ponny/model/Product.dart';
import 'package:ponny/screens/Qris_screen.dart';
import 'package:ponny/screens/account/menunggu_pembayaran_sukses_screen.dart';
import 'package:ponny/screens/home_screen.dart';
import 'package:ponny/screens/pembayaran_credit_card_screen.dart';
import 'package:ponny/screens/pesanan_berhasil_screen.dart';
import 'package:ponny/screens/bank_transfer_detail_screen.dart';
import 'package:ponny/widgets/PonnyBottomNavbar.dart';
import 'package:ponny/screens/bank_transfer_screen.dart';
import 'package:ponny/screens/pembayaran_ovo_screen.dart';
import 'package:ponny/screens/pembayaran_gopay_screen.dart';
import 'package:provider/provider.dart';
import 'package:uiblock/uiblock.dart';

class PaymentScreen extends StatefulWidget {
  static const String id = "payment_screen";

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      Provider.of<PaymentMethodModel>(context)
          .getListPayment()
          .then((value) => isLoading = false);
    });
  }

  Future<void> chekOut(BuildContext context, String method) {
    final card = Provider.of<CartModel>(context, listen: false);
    showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: new Text('Konfirmasi Pesanan'),
        content: Text("Total Pembayaran: " + card.summary.total),
        actions: <Widget>[
          new FlatButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: new Text('No'),
          ),
          new FlatButton(
            onPressed: () {
              UIBlock.block(context, customLoaderChild: LoadingWidget(context));
              Provider.of<CartModel>(context)
                  .Checkout(
                      Provider.of<AppModel>(context).auth.access_token,
                      Provider.of<AddressModel>(context).useAddress,
                      method,
                      null)
                  .then((value) {
                if (value != null && value.success) {
                  if (method == "qris") {
                    Navigator.pushAndRemoveUntil(
                        context,
                        new MaterialPageRoute(
                          builder: (BuildContext context) => new QrisScreen(
                              title: "QRIS",
                              urlQR: value.mitransRequest.actions
                                  .firstWhere((element) =>
                                      element.name == "generate-qr-code")
                                  .url,
                              type: QrisScreen.qris),
                        ),
                        (_) => false);
                  } else if (method == "ovo") {
                    Navigator.pushAndRemoveUntil(
                        context,
                        new MaterialPageRoute(
                          builder: (BuildContext context) => new QrisScreen(
                              title: "OVO",
                              urlQR: value.mitransRequest.actions
                                  .firstWhere((element) =>
                                      element.name == "generate-qr-code")
                                  .url,
                              type: QrisScreen.ovo),
                        ),
                        (_) => false);
                  } else if (method == "shopeepay") {
                    Navigator.pushAndRemoveUntil(
                        context,
                        new MaterialPageRoute(
                          builder: (BuildContext context) => new QrisScreen(
                              title: "SHOPEEPAY",
                              urlQR: value.mitransRequest.actions
                                  .firstWhere((element) =>
                                      element.name == "generate-qr-code")
                                  .url,
                              type: QrisScreen.shopee),
                        ),
                        (_) => false);
                  } else if (method == "manual_bca" ||
                      method == "manual_mandiri" ||
                      method == "manual_permata" ||
                      method == "manual_bni" ||
                      method == "manual_bri" ||
                      method == "manual_nobu" ||
                      method == "transfer_manual") {
                    Navigator.pushAndRemoveUntil(
                        context,
                        new MaterialPageRoute(
                          builder: (BuildContext context) =>
                              new BankTransferDetailScreen(
                                  order_id: value.orderId),
                        ),
                        (_) => false);
                  } else {
                    Navigator.pushAndRemoveUntil(
                        context,
                        new MaterialPageRoute(
                          builder: (BuildContext context) =>
                              new PesananBerhasilScreen(
                                  code: value.orderCode, nota: value),
                        ),
                        (_) => false);
                  }
                } else {
                  UIBlock.unblock(context);
                  // print(value.message);
                  Navigator.pop(context);
                  final snackBar = SnackBar(
                    content: Text(value.message,
                        style: TextStyle(color: Colors.white)),
                    backgroundColor: Colors.redAccent,
                  );
                  scaffoldKey.currentState.showSnackBar(snackBar);
                }
              }).catchError((onError) {
                // print(onError);
                UIBlock.unblock(context);
                final snackBar = SnackBar(
                  content: Text(onError, style: TextStyle(color: Colors.white)),
                  backgroundColor: Colors.redAccent,
                );
                scaffoldKey.currentState.showSnackBar(snackBar);
                // print(onError);
              });
            },
            child: new Text('Yes'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        titleSpacing: 0.0,
        elevation: 0.0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            color: Color(0xffF48262),
          ),
        ),
        title: Text(
          'Metode Pembayaran',
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
            width: MediaQuery.of(context).size.width,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  isLoading
                      ? Container(
                          height: MediaQuery.of(context).size.width * .2,
                          child: Center(
                            child: LoadingWidgetFadingCircle(context),
                          ),
                        )
                      : Container(
                          child: Container(
                            margin: EdgeInsets.only(top: 25, bottom: 25),
                            width: MediaQuery.of(context).size.width * 0.9,
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
                                      // Virtual Account
                                      if (Provider.of<PaymentMethodModel>(context)
                                              .listPayment
                                              .where((element) =>
                                                  element.code == 'mt_tf_bca' &&
                                                  element.status == 1)
                                              .isNotEmpty ||
                                          Provider.of<PaymentMethodModel>(context)
                                              .listPayment
                                              .where((element) =>
                                                  element.code == 'mt_tf_mdr' &&
                                                  element.status == 1)
                                              .isNotEmpty ||
                                          Provider.of<PaymentMethodModel>(context)
                                              .listPayment
                                              .where((element) =>
                                                  element.code == 'mt_tf_bni' &&
                                                  element.status == 1)
                                              .isNotEmpty ||
                                          Provider.of<PaymentMethodModel>(context)
                                              .listPayment
                                              .where((element) =>
                                                  element.code == 'mt_tf_bri' &&
                                                  element.status == 1)
                                              .isNotEmpty ||
                                          Provider.of<PaymentMethodModel>(
                                                  context)
                                              .listPayment
                                              .where((element) =>
                                                  element.code ==
                                                      'mt_tf_permata' &&
                                                  element.status == 1)
                                              .isNotEmpty)
                                        Container(
                                          color: Color(0xffFDEDE4),
                                          width:
                                              MediaQuery.of(context).size.width,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 15, vertical: 10),
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
                                      if (Provider.of<PaymentMethodModel>(
                                              context)
                                          .listPayment
                                          .where((element) =>
                                              element.code == 'mt_tf_bca' &&
                                              element.status == 1)
                                          .isNotEmpty)
                                        InkWell(
                                          onTap: () {
                                            chekOut(context, "mt_tf_bca");
                                          },
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 15, vertical: 5),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    Image.asset(
                                                      'assets/images/payment/bca-02.png',
                                                      height: 40,
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 10),
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
                                      if (Provider.of<PaymentMethodModel>(
                                              context)
                                          .listPayment
                                          .where((element) =>
                                              element.code == 'mt_tf_mdr' &&
                                              element.status == 1)
                                          .isNotEmpty)
                                        InkWell(
                                          onTap: () {
                                            chekOut(context, "mt_tf_mdr");
                                          },
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 15, vertical: 5),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    Image.asset(
                                                      'assets/images/payment/mandiri-02.png',
                                                      height: 40,
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 10),
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
                                      if (Provider.of<PaymentMethodModel>(
                                              context)
                                          .listPayment
                                          .where((element) =>
                                              element.code == 'mt_tf_bni' &&
                                              element.status == 1)
                                          .isNotEmpty)
                                        InkWell(
                                          onTap: () {
                                            chekOut(context, "mt_tf_bni");
                                          },
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 15, vertical: 5),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    Image.asset(
                                                      'assets/images/payment/bni-02.png',
                                                      height: 40,
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 10),
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
                                      if (Provider.of<PaymentMethodModel>(
                                              context)
                                          .listPayment
                                          .where((element) =>
                                              element.code == 'mt_tf_bri' &&
                                              element.status == 1)
                                          .isNotEmpty)
                                        InkWell(
                                          onTap: () {
                                            chekOut(context, "mt_tf_bri");
                                          },
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 15, vertical: 5),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    Image.asset(
                                                      'assets/images/payment/bri-02.png',
                                                      height: 40,
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 10),
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
                                      if (Provider.of<PaymentMethodModel>(
                                              context)
                                          .listPayment
                                          .where((element) =>
                                              element.code == 'mt_tf_permata' &&
                                              element.status == 1)
                                          .isNotEmpty)
                                        InkWell(
                                          onTap: () {
                                            chekOut(context, "mt_tf_permata");
                                          },
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 15, vertical: 5),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    Image.asset(
                                                      'assets/images/payment/permata-02.png',
                                                      height: 40,
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 10),
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
                                      // Indomaret & Alfamart
                                      if (Provider.of<PaymentMethodModel>(
                                                  context)
                                              .listPayment
                                              .where((element) =>
                                                  element.code == 'Indomaret' &&
                                                  element.status == 1)
                                              .isNotEmpty ||
                                          Provider.of<PaymentMethodModel>(
                                                  context)
                                              .listPayment
                                              .where((element) =>
                                                  element.code == 'alfamart' &&
                                                  element.status == 1)
                                              .isNotEmpty)
                                        Container(
                                          color: Color(0xffFDEDE4),
                                          width:
                                              MediaQuery.of(context).size.width,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 15, vertical: 10),
                                          child: Text(
                                            'OVER THE COUNTER (Alfamart/Indomaret)',
                                            style: TextStyle(
                                              fontFamily: 'Brandon',
                                              fontSize: 14,
                                              color: Color(0xffF48262),
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      if (Provider.of<PaymentMethodModel>(
                                              context)
                                          .listPayment
                                          .where((element) =>
                                              element.code == 'Indomaret' &&
                                              element.status == 1)
                                          .isNotEmpty)
                                        InkWell(
                                          onTap: () {
                                            chekOut(context, "Indomaret");
                                          },
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 15, vertical: 5),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    Image.asset(
                                                      'assets/images/payment/indomaret-02.png',
                                                      height: 40,
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 10),
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
                                        ),
                                      if (Provider.of<PaymentMethodModel>(
                                              context)
                                          .listPayment
                                          .where((element) =>
                                              element.code == 'alfamart' &&
                                              element.status == 1)
                                          .isNotEmpty)
                                        InkWell(
                                          onTap: () {
                                            chekOut(context, "alfamart");
                                          },
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 15, vertical: 5),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    Image.asset(
                                                      'assets/images/payment/alfamart-02.png',
                                                      height: 40,
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 10),
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
                                      // Transfer Manual
                                      Container(
                                        color: Color(0xffFDEDE4),
                                        width:
                                            MediaQuery.of(context).size.width,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 15, vertical: 10),
                                        child: Text(
                                          'BANK TRANSFER (Konfirmasi Manual)',
                                          style: TextStyle(
                                            fontFamily: 'Brandon',
                                            fontSize: 14,
                                            color: Color(0xffF48262),
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),

                                      if (Provider.of<PaymentMethodModel>(
                                              context)
                                          .listPayment
                                          .where((element) =>
                                              element.name == 'MANUAL BCA' &&
                                              element.status == 1)
                                          .isNotEmpty)
                                        InkWell(
                                          onTap: () {
                                            chekOut(context, "manual_bca");
                                          },
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 15, vertical: 5),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    Image.asset(
                                                      'assets/images/payment/bca-02.png',
                                                      height: 40,
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 10),
                                                      child: Text(
                                                        'Bank BCA',
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
                                      if (Provider.of<PaymentMethodModel>(
                                              context)
                                          .listPayment
                                          .where((element) =>
                                              element.name == 'MANUAL BRI' &&
                                              element.status == 1)
                                          .isNotEmpty)
                                        InkWell(
                                          onTap: () {
                                            chekOut(context, "manual_bri");
                                          },
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 15, vertical: 5),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    Image.asset(
                                                      'assets/images/payment/bri-02.png',
                                                      height: 40,
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 10),
                                                      child: Text(
                                                        'Bank BRI',
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
                                      if (Provider.of<PaymentMethodModel>(
                                              context)
                                          .listPayment
                                          .where((element) =>
                                              element.name == 'MANUAL BNI' &&
                                              element.status == 1)
                                          .isNotEmpty)
                                        InkWell(
                                          onTap: () {
                                            chekOut(context, "manual_bni");
                                          },
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 15, vertical: 5),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    Image.asset(
                                                      'assets/images/payment/bni-02.png',
                                                      height: 40,
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 10),
                                                      child: Text(
                                                        'Bank BNI',
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
                                      if (Provider.of<PaymentMethodModel>(
                                              context)
                                          .listPayment
                                          .where((element) =>
                                              element.name == 'MANUAL NOBU' &&
                                              element.status == 1)
                                          .isNotEmpty)
                                        InkWell(
                                          onTap: () {
                                            chekOut(context, "manual_nobu");
                                          },
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            // padding: EdgeInsets.symmetric(
                                            //     horizontal: 15, vertical: 5),
                                            padding: EdgeInsets.only(
                                                left: 0,
                                                right: 15,
                                                top: 5,
                                                bottom: 5),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    Image.asset(
                                                      'assets/images/payment/Nobu-Bank.png',
                                                      height: 46,
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 0),
                                                      child: Text(
                                                        'Bank Nobu',
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

                                      if (Provider.of<PaymentMethodModel>(
                                              context)
                                          .listPayment
                                          .where((element) =>
                                              element.name ==
                                                  'MANUAL MANDIRI' &&
                                              element.status == 1)
                                          .isNotEmpty)
                                        InkWell(
                                          onTap: () {
                                            chekOut(context, "manual_mandiri");
                                          },
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 15, vertical: 5),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    Image.asset(
                                                      'assets/images/payment/mandiri-02.png',
                                                      height: 40,
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 10),
                                                      child: Text(
                                                        'Bank Mandiri',
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
                                      if (Provider.of<PaymentMethodModel>(
                                              context)
                                          .listPayment
                                          .where((element) =>
                                              element.name ==
                                                  'MANUAL PERMATA' &&
                                              element.status == 1)
                                          .isNotEmpty)
                                        InkWell(
                                          onTap: () {
                                            chekOut(context, "manual_permata");
                                          },
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 15, vertical: 5),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    Image.asset(
                                                      'assets/images/payment/permata-02.png',
                                                      height: 40,
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 10),
                                                      child: Text(
                                                        'Bank Permata',
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
                                      if (Provider.of<PaymentMethodModel>(
                                              context)
                                          .listPayment
                                          .where((element) =>
                                              element.name == 'BANK LAIN' &&
                                              element.status == 1)
                                          .isNotEmpty)
                                        InkWell(
                                          onTap: () {
                                            chekOut(context, "transfer_manual");
                                          },
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 15, vertical: 10),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 5),
                                                      child: Text(
                                                        'Bank Lain',
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
                                      // Mobile Payment
                                      if (Provider.of<PaymentMethodModel>(
                                                  context)
                                              .listPayment
                                              .where((element) =>
                                                  element.code == 'ovo' &&
                                                  element.status == 1)
                                              .isNotEmpty ||
                                          Provider.of<PaymentMethodModel>(
                                                  context)
                                              .listPayment
                                              .where((element) =>
                                                  element.code == 'gopay' &&
                                                  element.status == 1)
                                              .isNotEmpty ||
                                          Provider.of<PaymentMethodModel>(
                                                  context)
                                              .listPayment
                                              .where((element) =>
                                                  element.code == 'shopeepay' &&
                                                  element.status == 1)
                                              .isNotEmpty)
                                        Container(
                                          color: Color(0xffFDEDE4),
                                          width:
                                              MediaQuery.of(context).size.width,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 15, vertical: 10),
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
                                      if (Provider.of<PaymentMethodModel>(
                                              context)
                                          .listPayment
                                          .where((element) =>
                                              element.code == 'ovo' &&
                                              element.status == 1)
                                          .isNotEmpty)
                                        InkWell(
                                          onTap: () {
                                            chekOut(context, "ovo");
                                          },
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 15, vertical: 5),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    Image.asset(
                                                      'assets/images/payment/ovo-02.png',
                                                      height: 40,
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 10),
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
                                      if (Provider.of<PaymentMethodModel>(
                                              context)
                                          .listPayment
                                          .where((element) =>
                                              element.code == 'gopay' &&
                                              element.status == 1)
                                          .isNotEmpty)
                                        InkWell(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                new MaterialPageRoute(
                                                  builder: (BuildContext
                                                          context) =>
                                                      new PembayaranGopayScreen(
                                                    method:
                                                        PembayaranGopayScreen
                                                            .gopay,
                                                  ),
                                                ));
                                          },
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 15, vertical: 5),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    Image.asset(
                                                      'assets/images/payment/gopay-02.png',
                                                      height: 40,
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 10),
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
                                      if (Provider.of<PaymentMethodModel>(
                                              context)
                                          .listPayment
                                          .where((element) =>
                                              element.code == 'shopeepay' &&
                                              element.status == 1)
                                          .isNotEmpty)
                                        InkWell(
                                          onTap: () {
                                            chekOut(context, "shopeepay");
                                          },
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 15, vertical: 5),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    Image.asset(
                                                      'assets/images/payment/shopee_pay.png',
                                                      height: 40,
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 10),
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
                                      // Kartu Kredit
                                      if (Provider.of<PaymentMethodModel>(
                                              context)
                                          .listPayment
                                          .where((element) =>
                                              element.code == 'credit_card' &&
                                              element.status == 1)
                                          .isNotEmpty)
                                        Container(
                                          color: Color(0xffFDEDE4),
                                          width:
                                              MediaQuery.of(context).size.width,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 15, vertical: 10),
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
                                      if (Provider.of<PaymentMethodModel>(
                                              context)
                                          .listPayment
                                          .where((element) =>
                                              element.code == 'credit_card' &&
                                              element.status == 1)
                                          .isNotEmpty)
                                        InkWell(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                new MaterialPageRoute(
                                                  builder: (BuildContext
                                                          context) =>
                                                      new PembayaranCreditCardScreen(),
                                                ));
                                          },
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 15, vertical: 15),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
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
                                                      padding: EdgeInsets.only(
                                                          left: 10),
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
                                          ),
                                        ),
                                      // Metode Pembayaran Lainnya
                                      if (Provider.of<PaymentMethodModel>(
                                              context)
                                          .listPayment
                                          .where((element) =>
                                              element.code == 'qris' &&
                                              element.status == 1)
                                          .isNotEmpty)
                                        Container(
                                          color: Color(0xffFDEDE4),
                                          width:
                                              MediaQuery.of(context).size.width,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 15, vertical: 10),
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
                                      if (Provider.of<PaymentMethodModel>(
                                              context)
                                          .listPayment
                                          .where((element) =>
                                              element.code == 'qris' &&
                                              element.status == 1)
                                          .isNotEmpty)
                                        InkWell(
                                          onTap: () {
                                            chekOut(context, "qris");
                                          },
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 15, vertical: 10),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    Image.asset(
                                                      'assets/images/payment/dana-02.png',
                                                      height: 40,
                                                    ),
                                                    Image.asset(
                                                      'assets/images/payment/linkaja-02.png',
                                                      height: 40,
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 5),
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
                                          ),
                                        ),
                                    ],
                                  ),
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
