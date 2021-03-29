import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:ponny/common/constant.dart';
import 'package:ponny/model/AffiliatesAddCode.dart';
import 'package:ponny/widgets/PonnyBottomNavbar.dart';
import 'package:provider/provider.dart';
import 'package:ponny/model/App.dart';
import 'package:ponny/util/globalUrl.dart';

class AddCodeAffiliate extends StatefulWidget {
  final String img;
  AddCodeAffiliate({this.img});
  @override
  _AddCodeAffiliateState createState() => _AddCodeAffiliateState();
}

class _AddCodeAffiliateState extends State<AddCodeAffiliate> {
  final code = TextEditingController();
  final scaffoldkey = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void customCode() async {
    await Provider.of<AddCodeResult>(context)
        .customCode(code.text, Provider.of<AppModel>(context).auth.access_token)
        .then((value) {
      if (value == true) {
        scaffoldkey.currentState.showSnackBar(snackBarSuccess);
        Navigator.pop(context);
      } else {
        scaffoldkey.currentState.showSnackBar(snackBarError);
      }
    });
    Future.delayed(const Duration(milliseconds: 1000), () {
      Navigator.pop(context);
    });
  }

  makeSureCreateCode(BuildContext context) {
    Widget cancelButton = FlatButton(
      child: Text("Tidak"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = FlatButton(
      child: Text("Ya"),
      onPressed: () {
        customCode();
      },
    );
    AlertDialog alert = AlertDialog(
      title: Text("Bikin Akun ?"),
      content: Text("Apakah anda ingin membuat kode voucher?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void validatorInput() {
    FormState form = this.formKey.currentState;
    if (form.validate() && code.text != null) {
      FocusScope.of(context).unfocus();
      makeSureCreateCode(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Hexcolor('#FCF8F0'),
        key: scaffoldkey,
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
            'Bikin Kode',
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
            children: [
              Container(
                  width: size.width,
                  height: 220,
                  decoration: BoxDecoration(color: Hexcolor('#FCF8F0')),
                  child: Stack(
                    children: [
                      Container(
                        width: size.width,
                        height: 170,
                        color: Colors.red,
                        child: CachedNetworkImage(
                          imageUrl: "$img_url${widget.img}",
                          placeholder: (context, url) =>
                              LoadingWidgetPulse(context),
                          errorWidget: (context, url, error) =>
                              Image.asset('assets/images/basic.jpg'),
                          fit: BoxFit.fill,
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        left: 0,
                        child: Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: size.width * 0.05),
                          width: size.width,
                          height: 80,
                          decoration: BoxDecoration(
                              color: Hexcolor('#FCF8F0'),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          child: Padding(
                            padding: EdgeInsets.only(top: size.height * 0.021),
                            child: Column(
                              children: [
                                Text(
                                  "Hallo,",
                                  style: TextStyle(
                                    fontFamily: "Yeseva",
                                    fontSize: size.height * 0.034,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  "tytan tyra".toUpperCase(),
                                  style: TextStyle(
                                    color: Hexcolor('#ffF48262'),
                                    fontFamily: "Yeseva",
                                    fontSize: size.height * 0.037,
                                    fontWeight: FontWeight.w600,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
              Column(
                children: [
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(left: size.width * 0.04),
                    child: Text(
                      "Yuk, bikin sendiri kode kamu",
                      style: TextStyle(
                        fontFamily: "Brandon",
                        fontWeight: FontWeight.w600,
                        fontSize: size.height * 0.023,
                      ),
                    ),
                  ),
                  Container(
                    width: size.width,
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
                        Container(
                            width: double.infinity,
                            margin: EdgeInsets.only(
                                left: size.width * 0.050,
                                top: size.width * 0.020,
                                bottom: size.width * 0.020),
                            child: Text(
                              "KODE DISKON",
                              style: TextStyle(
                                fontFamily: "Brandon",
                                fontWeight: FontWeight.w600,
                                fontSize: size.height * 0.023,
                              ),
                            )),
                        Column(
                          children: [
                            Container(
                                decoration: BoxDecoration(
                                  border: Border(
                                    top: BorderSide(
                                      color: Color(0xffF48262),
                                      width: 1,
                                    ),
                                  ),
                                ),
                                child: Form(
                                  key: formKey,
                                  child: TextFormField(
                                    controller: code,
                                    cursorColor: Colors.black,
                                    keyboardType: TextInputType.name,
                                    validator: (String value) {
                                      if (value.isEmpty) {
                                        return 'Field kode tidak boleh kosong';
                                      }
                                    },
                                    decoration: new InputDecoration(
                                        border: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        enabledBorder: InputBorder.none,
                                        errorBorder: InputBorder.none,
                                        disabledBorder: InputBorder.none,
                                        contentPadding: EdgeInsets.only(
                                            left: 15,
                                            bottom: 11,
                                            top: 11,
                                            right: 15),
                                        hintText: "PHOEBEXTITAN"),
                                  ),
                                )),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Container(
                child: RaisedButton(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    onPressed: () {
                      validatorInput();
                    },
                    elevation: 0,
                    child: Text("SIMPAN",
                        style: TextStyle(
                            fontFamily: "Brandon",
                            color: Colors.white,
                            fontSize: size.width * 0.034,
                            fontWeight: FontWeight.w700)),
                    color: Color(0xffF48262)),
              ),
            ],
          ),
        ),
        bottomNavigationBar: new PonnyBottomNavbar(selectedIndex: 4));
  }
}
