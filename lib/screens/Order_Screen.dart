import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:ponny/common/constant.dart';
import 'package:ponny/model/App.dart';
import 'package:ponny/model/Order.dart';
import 'package:http/http.dart' as http;
import 'package:ponny/screens/konfirmasi_pembayaran_screen.dart';
import 'package:ponny/util/globalUrl.dart';
import 'package:provider/provider.dart';

import 'bank_transfer_detail_screen.dart';

class OrderScreen extends StatefulWidget {
  static const String id = "OrderScreen";
  static const String unpaid ="unpaid";
  static const String paid ="paid";
  static const String on_delivery ="on_delivery";
  static const String delivered ="delivered";
  static const String completed ="completed";
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
  String type ="unpaid";

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
                            children:[
                              for(OrderDetail e in order.order_details)(
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
                                                    "Tukar Poin",
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
                                                    "Sample",
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
                            if(order.payment_type == "mt_tf_bca" || order.payment_type == "mt_tf_bni" || order.payment_type == "mt_tf_permata" || order.payment_type == "alfamart" || order.payment_type=="Indomaret" ||order.payment_type=="mt_tf_mdr")
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
                      textColor: Colors.white,
                      disabledColor: Colors.grey,
                      disabledTextColor: Colors.black,
                      child:  Text("BAYAR SEKARANG"),
                      onPressed: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BankTransferDetailScreen(order_id: order.id,), ),
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
                if(order.payment_status == 'paid' && order.confrimResi != null)
                  Container()

              ],
            ),
          );
        }
      },
      controller: _scrollController,
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
      title = "Dalam Pembayaran";
    }else if(widget.type == OrderScreen.delivered){
      title = "Terkirim";
    }else if(widget.type == OrderScreen.completed){
      title = "Pesanan Selesai";
    }
    // TODO: implement build
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(title: Text(
        title,
        style: TextStyle(
          fontSize: 22,
          fontFamily: "Yeseva",
          fontWeight: FontWeight.w500,
          color: Color(0xffF48262),
        ),
      ),
        leading: Container(
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
        toolbarHeight: 70,
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
    );
  }

}
