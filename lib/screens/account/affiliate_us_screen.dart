import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:ponny/model/User.dart';
import 'package:ponny/screens/account_screen.dart';
import 'package:ponny/widgets/PonnyBottomNavbar.dart';
import 'package:provider/provider.dart';
import 'package:ponny/util/globalUrl.dart';
import 'package:intl/intl.dart';

class AffiliateUsScreen extends StatefulWidget {
  static const String id = "Affiliate_Us_Screen";
  @override
  _AffiliateUsStateScreen createState() => _AffiliateUsStateScreen();
}

class _AffiliateUsStateScreen extends State<AffiliateUsScreen> {
  bool link = false;
  final scaffoldkey = GlobalKey<ScaffoldState>();


  @override
  Widget build(BuildContext context) {
    final user= Provider.of<UserModel>(context).user;
    String afiliateUrl= urlGlobal+"users/registration?referral_code="+user.referral_code;
    String ringkasUrl=  urlGlobal+"referral/"+user.referral_code;
    return Scaffold(
      key: scaffoldkey,
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
        title:  Text(
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
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Stack(
              children: [
                Container(
                  color: Colors.grey,
                  height: 230,
                  width: MediaQuery.of(context).size.width,
                ),
                Container(
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Hexcolor('#FDEDE4'),
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                        margin: EdgeInsets.only(right: 20, left: 20, top: 160),
                        height: 130,
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
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
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    child: Text(
                                      (user.name+" "+user.last_name).toUpperCase(),
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
              margin: EdgeInsets.only(top: 50,right: 20, left: 20),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
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
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
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
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
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
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    child: Text(
                      link?ringkasUrl:afiliateUrl,
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
              onTap: (){
                Clipboard.setData(new ClipboardData(text: link?ringkasUrl:afiliateUrl ));
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
                decoration: BoxDecoration(
                  color: Color(0xffF48262),
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 70),
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
            Container(
              margin: EdgeInsets.symmetric(horizontal: 15, vertical: 7),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 5),
                      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
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
                            "4.500",
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
                      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
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
                            "56",
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
                      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
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
                            NumberFormat.simpleCurrency(locale: "id_ID",decimalDigits: 0 ).format(5000),
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
                          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                  Container(
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
                            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                                  "PHOEBEXTITAN",
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
                            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 5),
                                  decoration: BoxDecoration(
                                    color: Color(0xffF6DE6E),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text(
                                    "Active",
                                    style: TextStyle(
                                      fontFamily: "Brandon",
                                      fontSize: 11,
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 5,
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Rp 2.000.000",
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
                            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "25",
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
                  ),
                  Container(
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
                            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                                  "PHOEBEXTITAN",
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
                            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 5),
                                  decoration: BoxDecoration(
                                    color: Color(0xffF6DE6E),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text(
                                    "Active",
                                    style: TextStyle(
                                      fontFamily: "Brandon",
                                      fontSize: 11,
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 5,
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Rp 2.000.000",
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
                            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "25",
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
                  ),
                  Container(
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
                            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                                  "PHOEBEXTITAN",
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
                            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 5),
                                  decoration: BoxDecoration(
                                    color: Color(0xffF6DE6E),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text(
                                    "Active",
                                    style: TextStyle(
                                      fontFamily: "Brandon",
                                      fontSize: 11,
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 5,
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Rp 2.000.000",
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
                            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "25",
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
                  ),
                  Container(
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
                            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                                  "PHOEBEXTITAN",
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
                            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 5),
                                  decoration: BoxDecoration(
                                    color: Color(0xffF06A4F),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text(
                                    "Finish",
                                    style: TextStyle(
                                      fontFamily: "Brandon",
                                      fontSize: 11,
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 5,
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Rp 2.000.000",
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
                            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "25",
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
                  ),
                ],
              ),
            ),
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
                          padding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                          padding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                          padding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                          padding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                  Container(
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
                              "2020-12-22 09:04:30",
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Rp 2.000.000",
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 5),
                                  decoration: BoxDecoration(
                                    color: Color(0xffF6DE6E),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text(
                                    "Unpaid",
                                    style: TextStyle(
                                      fontFamily: "Brandon",
                                      fontSize: 11,
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "25",
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
                  ),
                  Container(
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
                              "2020-12-22 09:04:30",
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Rp 2.000.000",
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 5),
                                  decoration: BoxDecoration(
                                    color: Color(0xffF6DE6E),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text(
                                    "Unpaid",
                                    style: TextStyle(
                                      fontFamily: "Brandon",
                                      fontSize: 11,
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "25",
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
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: size.width * 0.1),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: RaisedButton(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CairkanDanaTotalScreen()),
                          );
                        },
                        elevation: 0,
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
                    child: RaisedButton(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CairkanDanaTotalScreen()),
                          );
                        },
                        elevation: 0,
                        child: Text("CAIRKAN",
                            style: TextStyle(
                                fontFamily: "Brandon",
                                color: Colors.white,
                                fontSize: size.width * 0.034,
                                fontWeight: FontWeight.w700)),
                        color: Color(0xffF48262)),
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
}
