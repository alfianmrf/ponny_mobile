import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:agora_rtm/agora_rtm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:intl/intl.dart';
import 'package:ponny/common/constant.dart';
import 'package:ponny/model/App.dart';
import 'package:ponny/model/DetailKonsultasi.dart';
import 'package:ponny/model/Dokter.dart';
import 'package:ponny/model/FaqHeader.dart';
import 'package:ponny/model/Order.dart';
import 'package:ponny/model/User.dart';
import 'package:ponny/model/Voucher.dart';
import 'package:ponny/screens/Qris_screen.dart';
import 'package:ponny/screens/WaitingPage.dart';
import 'package:ponny/screens/payment_voucher_screen.dart';
import 'package:ponny/util/AppId.dart';
import 'package:ponny/util/globalUrl.dart';
import 'package:ponny/widgets/PonnyBottomNavbar.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

class KonsultasiScreen extends StatefulWidget {
  static const String id = "konsultasi_screen";
  @override
  _KonsultasiState createState() => _KonsultasiState();
}

class _KonsultasiState extends State<KonsultasiScreen> {
  ScrollController _scrollController = new ScrollController();
  ScrollController _scrollControllerVoucher = new ScrollController();
  final scaffolKey =  GlobalKey<ScaffoldState>();
  int _currentPage = 3;
  int counter = 1;
  Voucher voucher;
  bool loadingVoucher = true;
  bool loadingRiwayat = true;
  bool loadingMyvoucher = true;
  bool loadmore = false;
  bool loadmoreMyvoucher = false;
  bool pakai = false;
  List<Order> riwayatVoucher=[];
  List<OrderDetailVoucher> listMyvoucher =[];
  String nextUrlRiwayat;
  String nextUrllistVouvher;
  OrderDetailVoucher selectVoucher;
  int jmlVoucherAktive=0;
  int jmlBelumdibayar=0;
  DetailKonsultasi result = DetailKonsultasi();
  bool loading = true;

  @override
  void initState() {
    super.initState();
    getData();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      Provider.of<VoucherModel>(context).getVoucher().then((value){
        setState(() {
          loadingVoucher = false;
          voucher = Provider.of<VoucherModel>(context).voucher;
        });
      });
      _getVoucherAktive();

      _scrollController.addListener(() {
        if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent) {
          _getMoreDataRiwayat();
        }
      });

      _scrollControllerVoucher.addListener(() {
        if (_scrollControllerVoucher.position.pixels ==
            _scrollControllerVoucher.position.maxScrollExtent) {
          _getMoreListMyVoucher();
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

  _getVoucherAktive() async {
    var token = Provider.of<AppModel>(context,listen: false).auth.access_token;
    final res = await http.get(voucherAktive,headers: { HttpHeaders.contentTypeHeader: 'application/json', HttpHeaders.authorizationHeader: "Bearer $token"});
    if(res.statusCode == 200){
      setState(() {
        print(res.body);
        final result = json.decode(res.body);
        jmlVoucherAktive = result['vouchers'];
        jmlBelumdibayar = result['orders'];
      });
    }
  }

  Future<void> getData() async {
    try {
      final res = await http.get(detailKonsultasi);
      if (res.statusCode == 200) {
        final responeJson = json.decode(res.body);
        setState(() {
          result = DetailKonsultasi.fromJson(responeJson);
          loading = false;
        });
        print("SUCCESS");
        print(responeJson);
      }
    } catch (e) {
      print("ERROR");
      print(e.toString());
      setState(() {
        loading = false;
      });
      scaffolKey.currentState.showSnackBar(snackBarError);
    }
  }


  void incrementCounter() {
    setState(() {
      counter++;
    });
  }

  void decrementCounter() {
    setState(() {
      if(counter>1)
      counter--;
    });
  }
  
  void getDataRiwayat(){
    setState(() {
      loadingRiwayat =true;
      riwayatVoucher = [];
    });
    Provider.of<VoucherModel>(context).getRiwayat(historyVoucher, Provider.of<AppModel>(context,listen: false).auth.access_token).then((value){
      setState(() {
        riwayatVoucher.addAll(value.orders);
        nextUrlRiwayat = value.nextUrl;
        loadingRiwayat = false;
      });
    });
  }

  void getListVoucheSaya(){
    setState(() {
      loadingMyvoucher =true;
      listMyvoucher = [];
    });
    Provider.of<VoucherModel>(context).getListVoucher(listVoucherActive, Provider.of<AppModel>(context,listen: false).auth.access_token).then((value){
      setState(() {
        listMyvoucher.addAll(value.vouchers);
        nextUrllistVouvher = value.nextUrl;
        loadingMyvoucher = false;
      });
    });
  }

  void _getMoreDataRiwayat(){
    if(nextUrlRiwayat != null){
      setState(() {
        loadmore =true;
      });
      Provider.of<VoucherModel>(context).getRiwayat(nextUrlRiwayat, Provider.of<AppModel>(context,listen: false).auth.access_token).then((value){
        setState(() {
          riwayatVoucher.addAll(value.orders);
          nextUrlRiwayat = value.nextUrl;
          loadmore = false;
        });
      });

    }
  }
  void _getMoreListMyVoucher(){
    if(nextUrllistVouvher != null){
      setState(() {
        loadmoreMyvoucher =true;
      });
      Provider.of<VoucherModel>(context).getListVoucher(nextUrllistVouvher, Provider.of<AppModel>(context,listen: false).auth.access_token).then((value){
        setState(() {
          listMyvoucher.addAll(value.vouchers);
          nextUrllistVouvher = value.nextUrl;
          loadmoreMyvoucher = false;
        });
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    final faq = Provider.of<AppModel>(context,listen: false).listFaq.firstWhere((element) => element.id == 5);
    return Scaffold(
      key: scaffolKey,
      backgroundColor: Hexcolor("#FDF9EE"),
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.only(top: 70, bottom: 70),
                color: Hexcolor("#FEEDE5"),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: Text(
                        "TANYA AHLI",
                        style: TextStyle(
                          fontFamily: "Brandon",
                          color: Hexcolor("#F7866A"),
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Text(
                            "Kamu bisa konsultasi dengan dokter langsung \n melalui live chat",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: "Brandon",
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.only(
                  top: 5,
                  bottom: 10,
                  right: 10,
                  left: 10,
                ),
                margin: EdgeInsets.only(
                  right: 20,
                  left: 20,
                  top: 220.0,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Hexcolor("#FFF9EF"),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 1,
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: GestureDetector(
                        onTap: () {
                          setState(() => _currentPage = 3);
                        },
                        child: Container(
                          child: Column(
                            children: [
                              Container(
                                padding: EdgeInsets.only(top: 5),
                                child: Image.asset(
                                  "assets/images/konsultasi.png",
                                  width: 50,
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 5),
                                child: Text(
                                  "Konsultasi",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontFamily: "Brandon",
                                    color: (_currentPage == 3)
                                        ? Hexcolor("#F7866A")
                                        : Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 5),
                    Expanded(
                      flex: 1,
                      child: GestureDetector(
                        onTap: () {
                          setState(() => _currentPage = 0);
                        },
                        child: Container(
                          child: Column(
                            children: [
                              Container(
                                padding: EdgeInsets.only(top: 5),
                                child: Image.asset(
                                  "assets/images/tambah.png",
                                  width: 50,
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 5),
                                child: Text(
                                  "Beli",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontFamily: "Brandon",
                                    color:
                                        (_currentPage == 0 || _currentPage == 4)
                                            ? Hexcolor("#F7866A")
                                            : Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 5),
                    Expanded(
                      flex: 1,
                      child: GestureDetector(
                        onTap: () {
                          getDataRiwayat();
                          setState(() => _currentPage = 2);
                        },
                        child: Container(
                          child: Column(
                            children: [
                              Stack(
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(top: 5),
                                    child: Image.asset(
                                      "assets/images/Asset 1.png",
                                      width: 50,
                                    ),
                                  ),
                                  if(jmlBelumdibayar>0)
                                    Positioned(  // draw a red marble
                                      top: 0.0,
                                      right: 0.0,
                                      child: Container(
                                        width: 18,
                                        height: 18,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(40),
                                          color: Hexcolor('#de1738'),
                                        ),
                                        child: Center(
                                          child: Text(
                                            jmlBelumdibayar.toString(),
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: 'Brandon',
                                              fontSize: 12,
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                ],
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 5),
                                child: Text(
                                  "Riwayat",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontFamily: "Brandon",
                                    color: (_currentPage == 2)
                                        ? Hexcolor("#F7866A")
                                        : Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 5),
                    Expanded(
                      flex: 1,
                      child: GestureDetector(
                        onTap: () {
                          getListVoucheSaya();
                          setState(() => _currentPage = 1);
                        },
                        child: Container(
                          child: Column(
                            children: [
                              Stack(
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(top: 5),
                                    child: Image.asset(
                                      "assets/images/Asset 3.png",
                                      width: 50,
                                    ),
                                  ),
                                  if(jmlVoucherAktive>0)
                                  Positioned(  // draw a red marble
                                    top: 0.0,
                                    right: 0.0,
                                    child: Container(
                                      width: 18,
                                      height: 18,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(40),
                                        color: Hexcolor('#de1738'),
                                      ),
                                      child: Center(
                                        child: Text(
                                          jmlVoucherAktive.toString(),
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'Brandon',
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 5),
                                child: Text(
                                  "Voucher Saya",
                                  overflow: TextOverflow.clip,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontFamily: "Brandon",
                                    color: (_currentPage == 1)
                                        ? Hexcolor("#F7866A")
                                        : Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraint) {
                switch (_currentPage) {
                  case 0:
                    {
                      pakai=false;
                      return tambah_beli();
                    }
                  case 1:
                    {
                      if(pakai==false){
                        return voucher_saya();
                      }
                      else{
                        return SingleChildScrollView(
                          child:  pakai_konsultasi(voucher: selectVoucher,),
                        );
                      }
                      break;
                    }
                  case 2:
                    {
                      pakai=false;
                      return riwayat();
                    }
                  case 3:
                    {
                      pakai=false;
                      return SingleChildScrollView(
                        child:  Container(
                          padding: EdgeInsets.only(top: 20),
                          child: Column(
                            children: [
                              Container(
                                child: Column(
                                  children: [
                                    loading ? Container(
                                      child: Center(
                                        child: LoadingWidgetFadingCircle(context),
                                      ),
                                    ): Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.2),
                                            spreadRadius: 1,
                                            blurRadius: 1,
                                          ),
                                        ],
                                      ),
                                      margin: EdgeInsets.only(left: 35, right: 35),
                                      padding: EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            child: Text(
                                              json.decode(result.data[0])['judul'],
                                              style: TextStyle(
                                                fontFamily: "Brandon",
                                                fontWeight: FontWeight.w600,
                                                fontSize: 15,
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 10),
                                          Container(
                                            child: Text(
                                              json.decode(result.data[0])['deskripsi'],
                                              style: TextStyle(
                                                fontFamily: "Brandon",
                                                fontWeight: FontWeight.w400,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    GestureDetector(
                                      onTap: () {
                                        setState((){
                                          _currentPage = 0;
                                        });
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Hexcolor("#F7866A"),
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        padding: EdgeInsets.only(top: 8, bottom: 8),
                                        margin: EdgeInsets.only(right: 35, left: 35),
                                        width: double.infinity,
                                        child: Text(
                                          "Yuk, Mulai Konsultasi",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontFamily: "Brandon",
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 70),
                              Container(
                                decoration: BoxDecoration(
                                  border: Border(
                                    top: BorderSide(
                                      color: Hexcolor("#F7866A"),
                                      width: 2,
                                    ),
                                  ),
                                ),
                                margin: EdgeInsets.only(left: 20, right: 20),
                                padding: EdgeInsets.only(top: 15),
                                width: MediaQuery.of(context).size.width,
                                child: Text(
                                  "FAQs",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: "Yeseva",
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              for(Faq item in faq.faq)
                                Padding(
                                  padding: EdgeInsets.only(left: 20, right: 20),
                                  child: Card(
                                    elevation: 0,
                                    color: Colors.transparent,
                                    child: ExpansionTile(
                                      title: Padding(
                                        padding: EdgeInsets.only(left: 0),
                                        child: Text(
                                          item.ask,
                                          style: new TextStyle(
                                            fontFamily: "Brandon",
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black,
                                          ),
                                          textAlign: TextAlign.left,
                                        ),
                                      ),
                                      children: <Widget>[
                                        Container(
                                          decoration: BoxDecoration(
                                            color: Colors.transparent,
                                            border: Border(
                                              top: BorderSide(
                                                color: Hexcolor("#F7866A"),
                                                width: 2.0,
                                              ),
                                            ),
                                          ),
                                          padding: EdgeInsets.only(
                                            left: 15,
                                            right: 15,
                                            top: 5,
                                            bottom: 5,
                                          ),
                                          child: Column(
                                            children: [
                                              Container(
                                                  width: MediaQuery.of(context).size.width,
                                                  child:
                                                  Html(
                                                    data:item.ans,
                                                    style: {
                                                      "html": Style(
                                                        fontFamily: "Brandon",
                                                        fontSize: FontSize.medium,
                                                        fontWeight: FontWeight.w300,
                                                        color: Colors.black,
                                                      )
                                                    },
                                                  )
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              SizedBox(height: 20),
                            ],
                          ),
                        ),
                      );
                    }
                  case 4:
                    {
                      pakai=false;
                      return tambah_beli();
                    }
                  default:
                    {
                      pakai=false;
                      return Container(
                        child: Text("Halaman tidak ada"),
                      );
                    }
                }
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: new PonnyBottomNavbar(selectedIndex: 2),
    );
  }

  Widget beli() {
    if(loadingVoucher){
      return Container(
        margin: EdgeInsets.only(top: 50),
        child: Center(child: LoadingWidgetFadingCircle(context),),
      );
    }else{
      return Container(
        child: Column(
          children: [
            SizedBox(height: 30),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 1,
                  ),
                ],
              ),
              margin: EdgeInsets.only(left: 40, right: 40),
              padding: EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 10),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        width: 70,
                        height: 70,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50.0),
                          child: Image.asset(
                            "assets/images/doctor.png",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        flex: 3,
                        child: Container(
                          height: 70,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                child: Text(
                                  "VOUCHER KONSULTASI",
                                  style: TextStyle(
                                    fontFamily: "Brandon",
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Container(
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.alarm,
                                      color: Hexcolor("#F7866A"),
                                      size: 14,
                                    ),
                                    SizedBox(width: 4),
                                    Text(
                                      "1 Menit",
                                      style: TextStyle(
                                        fontFamily: "Brandon",
                                        fontSize: 10,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                child: Text(
                                  "Rp. 20.000",
                                  style: TextStyle(
                                    fontFamily: "Brandon",
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 5),
                      Expanded(
                        flex: 1,
                        child: Container(
                            height: 70,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () {

                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Hexcolor("#F7866A"),
                                      borderRadius: BorderRadius.circular(3),
                                    ),
                                    width: MediaQuery.of(context).size.width,
                                    padding: EdgeInsets.only(top: 2, bottom: 2),
                                    child: Text(
                                      "PAKAI",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: "Brandon",
                                        fontSize: 10,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )),
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  Row(
                    children: [
                      Text(
                        "Expired 30-10-2020",
                        style: TextStyle(
                          color: Hexcolor("#F7866A"),
                          fontFamily: "Brandon",
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

  }

  Widget voucher_saya() {
    if(loadingMyvoucher){
      return Container(
        margin: EdgeInsets.only(top: 50),
        child: Center(child: LoadingWidgetFadingCircle(context),),
      );
    }else if(listMyvoucher.length>0){
      return
        Container(
          height: MediaQuery.of(context).size.height*.46,
        child: ListView.builder(
          padding: EdgeInsets.only(top: 20),
            controller: _scrollControllerVoucher,
            scrollDirection: Axis.vertical,
            itemCount: listMyvoucher.length + 1,
            itemBuilder: (BuildContext context, int index) {
              if (index == listMyvoucher.length) {
                return _buildProgressIndicator();
              }else{
                var e = listMyvoucher[index];
                return  Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 1,
                        blurRadius: 1,
                      ),
                    ],
                  ),
                  margin: EdgeInsets.symmetric(vertical: 10,horizontal: 18),
                  padding: EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 10),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 70,
                            height: 70,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(50.0),
                              child: Image.asset(
                                "assets/images/doctor.png",
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            flex: 3,
                            child: Container(
                              height: 70,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    child: Text(
                                      "VOUCHER KONSULTASI",
                                      style: TextStyle(
                                        fontFamily: "Brandon",
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 5),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.alarm,
                                          color: Hexcolor("#F7866A"),
                                          size: 16,
                                        ),
                                        SizedBox(width: 4),
                                        Text(
                                            (e.durasi/60).round().toString()+" MENIT",
                                          style: TextStyle(
                                            fontFamily: "Brandon",
                                            fontSize: 12,
                                          ),
                                        ),
                                        if(e.dokterId == null && DateTime.now().isBefore(convertDateFromString(e.expDate)))
                                          Container(
                                            margin: EdgeInsets.only(left: 10),
                                            padding: EdgeInsets.symmetric(horizontal: 3),
                                            child: Container(
                                              height: 20,
                                              child: Align(
                                                alignment: Alignment.centerLeft,
                                                child: SizedBox(
                                                  width: 95,
                                                  height: 17,
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(15),
                                                      color: Color(0xffFFE8DB),
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        'BELUM DIPAKAI',
                                                        style: TextStyle(
                                                          fontFamily: 'Brandon',
                                                          color: Hexcolor("#F7866A"),
                                                          fontSize: 10,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )
                                        else if(!DateTime.now().isBefore(convertDateFromString(e.expDate)) && e.dokterId == null)
                                          Container(
                                            margin: EdgeInsets.only(left: 10),
                                            padding: EdgeInsets.symmetric(horizontal: 3),
                                            child: Container(
                                              height: 20,
                                              child: Align(
                                                alignment: Alignment.centerLeft,
                                                child: SizedBox(
                                                  width: 95,
                                                  height: 17,
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(15),
                                                      color: Color(0xffE2E2E2),
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        'KADALUARSA',
                                                        style: TextStyle(
                                                          fontFamily: 'Brandon',
                                                          fontSize: 10,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )
                                        else if(e.dokterId != null)
                                        Container(
                                          margin: EdgeInsets.only(left: 10),
                                          padding: EdgeInsets.symmetric(horizontal: 3),
                                          child: Container(
                                            height: 20,
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: SizedBox(
                                                width: 95,
                                                height: 17,
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(15),
                                                    color: Color(0xffECF2D1),
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      'SUDAH DIPAKAI',
                                                      style: TextStyle(
                                                        fontFamily: 'Brandon',
                                                        fontSize: 10,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  // Container(
                                  //   child: Text(
                                  //     nm_format.format(e.harga),
                                  //     style: TextStyle(
                                  //       fontFamily: "Brandon",
                                  //       fontSize: 12,
                                  //       fontWeight: FontWeight.w500,
                                  //     ),
                                  //   ),
                                  // ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      IntrinsicHeight(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: 10),
                              child: Text(
                                "Berlaku sampai tanggal "+DateFormat('dd MMMM yyyy').format(
                                    convertDateFromString(
                                        e.expDate.toString()))+' Pukul '+DateFormat('Hm').format(
                                    convertDateFromString(
                                        e.expDate)),
                                style: TextStyle(
                                  color: Hexcolor("#F7866A"),
                                  fontFamily: "Brandon",
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            if(DateTime.now().isBefore(convertDateFromString(e.expDate)) && e.dokterId == null)
                              Container(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            selectVoucher = e;
                                            pakai = true;
                                          });
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Hexcolor("#F7866A"),
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                                          child: Text(
                                            "PAKAI",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontFamily: "Brandon",
                                              fontSize: 10,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }

            }),
        );
    }else{
      return Container(
        child: Column(
          children: [
            SizedBox(height: 30),
            Stack(
              children: [
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(right: 40, left: 40),
                  height: 180,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 1,
                        blurRadius: 1,
                      ),
                    ],
                  ),
                  child: Text(
                    "Ups, kamu belum punya voucher konsultasi",
                    style: TextStyle(
                      fontFamily: "Brandon",
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() => _currentPage = 0);
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: 165),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Hexcolor("#F7866A"),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          padding: EdgeInsets.only(top: 3, bottom: 3),
                          width: 100,
                          child: Text(
                            "BELI",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: "Brandon",
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }

  }

  Widget riwayat() {
    if(loadingRiwayat){
      return Container(
        margin: EdgeInsets.only(top: 50),
        child: Center(child: LoadingWidgetFadingCircle(context),),
      );
    }else{
      return Column(
      children: [
        SizedBox(height: 20),
        Container(
          margin: EdgeInsets.only(right: 20, left: 20),
          padding: EdgeInsets.only(top: 10, bottom: 10, right: 5, left: 5),
          color: Hexcolor("#F7866A"),
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 3),
                  child: Text(
                    "ORDER",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontFamily: "Brandon",
                      fontSize: 12,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 3),
                  child: Text(
                    "TANGGAL",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontFamily: "Brandon",
                      fontSize: 12,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 3),
                  child: Text(
                    "STATUS",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontFamily: "Brandon",
                      fontSize: 12,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 3),
                  child: Text(
                    "TOTAL",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontFamily: "Brandon",
                      fontSize: 12,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Container(
            child: ListView.builder(
              padding: EdgeInsets.zero,
                controller: _scrollController,
                scrollDirection: Axis.vertical,
                itemCount: riwayatVoucher.length + 1,
                itemBuilder: (BuildContext context, int index) {
                  if (index == riwayatVoucher.length) {
                    return _buildProgressIndicator();
                  }else{
                    var item = riwayatVoucher[index];
                    return Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Hexcolor("#F7866A"),
                            width: 1,
                          ),
                        ),
                      ),
                      margin: EdgeInsets.only(right: 25, left: 25),
                      padding: EdgeInsets.only(top: 5, bottom: 5),
                      child: Column(
                        children: [
                          IntrinsicHeight(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(horizontal: 3),
                                    child: Text(
                                      "#"+item.code,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontFamily: "Brandon",
                                        fontSize: 12,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(horizontal: 3),
                                    child: Text(
                                      item.date,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontFamily: "Brandon",
                                        fontSize: 12,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(horizontal: 3),
                                    child: Text(
                                      item.status.param3,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontFamily: "Brandon",
                                        fontSize: 12,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(horizontal: 3),
                                    child: Text(
                                        item.grand_total != null ?  nm_format.format(item.grand_total) : "Rp. 0",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontFamily: "Brandon",
                                        fontSize: 12,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 5),
                          IntrinsicHeight(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: Container(),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(horizontal: 3),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("Payment Method",
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              fontFamily: "Brandon",
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.black,
                                            )
                                        ),
                                        if(item.payment_type == "mt_tf_bca" || item.payment_type == "mt_tf_bni" || item.payment_type == "mt_tf_permata" || item.payment_type == "alfamart" || item.payment_type=="Indomaret" ||item.payment_type=="mt_tf_mdr"|| item.payment_type=="mt_tf_bri")
                                          Container(
                                            width: 100,
                                            child: Text(
                                              item.mitrans_val != null ? item.mitrans_val.mitrans_val : "",
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
                                              item.typePayment,
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
                                ),
                                // if(item.payment_status == 'unpaid' && item.payment_type == "ovo")
                                //   Positioned(
                                //       left: 0,
                                //       child: Container(
                                //         child: FlatButton(
                                //           color:  Color(0xffF48262),
                                //           textColor: Colors.white,
                                //           disabledColor: Colors.grey,
                                //           disabledTextColor: Colors.black,
                                //           child:  Text("BAYAR SEKARANG"),
                                //           onPressed: (){
                                //             Navigator.push(
                                //               context,
                                //               MaterialPageRoute(
                                //                 builder: (context) => QrisScreen(title: "OVO", urlQR: item.mitransVal.actions.firstWhere((element) => element.name == "generate-qr-code").url,type: QrisScreen.ovo,), ),
                                //             );
                                //           },
                                //         ) ,
                                //       )
                                //   ),
                                //
                                // if(item.payment_status == 'unpaid' && item.payment_type == "shopeepay")
                                //   Positioned(
                                //       left: 0,
                                //       child: Container(
                                //         margin: EdgeInsets.only(left: 10),
                                //         alignment: Alignment.centerLeft,
                                //         child: FlatButton(
                                //           color:  Color(0xffF48262),
                                //           textColor: Colors.white,
                                //           disabledColor: Colors.grey,
                                //           disabledTextColor: Colors.black,
                                //           child:  Text("BAYAR SEKARANG"),
                                //           onPressed: (){
                                //             Navigator.push(
                                //               context,
                                //               MaterialPageRoute(
                                //                 builder: (context) => QrisScreen(title: "SHOPEEPAY", urlQR: item.mitransVal.actions.firstWhere((element) => element.name == "generate-qr-code").url,type: QrisScreen.shopee), ),
                                //             );
                                //           },
                                //         ) ,
                                //       )
                                //   )
                                //   ,
                                // if(item.payment_status == 'unpaid' && item.payment_type == "gopay")
                                //   Positioned(
                                //       left: 0,
                                //       child: Container(
                                //         margin: EdgeInsets.only(left: 10),
                                //         alignment: Alignment.centerLeft,
                                //         child: FlatButton(
                                //           color:  Color(0xffF48262),
                                //           textColor: Colors.white,
                                //           disabledColor: Colors.grey,
                                //           disabledTextColor: Colors.black,
                                //           child:  Text("BAYAR SEKARANG"),
                                //           onPressed: (){
                                //             // Navigator.push(
                                //             //   context,
                                //             //   MaterialPageRoute(
                                //             //     builder: (context) => BankTransferDetailScreen(order_id: order.id,), ),
                                //             // );
                                //             _launchURL(item.mitransVal.actions.firstWhere((element) => element.name == "deeplink-redirect").url);
                                //           },
                                //         ) ,
                                //       )
                                //   ),
                                // if(item.payment_status == 'unpaid' && item.payment_type == "qris")
                                //   Positioned(
                                //       left: 0,
                                //       child: Container(
                                //         margin: EdgeInsets.only(left: 10),
                                //         alignment: Alignment.centerLeft,
                                //         child: FlatButton(
                                //           color:  Color(0xffF48262),
                                //           textColor: Colors.white,
                                //           disabledColor: Colors.grey,
                                //           disabledTextColor: Colors.black,
                                //           child:  Text("BAYAR SEKARANG"),
                                //           onPressed: (){
                                //             Navigator.push(
                                //               context,
                                //               MaterialPageRoute(
                                //                 builder: (context) => QrisScreen(title: "QRIS", urlQR: item.mitransVal.actions.firstWhere((element) => element.name == "generate-qr-code").url,type: QrisScreen.qris), ),
                                //             );
                                //           },
                                //         ) ,
                                //       )
                                //   ),


                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                if(item.status.param1 == "unpaid" && item.status.param2 == "pending")
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: 3),
                                    child: Container(
                                      height: 20,
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: SizedBox(
                                          width: 120,
                                          height: 20,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(20),
                                              color: Color(0xffFFE8DB),
                                            ),
                                            child: Center(
                                              child: Text(
                                                'BELUM TERBAYAR',
                                                style: TextStyle(
                                                  fontFamily: 'Brandon',
                                                  color: Hexcolor("#F7866A"),
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                else if(item.status.param1 == "expire")
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: 3),
                                    child: Container(
                                      height: 20,
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: SizedBox(
                                          width: 120,
                                          height: 20,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(20),
                                              color: Color(0xffE2E2E2),
                                            ),
                                            child: Center(
                                              child: Text(
                                                'KADALUARSA',
                                                style: TextStyle(
                                                  fontFamily: 'Brandon',
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                else if(item.status.param1 == "paid")
                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: 3),
                                      child: Container(
                                        height: 20,
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: SizedBox(
                                            width: 120,
                                            height: 20,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(20),
                                                color: Color(0xffECF2D1),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  'SUDAH TERBAYAR',
                                                  style: TextStyle(
                                                    fontFamily: 'Brandon',
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  else
                                    Container(),
                                if(item.payment_status == 'unpaid' && item.payment_type == "ovo")
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => QrisScreen(title: "OVO", urlQR: item.mitransVal.actions.firstWhere((element) => element.name == "generate-qr-code").url,type: QrisScreen.ovo,), ),
                                    );
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Hexcolor("#F7866A"),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    padding: EdgeInsets.symmetric(vertical: 3, horizontal: 12),
                                    child: Text(
                                      "BAYAR SEKARANG",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: "Brandon",
                                        fontSize: 12,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                if(item.payment_status == 'unpaid' && item.payment_type == "shopeepay")
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => QrisScreen(title: "SHOPEEPAY", urlQR: item.mitransVal.actions.firstWhere((element) => element.name == "generate-qr-code").url,type: QrisScreen.shopee), ),
                                      );
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Hexcolor("#F7866A"),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      padding: EdgeInsets.symmetric(vertical: 3, horizontal: 12),
                                      child: Text(
                                        "BAYAR SEKARANG",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontFamily: "Brandon",
                                          fontSize: 12,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                if(item.payment_status == 'unpaid' && item.payment_type == "gopay")
                                  InkWell(
                                    onTap: () {
                                      _launchURL(item.mitransVal.actions.firstWhere((element) => element.name == "deeplink-redirect").url);
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Hexcolor("#F7866A"),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      padding: EdgeInsets.symmetric(vertical: 3, horizontal: 12),
                                      child: Text(
                                        "BAYAR SEKARANG",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontFamily: "Brandon",
                                          fontSize: 12,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                if(item.payment_status == 'unpaid' && item.payment_type == "qris")
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => QrisScreen(title: "QRIS", urlQR: item.mitransVal.actions.firstWhere((element) => element.name == "generate-qr-code").url,type: QrisScreen.qris), ),
                                      );
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Hexcolor("#F7866A"),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      padding: EdgeInsets.symmetric(vertical: 3, horizontal: 12),
                                      child: Text(
                                        "BAYAR SEKARANG",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontFamily: "Brandon",
                                          fontSize: 12,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          // Container(
                          //   child: Column(
                          //     children: item.orderDetailVoucher.map((e){
                          //
                          //       return  Container(
                          //         decoration: BoxDecoration(
                          //           color: Colors.white,
                          //           borderRadius: BorderRadius.circular(10),
                          //           boxShadow: [
                          //             BoxShadow(
                          //               color: Colors.grey.withOpacity(0.2),
                          //               spreadRadius: 1,
                          //               blurRadius: 1,
                          //             ),
                          //           ],
                          //         ),
                          //         margin: EdgeInsets.only(top: 10, bottom: 10),
                          //         padding: EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 10),
                          //         child: Column(
                          //           children: [
                          //             Row(
                          //               children: [
                          //                 Container(
                          //                   width: 70,
                          //                   height: 70,
                          //                   child: ClipRRect(
                          //                     borderRadius: BorderRadius.circular(50.0),
                          //                     child: Image.asset(
                          //                       "assets/images/doctor.png",
                          //                       fit: BoxFit.cover,
                          //                     ),
                          //                   ),
                          //                 ),
                          //                 SizedBox(width: 10),
                          //                 Expanded(
                          //                   flex: 3,
                          //                   child: Container(
                          //                     height: 70,
                          //                     child: Column(
                          //                       crossAxisAlignment: CrossAxisAlignment.start,
                          //                       mainAxisAlignment: MainAxisAlignment.start,
                          //                       children: [
                          //                         Container(
                          //                           child: Text(
                          //                             "VOUCHER KONSULTASI",
                          //                             style: TextStyle(
                          //                               fontFamily: "Brandon",
                          //                               fontSize: 13,
                          //                               fontWeight: FontWeight.w600,
                          //                             ),
                          //                           ),
                          //                         ),
                          //                         Container(
                          //                           child: Row(
                          //                             children: [
                          //                               Icon(
                          //                                 Icons.alarm,
                          //                                 color: Hexcolor("#F7866A"),
                          //                                 size: 14,
                          //                               ),
                          //                               SizedBox(width: 4),
                          //                               Text(
                          //                                   (e.durasi/60).round().toString()+" Menit",
                          //                                 style: TextStyle(
                          //                                   fontFamily: "Brandon",
                          //                                   fontSize: 10,
                          //                                 ),
                          //                               ),
                          //                             ],
                          //                           ),
                          //                         ),
                          //                         Container(
                          //                           child: Text(
                          //                             nm_format.format(e.harga),
                          //                             style: TextStyle(
                          //                               fontFamily: "Brandon",
                          //                               fontSize: 12,
                          //                               fontWeight: FontWeight.w500,
                          //                             ),
                          //                           ),
                          //                         ),
                          //                       ],
                          //                     ),
                          //                   ),
                          //                 ),
                          //                 SizedBox(width: 5),
                          //                 Expanded(
                          //                   flex: 1,
                          //                   child: Container(),
                          //                 ),
                          //               ],
                          //             ),
                          //             SizedBox(height: 15),
                          //             Row(
                          //               children: [
                          //                 Text(
                          //                   "Masa Berlaku "+e.masaBerlaku.toString()+" Hari",
                          //                   style: TextStyle(
                          //                     color: Hexcolor("#F7866A"),
                          //                     fontFamily: "Brandon",
                          //                     fontSize: 12,
                          //                     fontWeight: FontWeight.w500,
                          //                   ),
                          //                 ),
                          //               ],
                          //             ),
                          //           ],
                          //         ),
                          //       );
                          //
                          //     }).toList(),
                          //   ),
                          // )
                        ],
                      ),
                    );
                  }

                }),
          ),
        )


      ],
    );
    }
  }

  Widget _buildProgressIndicator() {
    return new Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Center(
        child: new Opacity(
          opacity: loadmore ? 1.0 : 00,
          child: LoadingWidget(context),
        ),
      ),
    );
  }

  Widget tambah_beli() {


    if(loadingVoucher){
      return Container(
        margin: EdgeInsets.only(top: 50),
        child: Center(child: LoadingWidgetFadingCircle(context),),
      );
    }else{
      return Container(
        child: Column(
          children: [
            SizedBox(height: 30),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 1,
                  ),
                ],
              ),
              margin: EdgeInsets.only(left: 40, right: 40),
              padding: EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 10),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        width: 70,
                        height: 70,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50.0),
                          child: Image.asset(
                            "assets/images/doctor.png",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        flex: 3,
                        child: Container(
                          height: 70,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                child: Text(
                                  "VOUCHER KONSULTASI",
                                  style: TextStyle(
                                    fontFamily: "Brandon",
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Container(
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.alarm,
                                      color: Hexcolor("#F7866A"),
                                      size: 14,
                                    ),
                                    SizedBox(width: 4),
                                    Text(
                                      voucher.durasi+" Menit",
                                      style: TextStyle(
                                        fontFamily: "Brandon",
                                        fontSize: 10,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                child: Text(
                                  nm_format.format(int.parse(voucher.harga)),
                                  style: TextStyle(
                                    fontFamily: "Brandon",
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 5),
                      Expanded(
                        flex: 1,
                        child: Container(
                          height: 70,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                  width: MediaQuery.of(context).size.width,
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: GestureDetector(
                                          onTap: () {
                                            return decrementCounter();
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Hexcolor("#F7866A"),
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(50),
                                                bottomLeft: Radius.circular(50),
                                              ),
                                            ),
                                            height: 20,
                                            child: Text("-",
                                                textAlign: TextAlign.center),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            border: Border(
                                              bottom: BorderSide(
                                                color: Hexcolor("#F7866A"),
                                              ),
                                              top: BorderSide(
                                                color: Hexcolor("#F7866A"),
                                              ),
                                            ),
                                          ),
                                          height: 20,
                                          child: Text('$counter',
                                              textAlign: TextAlign.center),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: GestureDetector(
                                          onTap: () {
                                            return incrementCounter();
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Hexcolor("#F7866A"),
                                              borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(50),
                                                bottomRight: Radius.circular(50),
                                              ),
                                            ),
                                            height: 20,
                                            child: Text("+",
                                                textAlign: TextAlign.center),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ))
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  Row(
                    children: [
                      Text(
                        "Masa Berlaku "+voucher.durasi+" Hari",
                        style: TextStyle(
                          color: Hexcolor("#F7866A"),
                          fontFamily: "Brandon",
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            int.parse(voucher.harga) > 0 ?
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PaymentVoucherScreen(voucher: voucher,qty: counter,),
                      ),
                    ).then((value){
                      if(value != null && value){
                        getDataRiwayat();
                        setState(() => _currentPage = 2);
                      }
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Hexcolor("#F7866A"),
                      borderRadius: BorderRadius.circular(3),
                    ),
                    margin: EdgeInsets.only(left: 40, right: 40),
                    width: 100,
                    padding: EdgeInsets.only(top: 5, bottom: 5),
                    child: Text(
                      "BELI",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: "Br4andon",
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                )
              ],
            ) : Container(),
          ],
        ),
      );
    }

  }
}

class pakai_konsultasi extends StatefulWidget {
  OrderDetailVoucher voucher;
  pakai_konsultasi({this.voucher});
  @override
  _PakaiKonsultasi createState() => _PakaiKonsultasi();
}

class _PakaiKonsultasi extends State<pakai_konsultasi> {
  // int _konsultasiPage = 0;
  final scaffollKey = GlobalKey<ScaffoldState>();
  AgoraRtmClient _client;
  AgoraRtmChannel _channel;
  BuildContext _context;
  bool status_build =true;
  List<AgoraRtmMember> dokter = new List<AgoraRtmMember>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if(Provider.of<UserModel>(context).user == null){
        Provider.of<UserModel>(context).getUser(Provider.of<AppModel>(context).auth.access_token).then((value) =>  _initLoby() );
      }else{
        _initLoby();
      }
    });

  }

  @override
  void dispose() {
    // TODO: implement dispose
    _channel.leave();
    _client.logout();
    super.dispose();
  }

  Future<Dokter> getDetaildokter(id) async {
    var param ={"id_dokter": id};
    Dokter dokter=null;
    final res = await http.post(detaildokter,headers: { HttpHeaders.contentTypeHeader: 'application/json' },body: json.encode(param));
    if(res.statusCode == 200){
      dokter = Dokter.fromJson( json.decode(res.body));
    }
    return dokter;
  }

  Future<void> _initLoby() async {
    String uid= "u"+Provider.of<UserModel>(context).user.id.toString();
    _client = await AgoraRtmClient.createInstance(appID);
    _client.login(null,uid);
    try {
      _channel = await _createChannel("loby");
      await _channel.join();
      final member =  await _channel.getMembers();
      setState(() {
        dokter = member.where((element) => element.userId.startsWith("d")).toList();
      });

      print(dokter);
      print('Join channel success.');
    } catch (errorCode) {
      print('Join channel error: ' + errorCode.toString());
    }
  }

  Future<AgoraRtmChannel> _createChannel(String name) async {
    AgoraRtmChannel channel = await _client.createChannel(name);

    channel.onMemberJoined = (AgoraRtmMember member) {
      print(
          "Member joined: " + member.userId + ', channel: ' + member.channelId);
      if(member.userId.startsWith("d")){
        setState(() {
          dokter.add(member);
        });
      }
      print(dokter);

    };
    channel.onMemberLeft = (AgoraRtmMember member) {
      print("Member left: " + member.userId + ', channel: ' + member.channelId);
      if(member.userId.startsWith("d")){
        setState(() {
          dokter.removeWhere((element) => element.userId == member.userId);
        });
        print(dokter);
      }
    };
    channel.onMessageReceived =
        (AgoraRtmMessage message, AgoraRtmMember member) {
      print("Channel msg: " + member.userId + ", msg: " + message.text);

    };
    return channel;
  }

  void kirimPesan(peerId,pesan){
    AgoraRtmMessage message = new AgoraRtmMessage(pesan, null, null);
    _client.sendMessageToPeer(peerId, message);
  }

  @override
  Widget build(BuildContext context) {
    //final faq = Provider.of<AppModel>(context,listen: false).listFaq.firstWhere((element) => element.id == 5);
    return Container(
      padding: EdgeInsets.only(top: 20),
      child: Column(
        children: [
          LayoutBuilder(
            builder: (context, constraint) {
              return Container(
                child: Column(
                  children: [
                    for(AgoraRtmMember item in dokter)
                    Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 1,
                            blurRadius: 1,
                          ),
                        ],
                      ),
                      margin: EdgeInsets.only(left: 35, right: 35, bottom: 20),
                      padding: EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
                      child: FutureBuilder<Dokter>(
                        future: getDetaildokter(item.userId.replaceFirst("d", "")),
                        builder: (context, snapshot) {
                        if(snapshot.hasData && snapshot.data != null){
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: 60.0,
                                    height: 60.0,
                                    margin: EdgeInsets.only(right: 10),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: snapshot.data.gambarProfile != null ? NetworkImage(img_url+snapshot.data.gambarProfile) : AssetImage(
                                              "assets/images/basic.jpg")
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: IntrinsicHeight(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                snapshot.data.user.name,
                                                style: TextStyle(
                                                  fontFamily: 'Brandon',
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 15,
                                                ),
                                              ),
                                              Text(
                                                snapshot.data.bidang,
                                                style: TextStyle(
                                                  fontFamily: 'Brandon',
                                                  fontSize: 15,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Container(
                                            margin: EdgeInsets.symmetric(vertical: 3),
                                            child: Row(
                                              children: [
                                                Container(
                                                  width: 10,
                                                  height: 10,
                                                  margin: EdgeInsets.only(right: 5),
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: Color(0xff4CBC43),
                                                  ),
                                                ),
                                                Text(
                                                  'Sedang Online',
                                                  style: TextStyle(
                                                    fontFamily: 'Brandon',
                                                    fontSize: 12,
                                                    color: Color(0xff4CBC43),
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
                              Container(
                                padding: EdgeInsets.only(top: 5),
                                child: Row(
                                  children: [
                                    Image.asset(
                                      'assets/images/konsultasi/tempat-praktek.png',
                                      height: 40,
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Tempat Praktek',
                                          style: TextStyle(
                                            fontFamily: 'Brandon',
                                            fontSize: 11,
                                          ),
                                        ),
                                        Text(
                                          snapshot.data.tempatPraktek != null?snapshot.data.tempatPraktek:'Belum Tersedia',
                                          style: TextStyle(
                                            fontFamily: 'Brandon',
                                            fontSize: 13,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(top: 5),
                                child: Row(
                                  children: [
                                    Image.asset(
                                      'assets/images/konsultasi/pengalaman.png',
                                      height: 40,
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Pengalaman',
                                          style: TextStyle(
                                            fontFamily: 'Brandon',
                                            fontSize: 11,
                                          ),
                                        ),
                                        Text(
                                          snapshot.data.graduated != null?snapshot.data.graduated+' Tahun':'Belum Tersedia',
                                          style: TextStyle(
                                            fontFamily: 'Brandon',
                                            fontSize: 13,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(top: 5),
                                child: Row(
                                  children: [
                                    Image.asset(
                                      'assets/images/konsultasi/izin-praktek.png',
                                      height: 40,
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Nomor Izin Praktek',
                                          style: TextStyle(
                                            fontFamily: 'Brandon',
                                            fontSize: 11,
                                          ),
                                        ),
                                        Text(
                                          snapshot.data.deskripsi != null?snapshot.data.deskripsi:'Belum Tersedia',
                                          style: TextStyle(
                                            fontFamily: 'Brandon',
                                            fontSize: 13,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: Container(
                                  margin: EdgeInsets.only(top: 15),
                                  child: FlatButton(
                                    onPressed: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => WaitingPage(
                                        channel: _channel,
                                        client: _client,
                                        voucher: widget.voucher,
                                        DokterID: item.userId,
                                      )));
                                    },
                                    padding: EdgeInsets.symmetric(horizontal: 10),
                                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      side: BorderSide(
                                        width: 1.0,
                                        color: Color(0xffF48262),
                                      ),
                                    ),
                                    child: Text(
                                      'KONSULTASI SEKARANG',
                                      style: TextStyle(
                                        fontFamily: 'Brandon',
                                        color: Color(0xffF48262),
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        }else{
                          return Center(
                            child: LoadingWidget(context),
                          );
                        }
                        })

                    ),
                    if(dokter.length<= 0)

                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: EdgeInsets.only(top: 8, bottom: 8),
                      margin: EdgeInsets.only(right: 20, left: 20),
                      width: MediaQuery.of(context).size.width,
                      child: Container(
                        padding: EdgeInsets.all(30),
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(bottom: 20),
                              child: Image.asset(
                                'assets/images/konsultasi/ponny-face.png',
                                width: 100,
                              ),
                            ),
                            Text(
                              "Sayang sekali tidak ada dokter yang Online :(. Tunggu beberapa saat atau hubungi Tim Phoebe untuk mendapatkan informasi lebih lanjut",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: "Brandon",
                                color: Hexcolor("#F7866A"),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class konsultasi_screen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 1,
                ),
              ],
            ),
            margin: EdgeInsets.only(left: 35, right: 35, bottom: 20),
            padding: EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 60.0,
                      height: 60.0,
                      margin: EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage(
                                "assets/images/basic.jpg")
                        ),
                      ),
                    ),
                    Expanded(
                      child: IntrinsicHeight(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Nama Dokter',
                                  style: TextStyle(
                                    fontFamily: 'Brandon',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15,
                                  ),
                                ),
                                Text(
                                  'Bidang',
                                  style: TextStyle(
                                    fontFamily: 'Brandon',
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 3),
                              child: Row(
                                children: [
                                  Container(
                                    width: 10,
                                    height: 10,
                                    margin: EdgeInsets.only(right: 5),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color(0xff4CBC43),
                                    ),
                                  ),
                                  Text(
                                    'Sedang Online',
                                    style: TextStyle(
                                      fontFamily: 'Brandon',
                                      fontSize: 12,
                                      color: Color(0xff4CBC43),
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
                Container(
                  padding: EdgeInsets.only(top: 5),
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/images/konsultasi/tempat-praktek.png',
                        height: 40,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Tempat Praktek",
                            style: TextStyle(
                              fontFamily: 'Brandon',
                              fontSize: 11,
                            ),
                          ),
                          Text(
                            'Nama Tempat',
                            style: TextStyle(
                              fontFamily: 'Brandon',
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 5),
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/images/konsultasi/pengalaman.png',
                        height: 40,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Pengalaman',
                            style: TextStyle(
                              fontFamily: 'Brandon',
                              fontSize: 11,
                            ),
                          ),
                          Text(
                            '5 Tahun',
                            style: TextStyle(
                              fontFamily: 'Brandon',
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 5),
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/images/konsultasi/izin-praktek.png',
                        height: 40,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Nomor Izin Praktek',
                            style: TextStyle(
                              fontFamily: 'Brandon',
                              fontSize: 11,
                            ),
                          ),
                          Text(
                            'Nomor Izin',
                            style: TextStyle(
                              fontFamily: 'Brandon',
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    margin: EdgeInsets.only(top: 15),
                    child: FlatButton(
                      onPressed: (){},
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(
                          width: 1.0,
                          color: Color(0xffF48262),
                        ),
                      ),
                      child: Text(
                        'KONSULTASI SEKARANG',
                        style: TextStyle(
                          fontFamily: 'Brandon',
                          color: Color(0xffF48262),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 1,
                ),
              ],
            ),
            margin: EdgeInsets.only(left: 35, right: 35, bottom: 20),
            padding: EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 60.0,
                      height: 60.0,
                      margin: EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage(
                                "assets/images/basic.jpg")
                        ),
                      ),
                    ),
                    Expanded(
                      child: IntrinsicHeight(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Nama Dokter',
                                  style: TextStyle(
                                    fontFamily: 'Brandon',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15,
                                  ),
                                ),
                                Text(
                                  'Bidang',
                                  style: TextStyle(
                                    fontFamily: 'Brandon',
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 3),
                              child: Row(
                                children: [
                                  Container(
                                    width: 10,
                                    height: 10,
                                    margin: EdgeInsets.only(right: 5),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color(0xff4CBC43),
                                    ),
                                  ),
                                  Text(
                                    'Sedang Online',
                                    style: TextStyle(
                                      fontFamily: 'Brandon',
                                      fontSize: 12,
                                      color: Color(0xff4CBC43),
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
                Container(
                  padding: EdgeInsets.only(top: 5),
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/images/konsultasi/tempat-praktek.png',
                        height: 40,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Tempat Praktek',
                            style: TextStyle(
                              fontFamily: 'Brandon',
                              fontSize: 11,
                            ),
                          ),
                          Text(
                            'Nama Tempat',
                            style: TextStyle(
                              fontFamily: 'Brandon',
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 5),
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/images/konsultasi/pengalaman.png',
                        height: 40,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Pengalaman',
                            style: TextStyle(
                              fontFamily: 'Brandon',
                              fontSize: 11,
                            ),
                          ),
                          Text(
                            '5 Tahun',
                            style: TextStyle(
                              fontFamily: 'Brandon',
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 5),
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/images/konsultasi/izin-praktek.png',
                        height: 40,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Nomor Izin Praktek',
                            style: TextStyle(
                              fontFamily: 'Brandon',
                              fontSize: 11,
                            ),
                          ),
                          Text(
                            'Nomor Izin',
                            style: TextStyle(
                              fontFamily: 'Brandon',
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    margin: EdgeInsets.only(top: 15),
                    child: FlatButton(
                      onPressed: (){},
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(
                          width: 1.0,
                          color: Color(0xffF48262),
                        ),
                      ),
                      child: Text(
                        'KONSULTASI SEKARANG',
                        style: TextStyle(
                          fontFamily: 'Brandon',
                          color: Color(0xffF48262),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: Container(
              decoration: BoxDecoration(
                color: Hexcolor("#F7866A"),
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.only(top: 8, bottom: 8),
              margin: EdgeInsets.only(right: 35, left: 35),
              width: MediaQuery.of(context).size.width,
              child: Text(
                "Yuk, Mulai Konsultasi",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: "Brandon",
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class tukar_screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 1,
                ),
              ],
            ),
            margin: EdgeInsets.only(left: 35, right: 35),
            padding: EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Text(
                    "Tukar",
                    style: TextStyle(
                      fontFamily: "Brandon",
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  child: Text(
                    "Dolor enim sit amet ex pariatur ullamco adipisicing consequat occaecat irure officia dolor. Voluptate ad nostrud pariatur sit dolor irure incididunt proident. Non anim amet voluptate sint officia ut anim et magna aute cupidatat nisi eiusmod anim. Eu consectetur nostrud excepteur eu est cupidatat cillum irure mollit cillum. Minim sunt commodo in pariatur commodo qui adipisicing culpa.",
                    style: TextStyle(
                      fontFamily: "Brandon",
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          GestureDetector(
            onTap: () {},
            child: Container(
              decoration: BoxDecoration(
                color: Hexcolor("#F7866A"),
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.only(top: 8, bottom: 8),
              margin: EdgeInsets.only(right: 40, left: 40),
              width: MediaQuery.of(context).size.width,
              child: Text(
                "Yuk, Mulai Konsultasi",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: "Brandon",
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
