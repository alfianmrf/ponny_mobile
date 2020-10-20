import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ponny/common/constant.dart';
import 'package:ponny/model/App.dart';
import 'package:ponny/model/Cart.dart';
import 'package:ponny/util/globalUrl.dart';
import 'package:ponny/widgets/PonnyBottomNavbar.dart';
import 'package:ponny/screens/shipping_screen.dart';
import 'package:provider/provider.dart';
import 'package:ponny/model/Cart.dart';
import 'package:uiblock/uiblock.dart';

class CartScreen extends StatefulWidget {
  static const String id = "cart_screen";

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  TextEditingController _code = TextEditingController();
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();

  }

  int _n1 = 1;
  int _n2 = 1;

  void add1() {
    setState(() {
      _n1++;
    });
  }

  void add2() {
    setState(() {
      _n2++;
    });
  }

  void minus1() {
    setState(() {
      if (_n1 != 1)
        _n1--;
    });
  }

  void minus2() {
    setState(() {
      if (_n2 != 1)
        _n2--;
    });
  }

  String dropdownValue = 'One';

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
              child:
              Consumer<CartModel>(
                builder: (context,value,child){
                  if(value.loadingCard){
                    return Center(
                     child: LoadingWidgetFadingcube(context),
                    );
                  }else{
                    if(value.listCardOfitem.isEmpty){
                     return new Container( height: MediaQuery.of(context).size.height, child: Center(child: Text("Kerajang Belaja Kosong"),),);
                    }else {


                      return new Column(
                        children: <Widget>[
                          Container(
                            width: MediaQuery
                                .of(context)
                                .size
                                .width,
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 30),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: Color(0xffF48262),
                                  width: 1.0,
                                ),
                              ),
                            ),
                            child: Text(
                              'Keranjang Belanja',
                              style: TextStyle(
                                fontFamily: 'Yeseva',
                                fontSize: 22,
                                color: Color(0xffF48262),
                              ),
                            ),
                          ),
                          for(final item in value.listCardOfitem)(
                              Container(
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width * 0.95,
                                padding: EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: Color(0xffF48262),
                                      width: 1.0,
                                    ),
                                  ),
                                ),
                                child: IntrinsicHeight(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                        width: MediaQuery
                                            .of(context)
                                            .size
                                            .width * 0.25,
                                        padding: EdgeInsets.only(right: 7),
                                        child: CachedNetworkImage(
                                            imageUrl: img_url+ item.product.thumbnail_image,
                                            placeholder: (context, url) => LoadingWidgetPulse(context),
                                            errorWidget: (context, url, error) => Image.asset('assets/images/basic.jpg'),
                                            width: MediaQuery.of(context).size.width,
                                            fit: BoxFit.cover,
                                        ),
                                      ),
                                      Container(
                                        width: MediaQuery
                                            .of(context)
                                            .size
                                            .width * 0.35,
                                        padding: EdgeInsets.only(right: 7),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment
                                              .start,
                                          children: <Widget>[
                                            Text(
                                              item.product.brand.name,
                                              style: TextStyle(
                                                fontFamily: 'Yeseva',
                                                fontSize: 16,
                                              ),
                                            ),
                                            Text(
                                              item.product.name.length > 20 ? item.product.name.substring(0, 20)+'...' : item.product.name,
                                              style: TextStyle(
                                                fontFamily: 'Brandon',
                                                fontSize: 14,
                                              ),
                                            ),
                                            Text(
                                              NumberFormat.simpleCurrency(locale: "id_ID",decimalDigits: 0 ).format(item.product.base_discounted_price),
                                              style: TextStyle(
                                                fontFamily: 'Brandon',
                                                fontSize: 15,
                                                color: Color(0xffF48262),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(top: 10),
                                              child: Text(
                                                'JUMLAH',
                                                style: TextStyle(
                                                    fontFamily: 'Brandon',
                                                    fontSize: 12),
                                              ),
                                            ),
                                            Container(
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Color(0xffF48262)),
                                                borderRadius: BorderRadius.circular(
                                                    5),
                                              ),
                                              child: Wrap(
                                                crossAxisAlignment: WrapCrossAlignment
                                                    .center,
                                                children: <Widget>[
                                                  SizedBox(
                                                      width: 25,
                                                      height: 25,
                                                      child: FloatingActionButton(
                                                        backgroundColor: Color(
                                                            0xffFDF8F0),
                                                        elevation: 0.0,
                                                        highlightElevation: 0.0,
                                                        heroTag: "btnmin"+item.product.id.toString(),
                                                        child: Text(
                                                          '-',
                                                          style: TextStyle(
                                                            color: Color(
                                                                0xffF48262),
                                                            fontFamily: 'Brandon',
                                                            fontWeight: FontWeight
                                                                .w700,
                                                          ),
                                                        ),
                                                        onPressed:(){
                                                          value.RemoveProductToCart(item.product);
                                                        },
                                                      )
                                                  ),
                                                  Container(
                                                    padding: EdgeInsets.symmetric(
                                                        horizontal: 10),
                                                    child: Text(item.quantity.toString()),
                                                  ),
                                                  SizedBox(

                                                      width: 25,
                                                      height: 25,
                                                      child: FloatingActionButton(
                                                        backgroundColor: Color(
                                                            0xffFDF8F0),
                                                        elevation: 0.0,
                                                        highlightElevation: 0.0,
                                                        heroTag: "btnplus"+item.product.id.toString(),
                                                        child: Text(
                                                          '+',
                                                          style: TextStyle(
                                                            color: Color(
                                                                0xffF48262),
                                                            fontFamily: 'Brandon',
                                                            fontWeight: FontWeight
                                                                .w700,
                                                          ),
                                                        ),
                                                        onPressed: (){
                                                          value.addProductToCart(item.product);
                                                        },
                                                      )
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: MediaQuery
                                            .of(context)
                                            .size
                                            .width * 0.25,
                                        child: Column(
                                          children: <Widget>[
                                            Container(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment
                                                    .start,
                                                children: <Widget>[
                                                  Text(
                                                    'TOTAL',
                                                    style: TextStyle(
                                                        fontFamily: 'Brandon',
                                                        fontSize: 12
                                                    ),
                                                  ),
                                                  Text(
                                                    NumberFormat.simpleCurrency(locale: "id_ID",decimalDigits: 0 ).format((item.product.base_discounted_price*item.quantity)),
                                                    style: TextStyle(
                                                        fontFamily: 'Brandon',
                                                        fontSize: 14,
                                                        fontWeight: FontWeight.w600
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              child: Align(
                                                alignment: Alignment.bottomRight,
                                                child:  IconButton(
                                                  onPressed: (){
                                                    value.DeleteProductToCart(item.product);
                                                  },
                                                  icon: Icon(Icons.delete_outline,
                                                      color: Color(0xffF48262)),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                          ),
                          Container(
                            width: MediaQuery
                                .of(context)
                                .size
                                .width,
                            padding: EdgeInsets.all(15),
                            child: IntrinsicHeight(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    margin: EdgeInsets.symmetric(
                                        horizontal: 10),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 5),
                                    width: MediaQuery
                                        .of(context)
                                        .size
                                        .width * 0.4,
                                    decoration: BoxDecoration(
                                      color: Color(0xffF48262),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment
                                          .spaceBetween,
                                      children: <Widget>[
                                        Image.asset(
                                            "assets/images/pilih_sample.png"),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment
                                              .start,
                                          children: <Widget>[
                                            Text(
                                              'PILIH SAMPLE',
                                              style: TextStyle(
                                                  fontFamily: 'Brandon',
                                                  fontSize: 12,
                                                  color: Colors.white
                                              ),
                                            ),
                                            Text(
                                              'YANG KAMU',
                                              style: TextStyle(
                                                  fontFamily: 'Brandon',
                                                  fontSize: 12,
                                                  color: Colors.white
                                              ),
                                            ),
                                            Text(
                                              'INGINKAN: 2/2',
                                              style: TextStyle(
                                                  fontFamily: 'Brandon',
                                                  fontSize: 12,
                                                  color: Colors.white
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.symmetric(
                                        horizontal: 10),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 5),
                                    width: MediaQuery
                                        .of(context)
                                        .size
                                        .width * 0.4,
                                    decoration: BoxDecoration(
                                      color: Color(0xffF48262),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment
                                          .spaceBetween,
                                      children: <Widget>[
                                        Image.asset(
                                            "assets/images/tukar_poin.png"),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment
                                              .start,
                                          mainAxisAlignment: MainAxisAlignment
                                              .center,
                                          children: <Widget>[
                                            Text(
                                              'TUKAR POIN MU',
                                              style: TextStyle(
                                                  fontFamily: 'Brandon',
                                                  fontSize: 12,
                                                  color: Colors.white
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            width: MediaQuery
                                .of(context)
                                .size
                                .width * 0.95,
                            padding: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 7),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: Color(0xffF48262),
                                  width: 1.0,
                                ),
                              ),
                            ),


                            child: IntrinsicHeight(

                              child:Stack(
                                alignment: Alignment(1.0,0.0), // right & center
                                children: <Widget>[
                                  TextField(
                                    controller: _code..text = (value.coupon != null && value.coupon.coupon_id != null) ? value.coupon.code : null,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        enabledBorder: InputBorder.none,
                                        errorBorder: InputBorder.none,
                                        disabledBorder: InputBorder.none,
                                        fillColor: Colors.transparent,
                                        labelText: 'KODE PROMO',
                                        hintText: 'Enter KODE PROMO',
                                    ),
                                  ),
                                  Positioned(
                                    child:FlatButton (
                                      child: Text("PAKAI",style: TextStyle(fontFamily: 'Brandon',
                                        fontSize: 14,
                                        color: Color(0xffF48262),
                                        ) ,
                                        textAlign: TextAlign.right,
                                        ),
                                      onPressed: () {

                                        if(_code.text.isNotEmpty){
                                          value.AppyCoupon(_code.value.text, Provider.of<AppModel>(context).auth.access_token).then((values){
                                            if(value.coupon != null && value.coupon.code != null){
                                              final snackBar = SnackBar(
                                                content: Text('Success.',style: TextStyle(color: Colors.white)),
                                                backgroundColor: Colors.green,
                                              );
                                              scaffoldKey.currentState.showSnackBar(snackBar);
                                            }else{
                                              final snackBar = SnackBar(
                                                content: Text('Code promo tidak berlaku!',style: TextStyle(color: Colors.white)),
                                                backgroundColor: Colors.redAccent,
                                              );
                                              scaffoldKey.currentState.showSnackBar(snackBar);
                                            }
                                          });
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            width: MediaQuery
                                .of(context)
                                .size
                                .width * 0.95,
                            padding: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 7),
                            child: IntrinsicHeight(
                              child: Column(
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.symmetric(vertical: 5),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment
                                          .spaceBetween,
                                      children: <Widget>[
                                        Text(
                                          'SUB TOTAL',
                                          style: TextStyle(
                                            fontFamily: 'Brandon',
                                            fontSize: 14,
                                          ),
                                        ),
                                        Text(
                                          NumberFormat.simpleCurrency(locale: "id_ID",decimalDigits: 0 ).format((value.getSubtotal())),
                                          style: TextStyle(
                                            fontFamily: 'Brandon',
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  if(value.coupon != null )
                                  Padding(
                                    padding: EdgeInsets.symmetric(vertical: 5),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment
                                          .spaceBetween,
                                      children: <Widget>[
                                        Text(
                                          'POTONGAN DISKON',
                                          style: TextStyle(
                                            fontFamily: 'Brandon',
                                            fontSize: 14,
                                          ),
                                        ),
                                        Text(
                                        NumberFormat.simpleCurrency(locale: "id_ID",decimalDigits: 0 ).format(value.getJmlDiskon()),
                                          style: TextStyle(
                                            fontFamily: 'Brandon',
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(vertical: 5),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment
                                          .spaceBetween,
                                      children: <Widget>[
                                        Text(
                                          'TOTAL',
                                          style: TextStyle(
                                            fontFamily: 'Brandon',
                                            fontSize: 14,
                                          ),
                                        ),
                                        Text(
                                          NumberFormat.simpleCurrency(locale: "id_ID",decimalDigits: 0 ).format(value.getSumtotal()),
                                          style: TextStyle(
                                            fontFamily: 'Brandon',
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(vertical: 5),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment
                                          .spaceBetween,
                                      children: <Widget>[
                                        Text(
                                          'Poin yang didapat',
                                          style: TextStyle(
                                            fontFamily: 'Brandon',
                                            fontSize: 14,
                                            color: Color(0xffF48262),
                                          ),
                                        ),
                                        Text(
                                          '+ 2000',
                                          style: TextStyle(
                                            fontFamily: 'Brandon',
                                            fontSize: 14,
                                            color: Color(0xffF48262),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            width: MediaQuery
                                .of(context)
                                .size
                                .width * 0.95,
                            padding: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 7),
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
                              onPressed: () {
                                Navigator.of(context)
                                    .pushReplacementNamed(ShippingScreen.id);
                              },
                            ),
                          ),
                        ],
                      );
                    }
                  }
                },
              ),

            ),
          ),
        )
      ]),
      bottomNavigationBar: new PonnyBottomNavbar(selectedIndex: 1),
    );
  }
}
