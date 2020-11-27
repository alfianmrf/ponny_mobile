import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:ponny/common/constant.dart';
import 'package:ponny/model/App.dart';
import 'package:ponny/model/User.dart';
import 'package:ponny/screens/home_screen.dart';
import 'package:ponny/screens/account_screen.dart';
import 'package:ponny/screens/ubah_password_screen.dart';
import 'package:ponny/util/globalUrl.dart';
import 'package:ponny/widgets/PonnyBottomNavbar.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:uiblock/uiblock.dart';

class UbahPasswordScreen extends StatefulWidget {
  static const String id = "ubah_password_Screen";

  @override
  _UbahPasswordStateScreen createState() => _UbahPasswordStateScreen();
}

class _UbahPasswordStateScreen extends State<UbahPasswordScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final passwordLama = TextEditingController();
  final password = TextEditingController();
  final konfirmasi_password = TextEditingController();

  Future SavePassword() async {
    FormState form = this.formKey.currentState;
    if(form.validate()){
      final token =Provider.of<AppModel>(context).auth.access_token;
      FocusScope.of(context).requestFocus(new FocusNode());
      UIBlock.block(context,customLoaderChild: LoadingWidget(context));
      var param ={
        "old_password":passwordLama.value.text,
        "password":password.value.text,
        "confirm_password":konfirmasi_password.value.text,
      };
      print(param);
      http.post(changePassword,headers: { HttpHeaders.contentTypeHeader: 'application/json', HttpHeaders.authorizationHeader: "Bearer $token"},body: json.encode(param)).then((value){
        UIBlock.unblock(context);
        if(value.statusCode == 200){
          final snackBar = SnackBar(
            content: Text('Sukses sandi baru berhasil disimpan.',style: TextStyle(color: Colors.white)),
            backgroundColor: Colors.green,
          );
          scaffoldKey.currentState.showSnackBar(snackBar);
        }else{
          final snackBar = SnackBar(
            content: Text('Sandi lama anda salah!',style: TextStyle(color: Colors.white)),
            backgroundColor: Colors.redAccent,
          );
          scaffoldKey.currentState.showSnackBar(snackBar);
        }
      }).catchError((onError){
        UIBlock.unblock(context);
        scaffoldKey.currentState.showSnackBar(snackBarError);

      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      resizeToAvoidBottomInset: false,
      backgroundColor: Hexcolor('#FCF8F0'),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 70,
            ),
            Container(
              padding: EdgeInsets.only(left: 15, bottom: 15),
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 14),
                    child: GestureDetector(
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: Color(0xffF48262),
                        size: 26,
                      ),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  Container(
                    child: Text(
                      "Ubah Sandi",
                      style: TextStyle(
                        fontSize: 24,
                        fontFamily: "Yeseva",
                        fontWeight: FontWeight.w500,
                        color: Color(0xffF48262),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 1,
              color: Color(0xffF3C1B5),
            ),
            Container(
              margin: EdgeInsets.only(left: 20, top: 20, right: 20),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Color(0xffF48262),
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(7),
              ),
              padding: EdgeInsets.only(
                right: 20,
                left: 20,
                top: 15,
                bottom: 15,
              ),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(bottom: 8),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Color(0xffF48262),
                            width: 1,
                          ),
                        ),
                      ),
                      child: TextFormField(
                        controller: passwordLama,
                        obscureText: true,
                        style: TextStyle(
                          fontFamily: "Brandon",
                          fontSize: 17,
                          fontWeight: FontWeight.w300,
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Sandi Lama',
                          isDense: true,
                        ),
                        maxLines: 1,
                        minLines: 1,
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'Sandi lama tidak boleh kosong';
                          }
                        }
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(bottom: 8),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Color(0xffF48262),
                            width: 1,
                          ),
                        ),
                      ),
                      child: TextFormField(
                        controller: password,
                        obscureText: true,
                        style: TextStyle(
                          fontFamily: "Brandon",
                          fontSize: 17,
                          fontWeight: FontWeight.w300,
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Sandi Baru',
                          isDense: true,
                        ),
                        maxLines: 1,
                        minLines: 1,
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'Sandi baru tidak boleh kosong';
                          }
                        }
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(bottom: 8),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Color(0xffF48262),
                            width: 1,
                          ),
                        ),
                      ),
                      child: TextFormField(
                        controller: konfirmasi_password,
                        obscureText: true,
                        style: TextStyle(
                          fontFamily: "Brandon",
                          fontSize: 17,
                          fontWeight: FontWeight.w300,
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Konfirmasi Sandi Baru',
                          isDense: true,
                        ),
                        maxLines: 1,
                        minLines: 1,
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'Konfirmasi sandi lama tidak boleh kosong';
                          }else if(value != password.value.text){
                            return 'Sandi baru dan konfirmasi sandi lama tidak cocok';
                          }
                        }
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 15, bottom: 0),
                      child: GestureDetector(
                        onTap: () {
                          SavePassword();
                        },
                        child: Text(
                          "Simpan",
                          style: TextStyle(
                            fontFamily: "Brandon",
                            color: Color(0xffF48262),
                            fontSize: 17,
                          ),
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
      bottomNavigationBar: new PonnyBottomNavbar(selectedIndex: 4),
    );
  }
}
