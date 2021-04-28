import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:ponny/common/constant.dart';
import 'package:ponny/model/Address.dart';
import 'package:ponny/model/App.dart';
import 'package:ponny/model/Cart.dart';
import 'package:ponny/screens/Order_Screen.dart';
import 'package:ponny/screens/midtrans_token_request.dart';
import 'package:ponny/widgets/PonnyBottomNavbar.dart';
import 'package:ponny/screens/pesanan_berhasil_screen.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:provider/provider.dart';
import 'package:uiblock/uiblock.dart';
import 'package:url_launcher/url_launcher.dart';

class PembayaranCreditCardScreen extends StatefulWidget {
  static const String id = "pembayaran_credit_card_screen";

  @override
  _PembayaranCreditCardScreenState createState() => _PembayaranCreditCardScreenState();
}

class CardNumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var text = newValue.text;

    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    var buffer = new StringBuffer();
    for (int i = 0; i < text.length; i++) {
      buffer.write(text[i]);
      var nonZeroIndex = i + 1;
      if (nonZeroIndex % 4 == 0 && nonZeroIndex != text.length) {
        buffer.write('  '); // Add double spaces.
      }
    }

    var string = buffer.toString();
    return newValue.copyWith(
        text: string,
        selection: new TextSelection.collapsed(offset: string.length));
  }
}

class CardMonthInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var text = newValue.text;

    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    var buffer = new StringBuffer();
    for (int i = 0; i < text.length; i++) {
      buffer.write(text[i]);
      var nonZeroIndex = i + 1;
      if (nonZeroIndex % 2 == 0 && nonZeroIndex != text.length) {
        buffer.write('/');
      }
    }

    var string = buffer.toString();
    return newValue.copyWith(
        text: string,
        selection: new TextSelection.collapsed(offset: string.length));
  }
}

class _PembayaranCreditCardScreenState extends State<PembayaranCreditCardScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final cardNumber = TextEditingController();
  final expiryDate = TextEditingController();
  final cvv = TextEditingController();
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

    onGoBack(dynamic value){
      if(Provider.of<CartModel>(context).tokenMidtrans!=null){
        Provider.of<CartModel>(context).Checkout(Provider.of<AppModel>(context).auth.access_token, Provider.of<AddressModel>(context).useAddress, 'credit_card', Provider.of<CartModel>(context).tokenMidtrans).then((value){
          if(value.success){
            UIBlock.unblock(context);
            return Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => OrderScreen(
                  type: OrderScreen.paid,
                ),
              ),
            );
          }
          else{
            UIBlock.unblock(context);
            final snackBar = SnackBar(
              content: Text('Pembayaran tidak berhasil',style: TextStyle(color: Colors.white)),
              backgroundColor: Colors.redAccent,
            );
            scaffoldKey.currentState.showSnackBar(snackBar);
          }
        });
      }
      else{
        final snackBar = SnackBar(
          content: Text('Pembayaran tidak berhasil',style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.redAccent,
        );
        scaffoldKey.currentState.showSnackBar(snackBar);
      }
    }

    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: Stack(children: <Widget>[
          Scaffold(
            key: scaffoldKey,
            backgroundColor: Color(0xffFDF8F0),
            appBar: AppBar(
              elevation: 0,
              titleSpacing: 0,
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Color(0xffF48262),
                  size: 26,
                ),
              ),
              title: Text(
                'Kartu Kredit/Debit Online',
                style: TextStyle(
                  fontSize: 24,
                  fontFamily: "Yeseva",
                  fontWeight: FontWeight.w500,
                  color: Color(0xffF48262),
                ),
              ),
              bottom: PreferredSize(
                  child: Container(
                    color: Color(0xffF48262),
                    height: 1.0,
                  ),
                  preferredSize: Size.fromHeight(1.0)),
            ),
            body: Container(
              // margin: MediaQuery.of(context).padding,
              child: Column(
                children: <Widget>[

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
                            card.summary.total,
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
                  Expanded(
                    child: SingleChildScrollView(
                      child: Form(
                        key: formKey,
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 10),
                              width: MediaQuery.of(context).size.width*0.9,
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Row(
                                  children: [
                                    Image.asset(
                                      'assets/images/payment/visa-02.png',
                                      height: 30,
                                    ),
                                    Image.asset(
                                      'assets/images/payment/mastercard-02.png',
                                      height: 30,
                                    ),
                                    Expanded(
                                      child: Container(
                                        alignment: Alignment.centerRight,
                                        child: Image.asset(
                                          'assets/images/secure-guarantee.png',
                                          height: 25,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              width: MediaQuery.of(context).size.width*0.9,
                              child: Container(
                                margin: EdgeInsets.all(10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Kartu Kredit / Debit Online',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 10, bottom: 35),
                                      child: Text('Kamu akan dialihkan ke laman Midtrans untuk menyelesaikan proses pembayaran'),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              color: Color(0xffFDEDE4),
                              child: Column(
                                children: [
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    width: MediaQuery.of(context).size.width*0.9,
                                    padding: EdgeInsets.all(10),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(top: 3, right: 5),
                                          child: Icon(
                                            Icons.favorite,
                                            color: Color(0xffF48262),
                                            size: 14,
                                          ),
                                        ),
                                        Expanded(child: Text('Catatan: Voucher dan bentuk promosi lainnya tidak dapat digabungkan untuk pembelian kamu.')),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 10),
                              width: MediaQuery.of(context).size.width*0.9,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 5),
                                    child: RichText(
                                      text: TextSpan(
                                        text: 'Card Number',
                                        style: TextStyle(
                                          fontFamily: 'Brandon',
                                          color: Colors.black,
                                        ),
                                        children: [
                                          TextSpan(
                                            text: '*',
                                            style: TextStyle(
                                              color: Hexcolor('#F48262'),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  TextFormField(
                                    controller: cardNumber,
                                    inputFormatters: [
                                      WhitelistingTextInputFormatter.digitsOnly,
                                      new LengthLimitingTextInputFormatter(16),
                                      new CardNumberInputFormatter()
                                    ],
                                    decoration: InputDecoration(
                                      isDense: true,
                                      contentPadding: EdgeInsets.all(10),
                                      filled: true,
                                      fillColor: Colors.white,
                                      hintText: 'XXXX XXXX XXXX XXXX',
                                      hintStyle: TextStyle(fontFamily: 'Brandon'),
                                      labelStyle: TextStyle(color: Colors.black),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10.0),
                                        borderSide: BorderSide(
                                          color: Hexcolor('#F48262'),
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10.0),
                                        borderSide: BorderSide(
                                          color: Hexcolor('#F48262'),
                                          width: 1.0,
                                        ),
                                      ),
                                    ),
                                    keyboardType: TextInputType.number,
                                    validator: (String value) {
                                      if (value.isEmpty) {
                                        return 'Credit Number tidak boleh kosong';
                                      }
                                      return null;
                                    },
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 10),
                              width: MediaQuery.of(context).size.width*0.9,
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      padding: EdgeInsets.only(right: 10),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(bottom: 5),
                                            child: RichText(
                                              text: TextSpan(
                                                text: 'Expiry Date',
                                                style: TextStyle(
                                                  fontFamily: 'Brandon',
                                                  color: Colors.black,
                                                ),
                                                children: [
                                                  TextSpan(
                                                    text: '*',
                                                    style: TextStyle(
                                                      color: Hexcolor('#F48262'),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          TextFormField(
                                            controller: expiryDate,
                                            inputFormatters: [
                                              WhitelistingTextInputFormatter.digitsOnly,
                                              new LengthLimitingTextInputFormatter(4),
                                              new CardMonthInputFormatter()
                                            ],
                                            decoration: InputDecoration(
                                              isDense: true,
                                              contentPadding: EdgeInsets.all(10),
                                              filled: true,
                                              fillColor: Colors.white,
                                              hintText: 'MM/YY',
                                              hintStyle: TextStyle(fontFamily: 'Brandon'),
                                              labelStyle: TextStyle(color: Colors.black),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(10.0),
                                                borderSide: BorderSide(
                                                  color: Hexcolor('#F48262'),
                                                ),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(10.0),
                                                borderSide: BorderSide(
                                                  color: Hexcolor('#F48262'),
                                                  width: 1.0,
                                                ),
                                              ),
                                            ),
                                            keyboardType: TextInputType.number,
                                            validator: (String value) {
                                              if (value.isEmpty) {
                                                return 'Expiry Date tidak boleh kosong';
                                              }
                                              return null;
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      padding: EdgeInsets.only(left: 10),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(bottom: 5),
                                            child: RichText(
                                              text: TextSpan(
                                                text: 'CVV',
                                                style: TextStyle(
                                                  fontFamily: 'Brandon',
                                                  color: Colors.black,
                                                ),
                                                children: [
                                                  TextSpan(
                                                    text: '*',
                                                    style: TextStyle(
                                                      color: Hexcolor('#F48262'),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          TextFormField(
                                            controller: cvv,
                                            inputFormatters: [
                                              WhitelistingTextInputFormatter.digitsOnly,
                                              new LengthLimitingTextInputFormatter(3),
                                            ],
                                            obscureText: true,
                                            decoration: InputDecoration(
                                              isDense: true,
                                              contentPadding: EdgeInsets.all(10),
                                              filled: true,
                                              fillColor: Colors.white,
                                              hintText: '***',
                                              hintStyle: TextStyle(fontFamily: 'Brandon'),
                                              labelStyle: TextStyle(color: Colors.black),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(10.0),
                                                borderSide: BorderSide(
                                                  color: Hexcolor('#F48262'),
                                                ),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(10.0),
                                                borderSide: BorderSide(
                                                  color: Hexcolor('#F48262'),
                                                  width: 1.0,
                                                ),
                                              ),
                                            ),
                                            keyboardType: TextInputType.number,
                                            validator: (String value) {
                                              if (value.isEmpty) {
                                                return 'CVV tidak boleh kosong';
                                              }
                                              return null;
                                            },
                                          ),
                                        ],
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
                  ),
                  Align(
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
                          FormState form = this.formKey.currentState;
                          ScaffoldState scaffold = this.scaffoldKey.currentState;

                          if (form.validate()) {
                            UIBlock.block(context);
                            Navigator.push(context,new MaterialPageRoute(
                              builder: (BuildContext context) => new MidtransTokenRequest(card_number: cardNumber.text, exp_month: expiryDate.text.substring(0,2), exp_year: expiryDate.text.substring(3,5), cvv: cvv.text,),
                            )).then(onGoBack);
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ]),
        bottomNavigationBar: new PonnyBottomNavbar(selectedIndex: 1),
      ),
    );
  }
}
