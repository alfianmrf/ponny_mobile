import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:ponny/common/constant.dart';
import 'package:ponny/model/App.dart';
import 'package:ponny/model/User.dart';
import 'package:ponny/screens/account_screen.dart';
import 'package:ponny/screens/metode_verifikasi_screen.dart';
import 'package:ponny/screens/pra_daftar.dart';
import 'package:ponny/screens/home_screen.dart';
import 'package:ponny/screens/login_otp.dart';
import 'package:keyboard_attachable/keyboard_attachable.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uiblock/uiblock.dart';
import 'package:ponny/util/globalUrl.dart';

class LupaPasswordScreen extends StatefulWidget {
  static const String id = "lupa_password_Screen";
  @override
  _LupaPasswordStateScreen createState() => _LupaPasswordStateScreen();
}

class _LupaPasswordStateScreen extends State<LupaPasswordScreen> {
  final scafollKey = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final myemail = TextEditingController();

  Future<bool> _reset() async {
    try {
      String email = myemail.value.text;
      final response = await http.post(passwordReset,headers: { HttpHeaders.contentTypeHeader: 'application/json'},body: json.encode( { "email" : email } ));
      final responseJson = json.decode(response.body);
      if(response.statusCode == 200){
        final snackBar = SnackBar(
          content: Text('Success, '+responseJson['message'],style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.green,
        );
        scafollKey.currentState.showSnackBar(snackBar);
      }else{
        final snackBar = SnackBar(
          content: Text(responseJson['message'],style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.redAccent,
        );
        scafollKey.currentState.showSnackBar(snackBar);
      }
    } catch (err) {
      print(err);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scafollKey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0.0,
        title: Text(
          'Atur ulang kata sandi',
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
            preferredSize: Size.fromHeight(1.0)
        ),
      ),
      resizeToAvoidBottomInset: false,
      backgroundColor: Hexcolor('#FCF8F0'),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 40.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(top: 25, bottom: 10),
                        child: Text(
                          'Masukkan email yang terdaftar. Tim Phoebe akan mengirimkan kode verifikasi untuk atur ulang kata sandi',
                          style: TextStyle(
                            fontFamily: 'Brandon',
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Text(
                        'Email',
                        style: TextStyle(
                          fontFamily: 'Brandon',
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 5, bottom: 40),
                        child: TextFormField(
                          controller: myemail,
                          cursorColor: Color(0xffF48262),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            isDense: true,
                            contentPadding: EdgeInsets.all(15),
                            labelStyle: TextStyle(color: Colors.black),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide: BorderSide(
                                color: Hexcolor('#F48262'),
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: BorderSide(
                                color: Hexcolor('#F48262'),
                                width: 1.0,
                              ),
                            ),
                          ),
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'Email tidak boleh kosong';
                            } else if (!value.contains('@')) {
                              return 'Email tidak valid';
                            }
                          },
                        ),
                      ),
                      Center(
                        child: ButtonTheme(
                          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 70),
                          child: FlatButton(
                            onPressed: (){
                              FocusScope.of(context).requestFocus(new FocusNode());
                              if(formKey.currentState.validate()){
                                UIBlock.block(context,customLoaderChild: LoadingWidget(context));
                                _reset().then((value) {
                                  UIBlock.unblock(context);
                                }).catchError((onError){
                                  UIBlock.unblock(context);
                                });
                              }
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) => MetodeVerifikasiScreen(),
                              //   ),
                              // );
                            },
                            color: Color(0xffF48262),
                            child: Text(
                              "Kirim",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontFamily: 'Brandon',
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: 1,
                                  color: Colors.white),
                            ),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
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
      ),
    );
  }
}
