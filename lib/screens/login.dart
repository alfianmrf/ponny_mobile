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
      appBar: AppBar(
        titleSpacing: 20.0,
        elevation: 0.0,
        automaticallyImplyLeading: false,
        title: Text(
          'Akun Saya',
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
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Container(
                          padding: EdgeInsets.only(right: 10),
                          child: ButtonTheme(
                            buttonColor: Hexcolor('#F48262'),
                            height: 35.0,
                            child: FlatButton(
                              onPressed: () {},
                              color: Hexcolor('#F48262'),
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
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          padding: EdgeInsets.only(left: 10),
                          child: ButtonTheme(
                            buttonColor: Hexcolor('#FCF8F0'),
                            height: 35.0,
                            child: FlatButton(
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
                              borderRadius: BorderRadius.circular(10.0),
                              side: BorderSide(color: Hexcolor('#F48262')),
                            ),
                          ),
                        ),
                      ),
                    ]),
              ),
              Container(
                margin: EdgeInsets.only(top: 40.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(left: 20.0, right: 20.0,),
                        child: TextFormField(
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
                      ),
                      Container(
                        height: 20.0,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 20.0, right: 20.0,),
                        child: TextFormField(
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
                                width: 1.0,
                              ),
                            ),
                          ),
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'Password tidak boleh kosong';
                            }
                          },
                        ),
                      ),
                      Container(
                        height: 45.0,
                      ),
                      ButtonTheme(
                        buttonColor: Hexcolor('#F48262'),
                        minWidth: 220.0,
                        height: 60.0,
                        child: FlatButton(
                          color: Hexcolor('#F48262'),
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
                          borderRadius: BorderRadius.circular(10.0),
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
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 20),
                        child: IntrinsicHeight(
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Container(
                                  alignment: Alignment.center,
                                  width: double.infinity,
                                  height: 1,
                                  color: Hexcolor('#F48262'),
                                  margin: EdgeInsets.symmetric(horizontal: 20),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Container(
                                  child: Text(
                                    'atau masuk dengan',
                                    style: TextStyle(
                                      fontFamily: 'Brandon',
                                      color: Hexcolor('#F48262'),
                                      fontSize: 16,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Container(
                                  alignment: Alignment.center,
                                  width: double.infinity,
                                  height: 1,
                                  color: Hexcolor('#F48262'),
                                  margin: EdgeInsets.symmetric(horizontal: 20),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 5),
                        child: Row(
                          children: [
                            Expanded(flex: 1, child: Container()),
                            Expanded(
                              flex: 3,
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Hexcolor('#F48262'),
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: IntrinsicHeight(
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            border: Border(
                                              right: BorderSide(
                                                width: 1,
                                                color: Hexcolor('#F48262'),
                                              ),
                                            ),
                                          ),
                                          child: IconButton(
                                            onPressed: () {},
                                            icon: Image.asset("assets/images/googleLogo.png"),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: FlatButton(
                                          onPressed: () {},
                                          child: SizedBox(
                                            width: double.infinity,
                                            child: Text(
                                              "GOOGLE",
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontFamily: 'Brandon',
                                                  fontWeight: FontWeight.w800,
                                                  letterSpacing: 1,
                                                  color: Hexcolor('#F48262')),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Expanded(flex: 1, child: Container()),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 5),
                        child: Row(
                          children: [
                            Expanded(flex: 1, child: Container()),
                            Expanded(
                              flex: 3,
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Hexcolor('#F48262'),
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: IntrinsicHeight(
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            border: Border(
                                              right: BorderSide(
                                                width: 1,
                                                color: Hexcolor('#F48262'),
                                              ),
                                            ),
                                          ),
                                          child: IconButton(
                                            onPressed: () {},
                                            icon: Image.asset("assets/images/facebookLogo.png"),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: FlatButton(
                                          onPressed: () {},
                                          child: SizedBox(
                                            width: double.infinity,
                                            child: Text(
                                              "FACEBOOK",
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontFamily: 'Brandon',
                                                  fontWeight: FontWeight.w800,
                                                  letterSpacing: 1,
                                                  color: Hexcolor('#F48262')),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Expanded(flex: 1, child: Container()),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 5),
                        child: Row(
                          children: [
                            Expanded(flex: 1, child: Container()),
                            Expanded(
                              flex: 3,
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Hexcolor('#F48262'),
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: IntrinsicHeight(
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            border: Border(
                                              right: BorderSide(
                                                width: 1,
                                                color: Hexcolor('#F48262'),
                                              ),
                                            ),
                                          ),
                                          child: IconButton(
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) => LoginOTP(),
                                                ),
                                              );
                                            },
                                            icon: Icon(
                                              Icons.phone_android,
                                              color: Hexcolor('#F48262'),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: FlatButton(
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => LoginOTP(),
                                              ),
                                            );
                                          },
                                          child: SizedBox(
                                            width: double.infinity,
                                            child: Text(
                                              "OTP / SMS",
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontFamily: 'Brandon',
                                                  fontWeight: FontWeight.w800,
                                                  letterSpacing: 1,
                                                  color: Hexcolor('#F48262')),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Expanded(flex: 1, child: Container()),
                          ],
                        ),
                      ),
                      Container(
                        height: 50,
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
