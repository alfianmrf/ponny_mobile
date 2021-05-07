import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:ponny/common/constant.dart';
import 'package:ponny/model/AffiliateResult.dart';
import 'package:ponny/screens/home_screen.dart';
import 'package:ponny/screens/login.dart';
import 'package:ponny/util/globalUrl.dart';
import 'package:ponny/widgets/PonnyBottomNavbar.dart';
import 'package:provider/provider.dart';
import 'package:uiblock/uiblock.dart';
import 'package:http/http.dart' as http;


class AffiliateHomeScreen extends StatefulWidget {
  static const String id = "Affiliate_Home_screen";

  @override
  _AffiliateHomeScreenState createState() => _AffiliateHomeScreenState();
}

class _AffiliateHomeScreenState extends State<AffiliateHomeScreen>
    with SingleTickerProviderStateMixin {
  bool login = false;
  bool regist = true;
  bool menu = true;
  bool daftarInfluencer = false;
  bool daftarBrand = false;
  bool vision = true;
  String typeAffiliate = '';

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  GlobalKey<FormState> formKeyInfluencer = GlobalKey<FormState>();
  final nama_influencer = TextEditingController();
  final email_influencer = TextEditingController();
  final password_influencer = TextEditingController();
  final konfirmasi_password_influencer = TextEditingController();
  final no_telepon_influencer = TextEditingController();
  final username_ig = TextEditingController();
  final username_fb = TextEditingController();
  final username_tw = TextEditingController();
  final username_yt = TextEditingController();
  String JenisKelaminInfluencer;

  GlobalKey<FormState> formKeyCompany = GlobalKey<FormState>();
  final nama_lengkap_company = TextEditingController();
  final email_company = TextEditingController();
  final password_company = TextEditingController();
  final konfirmasi_password_company = TextEditingController();
  final no_telepon_pic_company = TextEditingController();
  final nama_company  = TextEditingController();
  final alamat_company = TextEditingController();
  final no_telepon_company = TextEditingController();
  final deskripsi_company = TextEditingController();
  String JenisKelaminCompany;

  void validateInput() {
    FormState formInfluencer = this.formKeyInfluencer.currentState;
    FormState formCompany = this.formKeyCompany.currentState;

    if (typeAffiliate == 'influencer'){
      if (formInfluencer.validate() && JenisKelaminInfluencer != null && password_influencer.value.text == konfirmasi_password_influencer.value.text) {
        _fetchRegister();

      }
      else if(JenisKelaminInfluencer == null){
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                content: Text("Jenis Kelamin harus diisi."),
              );
            });
      }
      else if(password_influencer.value.text != konfirmasi_password_influencer.value.text){
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                content: Text("Password dan Konfirmasi Password harus sama"),
              );
            });
      }
    }
    else if (typeAffiliate == 'company'){
      if (formCompany.validate() && JenisKelaminCompany != null && password_company.value.text == konfirmasi_password_company.value.text) {
        _fetchRegister();

      }
      else if(JenisKelaminCompany == null){
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                content: Text("Jenis Kelamin harus diisi."),
              );
            });
      }
      else if(password_company.value.text != konfirmasi_password_company.value.text){
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                content: Text("Password dan Konfirmasi Password harus sama"),
              );
            });
      }
    }
  }

  _fetchRegister() async {
    var param;
    FocusScope.of(context).requestFocus(new FocusNode());
    UIBlock.block(context,customLoaderChild: LoadingWidget(context));
    if (typeAffiliate == 'influencer')
      param ={
        "type":typeAffiliate,
        "name":nama_influencer.value.text,
        "email":email_influencer.value.text,
        "password": password_influencer.value.text,
        "password_confirmation": konfirmasi_password_influencer.value.text,
        "nomor_hp_pic":no_telepon_influencer.value.text,
        "jeniskelamin":JenisKelaminInfluencer,
        "ig_username":username_ig.value.text,
        "fb_username":username_fb.value.text,
        "tw_username":username_tw.value.text,
        "yt_username":username_yt.value.text
      };
    else if (typeAffiliate == 'company')
      param ={
        "type":typeAffiliate,
        "name":nama_lengkap_company.value.text,
        "email":email_company.value.text,
        "password": password_company.value.text,
        "password_confirmation": konfirmasi_password_company.value.text,
        "nomor_hp_pic":no_telepon_pic_company.value.text,
        "nama_perusahaan":nama_company.value.text,
        "alamat_perusahaan":alamat_company.value.text,
        "nomor_hp_perusahaan":no_telepon_company.value.text,
        "deskripsi_produk":deskripsi_company.value.text,
        "jeniskelamin":JenisKelaminCompany
      };
    final res = await http.post(affiliateRegister+'/'+typeAffiliate,headers: { HttpHeaders.contentTypeHeader: 'application/json' },body: json.encode(param));
    UIBlock.unblock(context);
    if(res.statusCode == 200){
      final pesan = json.decode(res.body);
      print(pesan);
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: Text(pesan['message']),
              actions:<Widget> [
                FlatButton (
                  child: Text('Login Now'),
                  onPressed: () {
                    Navigator.pushReplacement(context,new MaterialPageRoute(
                      builder: (BuildContext context) =>  new LoginScreen(),
                    ));
                  },
                ),
              ],
            );
          });
    }else{
      print(res.body);
      final snackBar = SnackBar(
        content: Text('Terjadi kesalahan pada server!',style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.redAccent,
      );
      scaffoldKey.currentState.showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        if (menu)
          Navigator.pop(context);
        setState(() {
          login = false;
          daftarInfluencer = false;
          daftarBrand = false;
          regist = true;
          menu = true;
        });
      },
      child: Scaffold(
        key: scaffoldKey,
          resizeToAvoidBottomInset: true,
          backgroundColor: Color(0xffFDF8F0),
          appBar: AppBar(
            elevation: 0,
            titleSpacing: 0,
            leading: IconButton(
              onPressed: () {
                if (menu)
                  Navigator.pop(context);
                setState(() {
                  login = false;
                  daftarInfluencer = false;
                  daftarBrand = false;
                  regist = true;
                  menu = true;
                });
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: Color(0xffF48262),
                size: 26,
              ),
            ),
            title: Text(
              menu ? "Affiliate With Us" : "Daftar",
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
          body: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(new FocusNode());
            },
            child: SingleChildScrollView(
              child: Stack(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: CachedNetworkImage(
                      imageUrl: img_url + Provider.of<AffiliateModel>(context).banner,
                      placeholder: (context, url) =>
                          LoadingWidgetPulse(context),
                      errorWidget: (context, url, error) =>
                          Image.asset('assets/images/basic.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  Column(
                    children: [
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.fromLTRB(20, 175, 20, 0),
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Color(0xffFCF6F0),
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 1,
                              blurRadius: 1,// changes position of shadow
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Text(
                              "Yuk Join \ndan Dapatkan Keuntungan",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 20,
                                fontFamily: "Yeseva",
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              'Isi formulir di bawah ini dan Tim Phoebe akan menghubungi kamu lebih lanjut',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'Brandon',
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      daftarInfluencer
                          ? Container(
                        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                        child: Form(
                          key: formKeyInfluencer,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RichText(
                                text: TextSpan(
                                  text: 'Nama Lengkap',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.black,
                                    fontFamily: 'Brandon',
                                  ),
                                  children: [
                                    TextSpan(
                                      text: '*',
                                      style: TextStyle(
                                        color: Hexcolor('#F48262'),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              TextFormField(
                                controller: nama_influencer,
                                style: TextStyle(
                                  fontFamily: 'Brandon',
                                  fontSize: 14,
                                ),
                                decoration: InputDecoration(
                                  isDense: true,
                                  contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                  filled: true,
                                  fillColor: Colors.white,
                                  labelStyle: TextStyle(color: Colors.black),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide(
                                      color: Hexcolor('#F48262'),
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide(
                                      color: Hexcolor('#F48262'),
                                      width: 1.0,
                                    ),
                                  ),
                                ),
                                keyboardType: TextInputType.name,
                                validator: (String value) {
                                  if (value.isEmpty) {
                                    return 'Nama Lengkap tidak boleh kosong';
                                  }
                                },
                              ),
                              Container(height: 10),
                              RichText(
                                text: TextSpan(
                                  text: 'Email',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.black,
                                    fontFamily: 'Brandon',
                                  ),
                                  children: [
                                    TextSpan(
                                      text: '*',
                                      style: TextStyle(
                                        color: Hexcolor('#F48262'),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              TextFormField(
                                controller: email_influencer,
                                style: TextStyle(
                                  fontFamily: 'Brandon',
                                  fontSize: 14,
                                ),
                                decoration: InputDecoration(
                                  isDense: true,
                                  contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                  filled: true,
                                  fillColor: Colors.white,
                                  labelStyle: TextStyle(color: Colors.black),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide(
                                      color: Hexcolor('#F48262'),
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide(
                                      color: Hexcolor('#F48262'),
                                      width: 1.0,
                                    ),
                                  ),
                                ),
                                keyboardType: TextInputType.emailAddress,
                                validator: (String value) {
                                  if (value.isEmpty) {
                                    return 'Email tidak boleh kosong';
                                  }
                                },
                              ),
                              Container(height: 10),
                              RichText(
                                text: TextSpan(
                                  text: 'Kata Sandi',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.black,
                                    fontFamily: 'Brandon',
                                  ),
                                  children: [
                                    TextSpan(
                                      text: '*',
                                      style: TextStyle(
                                        color: Hexcolor('#F48262'),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              TextFormField(
                                controller: password_influencer,
                                obscureText: true,
                                style: TextStyle(
                                  fontFamily: 'Brandon',
                                  fontSize: 14,
                                ),
                                decoration: InputDecoration(
                                  isDense: true,
                                  contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                  filled: true,
                                  fillColor: Colors.white,
                                  labelStyle: TextStyle(color: Colors.black),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide(
                                      color: Hexcolor('#F48262'),
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide(
                                      color: Hexcolor('#F48262'),
                                      width: 1.0,
                                    ),
                                  ),
                                ),
                                keyboardType: TextInputType.visiblePassword,
                                validator: (String value) {
                                  if (value.isEmpty) {
                                    return 'Kata Sandi tidak boleh kosong';
                                  }
                                  if (value.length<8) {
                                    return 'Kata Sandi minimal 8 karakter';
                                  }
                                },
                              ),
                              Container(height: 10),
                              RichText(
                                text: TextSpan(
                                  text: 'Konfirmasi Kata Sandi',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.black,
                                    fontFamily: 'Brandon',
                                  ),
                                  children: [
                                    TextSpan(
                                      text: '*',
                                      style: TextStyle(
                                        color: Hexcolor('#F48262'),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              TextFormField(
                                controller: konfirmasi_password_influencer,
                                obscureText: true,
                                style: TextStyle(
                                  fontFamily: 'Brandon',
                                  fontSize: 14,
                                ),
                                decoration: InputDecoration(
                                  isDense: true,
                                  contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                  filled: true,
                                  fillColor: Colors.white,
                                  labelStyle: TextStyle(color: Colors.black),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide(
                                      color: Hexcolor('#F48262'),
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide(
                                      color: Hexcolor('#F48262'),
                                      width: 1.0,
                                    ),
                                  ),
                                ),
                                keyboardType: TextInputType.visiblePassword,
                                validator: (String value) {
                                  if (value.isEmpty) {
                                    return 'Konfirmasi Kata Sandi tidak boleh kosong';
                                  }
                                  if (value.length<8) {
                                    return 'Konfirmasi Kata Sandi minimal 8 karakter';
                                  }
                                },
                              ),
                              Container(height: 10),
                              RichText(
                                text: TextSpan(
                                  text: 'Nomor Handphone (PIC)',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.black,
                                    fontFamily: 'Brandon',
                                  ),
                                  children: [
                                    TextSpan(
                                      text: '*',
                                      style: TextStyle(
                                        color: Hexcolor('#F48262'),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              TextFormField(
                                controller: no_telepon_influencer,
                                style: TextStyle(
                                  fontFamily: 'Brandon',
                                  fontSize: 14,
                                ),
                                decoration: InputDecoration(
                                  isDense: true,
                                  contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                  filled: true,
                                  fillColor: Colors.white,
                                  labelStyle: TextStyle(color: Colors.black),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide(
                                      color: Hexcolor('#F48262'),
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide(
                                      color: Hexcolor('#F48262'),
                                      width: 1.0,
                                    ),
                                  ),
                                ),
                                keyboardType: TextInputType.phone,
                                validator: (String value) {
                                  if (value.isEmpty) {
                                    return 'Nomor Handphone (PIC) tidak boleh kosong';
                                  }
                                },
                              ),
                              Container(height: 10),
                              RichText(
                                text: TextSpan(
                                  text: 'Nama Social Media',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.black,
                                    fontFamily: 'Brandon',
                                  ),
                                  children: [
                                    TextSpan(
                                      text: '*',
                                      style: TextStyle(
                                        color: Hexcolor('#F48262'),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              TextFormField(
                                controller: username_ig,
                                style: TextStyle(
                                  fontFamily: 'Brandon',
                                  fontSize: 14,
                                ),
                                decoration: InputDecoration(
                                  prefixIcon: Container(
                                    width: 45,
                                    padding: EdgeInsets.symmetric(horizontal: 12.0),
                                    child: FaIcon(FontAwesomeIcons.instagram, color: Hexcolor('#F48262'), size: 20,),
                                  ),
                                  prefixIconConstraints: BoxConstraints(
                                    minWidth: 20,
                                    minHeight: 20,
                                  ),
                                  hintText: 'Username',
                                  hintStyle: TextStyle(color: Colors.black26),
                                  isDense: true,
                                  contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                  filled: true,
                                  fillColor: Colors.white,
                                  labelStyle: TextStyle(color: Colors.black),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide(
                                      color: Hexcolor('#F48262'),
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide(
                                      color: Hexcolor('#F48262'),
                                      width: 1.0,
                                    ),
                                  ),
                                ),
                                keyboardType: TextInputType.name,
                                validator: (String value) {
                                  if (value.isEmpty) {
                                    return 'Instagram tidak boleh kosong';
                                  }
                                },
                              ),
                              Container(height: 10),
                              TextFormField(
                                controller: username_fb,
                                style: TextStyle(
                                  fontFamily: 'Brandon',
                                  fontSize: 14,
                                ),
                                decoration: InputDecoration(
                                  prefixIcon: Container(
                                    width: 45,
                                    padding: EdgeInsets.symmetric(horizontal: 12.0),
                                    child: FaIcon(FontAwesomeIcons.facebookF, color: Hexcolor('#F48262'), size: 20,),
                                  ),
                                  prefixIconConstraints: BoxConstraints(
                                    minWidth: 20,
                                    minHeight: 20,
                                  ),
                                  hintText: 'Username',
                                  hintStyle: TextStyle(color: Colors.black26),
                                  isDense: true,
                                  contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                  filled: true,
                                  fillColor: Colors.white,
                                  labelStyle: TextStyle(color: Colors.black),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide(
                                      color: Hexcolor('#F48262'),
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide(
                                      color: Hexcolor('#F48262'),
                                      width: 1.0,
                                    ),
                                  ),
                                ),
                                keyboardType: TextInputType.name,
                                validator: (String value) {
                                  if (value.isEmpty) {
                                    return 'Facebook tidak boleh kosong';
                                  }
                                },
                              ),
                              Container(height: 10),
                              TextFormField(
                                controller: username_tw,
                                style: TextStyle(
                                  fontFamily: 'Brandon',
                                  fontSize: 14,
                                ),
                                decoration: InputDecoration(
                                  prefixIcon: Container(
                                    width: 45,
                                    padding: EdgeInsets.symmetric(horizontal: 12.0),
                                    child: FaIcon(FontAwesomeIcons.twitter, color: Hexcolor('#F48262'), size: 20,),
                                  ),
                                  prefixIconConstraints: BoxConstraints(
                                    minWidth: 20,
                                    minHeight: 20,
                                  ),
                                  hintText: 'Username',
                                  hintStyle: TextStyle(color: Colors.black26),
                                  isDense: true,
                                  contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                  filled: true,
                                  fillColor: Colors.white,
                                  labelStyle: TextStyle(color: Colors.black),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide(
                                      color: Hexcolor('#F48262'),
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide(
                                      color: Hexcolor('#F48262'),
                                      width: 1.0,
                                    ),
                                  ),
                                ),
                                keyboardType: TextInputType.name,
                                validator: (String value) {
                                  if (value.isEmpty) {
                                    return 'Twitter tidak boleh kosong';
                                  }
                                },
                              ),
                              Container(height: 10),
                              TextFormField(
                                controller: username_yt,
                                style: TextStyle(
                                  fontFamily: 'Brandon',
                                  fontSize: 14,
                                ),
                                decoration: InputDecoration(
                                  prefixIcon: Container(
                                    width: 45,
                                    padding: EdgeInsets.symmetric(horizontal: 12.0),
                                    child: FaIcon(FontAwesomeIcons.youtube, color: Hexcolor('#F48262'), size: 20,),
                                  ),
                                  prefixIconConstraints: BoxConstraints(
                                    minWidth: 20,
                                    minHeight: 20,
                                  ),
                                  hintText: 'Username',
                                  hintStyle: TextStyle(color: Colors.black26),
                                  isDense: true,
                                  contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                  filled: true,
                                  fillColor: Colors.white,
                                  labelStyle: TextStyle(color: Colors.black),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide(
                                      color: Hexcolor('#F48262'),
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide(
                                      color: Hexcolor('#F48262'),
                                      width: 1.0,
                                    ),
                                  ),
                                ),
                                keyboardType: TextInputType.name,
                                validator: (String value) {
                                  if (value.isEmpty) {
                                    return 'Youtube tidak boleh kosong';
                                  }
                                },
                              ),
                              Container(height: 10),
                              Text(
                                "Jenis Kelamin",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontFamily: 'Brandon',
                                ),
                              ),
                              Row(
                                children: [
                                  Radio(
                                    activeColor: Color(0xffF48262),
                                    value: "P",
                                    groupValue: JenisKelaminInfluencer,
                                    onChanged: (String value) {
                                      setState(() {
                                        JenisKelaminInfluencer = value;
                                      });
                                    },
                                  ),
                                  Text(
                                    "Perempuan",
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontFamily: 'Brandon',
                                    ),
                                  ),
                                  Radio(
                                    activeColor: Color(0xffF48262),
                                    value: "L",
                                    groupValue: JenisKelaminInfluencer,
                                    onChanged: (String value) {
                                      setState(() {
                                        JenisKelaminInfluencer = value;
                                      });
                                    },
                                  ),
                                  Text(
                                    "Laki-Laki",
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontFamily: 'Brandon',
                                    ),
                                  ),
                                ],
                              ),
                              ButtonTheme(
                                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                                child: FlatButton(
                                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                  padding: EdgeInsets.symmetric(vertical: 5),
                                  color: Hexcolor('#F48262'),
                                  onPressed: (){
                                    setState(() {
                                      typeAffiliate = 'influencer';
                                    });
                                    validateInput();
                                  },
                                  child: Text(
                                    'KIRIM',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: 'Brandon',
                                        fontWeight: FontWeight.w800,
                                        color: Colors.white),
                                  ),
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                          : daftarBrand
                          ? Container(
                        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                        child: Form(
                          key: formKeyCompany,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RichText(
                                text: TextSpan(
                                  text: 'Nama Lengkap',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.black,
                                    fontFamily: 'Brandon',
                                  ),
                                  children: [
                                    TextSpan(
                                      text: '*',
                                      style: TextStyle(
                                        color: Hexcolor('#F48262'),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              TextFormField(
                                controller: nama_lengkap_company,
                                style: TextStyle(
                                  fontFamily: 'Brandon',
                                  fontSize: 14,
                                ),
                                decoration: InputDecoration(
                                  isDense: true,
                                  contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                  filled: true,
                                  fillColor: Colors.white,
                                  labelStyle: TextStyle(color: Colors.black),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide(
                                      color: Hexcolor('#F48262'),
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide(
                                      color: Hexcolor('#F48262'),
                                      width: 1.0,
                                    ),
                                  ),
                                ),
                                keyboardType: TextInputType.name,
                                validator: (String value) {
                                  if (value.isEmpty) {
                                    return 'Nama Lengkap tidak boleh kosong';
                                  }
                                },
                              ),
                              Container(height: 10),
                              RichText(
                                text: TextSpan(
                                  text: 'Email',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.black,
                                    fontFamily: 'Brandon',
                                  ),
                                  children: [
                                    TextSpan(
                                      text: '*',
                                      style: TextStyle(
                                        color: Hexcolor('#F48262'),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              TextFormField(
                                controller: email_company,
                                style: TextStyle(
                                  fontFamily: 'Brandon',
                                  fontSize: 14,
                                ),
                                decoration: InputDecoration(
                                  isDense: true,
                                  contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                  filled: true,
                                  fillColor: Colors.white,
                                  labelStyle: TextStyle(color: Colors.black),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide(
                                      color: Hexcolor('#F48262'),
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide(
                                      color: Hexcolor('#F48262'),
                                      width: 1.0,
                                    ),
                                  ),
                                ),
                                keyboardType: TextInputType.emailAddress,
                                validator: (String value) {
                                  if (value.isEmpty) {
                                    return 'Email tidak boleh kosong';
                                  }
                                },
                              ),
                              Container(height: 10),
                              RichText(
                                text: TextSpan(
                                  text: 'Kata Sandi',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.black,
                                    fontFamily: 'Brandon',
                                  ),
                                  children: [
                                    TextSpan(
                                      text: '*',
                                      style: TextStyle(
                                        color: Hexcolor('#F48262'),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              TextFormField(
                                controller: password_company,
                                obscureText: true,
                                style: TextStyle(
                                  fontFamily: 'Brandon',
                                  fontSize: 14,
                                ),
                                decoration: InputDecoration(
                                  isDense: true,
                                  contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                  filled: true,
                                  fillColor: Colors.white,
                                  labelStyle: TextStyle(color: Colors.black),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide(
                                      color: Hexcolor('#F48262'),
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide(
                                      color: Hexcolor('#F48262'),
                                      width: 1.0,
                                    ),
                                  ),
                                ),
                                keyboardType: TextInputType.visiblePassword,
                                validator: (String value) {
                                  if (value.isEmpty) {
                                    return 'Kata Sandi tidak boleh kosong';
                                  }
                                  if (value.length<8) {
                                    return 'Kata Sandi minimal 8 karakter';
                                  }
                                },
                              ),
                              Container(height: 10),
                              RichText(
                                text: TextSpan(
                                  text: 'Konfirmasi Kata Sandi',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.black,
                                    fontFamily: 'Brandon',
                                  ),
                                  children: [
                                    TextSpan(
                                      text: '*',
                                      style: TextStyle(
                                        color: Hexcolor('#F48262'),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              TextFormField(
                                controller: konfirmasi_password_company,
                                obscureText: true,
                                style: TextStyle(
                                  fontFamily: 'Brandon',
                                  fontSize: 14,
                                ),
                                decoration: InputDecoration(
                                  isDense: true,
                                  contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                  filled: true,
                                  fillColor: Colors.white,
                                  labelStyle: TextStyle(color: Colors.black),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide(
                                      color: Hexcolor('#F48262'),
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide(
                                      color: Hexcolor('#F48262'),
                                      width: 1.0,
                                    ),
                                  ),
                                ),
                                keyboardType: TextInputType.visiblePassword,
                                validator: (String value) {
                                  if (value.isEmpty) {
                                    return 'Konfirmasi Kata Sandi tidak boleh kosong';
                                  }
                                  if (value.length<8) {
                                    return 'Konfirmasi Kata Sandi minimal 8 karakter';
                                  }
                                },
                              ),
                              Container(height: 10),
                              RichText(
                                text: TextSpan(
                                  text: 'Nomor Handphone (PIC)',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.black,
                                    fontFamily: 'Brandon',
                                  ),
                                  children: [
                                    TextSpan(
                                      text: '*',
                                      style: TextStyle(
                                        color: Hexcolor('#F48262'),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              TextFormField(
                                controller: no_telepon_pic_company,
                                style: TextStyle(
                                  fontFamily: 'Brandon',
                                  fontSize: 14,
                                ),
                                decoration: InputDecoration(
                                  isDense: true,
                                  contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                  filled: true,
                                  fillColor: Colors.white,
                                  labelStyle: TextStyle(color: Colors.black),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide(
                                      color: Hexcolor('#F48262'),
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide(
                                      color: Hexcolor('#F48262'),
                                      width: 1.0,
                                    ),
                                  ),
                                ),
                                keyboardType: TextInputType.phone,
                                validator: (String value) {
                                  if (value.isEmpty) {
                                    return 'Nomor Handphone (PIC) tidak boleh kosong';
                                  }
                                },
                              ),
                              Container(height: 10),
                              RichText(
                                text: TextSpan(
                                  text: 'Toko/Nama Perusahaan',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.black,
                                    fontFamily: 'Brandon',
                                  ),
                                  children: [
                                    TextSpan(
                                      text: '*',
                                      style: TextStyle(
                                        color: Hexcolor('#F48262'),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              TextFormField(
                                controller: nama_company,
                                style: TextStyle(
                                  fontFamily: 'Brandon',
                                  fontSize: 14,
                                ),
                                decoration: InputDecoration(
                                  isDense: true,
                                  contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                  filled: true,
                                  fillColor: Colors.white,
                                  labelStyle: TextStyle(color: Colors.black),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide(
                                      color: Hexcolor('#F48262'),
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide(
                                      color: Hexcolor('#F48262'),
                                      width: 1.0,
                                    ),
                                  ),
                                ),
                                keyboardType: TextInputType.name,
                                validator: (String value) {
                                  if (value.isEmpty) {
                                    return 'Toko/Nama Perusahaan tidak boleh kosong';
                                  }
                                },
                              ),
                              Container(height: 10),
                              RichText(
                                text: TextSpan(
                                  text: 'Alamat Toko/Perusahaan',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.black,
                                    fontFamily: 'Brandon',
                                  ),
                                  children: [
                                    TextSpan(
                                      text: '*',
                                      style: TextStyle(
                                        color: Hexcolor('#F48262'),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              TextFormField(
                                controller: alamat_company,
                                style: TextStyle(
                                  fontFamily: 'Brandon',
                                  fontSize: 14,
                                ),
                                decoration: InputDecoration(
                                  isDense: true,
                                  contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                  filled: true,
                                  fillColor: Colors.white,
                                  labelStyle: TextStyle(color: Colors.black),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide(
                                      color: Hexcolor('#F48262'),
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide(
                                      color: Hexcolor('#F48262'),
                                      width: 1.0,
                                    ),
                                  ),
                                ),
                                keyboardType: TextInputType.streetAddress,
                                validator: (String value) {
                                  if (value.isEmpty) {
                                    return 'Alamat Toko/Perusahaan tidak boleh kosong';
                                  }
                                },
                              ),
                              Container(height: 10),
                              RichText(
                                text: TextSpan(
                                  text: 'Nomor Handphone Perusahaan',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.black,
                                    fontFamily: 'Brandon',
                                  ),
                                  children: [
                                    TextSpan(
                                      text: '*',
                                      style: TextStyle(
                                        color: Hexcolor('#F48262'),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              TextFormField(
                                controller: no_telepon_company,
                                style: TextStyle(
                                  fontFamily: 'Brandon',
                                  fontSize: 14,
                                ),
                                decoration: InputDecoration(
                                  isDense: true,
                                  contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                  filled: true,
                                  fillColor: Colors.white,
                                  labelStyle: TextStyle(color: Colors.black),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide(
                                      color: Hexcolor('#F48262'),
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide(
                                      color: Hexcolor('#F48262'),
                                      width: 1.0,
                                    ),
                                  ),
                                ),
                                keyboardType: TextInputType.phone,
                                validator: (String value) {
                                  if (value.isEmpty) {
                                    return 'Nomor Handphone Perusahaan tidak boleh kosong';
                                  }
                                },
                              ),
                              Container(height: 10),
                              RichText(
                                text: TextSpan(
                                  text: 'Deskripsi Produk',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.black,
                                    fontFamily: 'Brandon',
                                  ),
                                  children: [
                                    TextSpan(
                                      text: '*',
                                      style: TextStyle(
                                        color: Hexcolor('#F48262'),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              TextFormField(
                                controller: deskripsi_company,
                                style: TextStyle(
                                  fontFamily: 'Brandon',
                                  fontSize: 14,
                                ),
                                maxLines: 4,
                                textAlignVertical: TextAlignVertical.top,
                                decoration: InputDecoration(
                                  hintText: "Deskripsi mengenai merek/produk anda...",
                                  isDense: true,
                                  contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                  filled: true,
                                  fillColor: Colors.white,
                                  labelStyle: TextStyle(color: Colors.black),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide(
                                      color: Hexcolor('#F48262'),
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide(
                                      color: Hexcolor('#F48262'),
                                      width: 1.0,
                                    ),
                                  ),
                                ),
                                keyboardType: TextInputType.multiline,
                                validator: (String value) {
                                  if (value.isEmpty) {
                                    return 'Deskripsi Produk tidak boleh kosong';
                                  }
                                },
                              ),
                              Container(height: 10),
                              Text(
                                "Jenis Kelamin",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontFamily: 'Brandon',
                                ),
                              ),
                              Row(
                                children: [
                                  Radio(
                                    activeColor: Color(0xffF48262),
                                    value: "P",
                                    groupValue: JenisKelaminCompany,
                                    onChanged: (String value) {
                                      setState(() {
                                        JenisKelaminCompany = value;
                                      });
                                    },
                                  ),
                                  Text(
                                    "Perempuan",
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontFamily: 'Brandon',
                                    ),
                                  ),
                                  Radio(
                                    activeColor: Color(0xffF48262),
                                    value: "L",
                                    groupValue: JenisKelaminCompany,
                                    onChanged: (String value) {
                                      setState(() {
                                        JenisKelaminCompany = value;
                                      });
                                    },
                                  ),
                                  Text(
                                    "Laki-Laki",
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontFamily: 'Brandon',
                                    ),
                                  ),
                                ],
                              ),
                              ButtonTheme(
                                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                                child: FlatButton(
                                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                  padding: EdgeInsets.symmetric(vertical: 5),
                                  color: Hexcolor('#F48262'),
                                  onPressed: (){
                                    setState(() {
                                      typeAffiliate = 'company';
                                    });
                                    validateInput();
                                  },
                                  child: Text(
                                    'KIRIM',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: 'Brandon',
                                        fontWeight: FontWeight.w800,
                                        color: Colors.white),
                                  ),
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                          : Container(),
                      login
                          ? Container(
                              margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
                              child: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "HALO PARTNER PHOEBE!",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: 'Brandon',
                                        fontWeight: FontWeight.w800,
                                        color: Colors.black),
                                  ),
                                  Text(
                                    "Masukan email dan password kamu untuk masuk",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: 'Brandon',
                                        fontWeight: FontWeight.w800,
                                        color: Colors.black),
                                  ),
                                  Container(height: 10),
                                  Container(
                                    height: 40,
                                    child: TextField(
                                      obscureText: vision,
                                      textAlignVertical:
                                          TextAlignVertical.bottom,
                                      decoration: new InputDecoration(
                                        fillColor: Colors.white,
                                        filled: true,
                                        hintStyle: TextStyle(
                                          fontFamily: 'Brandon',
                                        ),
                                        focusedBorder:
                                            new OutlineInputBorder(
                                                borderSide:
                                                    new BorderSide(
                                                        color: Hexcolor(
                                                            '#F48262'))),
                                        errorBorder: InputBorder.none,
                                        disabledBorder: InputBorder.none,
                                        hintText: "Email",
                                        enabledBorder:
                                            new OutlineInputBorder(
                                                borderSide:
                                                    new BorderSide(
                                                        color: Hexcolor(
                                                            '#F48262'))),
                                      ),
                                    ),
                                  ),
                                  Container(height: 10),
                                  Container(
                                    height: 40,
                                    child: TextField(
                                      obscureText: vision,
                                      textAlignVertical:
                                          TextAlignVertical.bottom,
                                      decoration: new InputDecoration(
                                        suffixIcon: GestureDetector(
                                            child: vision
                                                ? Icon(Icons.visibility)
                                                : Icon(
                                                    Icons.visibility_off),
                                            onTap: () {
                                              setState(() {
                                                vision = !vision;
                                              });
                                            }),
                                        fillColor: Colors.white,
                                        filled: true,
                                        hintStyle: TextStyle(
                                          fontFamily: 'Brandon',
                                        ),
                                        focusedBorder:
                                            new OutlineInputBorder(
                                                borderSide:
                                                    new BorderSide(
                                                        color: Hexcolor(
                                                            '#F48262'))),
                                        errorBorder: InputBorder.none,
                                        disabledBorder: InputBorder.none,
                                        hintText: "Password",
                                        enabledBorder:
                                            new OutlineInputBorder(
                                                borderSide:
                                                    new BorderSide(
                                                        color: Hexcolor(
                                                            '#F48262'))),
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: InkWell(
                                      child: Text(
                                        "Lupa kata sandi anda?",
                                        style: TextStyle(
                                          decoration:
                                              TextDecoration.underline,
                                          fontSize: 14,
                                          fontFamily: 'Brandon',
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(height: 10),
                                  Container(
                                      width: double.infinity,
                                      child: ButtonTheme(
                                        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                                        child: FlatButton(
                                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                          padding: EdgeInsets.symmetric(vertical: 5),
                                          color: Hexcolor('#F48262'),
                                          onPressed: () {},
                                          child: Text(
                                            'MASUK',
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontFamily: 'Brandon',
                                                fontWeight: FontWeight.w800,
                                                color: Colors.white),
                                          ),
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10.0),
                                        ),
                                      ))
                                ],
                              ),
                            )
                          : menu
                              ? Container(
                                  margin: EdgeInsets.only(top: 20),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Container(
                                        width: 120,
                                        height: 120,
                                        child: FlatButton(
                                          padding: EdgeInsets.all(0.0),
                                          onPressed: () {
                                            setState(() {
                                              daftarInfluencer =
                                                  !daftarInfluencer;
                                              daftarBrand = false;
                                              menu = false;
                                            });
                                          },
                                          child: Image.asset('assets/images/influencer.png'),
                                        ),
                                      ),
                                      Container(
                                        width: 120,
                                        height: 120,
                                        child: FlatButton(
                                          padding: EdgeInsets.all(0.0),
                                          onPressed: () {
                                            setState(() {
                                              daftarBrand = !daftarBrand;
                                              daftarInfluencer = false;
                                              menu = false;
                                            });
                                          },
                                          child: Image.asset('assets/images/company.png'),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              : /*Container(
                                  margin: EdgeInsets.only(top: 20),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      ButtonTheme(
                                        buttonColor: Hexcolor('#F48262'),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 30, vertical: 10),
                                        child: RaisedButton(
                                          onPressed: () {
                                            setState(() {
                                              regist = true;
                                            });
                                          },
                                          child: Text(
                                            "DAFTAR",
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontFamily: 'Brandon',
                                                fontWeight:
                                                    FontWeight.w800,
                                                color: Colors.white),
                                          ),
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                          side: BorderSide(
                                              color: Hexcolor('#F48262')),
                                        ),
                                      ),
                                      ButtonTheme(
                                        buttonColor: Hexcolor('#F48262'),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 30, vertical: 10),
                                        child: RaisedButton(
                                          onPressed: () {
                                            setState(() {
                                              login = true;
                                            });
                                          },
                                          child: Text(
                                            "MASUK",
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontFamily: 'Brandon',
                                                fontWeight:
                                                    FontWeight.w800,
                                                color: Colors.white),
                                          ),
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                          side: BorderSide(
                                              color: Hexcolor('#F48262')),
                                        ),
                                      )
                                    ],
                                  ),
                                ),*/
                      Container(height: 30),
                    ],
                  ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: new PonnyBottomNavbar(selectedIndex: 4)),
    );
  }
}

Widget daftar_TextField(String hintText, Image prefiksIcon) {
  return Container(
    height: 30,
    child: TextField(
      textAlignVertical: TextAlignVertical.bottom,
      decoration: new InputDecoration(
        fillColor: Colors.white,
        filled: true,
        hintStyle: TextStyle(
          fontFamily: 'Brandon',
        ),
        focusedBorder: new OutlineInputBorder(
            borderSide: new BorderSide(color: Hexcolor('#F48262'))),
        errorBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
        hintText: hintText,
        prefixIcon: prefiksIcon,
        enabledBorder: new OutlineInputBorder(
            borderSide: new BorderSide(color: Hexcolor('#F48262'))),
      ),
    ),
  );
}
