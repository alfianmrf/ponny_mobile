import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:ponny/common/constant.dart';
import 'package:ponny/screens/home_screen.dart';
import 'package:ponny/screens/login.dart';
import 'package:ponny/util/globalUrl.dart';
import 'package:uiblock/uiblock.dart';
import 'package:http/http.dart' as http;

class RegisterScreen extends StatefulWidget {
  static const String id = "register_Screen";
  @override
  _RegisterScreen createState() => _RegisterScreen();
}

class _RegisterScreen extends State<RegisterScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  DateTime date = DateTime.now();

  Future<Null> selectDate(BuildContext context) async {
    final DateTime selected = await showDatePicker(
        context: context,
        initialDate: this.date,
        firstDate: DateTime(1980),
        lastDate: DateTime.now());

    if (selected != null && selected != this.date) {
      setState(() {
        this.date = selected;
        TglLahir=DateFormat("d MMMM yyyy").format(selected);
      });
    }
  }

  final nama_depan = TextEditingController();
  final nama_belakang = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final konfirmasi_password = TextEditingController();
  final no_telepon = TextEditingController();
  String JenisKelamin;
  String TglLahir;

  void validateInput() {
    FormState form = this.formKey.currentState;
    ScaffoldState scaffold = this.scaffoldKey.currentState;

    if (form.validate() && JenisKelamin != null && TglLahir != null) {
      _fetchRegister();

    }else if(JenisKelamin == null || TglLahir == null){
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: Text("Jenis Kelamin dan Tanggal lahir harus diisi."),
            );
          });
    }
  }

  _fetchRegister() async {
      FocusScope.of(context).requestFocus(new FocusNode());
      UIBlock.block(context,customLoaderChild: LoadingWidget(context));
      var param ={
          "name":nama_depan.value.text,
          "last_name":nama_belakang.value.text,
          "email":email.value.text,
          "password": password.value.text,
          "phone":no_telepon.value.text,
          "gender":JenisKelamin,
          "tgl_lahir":DateFormat("y-M-d").format(date)
      };
      final res = await http.post(register,headers: { HttpHeaders.contentTypeHeader: 'application/json' },body: json.encode(param));
      UIBlock.unblock(context);
      if(res.statusCode == 201){
        final pesan = json.decode(res.body);
        showDialog(
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
        final snackBar = SnackBar(
          content: Text('Terjadi kesalahan pada serve!',style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.redAccent,
        );
        scaffoldKey.currentState.showSnackBar(snackBar);
      }



  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Hexcolor('#FCF8F0'),
      appBar: AppBar(
        titleSpacing: 0.0,
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            color: Color(0xffF48262),
          ),
        ),
        title: Text(
          'Daftar',
          style: TextStyle(
            fontSize: 24,
            fontFamily: 'Yeseva',
            color: Hexcolor('#F48262'),
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
        child: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(bottom: 5),
                          child: RichText(
                            text: TextSpan(
                              text: 'Nama Depan',
                              style: TextStyle(
                                fontFamily: 'Brandon',
                                color: Colors.black,
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
                        ),
                        TextFormField(
                          controller: nama_depan,
                          decoration: InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.all(10),
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
                              return 'Nama Depan tidak boleh kosong';
                            }
                          },
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 5, top: 10),
                          child: RichText(
                            text: TextSpan(
                              text: 'Nama Belakang',
                              style: TextStyle(
                                fontFamily: 'Brandon',
                                color: Colors.black,
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
                        ),
                        TextFormField(
                          controller: nama_belakang,
                          decoration: InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.all(10),
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
                              return 'Nama Belakang tidak boleh kosong';
                            }
                          },
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 5, top: 10),
                          child: RichText(
                            text: TextSpan(
                              text: 'Email',
                              style: TextStyle(
                                fontFamily: 'Brandon',
                                color: Colors.black,
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
                        ),
                        TextFormField(
                          controller: email,
                          decoration: InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.all(10),
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
                            } else if (!value.contains('@')) {
                              return 'Email tidak valid';
                            }
                          },
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 5, top: 10),
                          child: RichText(
                            text: TextSpan(
                              text: 'Password',
                              style: TextStyle(
                                fontFamily: 'Brandon',
                                color: Colors.black,
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
                        ),
                        TextFormField(
                          controller: password,
                          obscureText: true,
                          decoration: InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.all(10),
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
                              return 'Password tidak boleh kosong';
                            }
                            if (value.length<8) {
                              return 'Password minimal 8 karakter';
                            }
                          },
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 5, top: 10),
                          child: RichText(
                            text: TextSpan(
                              text: 'Konfirmasi Password',
                              style: TextStyle(
                                fontFamily: 'Brandon',
                                color: Colors.black,
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
                        ),
                        TextFormField(
                          controller: konfirmasi_password,
                          obscureText: true,
                          decoration: InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.all(10),
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
                              return 'Konfirmasi Password tidak boleh kosong';
                            }
                            if (value.length<8) {
                              return 'Password minimal 8 karakter';
                            }
                          },
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 5, top: 10),
                          child: RichText(
                            text: TextSpan(
                              text: 'Nomor Handphone',
                              style: TextStyle(
                                fontFamily: 'Brandon',
                                color: Colors.black,
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
                        ),
                        TextFormField(
                          controller: no_telepon,
                          decoration: InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.all(10),
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
                              return 'Nomor Telepon tidak boleh kosong';
                            }
                          },
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 5, top: 10),
                          child: RichText(
                            text: TextSpan(
                              text: 'Jenis Kelamin',
                              style: TextStyle(
                                fontFamily: 'Brandon',
                                color: Colors.black,
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
                        ),
                        Container(
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    padding: EdgeInsets.only(right: 10),
                                    child: ButtonTheme(
                                      buttonColor: Hexcolor('#FCF8F0'),
                                      child: FlatButton(
                                        padding: EdgeInsets.all(10),
                                        onPressed: () {
                                          setState(() {
                                            JenisKelamin="P";
                                          });
                                        },
                                        child: Text(
                                          "Perempuan",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontFamily: 'Brandon',
                                              color: JenisKelamin == "P" ? Colors.white : Hexcolor('#F48262')),
                                        ),

                                        color: JenisKelamin == "P" ? Hexcolor('#F48262') : Colors.white,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10.0),
                                        side:
                                        BorderSide(color: Hexcolor('#F48262')),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    padding: EdgeInsets.only(left: 10),
                                    child: ButtonTheme(
                                      buttonColor: Hexcolor('#FCF8F0'),
                                      child: FlatButton(
                                        padding: EdgeInsets.all(10),
                                        onPressed: () {
                                          setState(() {
                                            JenisKelamin="L";
                                          });
                                        },
                                        child: Text(
                                          "Laki-laki",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontFamily: 'Brandon',
                                              color: JenisKelamin == "L" ? Colors.white : Hexcolor('#F48262')),
                                        ),
                                        color: JenisKelamin == "L" ? Hexcolor('#F48262') : Colors.white,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10.0),
                                        side:
                                        BorderSide(color: Hexcolor('#F48262')),
                                      ),
                                    ),
                                  ),
                                ),
                              ]),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 5, top: 10),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Container(
                                  padding: EdgeInsets.only(right: 10),
                                  child: RichText(
                                    text: TextSpan(
                                      text: 'Tanggal Lahir',
                                      style: TextStyle(
                                        fontFamily: 'Brandon',
                                        color: Colors.black,
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
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Container(
                                  padding: EdgeInsets.only(left: 10),
                                  child: RichText(
                                    text: TextSpan(
                                      text: 'Kode Referal',
                                      style: TextStyle(
                                        fontFamily: 'Brandon',
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 3.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Expanded(
                                flex: 1,
                                child: Container(
                                  padding: EdgeInsets.only(right: 10),
                                  child: ButtonTheme(
                                    buttonColor: Hexcolor('#FCF8F0'),
                                    child: FlatButton(
                                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                      padding: EdgeInsets.all(10),
                                      color: Colors.white,
                                      onPressed: () {
                                        selectDate(context);
                                      },
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            TglLahir != null ? TglLahir :"Pilih Tanggal Lahir",
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontFamily: 'Brandon',
                                                color: Colors.black26),
                                          ),
                                          Icon(
                                            Icons.expand_more_rounded,
                                            color: Hexcolor('#F48262'),
                                            size: 14,
                                          ),
                                        ],
                                      ),
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      side: BorderSide(color: Hexcolor('#F48262')),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Container(
                                  padding: EdgeInsets.only(left: 10),
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      isDense: true,
                                      contentPadding: EdgeInsets.all(10),
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
                                    keyboardType: TextInputType.text,
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
                Container(
                  height: 30,
                ),
                Container(
                  child: ButtonTheme(
                    buttonColor: Hexcolor('#F48262'),
                    minWidth: 250.0,
                    height: 45.0,
                    child: FlatButton(
                      color: Hexcolor('#F48262'),
                      onPressed: validateInput,
                      child: Text(
                        "MASUK",
                        style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'Brandon',
                            fontWeight: FontWeight.w800,
                            letterSpacing: 1,
                            color: Colors.white),
                      ),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                Container(
                  height: 50,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
