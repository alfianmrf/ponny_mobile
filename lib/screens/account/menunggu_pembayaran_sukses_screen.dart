import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:ponny/common/constant.dart';
import 'package:ponny/model/Order.dart';
import 'package:ponny/model/Product.dart';
import 'package:ponny/screens/account_screen.dart';
import 'package:ponny/screens/account/komplain_menunggu_pembayaran_screen.dart';
import 'package:ponny/util/globalUrl.dart';
import 'package:ponny/widgets/PonnyBottomNavbar.dart';
import 'package:provider/provider.dart';

import '../HairAndMakeup_Screen.dart';

class MenungguPembayaranSuksesScreen extends StatefulWidget {
  static const String id = "Menunggu_Pembayaran_Screen";
  @override
  _MenungguPembayaranSuksesStateScreen createState() =>
      _MenungguPembayaranSuksesStateScreen();
}

class _MenungguPembayaranSuksesStateScreen
    extends State<MenungguPembayaranSuksesScreen> {
  @override
  Widget build(BuildContext context) {
    final nm_format= NumberFormat.simpleCurrency(locale: "id_ID",decimalDigits: 0 );
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Hexcolor('#FCF8F0'),
      body: Consumer<OrderModel>(
      builder: (context,value,child){
        if(value.loading){
          return LoadingWidget(context);
        }else{
         return SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  height: 70,
                ),
                Container(
                  padding: EdgeInsets.only(left: 15, bottom: 15),
                  child: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 14),
                        child: GestureDetector(
                          child: Icon(
                            Icons.arrow_back_ios,
                            color: Color(0xffF48262),
                            size: 26,
                          ),
                          onTap: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                      Container(
                        child: Text(
                          "Menunggu Pembayaran",
                          style: TextStyle(
                            fontSize: 22,
                            fontFamily: "Yeseva",
                            fontWeight: FontWeight.w500,
                            color: Color(0xffF48262),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                for(Order order in value.unpaid)(
                Column(
                  children: [
                    Container(
                      height: 1,
                      color: Color(0xffF3C1B5),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        top: 20,
                        left: 15,
                        right: 15,
                      ),

                      // height: 50,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: EdgeInsets.only(
                              top: 5,
                              bottom: 5,
                            ),
                            child: Text(
                              "#"+order.code,
                              style: TextStyle(
                                fontFamily: "Brandon",
                                fontWeight: FontWeight.w500,
                                fontSize: 15,
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(
                              top: 5,
                              left: 25,
                              bottom: 5,
                            ),
                            child: Text(
                              "29/04/2020",
                              style: TextStyle(
                                fontFamily: "Brandon",
                                fontWeight: FontWeight.w500,
                                fontSize: 15,
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 5, bottom: 5, right: 15),
                            child: Text(
                              "Proses",
                              style: TextStyle(
                                fontFamily: "Brandon",
                                fontWeight: FontWeight.w500,
                                fontSize: 15,
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(
                              top: 5,
                              bottom: 5,
                            ),
                            child: Text(
                              nm_format.format(order.grand_total),
                              style: TextStyle(
                                fontFamily: "Brandon",
                                fontWeight: FontWeight.w500,
                                fontSize: 15,
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(
                              top: 5,
                              bottom: 5,
                            ),
                            child: Icon(
                              Icons.keyboard_arrow_up,
                              size: 26,
                              color: Color(0xffF48262),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        top: 10,
                        left: 15,
                        right: 15,
                      ),
                      height: 1,
                      color: Color(0xffF3C1B5),
                    ),
                    Container(
                      // color: Colors.greenAccent,
                      margin: EdgeInsets.only(
                        top: 20,
                        left: 15,
                        right: 15,
                      ),
                      // color: Colors.greenAccent,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[

                          Expanded(
                            flex: 2,
                            child:Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: order.order_details.map((e){
                                return Container(
                                  alignment: Alignment.topCenter,
                                  padding: EdgeInsets.only(bottom: 10),
                                  child:  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Container(
                                          alignment: Alignment.topCenter,
                                          height: MediaQuery.of(context).size.width*0.35,
                                          child: CachedNetworkImage(
                                            imageUrl: img_url+e.product.thumbnail_image,
                                            placeholder: (context, url) => LoadingWidgetPulse(context),
                                            errorWidget: (context, url, error) => Image.asset('assets/images/basic.jpg'),
                                            width: MediaQuery.of(context).size.width,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child:Container(
                                          alignment: Alignment.topCenter,
                                          child: Column(
                                            children: [
                                              Container(
                                                margin: EdgeInsets.only(top: 0),
                                                // color: Colors.redAccent,
                                                width: 90,
                                                child: Text(
                                                  e.product.brand.name,
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                    fontFamily: "Yeseva",
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                margin: EdgeInsets.only(top: 1),
                                                width: 90,
                                                child: Text(
                                                  e.product.name,
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                    fontFamily: "Brandon",
                                                    fontWeight: FontWeight.w200,
                                                    fontSize: 13,
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                margin: EdgeInsets.only(top: 1),
                                                width: 90,
                                                child: Text(
                                                  nm_format.format(e.price)+" ("+e.quantity.toString()+")",
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                    fontFamily: "Brandon",
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 13,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              }).toList()

                            ),
                          ),
                          Expanded(
                            // color: Colors.yellowAccent,
                            child: Column(
                              children: [
                                Container(
                                  width: 80,
                                  child: Text(
                                    "Subtotal",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontFamily: "Brandon",
                                      fontWeight: FontWeight.w500,
                                      fontSize: 13,
                                    ),
                                  ),
                                ),

                                Container(
                                  width: 80,
                                  child: Text(
                                    nm_format.format(order.subtotal),
                                    style: TextStyle(
                                      fontFamily: "Brandon",
                                      fontWeight: FontWeight.w300,
                                      fontSize: 13,
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                    top: 5,
                                  ),
                                  width: 80,
                                  child: Text(
                                    "Voucher",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontFamily: "Brandon",
                                      fontWeight: FontWeight.w500,
                                      fontSize: 13,
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 80,
                                  child: Text(
                                    nm_format.format(order.coupon_discount),
                                    style: TextStyle(
                                      fontFamily: "Brandon",
                                      fontWeight: FontWeight.w300,
                                      fontSize: 13,
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                    top: 5,
                                  ),
                                  width: 80,
                                  child: Text(
                                    "Shipping",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontFamily: "Brandon",
                                      fontWeight: FontWeight.w500,
                                      fontSize: 13,
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 80,
                                  child: Text(
                                    nm_format.format(order.shipping_info.cost),
                                    style: TextStyle(
                                      fontFamily: "Brandon",
                                      fontWeight: FontWeight.w300,
                                      fontSize: 13,
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                    top: 5,
                                  ),
                                  width: 80,
                                  child: Text(
                                    "Free Shiping",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontFamily: "Brandon",
                                      fontWeight: FontWeight.w500,
                                      fontSize: 13,
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 80,
                                  child: Text(
                                    nm_format.format(order.free_ongkir),
                                    style: TextStyle(
                                      fontFamily: "Brandon",
                                      fontWeight: FontWeight.w300,
                                      fontSize: 13,
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                    top: 5,
                                  ),
                                  width: 80,
                                  child: Text(
                                    "TOTAL",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontFamily: "Brandon",
                                      fontWeight: FontWeight.w500,
                                      fontSize: 13,
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 80,
                                  child: Text(
                                    nm_format.format(order.grand_total),
                                    style: TextStyle(
                                      fontFamily: "Brandon",
                                      fontWeight: FontWeight.w300,
                                      fontSize: 13,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            // color: Colors.yellowAccent,
                            child: Column(
                              children: [
                                Container(
                                  width: 100,
                                  child: Text(
                                    "Payment Method",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: "Brandon",
                                    ),
                                  ),
                                ),
                                if(order.payment_type == "mt_tf_bca" || order.payment_type == "mt_tf_bni" || order.payment_type == "mt_tf_permata" || order.payment_type == "alfamart" || order.payment_type=="Indomaret")
                                  Container(
                                    width: 100,
                                    child: Text(
                                      order.mitrans_val.mitrans_val,
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: "Brandon",
                                      ),
                                    ),
                                  ),

                                Container(
                                  width: 100,
                                  margin: EdgeInsets.only(top: 10),
                                  child: Text(
                                    "Alamat Pengiriman",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: "Brandon",
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 100,
                                  child: Text(
                                    order.user_order_address.nama_depan+" "+order.user_order_address.nama_belakang+",",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: "Brandon",
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 100,
                                  child: Text(
                                    "+62"+order.user_order_address.nomor_hp,
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: "Brandon",
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 100,
                                  child: Text(
                                    order.user_order_address.alamat_lengkap,
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: "Brandon",
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 100,
                                  margin: EdgeInsets.only(top: 10),
                                  child: Text(
                                    "Area Pengiriman",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: "Brandon",
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 100,
                                  child: Text(
                                    order.user_order_address.kecamatan+", "+order.user_order_address.city_name+", "+order.user_order_address.province+", "+order.user_order_address.postal_code,
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
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
                  ],
                )
                )
              ],
            ),
          );
        }
      }),
      bottomNavigationBar: new PonnyBottomNavbar(selectedIndex: 4),
    );
  }
}
