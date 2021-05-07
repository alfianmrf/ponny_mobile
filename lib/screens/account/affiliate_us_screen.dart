import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:ponny/model/AffiliateResult.dart';
import 'package:ponny/model/User.dart';
import 'package:ponny/screens/Affiliate_Add_Code.dart';
import 'package:ponny/screens/account_screen.dart';
import 'package:ponny/widgets/PonnyBottomNavbar.dart';
import 'package:provider/provider.dart';
import 'package:ponny/util/globalUrl.dart';
import 'package:intl/intl.dart';
import 'package:ponny/screens/Affiliate_CairkanDana_TotalBox_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:ponny/common/constant.dart';
import 'package:ponny/model/App.dart';

class AffiliateUsScreen extends StatefulWidget {
  static const String id = "Affiliate_Us_Screen";
  @override
  _AffiliateUsStateScreen createState() => _AffiliateUsStateScreen();
}

class _AffiliateUsStateScreen extends State<AffiliateUsScreen> {
  bool link = false;
  final scaffoldkey = GlobalKey<ScaffoldState>();
  AffiliateResult result = AffiliateResult();
  bool loading = true;
  String bank, noRek, name;
  int total;
  bool codeReferal, income;
  List<dynamic> detailImage;

  final formatCurrency = new NumberFormat.simpleCurrency(locale: 'id_ID');

  void _sumSales() {
    total = 0;
    if (result.isAffiliate) {
      for (var i = 0; i < result.codes.length; i++) {
        total = total + result.codes[i].sales;
      }
    }
  }

  void _settingModalBottomSheet(context) {
    final size = MediaQuery.of(context).size;
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(15))),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        builder: (BuildContext bc) {
          return Container(
            child: new Wrap(
              children: <Widget>[
                new Column(
                  children: [
                    Container(
                      width: double.infinity,
                      margin:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      child: Text(
                        "Detail Pembayaran",
                        style: TextStyle(
                          fontFamily: "Brandon",
                          fontWeight: FontWeight.w600,
                          color: Color(0xffF48262),
                          fontSize: size.height * 0.03,
                        ),
                      ),
                    ),
                    Divider(color: Color(0xffF48262))
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  child: Row(
                    children: [
                      Column(
                        children: [
                          DetailAffiliateTextStyle(
                              nama: "Bukti Pembayaran",
                              sizing: FontWeight.w700),
                          SizedBox(height: 15),
                          detailImage == null
                              ? Container(
                                  width: 110,
                                  height: 110,
                                  color: Colors.grey[300],
                                  child:
                                      Image.asset('assets/images/210x265.png'),
                                )
                              : Container(
                                  width: 110,
                                  height: 110,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              "$img_url${detailImage[0]}"),
                                          fit: BoxFit.cover)),
                                )
                        ],
                      ),
                      Container(
                        width: size.width * 0.58,
                        margin:
                            EdgeInsets.only(left: size.width * 0.04, top: 40),
                        child: new Column(
                          children: [
                            Row(
                              children: [
                                DetailAffiliateTextStyle(
                                    nama: "Bank", sizing: FontWeight.w700),
                                DetailAffiliateTextStyle(
                                    nama: ": $bank", sizing: FontWeight.w400)
                              ],
                            ),
                            SizedBox(height: 15),
                            Row(
                              children: [
                                DetailAffiliateTextStyle(
                                    nama: "No. Rek", sizing: FontWeight.w700),
                                DetailAffiliateTextStyle(
                                    nama: ": $noRek", sizing: FontWeight.w400)
                              ],
                            ),
                            SizedBox(height: 15),
                            Row(
                              children: [
                                DetailAffiliateTextStyle(
                                    nama: "Atas Nama", sizing: FontWeight.w700),
                                DetailAffiliateTextStyle(
                                    nama: ": $name", sizing: FontWeight.w400)
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    try {
      var token =
          Provider.of<AppModel>(context, listen: false).auth.access_token;
      final res = await http.get(affiliateHome, headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader: "Bearer $token"
      });
      if (res.statusCode == 200) {
        final responeJson = json.decode(res.body);
        setState(() {
          result = AffiliateResult.fromJson(responeJson);
          loading = false;
        });
        _sumSales();
        print("SUCCESS");
        print(responeJson);
      }
    } catch (e) {
      print("ERROR");
      print(e.toString());
      setState(() {
        loading = false;
      });
      scaffoldkey.currentState.showSnackBar(snackBarError);
    }
  }

  @override
  Widget build(BuildContext context) {
    onGoBack(dynamic value) {
      getData();
      setState(() {});
      print("ulala");
    }

    void affiliateAddCodePage() {
      Route route = MaterialPageRoute(
          builder: (context) => AddCodeAffiliate(
                img: result.banner.photo,
              ));
      Navigator.push(context, route).then(onGoBack);
    }

    void affiliateWithdrawPage() {
      Route route = MaterialPageRoute(
          builder: (context) => CairkanDanaTotalScreen(
              total: total,
              session: result.sessions,
              use: result.totalUsed,
              sales: result.sales,
              img: result.banner.photo));
      Navigator.push(context, route).then(onGoBack);
    }

    final user = Provider.of<UserModel>(context).user;
    String afiliateUrl =
        urlGlobal + "users/registration?referral_code=" + user.referral_code;
    String ringkasUrl = urlGlobal + "referral/" + user.referral_code;
    final size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Hexcolor('#FCF8F0'),
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
          'Jadi Rekan Phoebe',
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
      key: scaffoldkey,
      body: loading
          ? Container(
              child: Center(
                child: LoadingWidgetFadingCircle(context),
              ),
            )
          : SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Stack(
                    children: [
                      CachedNetworkImage(
                        imageUrl: img_url + result.banner.photo,
                        placeholder: (context, url) =>
                            LoadingWidgetPulse(context),
                        errorWidget: (context, url, error) =>
                            Image.asset('assets/images/basic.jpg'),
                        fit: BoxFit.fill,
                      ),
                      Container(
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Hexcolor('#FDEDE4'),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                              ),
                              margin: EdgeInsets.only(
                                  right: 20, left: 20, top: 120),
                              height: 80,
                              width: MediaQuery.of(context).size.width,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          child: Text(
                                            "Halo,",
                                            style: TextStyle(
                                              fontFamily: "Brandon",
                                              fontSize: 22,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          child: Text(
                                            user.last_name!=null?(user.name + " " + user.last_name).toUpperCase():user.name.toUpperCase(),
                                            style: TextStyle(
                                              fontFamily: "Brandon",
                                              fontSize: 20,
                                              fontWeight: FontWeight.w600,
                                              color: Color(0xffF48262),
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
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Color(0xffF48262),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    // padding: EdgeInsets.only(top: 20, bottom: 20),
                    margin: EdgeInsets.only(top: 50, right: 20, left: 20),
                    child: Column(
                      children: [
                        Container(
                          width: double.infinity,
                          padding:
                              EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                          child: Container(
                            width: double.infinity,
                            child: Text(
                              "AFFILIATE URL",
                              style: TextStyle(
                                fontFamily: "Brandon",
                                fontWeight: FontWeight.w600,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            border: Border(
                              top: BorderSide(
                                color: Color(0xffF48262),
                                width: 1,
                              ),
                            ),
                          ),
                          padding:
                              EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                          child: Text(
                            afiliateUrl,
                            style: TextStyle(
                              fontFamily: "Brandon",
                              fontWeight: FontWeight.w500,
                              fontSize: 13,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Color(0xffF48262),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    // padding: EdgeInsets.only(top: 20, bottom: 20),
                    margin: EdgeInsets.only(top: 10, left: 20, right: 20),
                    child: Column(
                      children: [
                        Container(
                          width: double.infinity,
                          padding:
                              EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                          child: Container(
                            width: double.infinity,
                            child: Text(
                              "Salin tautan di bawah ini untuk digunakan di website mu",
                              style: TextStyle(
                                fontFamily: "Brandon",
                                fontWeight: FontWeight.w600,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            border: Border(
                              top: BorderSide(
                                color: Color(0xffF48262),
                                width: 1,
                              ),
                            ),
                          ),
                          padding:
                              EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                          child: Text(
                            link ? ringkasUrl : afiliateUrl,
                            style: TextStyle(
                              fontFamily: "Brandon",
                              fontWeight: FontWeight.w500,
                              fontSize: 13,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20, right: 20),
                    padding: EdgeInsets.only(top: 0, bottom: 0),
                    child: Row(
                      children: [
                        Container(
                          width: 20,
                          height: 40,
                          child: Checkbox(
                            activeColor: Color(0xffF48262),
                            checkColor: Colors.black,
                            value: link,
                            onChanged: (bool value) {
                              setState(() {
                                link = value;
                              });
                            },
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 10),
                          child: Text(
                            "Ringkas URL",
                            style: TextStyle(
                              fontFamily: "Brandon",
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Clipboard.setData(new ClipboardData(
                          text: link ? ringkasUrl : afiliateUrl));
                      Fluttertoast.showToast(
                          msg: "Copied to Clipboard",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xffF48262),
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                      margin:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      padding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 70),
                      child: Container(
                        child: Text(
                          "SALIN TAUTAN",
                          style: TextStyle(
                            fontFamily: "Brandon",
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                  if (result.isAffiliate)
                    Container(
                      width: double.infinity,
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        "Perolehan Kamu",
                        style: TextStyle(
                          fontFamily: "Brandon",
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  if (result.isAffiliate)
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 7),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 5),
                              padding: EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  color: Color(0xffF48262),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Sessions",
                                    style: TextStyle(
                                      fontFamily: "Brandon",
                                      fontSize: 12,
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                  Text(
                                    "${result.sessions == null ? 0 : result.sessions}",
                                    style: TextStyle(
                                      fontFamily: "Brandon",
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 5),
                              padding: EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  color: Color(0xffF48262),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Yang Terpakai",
                                    style: TextStyle(
                                      fontFamily: "Brandon",
                                      fontSize: 12,
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                  Text(
                                    "${result.totalUsed == null ? 0 : result.totalUsed.toString()}",
                                    style: TextStyle(
                                      fontFamily: "Brandon",
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 5),
                              padding: EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  color: Color(0xffF48262),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Pendapatan",
                                    style: TextStyle(
                                      fontFamily: "Brandon",
                                      fontSize: 12,
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                  Text(
                                    "${result.sales == null ? 0 : result.sales}",
                                    // NumberFormat.simpleCurrency(
                                    //         locale: "id_ID", decimalDigits: 0)
                                    //     .format(5000),
                                    style: TextStyle(
                                      fontFamily: "Brandon",
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  if (result.isAffiliate)
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 7),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: Color(0xffF48262),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                flex: 6,
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 5),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Campaigns",
                                        style: TextStyle(
                                          fontFamily: "Brandon",
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 5),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Status",
                                        style: TextStyle(
                                          fontFamily: "Brandon",
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 5,
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 5),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Pendapatan",
                                        style: TextStyle(
                                          fontFamily: "Brandon",
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 4,
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 5),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Total Penggunaan",
                                        style: TextStyle(
                                          fontFamily: "Brandon",
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          if (result.isAffiliate)
                            ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: result.codes.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Container(
                                  decoration: BoxDecoration(
                                    border: Border(
                                      top: BorderSide(
                                        color: Color(0xffF48262),
                                        width: 1,
                                      ),
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 6,
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 5, horizontal: 5),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Code",
                                                style: TextStyle(
                                                  fontFamily: "Brandon",
                                                  fontSize: 11,
                                                ),
                                                textAlign: TextAlign.left,
                                              ),
                                              Text(
                                                "${result.codes[index].kodeId}",
                                                style: TextStyle(
                                                  fontFamily: "Brandon",
                                                  fontSize: 12,
                                                ),
                                                textAlign: TextAlign.left,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 3,
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 5, horizontal: 5),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              statusAffiliatesStatus(
                                                  result.codes[index].isActive),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 5,
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 5, horizontal: 5),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "${formatCurrency.format(result.codes[index].sales)}",
                                                style: TextStyle(
                                                  fontFamily: "Brandon",
                                                  fontSize: 12,
                                                ),
                                                textAlign: TextAlign.left,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 4,
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 5, horizontal: 5),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "${result.codes[index].use}",
                                                style: TextStyle(
                                                  fontFamily: "Brandon",
                                                  fontSize: 12,
                                                ),
                                                textAlign: TextAlign.left,
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
                    ),
                  if (result.isAffiliate)
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 7),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: Color(0xffF48262),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                flex: 6,
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 5),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Date",
                                        style: TextStyle(
                                          fontFamily: "Brandon",
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 5,
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 5),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Amount",
                                        style: TextStyle(
                                          fontFamily: "Brandon",
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 5),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Status",
                                        style: TextStyle(
                                          fontFamily: "Brandon",
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 4,
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 5),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Detail",
                                        style: TextStyle(
                                          fontFamily: "Brandon",
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: result.withdrawal.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                decoration: BoxDecoration(
                                  border: Border(
                                    top: BorderSide(
                                      color: Color(0xffF48262),
                                      width: 1,
                                    ),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 6,
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 5, horizontal: 5),
                                        child: Text(
                                          "${result.withdrawal[index].createdAt}",
                                          style: TextStyle(
                                            fontFamily: "Brandon",
                                            fontSize: 12,
                                          ),
                                          textAlign: TextAlign.left,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 5,
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 5, horizontal: 5),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "${formatCurrency.format(result.withdrawal[index].amount)}",
                                              style: TextStyle(
                                                fontFamily: "Brandon",
                                                fontSize: 12,
                                              ),
                                              textAlign: TextAlign.left,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 5, horizontal: 5),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            statusAffiliatesReedem(result
                                                .withdrawal[index].status),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 4,
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 5, horizontal: 5),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                                width: 40,
                                                height: 20,
                                                child: RaisedButton(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 5),
                                                    onPressed: () {
                                                      name = result
                                                          .withdrawal[index]
                                                          .atasnama;
                                                      bank = result
                                                          .withdrawal[index]
                                                          .paymentMethod;
                                                      noRek = result
                                                          .withdrawal[index]
                                                          .norek;
                                                      result.withdrawal[index]
                                                                  .gambar ==
                                                              null
                                                          ? detailImage = null
                                                          : detailImage =
                                                              json.decode(result
                                                                  .withdrawal[
                                                                      index]
                                                                  .gambar);

                                                      _settingModalBottomSheet(
                                                          context);
                                                      print(
                                                          "objeck $index dengan nama ${result.withdrawal[index].createdAt}");
                                                    },
                                                    elevation: 0,
                                                    child: Text("Detail",
                                                        style: TextStyle(
                                                            fontFamily:
                                                                "Brandon",
                                                            color: Colors.white,
                                                            fontSize:
                                                                size.width *
                                                                    0.028,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w700)),
                                                    color: Colors.blue[700])),
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
                    ),
                  if (result.isAffiliate)
                    Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: size.width * 0.1),
                      padding: EdgeInsets.only(top: 10, bottom: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: FlatButton(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                onPressed: () {
                                  affiliateAddCodePage();
                                },
                                shape: new RoundedRectangleBorder(
                                    borderRadius:
                                        new BorderRadius.circular(15.0)),
                                child: Row(
                                  children: [
                                    Icon(Icons.add, color: Colors.white),
                                    Text("BIKIN KODE SENDIRI",
                                        style: TextStyle(
                                            fontFamily: "Brandon",
                                            color: Colors.white,
                                            fontSize: size.width * 0.034,
                                            fontWeight: FontWeight.w700)),
                                  ],
                                ),
                                color: Color(0xffF48262)),
                          ),
                          Container(
                            child: FlatButton(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                onPressed: () {
                                  total == 0 ? null : affiliateWithdrawPage();
                                },
                                shape: new RoundedRectangleBorder(
                                    borderRadius:
                                        new BorderRadius.circular(15.0)),
                                child: Text("CAIRKAN",
                                    style: TextStyle(
                                        fontFamily: "Brandon",
                                        color: Colors.white,
                                        fontSize: size.width * 0.034,
                                        fontWeight: FontWeight.w700)),
                                color: total == 0
                                    ? Color(0xffF48262).withOpacity(0.46)
                                    : Color(0xffF48262)),
                          )
                        ],
                      ),
                    ),
                ],
              ),
            ),
      bottomNavigationBar: new PonnyBottomNavbar(selectedIndex: 4),
    );
  }

  Container statusAffiliatesReedem(String statusName) {
    Color colors;
    if (statusName == "paid") {
      colors = Color(0xffF6DE6E);
    } else {
      colors = Color(0xFF40a153);
    }
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        color: colors,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        "$statusName",
        style: TextStyle(
          fontFamily: "Brandon",
          fontSize: 11,
        ),
        textAlign: TextAlign.left,
      ),
    );
  }

  Container statusAffiliatesStatus(int isActive) {
    Color colors;
    String statusName;

    if (isActive == 1) {
      statusName = "Active";
      colors = Color(0xffF6DE6E);
    } else {
      statusName = "Finish";
      colors = Color(0xffEB4034);
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        color: colors,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        "$statusName",
        style: TextStyle(
          fontFamily: "Brandon",
          fontSize: 11,
        ),
        textAlign: TextAlign.left,
      ),
    );
  }
}

class DetailAffiliateTextStyle extends StatelessWidget {
  const DetailAffiliateTextStyle({Key key, this.nama, this.sizing})
      : super(key: key);

  final String nama;
  final FontWeight sizing;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Text(nama,
        style: TextStyle(
            fontFamily: "Brandon",
            fontSize: size.width * 0.04,
            fontWeight: sizing));
  }
}
