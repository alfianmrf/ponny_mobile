import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:ponny/common/constant.dart';
import 'package:ponny/model/Address.dart';
import 'package:ponny/model/App.dart';
import 'package:ponny/model/Cart.dart';
import 'package:ponny/model/Order.dart';
import 'package:ponny/model/User.dart';
import 'package:ponny/screens/CallPage.dart';
import 'package:ponny/screens/FAQ_screen.dart';
import 'package:ponny/screens/Syarat_Ketentuan_screen.dart';
import 'package:ponny/screens/WebView_screen.dart';
import 'package:ponny/screens/account/hubungi_kami_screen.dart';
import 'package:ponny/screens/Order_Screen.dart';
import 'package:ponny/screens/account/ulasan_produk_sukses_screen.dart';
import 'package:ponny/screens/konsultasi_screen.dart';
import 'package:ponny/screens/pra_daftar.dart';
import 'package:ponny/screens/login.dart';
import 'package:ponny/screens/account/menunggu_pembayaran_screen.dart';
import 'package:ponny/screens/account/pembayaran_diterima_screen.dart';
import 'package:ponny/screens/account/dalam_perjalanan_screen.dart';
import 'package:ponny/screens/account/terkirim_screen.dart';
import 'package:ponny/screens/account/pesanan_selesai_screen.dart';
import 'package:ponny/screens/account/ulasan_produk_screen.dart';
import 'package:ponny/screens/account/daftar_keinginan_screen.dart';
import 'package:ponny/screens/account/detail_akun_screen.dart';
import 'package:ponny/screens/account/beauty_profile_screen.dart';
import 'package:ponny/screens/account/happy_skin_reward_screen.dart';
import 'package:ponny/screens/account/affiliate_us_screen.dart';
import 'package:ponny/util/globalUrl.dart';
import 'Pengiriman_screen.dart';
import 'RincianPoint_screen.dart';
import 'package:ponny/widgets/PonnyBottomNavbar.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:uiblock/uiblock.dart';
import 'account/menunggu_pembayaran_sukses_screen.dart';
import 'Keuntungan_HappyReward_screen.dart';
import 'cart_screen.dart';
import 'home_screen.dart';

class AccountScreen extends StatefulWidget {
  static const String id = "account_screen";
  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  bool isLoading = true;
  final mon = DateFormat('MMMM');

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      Provider.of<UserModel>(context)
          .getUser(
          Provider.of<AppModel>(context, listen: false).auth.access_token)
          .then((value) {
        setState(() {
          isLoading = false;
        });
      });
    });
  }

  Future<void> getUser() async {
    final auth = Provider.of<AppModel>(context, listen: false);
    String token = auth.auth.access_token;

    // final response = await http.get(userprofile,headers: { HttpHeaders.contentTypeHeader: 'application/json',HttpHeaders.authorizationHeader: "Bearer $token" });
    // final responseJson = json.decode(response.body);
    //
    // setState(() {
    //   isLoading =false;
    // });
    // if(response.statusCode == 200){
    //   setState(() {
    //     user = User.fromLocalJson(responseJson);
    //   });
    // }else{
    //   await Provider.of<AddressModel>(context).RemoveDefaultAddress();
    //   await Provider.of<AppModel>(context).logout();
    //
    //   Navigator.pushReplacement(context,new MaterialPageRoute(
    //     builder: (BuildContext context) =>  new LoginScreen(),
    //   ));
    // }
  }

  List<String> judul = [
    "Dalam Perjalanan",
    "Pesanan Selesai",
    "Ulasan Produk",
    "Daftar Keinginan",
    "Detail Akun",
  ];

  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  Future<bool> _onWillPop() async {
    return (await showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: new Text('Are you sure?'),
        content: new Text('Do you want to exit an App'),
        actions: <Widget>[
          new FlatButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: new Text('No'),
          ),
          new FlatButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: new Text('Yes'),
          ),
        ],
      ),
    )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel>(context).user;
    final jmlCard = Provider.of<CartModel>(context).getCountOfquantity();
    return new WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Hexcolor('#FCF8F0'),
        body: SafeArea(
          child: SingleChildScrollView(
            child: isLoading
                ? Container(
              height: MediaQuery.of(context).size.height,
              child: Center(
                child: LoadingWidgetFadingCircle(context),
              ),
            )
                : Column(
              children: <Widget>[
                Container(
                  alignment: Alignment.centerRight,
                  margin: EdgeInsets.only(left: 10, right: 10),
                  child: IconButton(
                    icon: new Stack(
                        children: <Widget>[
                          new Container(
                            padding: EdgeInsets.all(5),
                            child: ImageIcon(
                              AssetImage('assets/images/home/cart.png'),
                              color: Color(0xffF48262),
                            ),
                          ),
                          if(jmlCard>0)
                            new Positioned(  // draw a red marble
                              top: 0.0,
                              right: 0.0,
                              child: Container(
                                width: 12,
                                height: 12,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(40),
                                  color: Colors.redAccent,
                                ),
                                child: Center(
                                  child: Text(
                                    jmlCard.toString(),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Brandon',
                                      fontSize: 8,
                                    ),
                                  ),
                                ),
                              ),
                            )
                        ]
                    ),
                    onPressed: () {
                      if(Provider.of<AppModel>(context).loggedIn){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CartScreen()),
                        );
                      }else{
                        Navigator.push(context,new MaterialPageRoute(
                          builder: (BuildContext context) => new LoginScreen(),
                        ));
                      }
                    },
                  ),
                ),
                Container(
                  height: 10,
                ),
                Container(
                  margin: EdgeInsets.only(left: 20, right: 20),
                  width: double.infinity,
                  child: Container(
                    child: Text(
                      "Hi, " + user.name,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Yeseva',
                        color: Hexcolor("#F59379"),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 10,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 330,
                  color: Hexcolor("#F59379"),
                  child: Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(top: 20),
                        padding: EdgeInsets.only(right: 20, left: 20),
                        decoration: new BoxDecoration(
                          color: Hexcolor('#FCF8F0'),
                          borderRadius:
                          BorderRadius.all(Radius.circular(15)),
                        ),
                        width: 300,
                        height: 190,
                        child: Column(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(top: 7),
                              child: Text(
                                user.dashboard.membershipTitle
                                    .toUpperCase(),
                                style: TextStyle(
                                  color: Hexcolor("#F59379"),
                                  fontFamily: "Brandon",
                                  fontSize: 45,
                                  fontWeight: FontWeight.w900,
                                  letterSpacing: 3,
                                ),
                              ),
                            ),
                            Container(
                              child: Text(
                                "SKIN",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Hexcolor("#F59379"),
                                  fontFamily: "Yeseva",
                                  fontWeight: FontWeight.w300,
                                  letterSpacing: 1,
                                ),
                              ),
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              margin: EdgeInsets.only(top: 10),
                              child: RichText(
                                text: TextSpan(
                                    text: user.name,
                                    style: TextStyle(
                                      fontFamily: "Yeseva",
                                      fontSize: 12,
                                      color: Hexcolor("#F59379"),
                                      fontWeight: FontWeight.w600,
                                    ),
                                    children: <TextSpan>[
                                      TextSpan(text: " "),
                                      TextSpan(text: user.last_name)
                                    ]),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                top: 6,
                              ),
                              height: 1,
                              color: Hexcolor("#F59379"),
                            ),
                            Container(
                              // margin: EdgeInsets.only(top: 10),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                    child: Text(
                                      user.point.toString() + " POINTS",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                        fontFamily: 'Brandon',
                                        color: Hexcolor("#F59379"),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 2),
                                    child: Row(
                                      children: <Widget>[
                                        Container(
                                          child: Column(
                                            children: <Widget>[
                                              Container(
                                                child: Text(
                                                  "Berlaku",
                                                  style: TextStyle(
                                                    fontFamily: "Brandon",
                                                    fontSize: 11,
                                                    color:
                                                    Hexcolor("#F59379"),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                child: Text(
                                                  "Hingga",
                                                  style: TextStyle(
                                                    fontFamily: "Brandon",
                                                    fontSize: 11,
                                                    color:
                                                    Hexcolor("#F59379"),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          child: Column(
                                            children: <Widget>[
                                              Container(
                                                margin: EdgeInsets.only(
                                                    left: 5),
                                                child: Text(
                                                  mon
                                                      .format(
                                                      convertDateFromString(
                                                          user
                                                              .dashboard
                                                              .log
                                                              .endsOn))
                                                      .toUpperCase(),
                                                  style: TextStyle(
                                                    fontFamily: "Brandon",
                                                    fontSize: 11,
                                                    color:
                                                    Hexcolor("#F59379"),
                                                    fontWeight:
                                                    FontWeight.w600,
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                // margin: EdgeInsets.only(left: 10),
                                                child: Text(
                                                  convertDateFromString(user
                                                      .dashboard
                                                      .log
                                                      .endsOn)
                                                      .year
                                                      .toString(),
                                                  style: TextStyle(
                                                    fontFamily: "Brandon",
                                                    fontSize: 11,
                                                    color:
                                                    Hexcolor('#F48262'),
                                                    fontWeight:
                                                    FontWeight.w600,
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
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 20,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 45, right: 45),
                        height: 50,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Container(
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    child: Text(
                                      user.dashboard.membershipTitle
                                          .toUpperCase(),
                                      style: TextStyle(
                                        fontFamily: "Brandon",
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white,
                                        fontSize: 12,
                                        letterSpacing: 1,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    child: Text(
                                      "SKIN",
                                      style: TextStyle(
                                        fontFamily: "Yeseva",
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Container(
                                child: LinearPercentIndicator(
                                  lineHeight: 8.0,
                                  percent: user.dashboard.percent / 100,
                                  progressColor: Colors.white,
                                ),
                              ),
                            ),
                            Container(
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    child: Text(
                                      user.dashboard.next.toUpperCase(),
                                      style: TextStyle(
                                        fontFamily: "Brandon",
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    child: Text(
                                      "SKIN",
                                      style: TextStyle(
                                        fontFamily: "Yeseva",
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: Column(
                          children: <Widget>[
                            Container(
                              child: Text(
                                "Belanja " +
                                    nm_format
                                        .format(user.dashboard.toNext) +
                                    " lagi untuk naik tingkat",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w800,
                                  fontFamily: "Brandon",
                                ),
                              ),
                            ),
                            Container(
                              child: Text(
                                  "ke " + user.dashboard.next + " Skin",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w800,
                                    fontFamily: "Brandon",
                                  )),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: 10,
                    left: 20,
                    right: 20,
                    bottom: 10,
                  ),
                  child: ListView(
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    primary: false,
                    children: <Widget>[
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => OrderScreen(
                                type: OrderScreen.unpaid,
                              ),
                            ),
                          );
                        },
                        child: Container(
                          decoration: new BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                width: 1,
                                color: Hexcolor("#F59379"),
                              ),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(
                                        bottom: 5, left: 15, right: 15),
                                    child: Icon(
                                      Icons.watch_later,
                                      size: 30,
                                      color: Hexcolor("#F59379"),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(bottom: 5),
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(left: 0),
                                          child: Text(
                                            "Menunggu Pembayaran",
                                            style: TextStyle(
                                              fontFamily: "Brandon",
                                              fontWeight: FontWeight.w700,
                                              fontSize: 17,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          // width: 150,
                                          child: Text(
                                            "Yuk dibayar, yuk ^_^",
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              fontFamily: "Brandon",
                                              fontWeight: FontWeight.w500,
                                              color: Colors.grey,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              if(user.dashboard.unpaid > 0)
                              Container(
                                width: 15,
                                height: 15,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Hexcolor("#F59379"),
                                ),
                                child: Center(
                                  child: Text(
                                    user.dashboard.unpaid.toString(),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Brandon',
                                      fontSize: 10,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => OrderScreen(
                                type: OrderScreen.paid,
                              ),
                            ),
                          );
                        },
                        child: Container(
                          decoration: new BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                width: 1,
                                color: Hexcolor("#F59379"),
                              ),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(
                                        bottom: 5, left: 15, right: 15),
                                    child: Icon(
                                      Icons.shopping_cart,
                                      size: 30,
                                      color: Hexcolor("#F59379"),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 5, bottom: 5),
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(left: 0),
                                          child: Text(
                                            "Pembayaran Diterima",
                                            style: TextStyle(
                                              fontFamily: "Brandon",
                                              fontWeight: FontWeight.w700,
                                              fontSize: 17,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          // width: 150,
                                          child: Text(
                                            "Asik! Transaksimu berhasil!",
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              fontFamily: "Brandon",
                                              fontWeight: FontWeight.w500,
                                              color: Colors.grey,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              if(user.dashboard.paid > 0)
                              Container(
                                width: 15,
                                height: 15,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Hexcolor("#F59379"),
                                ),
                                child: Center(
                                  child: Text(
                                    user.dashboard.paid.toString(),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Brandon',
                                      fontSize: 10,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => OrderScreen(
                                type: OrderScreen.on_delivery,
                              ),
                            ),
                          );
                        },
                        child: Container(
                          decoration: new BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                width: 1,
                                color: Hexcolor("#F59379"),
                              ),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(
                                        bottom: 5, left: 15, right: 15),
                                    child: Image.asset(
                                      'assets/images/perjalanan@4x.png',
                                      width: 30,
                                      height: 30,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 5, bottom: 5),
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(left: 0),
                                          child: Text(
                                            "Dalam Perjalanan",
                                            style: TextStyle(
                                              fontFamily: "Brandon",
                                              fontWeight: FontWeight.w700,
                                              fontSize: 17,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          // width: 150,
                                          child: Text(
                                            "Mari tengok keberadaan paketmu.",
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              fontFamily: "Brandon",
                                              fontWeight: FontWeight.w500,
                                              color: Colors.grey,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              if(user.dashboard.ondelivery > 0)
                              Container(
                                width: 15,
                                height: 15,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Hexcolor("#F59379"),
                                ),
                                child: Center(
                                  child: Text(
                                    user.dashboard.ondelivery.toString(),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Brandon',
                                      fontSize: 10,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => OrderScreen(
                                type: OrderScreen.delivered,
                              ),
                            ),
                          );
                        },
                        child: Container(
                          decoration: new BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                width: 1,
                                color: Hexcolor("#F59379"),
                              ),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(
                                        bottom: 5, left: 15, right: 15),
                                    child: Icon(
                                      Icons.directions_car,
                                      size: 30,
                                      color: Hexcolor("#F59379"),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 5, bottom: 5),
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(left: 0),
                                          child: Text(
                                            "Terkirim",
                                            style: TextStyle(
                                              fontFamily: "Brandon",
                                              fontWeight: FontWeight.w700,
                                              fontSize: 17,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          // width: 150,
                                          child: Text(
                                            "Hore! Paketmu udah diantar jasa kurir pilihanmu.",
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              fontFamily: "Brandon",
                                              fontWeight: FontWeight.w500,
                                              color: Colors.grey,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              if(user.dashboard.delivered > 0)
                              Container(
                                width: 15,
                                height: 15,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Hexcolor("#F59379"),
                                ),
                                child: Center(
                                  child: Text(
                                    user.dashboard.delivered.toString(),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Brandon',
                                      fontSize: 10,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => OrderScreen(
                                type: OrderScreen.completed,
                              ),
                            ),
                          );
                        },
                        child: Container(
                          decoration: new BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                width: 1,
                                color: Hexcolor("#F59379"),
                              ),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(
                                        bottom: 10,
                                        left: 15,
                                        right: 15,
                                        top: 10),
                                    child: Image.asset(
                                      'assets/images/Asset 8.png',
                                      width: 30,
                                      height: 30,
                                      fit: BoxFit.contain,
                                    ),
                                  ),

                                  Container(
                                    margin: EdgeInsets.only(bottom: 5, top: 5),
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(top: 0),
                                          child: Text(
                                            "Pesanan Selesai",
                                            style: TextStyle(
                                              fontFamily: "Brandon",
                                              fontWeight: FontWeight.w700,
                                              fontSize: 17,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          // width: 150,
                                          child: Text(
                                            "Pesanan yang telah diterima",
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              fontFamily: "Brandon",
                                              fontWeight: FontWeight.w500,
                                              color: Colors.grey,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              if(user.dashboard.selesai > 0)
                              Container(
                                width: 15,
                                height: 15,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Hexcolor("#F59379"),
                                ),
                                child: Center(
                                  child: Text(
                                    user.dashboard.selesai.toString(),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Brandon',
                                      fontSize: 10,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => OrderScreen(
                                type: OrderScreen.komplain,
                              ),
                            ),
                          );
                        },
                        child: Container(
                          decoration: new BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                width: 1,
                                color: Hexcolor("#F59379"),
                              ),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(
                                        bottom: 10,
                                        left: 15,
                                        right: 15,
                                        top: 10),
                                    child: Image.asset(
                                      'assets/images/komplain.png',
                                      width: 30,
                                      height: 30,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(bottom: 5, top: 5),
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(top: 0),
                                          child: Text(
                                            "Sedang Komplain",
                                            style: TextStyle(
                                              fontFamily: "Brandon",
                                              fontWeight: FontWeight.w700,
                                              fontSize: 17,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          // width: 150,
                                          child: Text(
                                            "Mohon maaf, ada yang bisa Phobe bantu?",
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              fontFamily: "Brandon",
                                              fontWeight: FontWeight.w500,
                                              color: Colors.grey,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              if(user.dashboard.komplain > 0)
                              Container(
                                width: 15,
                                height: 15,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Hexcolor("#F59379"),
                                ),
                                child: Center(
                                  child: Text(
                                    user.dashboard.komplain.toString(),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Brandon',
                                      fontSize: 10,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => OrderScreen(
                                type: OrderScreen.dibatalkan,
                              ),
                            ),
                          );
                        },
                        child: Container(
                          decoration: new BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                width: 1,
                                color: Hexcolor("#F59379"),
                              ),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(
                                        bottom: 10,
                                        left: 15,
                                        right: 15,
                                        top: 10),
                                    child: Image.asset(
                                      'assets/images/dibatalkan@4x.png',
                                      width: 30,
                                      height: 30,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(bottom: 5, top: 5),
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(top: 0),
                                          child: Text(
                                            "Pesanan Dibatalkan",
                                            style: TextStyle(
                                              fontFamily: "Brandon",
                                              fontWeight: FontWeight.w700,
                                              fontSize: 17,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          // width: 150,
                                          child: Text(
                                            "Mohon maaf, ada yang bisa Phobe bantu?",
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              fontFamily: "Brandon",
                                              fontWeight: FontWeight.w500,
                                              color: Colors.grey,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              if(user.dashboard.dibatalkan > 0)
                              Container(
                                width: 15,
                                height: 15,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Hexcolor("#F59379"),
                                ),
                                child: Center(
                                  child: Text(
                                    user.dashboard.dibatalkan.toString(),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Brandon',
                                      fontSize: 10,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    UlasanProdukSuksesScreen()),
                          );
                        },
                        child: Container(
                          decoration: new BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                width: 1,
                                color: Hexcolor("#F59379"),
                              ),
                            ),
                          ),
                          child: Row(
                            children: [
                              Container(
                                margin: EdgeInsets.only(
                                    bottom: 10,
                                    left: 15,
                                    right: 15,
                                    top: 10),
                                child: Image.asset(
                                  'assets/images/Asset 9.png',
                                  width: 30,
                                  height: 30,
                                  fit: BoxFit.contain,
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(bottom: 5, top: 5),
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(left: 0),
                                      child: Text(
                                        "Ulasan Produk",
                                        style: TextStyle(
                                          fontFamily: "Brandon",
                                          fontWeight: FontWeight.w700,
                                          fontSize: 17,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      // width: 150,
                                      child: Text(
                                        "Suka produknya? Tinggalkan ulasanmu, ya!",
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          fontFamily: "Brandon",
                                          fontWeight: FontWeight.w500,
                                          color: Colors.grey,
                                          fontSize: 12,
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
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    DaftarKeinginanScreen()),
                          );
                        },
                        child: Container(
                          decoration: new BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                width: 1,
                                color: Hexcolor("#F59379"),
                              ),
                            ),
                          ),
                          child: Row(
                            children: [
                              Container(
                                margin: EdgeInsets.only(
                                    bottom: 10,
                                    left: 15,
                                    right: 15,
                                    top: 10),
                                child: Image.asset(
                                  'assets/images/Asset 10.png',
                                  width: 30,
                                  height: 30,
                                  fit: BoxFit.contain,
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(bottom: 5, top: 5),
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(left: 0),
                                      child: Text(
                                        "Daftar Keinginan",
                                        style: TextStyle(
                                          fontFamily: "Brandon",
                                          fontWeight: FontWeight.w700,
                                          fontSize: 17,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      // width: 150,
                                      child: Text(
                                        "Produk kesayanganmu masih menunggu loh!",
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          fontFamily: "Brandon",
                                          fontWeight: FontWeight.w500,
                                          color: Colors.grey,
                                          fontSize: 12,
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
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DetailAkunScreen()),
                          );
                        },
                        child: Container(
                          child: Row(
                            children: [
                              Container(
                                margin: EdgeInsets.only(
                                    bottom: 10,
                                    left: 15,
                                    right: 15,
                                    top: 10),
                                child: Image.asset(
                                  'assets/images/Asset 11.png',
                                  width: 30,
                                  height: 30,
                                  fit: BoxFit.contain,
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(bottom: 5, top: 5),
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(left: 0),
                                      child: Text(
                                        "Detail Akun",
                                        style: TextStyle(
                                          fontFamily: "Brandon",
                                          fontWeight: FontWeight.w700,
                                          fontSize: 17,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      // width: 150,
                                      child: Text(
                                        "Kenalan, yuk!",
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          fontFamily: "Brandon",
                                          fontWeight: FontWeight.w500,
                                          color: Colors.grey,
                                          fontSize: 12,
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
                    ],
                  ),
                ),
                Container(
                  height: 20,
                  color: Colors.white,
                  width: MediaQuery.of(context).size.width,
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: 10,
                    left: 20,
                    right: 20,
                    bottom: 10,
                  ),
                  child: ListView(
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    primary: false,
                    children: <Widget>[
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    BeautyProfileScreen()),
                          );
                        },
                        child: Container(
                          decoration: new BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                width: 1,
                                color: Hexcolor("#F59379"),
                              ),
                            ),
                          ),
                          child: Row(
                            children: [
                              Container(
                                margin: EdgeInsets.only(
                                    bottom: 5, left: 15, right: 15),
                                child: Image.asset(
                                  'assets/images/Asset 12.png',
                                  width: 30,
                                  height: 30,
                                  fit: BoxFit.contain,
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(bottom: 5),
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(left: 0),
                                      child: Text(
                                        "Profil Kecantikan",
                                        style: TextStyle(
                                          fontFamily: "Brandon",
                                          fontWeight: FontWeight.w700,
                                          fontSize: 17,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      // width: 150,
                                      child: Text(
                                        "Semua tentang kulit, rambut & kesukaanmu",
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          fontFamily: "Brandon",
                                          fontWeight: FontWeight.w500,
                                          color: Colors.grey,
                                          fontSize: 12,
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
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    HappySkinRewardScreen()),
                          );
                        },
                        child: Container(
                          decoration: new BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                width: 1,
                                color: Hexcolor("#F59379"),
                              ),
                            ),
                          ),
                          child: Row(
                            children: [
                              Container(
                                margin: EdgeInsets.only(
                                    bottom: 10,
                                    left: 15,
                                    right: 15,
                                    top: 10),
                                child: Image.asset(
                                  'assets/images/Asset 13.png',
                                  width: 30,
                                  height: 30,
                                  fit: BoxFit.contain,
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(bottom: 5, top: 5),
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(top: 0),
                                      child: Text(
                                        "Happy Skin Rewards",
                                        style: TextStyle(
                                          fontFamily: "Brandon",
                                          fontWeight: FontWeight.w700,
                                          fontSize: 17,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      // width: 150,
                                      child: Text(
                                        "Tukar poinmu biar makin glowing!",
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          fontFamily: "Brandon",
                                          fontWeight: FontWeight.w500,
                                          color: Colors.grey,
                                          fontSize: 12,
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
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => UntungReward()));
                        },
                        child: Container(
                          decoration: new BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                width: 1,
                                color: Hexcolor("#F59379"),
                              ),
                            ),
                          ),
                          child: Row(
                            children: [
                              Container(
                                margin: EdgeInsets.only(
                                    bottom: 10,
                                    left: 15,
                                    right: 15,
                                    top: 10),
                                child: Image.asset(
                                  'assets/images/Asset 14.png',
                                  width: 30,
                                  height: 30,
                                  fit: BoxFit.contain,
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(bottom: 5, top: 5),
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(left: 0),
                                      child: Text(
                                        "Keuntungan Happy Skin Reward",
                                        style: TextStyle(
                                          fontFamily: "Brandon",
                                          fontWeight: FontWeight.w700,
                                          fontSize: 17,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      // width: 150,
                                      child: Text(
                                        "Makin sering belanja, makin untung!",
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          fontFamily: "Brandon",
                                          fontWeight: FontWeight.w500,
                                          color: Colors.grey,
                                          fontSize: 12,
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
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RincianPoint()));
                        },
                        child: Container(
                          child: Row(
                            children: [
                              Container(
                                margin: EdgeInsets.only(
                                    bottom: 10,
                                    left: 15,
                                    right: 15,
                                    top: 10),
                                child: Image.asset(
                                  'assets/images/Asset 15.png',
                                  width: 30,
                                  height: 30,
                                  fit: BoxFit.contain,
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(bottom: 5, top: 5),
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(left: 0),
                                      child: Text(
                                        "Rincian Poin",
                                        style: TextStyle(
                                          fontFamily: "Brandon",
                                          fontWeight: FontWeight.w700,
                                          fontSize: 17,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      // width: 150,
                                      child: Text(
                                        "Lihat riwayat poinmu",
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          fontFamily: "Brandon",
                                          fontWeight: FontWeight.w500,
                                          color: Colors.grey,
                                          fontSize: 12,
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
                    ],
                  ),
                ),
                Container(
                  height: 20,
                  color: Colors.white,
                  width: MediaQuery.of(context).size.width,
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: 10,
                    left: 30,
                    right: 30,
                    bottom: 10,
                  ),
                  child: ListView(
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    primary: false,
                    children: <Widget>[
                      InkWell(
                        onTap: () {},
                        child: Container(
                          padding: EdgeInsets.only(bottom: 10, top: 10),
                          decoration: new BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                width: 1,
                                color: Hexcolor("#F59379"),
                              ),
                            ),
                          ),
                          child: Text(
                            "BUTUH BANTUAN ?",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              fontFamily: "Brandon",
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    WebViewScreen(titile: "Tentang Ponny Beaute", url:"https://www.ponnybeaute.co.id/about-us" ,)),
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.only(bottom: 15, top: 15),
                          decoration: new BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                width: 1,
                                color: Hexcolor("#F59379"),
                              ),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Text(
                                  "Tentang Ponny Beaute",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w200,
                                    fontFamily: "Brandon",
                                  ),
                                ),
                              ),
                              Container(
                                child: Icon(
                                  Icons.arrow_forward_ios,
                                  color: Color(0xffF48262),
                                  size: 20,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> PengirimanScreen()));
                        },
                        child: Container(
                          padding: EdgeInsets.only(bottom: 15, top: 15),
                          decoration: new BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                width: 1,
                                color: Hexcolor("#F59379"),
                              ),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Text(
                                  "Pengiriman",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w200,
                                    fontFamily: "Brandon",
                                  ),
                                ),
                              ),
                              Container(
                                child: Icon(
                                  Icons.arrow_forward_ios,
                                  color: Color(0xffF48262),
                                  size: 20,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    FAQScreen()),
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.only(bottom: 15, top: 15),
                          decoration: new BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                width: 1,
                                color: Hexcolor("#F59379"),
                              ),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Text(
                                  "FAQ",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w200,
                                    fontFamily: "Brandon",
                                  ),
                                ),
                              ),
                              Container(
                                child: Icon(
                                  Icons.arrow_forward_ios,
                                  color: Color(0xffF48262),
                                  size: 20,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HubungiKamiScreen(),
                            ),
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.only(bottom: 15, top: 15),
                          decoration: new BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                width: 1,
                                color: Hexcolor("#F59379"),
                              ),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Text(
                                  "Hubungi Kami",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w200,
                                    fontFamily: "Brandon",
                                  ),
                                ),
                              ),
                              Container(
                                child: Icon(
                                  Icons.arrow_forward_ios,
                                  color: Color(0xffF48262),
                                  size: 20,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => KonsultasiScreen(),
                            ),
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.only(bottom: 15, top: 15),
                          decoration: new BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                width: 1,
                                color: Hexcolor("#F59379"),
                              ),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Text(
                                  "Tanya Ahlinya",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w200,
                                    fontFamily: "Brandon",
                                  ),
                                ),
                              ),
                              Container(
                                child: Icon(
                                  Icons.arrow_forward_ios,
                                  color: Color(0xffF48262),
                                  size: 20,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AffiliateUsScreen()),
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.only(bottom: 15, top: 15),
                          decoration: new BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                width: 1,
                                color: Hexcolor("#F59379"),
                              ),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Text(
                                  "Jadi Rekan Phoebe",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w200,
                                    fontFamily: "Brandon",
                                  ),
                                ),
                              ),
                              Container(
                                child: Icon(
                                  Icons.arrow_forward_ios,
                                  color: Color(0xffF48262),
                                  size: 20,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    WebViewScreen(titile: "Kebijakan Privasi", url:"https://www.ponnybeaute.co.id/kebijakan-privasi" ,)),
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.only(bottom: 15, top: 15),
                          decoration: new BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                width: 1,
                                color: Hexcolor("#F59379"),
                              ),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Text(
                                  "Kebijakan Privasi",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w200,
                                    fontFamily: "Brandon",
                                  ),
                                ),
                              ),
                              Container(
                                child: Icon(
                                  Icons.arrow_forward_ios,
                                  color: Color(0xffF48262),
                                  size: 20,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    WebViewScreen(titile: "Syarat dan Ketentuan", url:"https://www.ponnybeaute.co.id/syarat-ketentuan" ,)),
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.only(bottom: 15, top: 15),
                          decoration: new BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                width: 1,
                                color: Hexcolor("#F59379"),
                              ),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Text(
                                  "Syarat dan Ketentuan",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w200,
                                    fontFamily: "Brandon",
                                  ),
                                ),
                              ),
                              Container(
                                child: Icon(
                                  Icons.arrow_forward_ios,
                                  color: Color(0xffF48262),
                                  size: 20,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () async {
                          UIBlock.block(context,
                              customLoaderChild: LoadingWidget(context));
                          Provider.of<CartModel>(context)
                              .DefaultCart()
                              .then((value) {
                            Provider.of<AppModel>(context)
                                .logout()
                                .then((value) {
                              UIBlock.unblock(context);
                              Navigator.pushReplacement(
                                  context,
                                  new MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                    new HomeScreen(),
                                  ));
                            });
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.only(bottom: 15, top: 15),
                          child: Row(
                            children: [
                              Container(
                                child: Image.asset('assets/images/logout.png', width: 18,),
                                margin: EdgeInsets.only(right: 10),
                              ),
                              Container(
                                child: Text(
                                  "Keluar",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w200,
                                    fontFamily: "Brandon",
                                    color: Color(0xffF48262),
                                  ),
                                ),
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
        bottomNavigationBar: new PonnyBottomNavbar(selectedIndex: 4),
      ),
    );
  }
}
