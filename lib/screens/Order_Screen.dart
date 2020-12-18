import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:ponny/common/constant.dart';
import 'package:ponny/model/App.dart';
import 'package:ponny/model/LacakResult.dart';
import 'package:ponny/model/Order.dart';
import 'package:http/http.dart' as http;
import 'package:ponny/screens/Qris_screen.dart';
import 'package:ponny/screens/account/komplain_dalam_perjalanan_screen.dart';
import 'package:ponny/screens/konfirmasi_pembayaran_screen.dart';
import 'package:ponny/screens/review_screen.dart';
import 'package:ponny/util/globalUrl.dart';
import 'package:ponny/widgets/PonnyBottomNavbar.dart';
import 'package:provider/provider.dart';
import 'package:uiblock/uiblock.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:ponny/screens/account_screen.dart';

import 'bank_transfer_detail_screen.dart';

class OrderScreen extends StatefulWidget {
  static const String id = "OrderScreen";
  static const String unpaid ="unpaid";
  static const String paid ="paid";
  static const String on_delivery ="on_delivery";
  static const String delivered ="delivered";
  static const String completed ="completed";
  static const String komplain ="komplain";
  String type;
  OrderScreen({Key key,this.type});


  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  ScrollController _scrollController = new ScrollController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  var refreshKey = GlobalKey<RefreshIndicatorState>();
  List<Order> orders=[];
  bool isLoading = true;
  int current_page=0;
  int last_page =0;
  String NextPage;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _getData();
      _scrollController.addListener(() {
        if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent) {
          _getMoreData();
        }
      });
    });
  }
  _launchURL(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Widget _buildProgressIndicator() {
    return new Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Center(
        child: new Opacity(
          opacity: isLoading ? 1.0 : 00,
          child: LoadingWidget(context),
        ),
      ),
    );
  }


  Future<Null> _getData()  async {
    String token = Provider.of<AppModel>(context,listen: false).auth.access_token;
    setState(() {
      isLoading = true;
      NextPage=null;
      orders=[];
    });
    final response = await http.get(urlOrder+"/"+widget.type, headers: { HttpHeaders.contentTypeHeader: 'application/json', HttpHeaders.authorizationHeader: "Bearer $token"});
    if(response.statusCode == 200)
    {
      print(response.body);
      final responseJson = json.decode(response.body);


      setState(() {
        for (Map item in responseJson["data"]) {
          print(Order.fromJson(item).code);
          orders.add(Order.fromJson(item));
        }
        isLoading =false;
        current_page = responseJson['pagination']['current_page'];
        last_page = responseJson['pagination']['last_page'];
        NextPage = responseJson['pagination']["next_page_url"];
      });
    }

  }
  void _getMoreData() async {
    if(NextPage != null && !isLoading  && current_page <= last_page){
      String token = Provider.of<AppModel>(context,listen: false).auth.access_token;
      setState(() {
        isLoading = true;
        current_page ++;
      });
      final response = await http.get(NextPage,headers: { HttpHeaders.contentTypeHeader: 'application/json',HttpHeaders.authorizationHeader: "Bearer $token" });
      final responseJson = json.decode(response.body);

      setState(() {
        for (Map item in responseJson["data"]) {
          print(Order.fromJson(item).code);
          orders.add(Order.fromJson(item));
        }
        isLoading =false;
        current_page = responseJson['pagination']['current_page'];
        last_page = responseJson['pagination']['last_page'];
        NextPage = responseJson['pagination']["next_page_url"];
      });
    }
  }

  Widget _buildList() {
    final nm_format= NumberFormat.simpleCurrency(locale: "id_ID",decimalDigits: 0 );
    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: orders.length + 1,
      itemBuilder: (BuildContext context, int index) {
        if (index == orders.length) {
          return _buildProgressIndicator();
        }
        else {
          Order order = orders[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: new Column(
              children: [
                Container(
                  height: 1,
                  color: Color(0xffF48262),
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: 20,
                  ),
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
                          order.date,
                          style: TextStyle(
                            fontFamily: "Brandon",
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                          ),
                        ),
                      ),
                      // Container(
                      //   padding: EdgeInsets.only(top: 5, bottom: 5, right: 15),
                      //   child: Text(
                      //     "Proses",
                      //     style: TextStyle(
                      //       fontFamily: "Brandon",
                      //       fontWeight: FontWeight.w500,
                      //       fontSize: 15,
                      //     ),
                      //   ),
                      // ),
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
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: 10,
                  ),
                  height: 1,
                  color: Color(0xffF48262),
                ),
                Container(
                  // color: Colors.greenAccent,
                  margin: EdgeInsets.only(
                    top: 20,
                  ),
                  // color: Colors.greenAccent,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        flex: 2,
                        child:Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children:[
                              for(OrderDetail e in order.order_details)(
                                  Container(
                                    alignment: Alignment.topCenter,
                                    padding: EdgeInsets.only(bottom: 10, right: 10),
                                    child:  Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Container(
                                            alignment: Alignment.topCenter,
                                            padding: EdgeInsets.only(right: 10),
                                            height: MediaQuery.of(context).size.width*0.35,
                                            child: CachedNetworkImage(
                                              imageUrl: e.product.thumbnail_image != null ? img_url+ e.product.thumbnail_image :"",
                                              placeholder: (context, url) => LoadingWidgetPulse(context),
                                              errorWidget: (context, url, error) => Image.asset('assets/images/210x265.png'),
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
                                                if(order.deliveryStatus == OrderScreen.completed && e.reviewed == 0)
                                                Container(
                                                  margin:EdgeInsets.only(top: 4),
                                                  child: FlatButton(
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(10),
                                                      side: BorderSide(width: 1, color: Color(0xffF48262),),
                                                    ),
                                                    onPressed: () {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) => ReviewScreen(product: e.product,orderReview: OrderReview(e.id,"order_detail_id"),), ),
                                                      ).then((_value){
                                                        if(_value){
                                                         _getData();
                                                        }
                                                      });
                                                    },
                                                    child: Text(
                                                      "ULAS",
                                                      style: TextStyle(
                                                          color: Color(0xffF48262),
                                                          fontFamily:
                                                          "Brandon"),
                                                    ),
                                                  ),
                                                  height: 30,
                                                )
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                              ),
                              for(OrderDetailPoint e in order.orderDetailPoint)(
                                  Container(
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
                                              errorWidget: (context, url, error) => Image.asset('assets/images/210x265.png'),
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
                                                    "Tukar Poin ("+e.quantity.toString()+")",
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                      fontFamily: "Brandon",
                                                      fontWeight: FontWeight.w600,
                                                      fontSize: 13,
                                                    ),
                                                  ),
                                                ),
                                                if(order.deliveryStatus == OrderScreen.completed && e.reviewed == 0)
                                                  Container(
                                                    margin:EdgeInsets.only(top: 4),
                                                    child: RaisedButton(
                                                      color: Color(0xffF48262),
                                                      onPressed: () {
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (context) => ReviewScreen(product: e.product,orderReview: OrderReview(e.id,"order_point_id"),), ),
                                                        ).then(( _value){
                                                          if(_value){
                                                            _getData();
                                                          }
                                                        });
                                                      },
                                                      child: Text(
                                                        "Review",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 12,
                                                            fontFamily:
                                                            "Brandon"),
                                                      ),
                                                    ),
                                                    height: 30,
                                                  )
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                              ),
                              for(OrderDetailSample e in order.orderDetailSample)(
                                  Container(
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
                                              errorWidget: (context, url, error) => Image.asset('assets/images/210x265.png'),
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
                                                    "Sample",
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                      fontFamily: "Brandon",
                                                      fontWeight: FontWeight.w600,
                                                      fontSize: 13,
                                                    ),
                                                  ),
                                                ),
                                                if(order.deliveryStatus == OrderScreen.completed && e.reviewed == 0)
                                                  Container(
                                                    margin:EdgeInsets.only(top: 4),
                                                    child: RaisedButton(
                                                      color: Color(0xffF48262),
                                                      onPressed: () {

                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (context) => ReviewScreen(product: e.product,orderReview: OrderReview(e.id,"order_sample_id"),), ),
                                                        ).then((_value) async {
                                                          if(_value){
                                                            print("get dta");
                                                            await _getData();
                                                          }
                                                        });

                                                      },
                                                      child: Text(
                                                        "Review",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 12,
                                                            fontFamily:
                                                            "Brandon"),
                                                      ),
                                                    ),
                                                    height: 30,
                                                  )
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                              )

                            ]

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
                            if(order.payment_type == "mt_tf_bca" || order.payment_type == "mt_tf_bni" || order.payment_type == "mt_tf_permata" || order.payment_type == "alfamart" || order.payment_type=="Indomaret" ||order.payment_type=="mt_tf_mdr"|| order.payment_type=="mt_tf_bri")
                              Container(
                                width: 100,
                                child: Text(
                                  order.mitrans_val != null ? order.mitrans_val.mitrans_val : "",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: "Brandon",
                                  ),
                                ),
                              )else

                              Container(
                                width: 100,
                                child: Text(
                                  order.typePayment,
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
                if(order.payment_status == 'unpaid' && (order.payment_type == "manual_bca" || order.payment_type == "manual_mandiri" || order.payment_type == "manual_permata" || order.payment_type == "transfer_manual"))
                  Container(
                    margin: EdgeInsets.only(left: 10),
                    alignment: Alignment.centerLeft,
                    child: FlatButton(
                      color:  Color(0xffF48262),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      textColor: Colors.white,
                      disabledColor: Colors.grey,
                      disabledTextColor: Colors.black,
                      child:  Text("BAYAR SEKARANG", style: TextStyle(fontFamily: 'Brandon'),),
                      onPressed: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BankTransferDetailScreen(order_id: order.id,), ),
                        );
                      },
                    ) ,
                  ),
                if(order.payment_status == 'unpaid' && order.payment_type == "gopay")
                  Container(
                    margin: EdgeInsets.only(left: 10),
                    alignment: Alignment.centerLeft,
                    child: FlatButton(
                      color:  Color(0xffF48262),
                      textColor: Colors.white,
                      disabledColor: Colors.grey,
                      disabledTextColor: Colors.black,
                      child:  Text("BAYAR SEKARANG"),
                      onPressed: (){
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => BankTransferDetailScreen(order_id: order.id,), ),
                        // );
                        _launchURL(order.mitransVal.actions.firstWhere((element) => element.name == "deeplink-redirect").url);
                      },
                    ) ,
                  ),
                if(order.payment_status == 'unpaid' && order.payment_type == "qris")
                  Container(
                    margin: EdgeInsets.only(left: 10),
                    alignment: Alignment.centerLeft,
                    child: FlatButton(
                      color:  Color(0xffF48262),
                      textColor: Colors.white,
                      disabledColor: Colors.grey,
                      disabledTextColor: Colors.black,
                      child:  Text("BAYAR SEKARANG"),
                      onPressed: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => QrisScreen(title: "QRIS", urlQR: order.mitransVal.actions.firstWhere((element) => element.name == "generate-qr-code").url,type: QrisScreen.qris), ),
                        );
                      },
                    ) ,
                  ),
                if(order.payment_status == 'unpaid' && order.payment_type == "ovo")
                  Container(
                    margin: EdgeInsets.only(left: 10),
                    alignment: Alignment.centerLeft,
                    child: FlatButton(
                      color:  Color(0xffF48262),
                      textColor: Colors.white,
                      disabledColor: Colors.grey,
                      disabledTextColor: Colors.black,
                      child:  Text("BAYAR SEKARANG"),
                      onPressed: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => QrisScreen(title: "OVO", urlQR: order.mitransVal.actions.firstWhere((element) => element.name == "generate-qr-code").url,type: QrisScreen.ovo,), ),
                        );
                      },
                    ) ,
                  ),
                if(order.payment_status == 'unpaid' && order.payment_type == "shopeepay")
                  Container(
                    margin: EdgeInsets.only(left: 10),
                    alignment: Alignment.centerLeft,
                    child: FlatButton(
                      color:  Color(0xffF48262),
                      textColor: Colors.white,
                      disabledColor: Colors.grey,
                      disabledTextColor: Colors.black,
                      child:  Text("BAYAR SEKARANG"),
                      onPressed: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => QrisScreen(title: "SHOPEEPAY", urlQR: order.mitransVal.actions.firstWhere((element) => element.name == "generate-qr-code").url,type: QrisScreen.shopee), ),
                        );
                      },
                    ) ,
                  ),
                if(order.payment_status == "waiting_confrim" && (order.payment_type == "manual_bca" || order.payment_type == "manual_mandiri" || order.payment_type == "manual_permata" || order.payment_type == "transfer_manual"))
                  Container(
                    margin: EdgeInsets.only(left: 10),
                    alignment: Alignment.centerLeft,
                    child: FlatButton(
                      color:  Color(0xffF48262),
                      textColor: Colors.white,
                      disabledColor: Colors.grey,
                      disabledTextColor: Colors.black,
                      child: Text("UBAH BUKTI PEMBAYARAN"),
                      onPressed: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BankTransferDetailScreen(order_id: order.id,), ),
                        );
                      },
                    ) ,
                  ),
                if(order.confrimResi!=null)
                  InkWell(
                    child: Container(
                      padding: EdgeInsets.only(left: 15, right: 15),
                      alignment: Alignment.topLeft,
                      child: Text("Lacak Pesanan",style: TextStyle(
                        decoration: TextDecoration.underline,
                        fontSize: 16,
                        color: Color(0xffF48262)
                      ),),
                    ),
                    onTap: (){
                      showModalBottomSheet<void>(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                        ),
                        backgroundColor: Color(0xffFEF9F0),
                        context: context,
                        builder: (BuildContext context) {

                          return Wrap(
                            children: [
                              Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: 20),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'LACAK PESANAN',
                                            style: TextStyle(
                                              fontFamily: 'Brandon',
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          IconButton(
                                            icon: Icon(
                                              Icons.close,
                                              color: Color(0xffF48262),
                                              size: 24,
                                            ),
                                            onPressed: () => Navigator.pop(context),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      child:  FutureBuilder<LacakResult>(
                                        future:Provider.of<OrderModel>(context).getLacak(Provider.of<AppModel>(context,listen: false).auth.access_token, order.id.toString()),
                                        builder:(BuildContext context, AsyncSnapshot<LacakResult> snapshot){
                                          if(snapshot.hasData){
                                            print(snapshot.data.toJson());
                                            return Column(
                                              children: [
                                                Container(
                                                  color: Color(0xffFEEEE4),
                                                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                                                  child: IntrinsicHeight(
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Text(
                                                              snapshot.data.query.courier,
                                                              style: TextStyle(
                                                                fontFamily: 'Brandon',
                                                              ),
                                                            ),
                                                            Text(
                                                              'No Resi: '+snapshot.data.query.waybill,
                                                              style: TextStyle(
                                                                fontFamily: 'Brandon',
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        InkWell(
                                                          onTap: (){
                                                            Clipboard.setData(new ClipboardData(text: snapshot.data.query.waybill));
                                                            Fluttertoast.showToast(
                                                                msg: "Copied to Clipboard",
                                                                toastLength: Toast.LENGTH_SHORT,
                                                                gravity: ToastGravity.CENTER,
                                                                timeInSecForIosWeb: 1,
                                                                backgroundColor: Colors.red,
                                                                textColor: Colors.white,
                                                                fontSize: 16.0
                                                            );
                                                          },
                                                          child: Container(
                                                            alignment: Alignment.bottomRight,
                                                            child: Text(
                                                              'SALIN',
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
                                                Container(
                                                  color: Color(0xffFEF9F0),
                                                  padding: EdgeInsets.all(20),
                                                  child: Column(
                                                      children: snapshot.data.result.manifest.map(
                                                              (e) => IntrinsicHeight(
                                                            child: Row(
                                                              children: [
                                                                Container(
                                                                  padding: EdgeInsets.only(top: 15),
                                                                  width: 30,
                                                                  alignment: Alignment.topCenter,
                                                                  child: Container(
                                                                    width: 10,
                                                                    height: 10,
                                                                    decoration: BoxDecoration(
                                                                      color: Color(0xffF48262),
                                                                      shape: BoxShape.circle,
                                                                    ),
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                  child: Container(
                                                                    padding: EdgeInsets.symmetric(vertical: 10),
                                                                    decoration: BoxDecoration(
                                                                      border: Border(
                                                                        bottom: BorderSide(
                                                                          width: 1,
                                                                          color: Color(0xffF48262),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    child: Column(
                                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                                      children: [
                                                                        Text(
                                                                          e.manifestDescription,
                                                                          style: TextStyle(
                                                                            fontFamily: 'Brandon',
                                                                          ),
                                                                        ),
                                                                        Text(
                                                                          e.manifestDate+' '+e.manifestTime,
                                                                          style: TextStyle(
                                                                            fontFamily: 'Brandon',
                                                                            color: Color(0xff6D6E71),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          )
                                                      ).toList()
                                                  ),
                                                ),
                                              ],
                                            );
                                          }else if(snapshot.hasError){
                                            return Container(
                                              height: 100,
                                              child: Center(
                                                child: Text("Nomor resi belum ada."),
                                              ),
                                            );
                                          }else{
                                            return Container(
                                              child: Center(
                                                child: LoadingWidgetFadingCircle(context),
                                              ),
                                            );
                                          }
                                        },
                                      ),
                                    )
                                    ,

                                  ],
                                ),
                              ),
                            ],
                          );
                        },
                      );

                    },
                  ),
                if(order.payment_status == 'paid' && order.deliveryStatus != "komplain" && order.deliveryStatus != "completed" && order.deliveryStatus != "pending")
                  Container(
                    margin: EdgeInsets.only(top: 30),
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                            margin: EdgeInsets.only(right: 7.5),
                            child: GestureDetector(
                              onTap: () {
                                showAlertDialog(context,order);

                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  // border: Border.all(
                                  //   color: Colors.red[500],
                                  // ),
                                  color: Color(0xffF48262),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(5),
                                  ),
                                ),
                                height: 35,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      child: Text(
                                        "Terima Barang",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontFamily: "Brandon",
                                          color: Colors.white,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            margin: EdgeInsets.only(left: 7.5),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          KomplainDalamPerjalananScreen(order: order, )),
                                ).then((_value){
                                  _getData();
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Color(0xffF48262),
                                  ),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(5),
                                  ),
                                ),
                                height: 35,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      child: Text(
                                        "Komplain",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontFamily: "Brandon",
                                          color: Colors.black,
                                          fontSize: 15,
                                        ),
                                      ),
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

              ],
            ),
          );
        }
      },
      controller: _scrollController,
    );
  }

  void showAlertDialog(BuildContext context,Order order) {
    // set up the AlertDialog
    SimpleDialog alert = SimpleDialog(
      backgroundColor: Color(0xfffdf8f0),
      contentPadding: EdgeInsets.all(5.0),
      children: <Widget>[
        Align(
          alignment: Alignment.centerRight,
          child: IconButton(
              icon: Icon(Icons.close),
              color: Color(0xffF48262),
              onPressed: () {
                Navigator.of(context).pop();
              }),
        ),
        Container(
          child: Column(
            children: [
              Center(
                  child: Text(
                    "Pesanan Diterima",
                    style: TextStyle(
                      fontFamily: 'Brandon',
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                    ),
                  )
              ),
              Container(
                  padding: EdgeInsets.all(5.0),
                  child: Text(
                    "Saya telah memastikan bahwa produk telah saya terima dan tidak ada masalah. Saya tidak akan mengajukan pengembalian barang atau dana setelah ini.",
                    style: TextStyle(
                      fontFamily: 'Brandon',
                      fontSize: 12,
                    ),
                    textAlign: TextAlign.center,
                  )
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Color(0xffF3C1B5),
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(5),
                    ),
                  ),
                  width: 160,
                  height: 35,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: Text(
                          "NANTI SAJA",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: "Brandon",
                            color: Color(0xffF48262),
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  UIBlock.block(context,customLoaderChild: LoadingWidgetFadingCircle(context));
                  Provider.of<OrderModel>(context,listen: false).konfirmasiTerima(Provider.of<AppModel>(context,listen: false).auth.access_token, order.id.toString()).then((value){
                    UIBlock.unblock(context);
                    Navigator.of(context).pop();
                    _getData();
                  }).catchError((onError){
                    UIBlock.unblock(context);
                    Navigator.of(context).pop();
                    print(onError);
                  });

                },
                child: Container(
                  decoration: BoxDecoration(
                    // border: Border.all(
                    //   color: Colors.red[500],
                    // ),
                    color: Color(0xffF48262),
                    borderRadius: BorderRadius.all(
                      Radius.circular(5),
                    ),
                  ),
                  width: 160,
                  height: 35,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: Text(
                          "KONFIRMASI",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: "Brandon",
                            color: Colors.white,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )
        )


       
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Future<bool> _onWillPop() async {
    return Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => AccountScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    String title ="";
    if(widget.type == OrderScreen.unpaid){
      title ="Menunggu Pembayaran";
    }else if(widget.type == OrderScreen.paid){
      title = "Pembayaran Diterima";
    }else if(widget.type == OrderScreen.on_delivery){
      title = "Dalam Perjalanan";
    }else if(widget.type == OrderScreen.delivered){
      title = "Terkirim";
    }else if(widget.type == OrderScreen.completed){
      title = "Pesanan Selesai";
    } else if(widget.type == OrderScreen.komplain){
      title = "Sedang Komplain";
    }
    // TODO: implement build
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: Hexcolor('#FCF8F0'),
        appBar: AppBar(
          elevation: 0,
          titleSpacing: 0,
          leading: IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => AccountScreen(),
                ),
              );
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Color(0xffF48262),
              size: 26,
            ),
          ),
          title:  Text(
            title,
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
          child: Column(
            children: <Widget>[
              new Expanded(
                  child:
                  RefreshIndicator(
                    key: refreshKey,
                    child:  _buildList(),
                    onRefresh: _getData,
                  )
              ),
            ],
          ),
        ),
        bottomNavigationBar: new PonnyBottomNavbar(selectedIndex: 4),
      ),
    );
  }

}
