import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:ponny/common/constant.dart';
import 'package:ponny/model/App.dart';
import 'package:ponny/screens/Phone_OTP_screen.dart';
import 'package:ponny/screens/RegisterOtp.dart';
import 'package:ponny/screens/Syarat_Ketentuan_screen.dart';
import 'package:ponny/screens/WebView_screen.dart';
import 'package:ponny/screens/home_screen.dart';
import 'package:provider/provider.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:uiblock/uiblock.dart';
import 'package:flutter/services.dart';

import 'account_screen.dart';

class LoginOTP extends StatefulWidget {
  static const String id = "login_otp";
  final bool login;

  LoginOTP(this.login);

  @override
  _LoginOTPScreen createState() => _LoginOTPScreen();
}

class _LoginOTPScreen extends State<LoginOTP> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<ScaffoldState> scaffoldKey2 = GlobalKey<ScaffoldState>();
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  bool _validate = false;

  final phoneCode = TextEditingController();
  final phoneNumber = TextEditingController();
  String code;
  String VerifiCode;
  bool invalidotp =false;
  String pesan;


  void validateInput() {
    FormState form = this.formKey.currentState;
    ScaffoldState scaffold = this.scaffoldKey.currentState;

    // if (form.validate()) {
    //   _fetchLogin();
    // }
  }

  void showInputCode(String verificationId, int resendToken){
    showMaterialModalBottomSheet(
      context: context,
      useRootNavigator: true,
      builder: (context, scrollController) => Container(
        child:SafeArea(
          child: Scaffold(
            key: scaffoldKey2,
            resizeToAvoidBottomInset: false,
            backgroundColor: Hexcolor('#FCF8F0'),
            body: Container(
              width: double.infinity,
              height: double.infinity,
              margin: EdgeInsets.symmetric(vertical: 40, horizontal: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "DAFTAR SEBAGAI ANGGOTA PHOEBE'S SQUAD",
                        style: TextStyle(
                          fontSize: 22,
                          fontFamily: 'Brandon',
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1,
                        ),
                      ),
                      Text(
                        "Masukkan alamat email kamu untuk masuk atau mendaftar",
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'Brandon',
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1,
                        ),
                      ),
                      Container(height: 20),
                      Text(
                        "Nomor Telepon",
                        style: TextStyle(
                          fontSize: 15,
                          fontFamily: 'Brandon',
                          letterSpacing: 1,
                        ),
                      ),
                      Container(height: 20),
                      Text(
                        "+62"+phoneNumber.value.text,
                        style: TextStyle(
                          fontSize: 15,
                          fontFamily: 'Brandon',
                          letterSpacing: 1,
                        ),
                      ),
                      Container(height: 20),
                      Container(
                        height: 30,
                        width: double.infinity,
                        child: PinFieldAutoFill(
                          controller: phoneCode,
                          codeLength: 6,

                          onCodeSubmitted: ( String a){
                            sendOtp();
                          },
                        ),
                      ),
                      if(invalidotp)
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 5),
                        child: Text(pesan,
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.red,
                        fontFamily: 'Brandon',
                        letterSpacing: 1,
                      ),
                      ),),
                      Container(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: (){
                              sendOtp();
                            },
                            child: Text(
                              "Kirim ulang kode",
                              style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  fontSize: 15,
                                  fontFamily: 'Brandon',
                                  letterSpacing: 1,
                                  color: Colors.grey),
                            ),
                          ),
                          ButtonTheme(
                            buttonColor: Hexcolor('#F48262'),
                            child: RaisedButton(
                              onPressed: () async {
                                if(phoneCode.value.text.length == 6){
                                  UIBlock.block(context,customLoaderChild: LoadingWidget(context));
                                  PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: phoneCode.value.text);
                                  FirebaseAuth.instance.signInWithCredential(phoneAuthCredential).then((crediatial){
                                    if(crediatial !=null){
                                      var param ={
                                        "uid":crediatial.user.uid,
                                        "phone":crediatial.user.phoneNumber
                                      };
                                      Provider.of<AppModel>(context).setAuthOtp(param).then((value){
                                        UIBlock.unblock(context);
                                        if(value!= null){
                                          if(value.name == value.phone){
                                            Navigator.pushReplacement(context,new MaterialPageRoute(
                                              builder: (BuildContext context) =>  new RegisterOtpScreen(user: value,),
                                            ));
                                          }else{
                                            Navigator.pushReplacement(context,new MaterialPageRoute(
                                              builder: (BuildContext context) =>  new HomeScreen(),
                                            ));
                                          }

                                        }else{
                                          setState(() {
                                            pesan = 'Terjadi kesalahan pada server!';
                                            invalidotp = true;
                                          });
                                        }

                                      }).catchError((onError){
                                        UIBlock.unblock(context);
                                        setState(() {
                                          pesan = 'Terjadi kesalahan pada server atau kode yang anda masukan salah!';
                                          invalidotp = true;
                                        });
                                      });
                                    }else{
                                      UIBlock.unblock(context);
                                      setState(() {
                                        pesan = 'Terjadi kesalahan pada server atau kode yang anda masukan salah!';
                                        invalidotp = true;
                                      });
                                    }

                                  }).catchError((onError){
                                    UIBlock.unblock(context);
                                    setState(() {
                                      pesan = 'Terjadi kesalahan pada server atau kode yang anda masukan salah!';
                                      invalidotp = true;
                                    });
                                  });
                                }
                              },
                              child: Text(
                                "LANJUT",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: 'Brandon',
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 1,
                                    color: Colors.white),
                              ),
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              side: BorderSide(color: Hexcolor('#F48262')),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Row(
                          children: [
                            Icon(Icons.arrow_back_ios,color: Hexcolor('#F48262')),
                            Text(
                              "Kembali",
                              style: TextStyle(
                                fontSize: 18,
                                fontFamily: 'Brandon',
                                letterSpacing: 1,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 20,
                      ),
                      Text(
                        "Dengan melakukan pendaftaran kamu telah menyetujui",
                        style: TextStyle(
                            fontSize: 11,
                            fontFamily: 'Brandon',
                            fontWeight: FontWeight.w800,
                            letterSpacing: 1,
                            color: Colors.grey),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => WebViewScreen(titile: "Kebijakan Privasi",url: "https://www.ponnybeaute.co.id/kebijakan-privasi",)));
                            },
                            child: Text(
                              "Kebijakan Privasi ",
                              style: TextStyle(
                                  fontSize: 11,
                                  fontFamily: 'Brandon',
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: 1,
                                  color: Colors.blue),
                            ),
                          ),
                          Text(
                            "dan ",
                            style: TextStyle(
                                fontSize: 11,
                                fontFamily: 'Brandon',
                                fontWeight: FontWeight.w800,
                                letterSpacing: 1,
                                color: Colors.grey),
                          ),
                          InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => SyaratKetentuanScreen()));
                            },
                            child: Text(
                              "Syarat dan Ketentuan",
                              style: TextStyle(
                                  fontSize: 11,
                                  fontFamily: 'Brandon',
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: 1,
                                  color: Colors.blue),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );

  }

  Future<void> sendOtp() async {
    // FocusScope.of(context).requestFocus(new FocusNode());

    FormState form = this.formKey.currentState;
    if(form.validate()){
      UIBlock.block(context,customLoaderChild: LoadingWidget(context));
      var phone = "+62"+phoneNumber.value.text;
      print(phone);
      try{
        await FirebaseAuth.instance.verifyPhoneNumber(
          phoneNumber: phone,
          timeout: Duration(minutes: 2),
          verificationCompleted: (PhoneAuthCredential credential) {
            print(credential.smsCode);
          },
          verificationFailed: (FirebaseAuthException e) {
            UIBlock.unblock(context);
            final snackBar = SnackBar(
              content: Text(e.message,style: TextStyle(color: Colors.white)),
              backgroundColor: Colors.redAccent,
            );
            scaffoldKey.currentState.showSnackBar(snackBar);
            print(e.message);
          },
          codeSent: (String verificationId, int resendToken) {
            UIBlock.unblock(context);
            showInputCode(verificationId,resendToken);
          },
          codeAutoRetrievalTimeout: (String verificationId) {
            UIBlock.unblock(context);
            print('timeout');
          },
        );
      }catch(e){
        UIBlock.unblock(context);
        print(e);
        scaffoldKey.currentState.showSnackBar(snackBarError);
      }

    }
  }


  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context,snapshot){
        if(snapshot.connectionState == ConnectionState.waiting){
          return Center(
            child: LoadingWidget(context),
          );
        }else{
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
                      height: 100.0,
                    ),
                    Container(
                      color: Hexcolor('#F48262'),
                      margin: EdgeInsets.only(top: 20),
                      height: 2,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 35, right: 35, top: 70),
                      padding: EdgeInsets.only(top: 20, bottom: 20),
                      child: Column(
                        children: [
                          Container(
                            child: Row(
                              children: [
                                Flexible(
                                  child: Text(
                                    "SELAMAT DATANG DI PONNY BEAUTE!",
                                    style: TextStyle(
                                      fontFamily: "Brandon",
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                              top: 5,
                              bottom: 15,
                            ),
                            child: Row(
                              children: [
                                Flexible(
                                  child: Text(
                                    "Masukkan nomor telepon kamu untuk masuk",
                                    style: TextStyle(
                                      fontFamily: "Brandon",
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Form(
                            key: formKey,
                            child:Container(
                              // color: Colors.white,
                              child: Row(
                                children: [
                                  Container(
                                    color: Colors.white,
                                    width: 50,
                                    child: TextFormField(
                                      textAlign: TextAlign.center,
                                      readOnly: true,
                                      initialValue: "+62",
                                      style: TextStyle(
                                        fontFamily: "Brandon",
                                        fontSize: 15,
                                        fontWeight: FontWeight.w300,
                                      ),
                                      decoration: InputDecoration(
                                        hintText: 'Nomor Telepon ?',
                                        contentPadding: const EdgeInsets.all(10.0),
                                        isDense: true,
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                          BorderRadius.all(Radius.circular(3.0)),
                                          borderSide:
                                          BorderSide(color: Hexcolor('#F48262')),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(7.0),
                                            bottomLeft: Radius.circular(7.0),
                                          ),
                                          borderSide:
                                          BorderSide(color: Hexcolor('#F48262')),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width:
                                    MediaQuery.of(context).size.width - (70 + 50),
                                    color: Colors.white,
                                    child: TextFormField(
                                      // initialValue: " 8123456910",
                                      controller: phoneNumber,
                                      style: TextStyle(
                                        fontFamily: "Brandon",
                                        fontSize: 15,
                                        fontWeight: FontWeight.w300,
                                      ),
                                      decoration: InputDecoration(
                                        hintText: 'Nomor Handphone',
                                        contentPadding: const EdgeInsets.all(10.0),
                                        isDense: true,
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                          BorderRadius.all(Radius.circular(3.0)),
                                          borderSide:
                                          BorderSide(color: Hexcolor('#F48262')),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(7.0),
                                            bottomRight: Radius.circular(7.0),
                                          ),
                                          borderSide:
                                          BorderSide(color: Hexcolor('#F48262')),
                                        ),
                                      ),
                                      maxLines: 1,
                                      minLines: 1,
                                      keyboardType: TextInputType.phone,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.digitsOnly,
                                      ],
                                      validator: (value){
                                        if(value.startsWith("0")){
                                          return "Nomor awal tidak boleh 0.";
                                        }else if(value.isEmpty){
                                          return "Nomor Handphone tidak boleh kosong";
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          // InkWell(
                          //   onTap: (){
                          //       showInputCode("sdsd", 0);
                          //   },
                          //   child: Container(
                          //     child: Text("OK"),
                          //   ),
                          // ),
                          Container(
                            decoration: BoxDecoration(
                              color: Hexcolor('#F48262'),
                              borderRadius: BorderRadius.circular(7.0),
                            ),
                            margin: EdgeInsets.only(top: 40),
                            width: MediaQuery.of(context).size.width - 70,
                            child: FlatButton(
                              onPressed: () async {
                                sendOtp();

                              },
                              child: Text(
                                widget.login?"MASUK":"DAFTAR",
                                style: TextStyle(
                                  fontFamily: "Brandon",
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
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
          );
        }
      },
    );

  }
}
