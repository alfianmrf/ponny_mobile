import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:ponny/common/constant.dart';
import 'package:ponny/model/App.dart';
import 'package:ponny/model/User.dart';
import 'package:ponny/screens/account_screen.dart';
import 'package:ponny/screens/lupa_password_screen.dart';
import 'package:ponny/screens/pra_daftar.dart';
import 'package:ponny/screens/home_screen.dart';
import 'package:ponny/screens/login_otp.dart';
import 'package:keyboard_attachable/keyboard_attachable.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uiblock/uiblock.dart';
import 'package:ponny/util/globalUrl.dart';

class LoginScreen extends StatefulWidget {
  static const String id = "login_Screen";
  @override
  _LoginStateScreen createState() => _LoginStateScreen();
}

class _LoginStateScreen extends State<LoginScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  bool _validate = false;

  final myemail = TextEditingController();
  final mypass = TextEditingController();

  void validateInput() {
    FormState form = this.formKey.currentState;
    ScaffoldState scaffold = this.scaffoldKey.currentState;

    if (form.validate()) {
      _fetchLogin();
    }
  }

  _fetchLogin() async {
    FocusScope.of(context).requestFocus(new FocusNode());
    if (myemail.text.isEmpty || mypass.text.isEmpty) {
      setState(() {
        _validate = false;
      });
    }else{
      UIBlock.block(context,customLoaderChild: LoadingWidget(context));
      var param ={
        "email":myemail.text,
        "password":mypass.text
      };

      Provider.of<AppModel>(context).setAuth(param).then((value){
        UIBlock.unblock(context);
        if(value){
          Navigator.pushReplacement(context,new MaterialPageRoute(
            builder: (BuildContext context) =>  new AccountScreen(),
          ));
        }else{
          final snackBar = SnackBar(
            content: Text('Email atau password salah!',style: TextStyle(color: Colors.white)),
            backgroundColor: Colors.redAccent,
          );
          scaffoldKey.currentState.showSnackBar(snackBar);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomPadding: false,
      resizeToAvoidBottomInset: false,
      key: scaffoldKey,
      backgroundColor: Hexcolor('#FCF8F0'),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                height: 70.0,
              ),
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(left: 20.0),
                child: Text(
                  'Akun Saya',
                  style: TextStyle(
                      fontSize: 30,
                      fontFamily: 'Yeseva',
                      color: Hexcolor('#F48262'),
                      fontWeight: FontWeight.w500,
                      letterSpacing: 1),
                ),
              ),
              Container(
                color: Hexcolor('#F48262'),
                margin: EdgeInsets.only(top: 20),
                height: 2,
              ),
              Container(
                margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      ButtonTheme(
                        buttonColor: Hexcolor('#F48262'),
                        minWidth: 180.0,
                        height: 45.0,
                        child: RaisedButton(
                          onPressed: () {},
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
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                      ButtonTheme(
                        buttonColor: Hexcolor('#FCF8F0'),
                        minWidth: 180.0,
                        height: 45.0,
                        child: RaisedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PraDaftarScreen()),
                            );
                          },
                          child: Text(
                            "DAFTAR",
                            style: TextStyle(
                                fontSize: 18,
                                fontFamily: 'Brandon',
                                fontWeight: FontWeight.w800,
                                letterSpacing: 1,
                                color: Hexcolor('#F48262')),
                          ),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          side: BorderSide(color: Hexcolor('#F48262')),
                        ),
                      ),
                    ]),
              ),
              Container(
                margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 40.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        controller: myemail,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Email',
                          labelText: 'Email:',
                          labelStyle: TextStyle(color: Colors.black),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide(
                              color: Hexcolor('#F48262'),
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide(
                              color: Hexcolor('#F48262'),
                              width: 2.0,
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
                      Container(
                        height: 20.0,
                      ),
                      TextFormField(
                        controller: mypass,
                        obscureText: true,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Password',
                          labelText: 'Password :',
                          labelStyle: TextStyle(color: Colors.black),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide(
                              color: Hexcolor('#F48262'),
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide(
                              color: Hexcolor('#F48262'),
                              width: 2.0,
                            ),
                          ),
                        ),
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'Password tidak boleh kosong';
                          }
                        },
                      ),
                      Container(
                        height: 45.0,
                      ),
                      ButtonTheme(
                        buttonColor: Hexcolor('#F48262'),
                        minWidth: 220.0,
                        height: 60.0,
                        child: RaisedButton(
                          onPressed: validateInput,
                          // onPressed: () {
                          //   return showDialog(
                          //       context: context,
                          //       builder: (BuildContext context) {
                          //         return AlertDialog(
                          //           content: Text("Anda memasukkan email " +
                          //               myemail.text +
                          //               " dan password " +
                          //               mypass.text),
                          //         );
                          //       });
                          // },
                          child: Text(
                            "MASUK",
                            style: TextStyle(
                                fontSize: 22,
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
                      Container(
                        height: 10,
                      ),
                      ButtonTheme(
                        buttonColor: Hexcolor('#444444'),
                        minWidth: 220.0,
                        height: 60.0,
                        child: RaisedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginOTP(),
                              ),
                            );
                          },
                          child: Text(
                            "Login with Phone Number",
                            style: TextStyle(
                                fontSize: 14,
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
                      Container(
                        margin: EdgeInsets.only(top: 10.0),
                        child: GestureDetector(
                          onTap: (){
                            Navigator.push(context, new MaterialPageRoute(
                              builder: (BuildContext context) => new LupaPasswordScreen(),
                            ));
                          },
                          child: Text(
                            'Lupa Password ?',
                            style: TextStyle(
                                fontFamily: 'Brandon',
                                fontWeight: FontWeight.w300,
                                color: Colors.black,
                                decoration: TextDecoration.underline),
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
