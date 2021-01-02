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
                        margin: EdgeInsets.only(right: 30, left: 30, top: 160),
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
                                        fontFamily: "Yeseva",
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
                                      user.name+" "+user.last_name,
                                      style: TextStyle(
                                        fontFamily: "Yeseva",
                                        fontSize: 22,
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
                border: Border.all(
                  color: Color(0xffF48262),
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              // padding: EdgeInsets.only(top: 20, bottom: 20),
              margin: EdgeInsets.only(top: 50,right: 30, left: 30),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(left: 15, top: 5, bottom: 5),
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
                    padding: EdgeInsets.only(left: 15, top: 5, bottom: 5),
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
                border: Border.all(
                  color: Color(0xffF48262),
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              // padding: EdgeInsets.only(top: 20, bottom: 20),
              margin: EdgeInsets.only(top: 10, left: 30, right: 30),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(left: 15, top: 5, bottom: 5),
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
                    padding: EdgeInsets.only(left: 15, top: 5, bottom: 5),
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
              margin: EdgeInsets.only(left: 30, right: 30),
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
                margin: EdgeInsets.only(left: 30, right: 30, top: 20),
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
            Container(height: 30,)
          ],
        ),
      ),
      bottomNavigationBar: new PonnyBottomNavbar(selectedIndex: 4),
    );
  }
}
