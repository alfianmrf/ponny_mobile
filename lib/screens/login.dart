import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_twitter_login/flutter_twitter_login.dart';
import 'package:google_sign_in/google_sign_in.dart' as google;
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
import 'package:ponny/util/AppId.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uiblock/uiblock.dart';
import 'package:ponny/util/globalUrl.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart' as FirebasePakage;



class LoginScreen extends StatefulWidget {
  static const String id = "login_Screen";
  @override
  _LoginStateScreen createState() => _LoginStateScreen();
}

class _LoginStateScreen extends State<LoginScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  bool _validate = false;
  final FirebasePakage.FirebaseAuth _auth = FirebasePakage.FirebaseAuth.instance;
  final google.GoogleSignIn googleSignIn = google.GoogleSignIn();

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
        if(value.status == 200){
          Navigator.pushReplacement(context,new MaterialPageRoute(
            builder: (BuildContext context) =>  new AccountScreen(),
          ));
        }else if(value.status == 401){
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  content: Text(value.message),
                  actions:<Widget> [
                    FlatButton (
                      child: Text('Kirim Ulang verifikasi'),
                      onPressed: () {
                        UIBlock.block(context,customLoaderChild: LoadingWidget(context));
                        http.post(kirimUlangVerifikasi,headers: { HttpHeaders.contentTypeHeader: 'application/json' },body: json.encode({ "email":myemail.text })).then((value){
                          UIBlock.unblock(context);
                          if(value.statusCode == 200){
                            UIBlock.unblock(context);
                            // Navigator.pop(context);
                            scaffoldKey.currentState.showSnackBar(snackBarSuccess);
                          }
                        }).catchError((onError){
                          UIBlock.unblock(context);
                          scaffoldKey.currentState.showSnackBar(snackBarError);
                        });
                      },
                    ),
                  ],
                );
              });
        }else{
          final snackBar = SnackBar(
            content: Text(value.message,style: TextStyle(color: Colors.white)),
            backgroundColor: Colors.redAccent,
          );
          scaffoldKey.currentState.showSnackBar(snackBar);
        }
      }).catchError((onError){
        scaffoldKey.currentState.showSnackBar(snackBarError);
      });
    }
  }

  Future<bool> signInWithGoogle() async {
    await Firebase.initializeApp();
    bool result =false;

    final google.GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final google.GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;

    final FirebasePakage.AuthCredential credential = FirebasePakage.GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    final FirebasePakage.UserCredential authResult = await _auth.signInWithCredential(credential);
    final FirebasePakage.User user = authResult.user;

    if (user != null ) {
      var param = {
        "email" : user.email,
        "name":user.displayName,
        "provider_id":user.uid
      };
      result = await Provider.of<AppModel>(context).setAuthSocial(param);

      print('signInWithGoogle succeeded: $user');

      return result;
    }
    return result;
  }

  Future<bool> signInWithTwitter() async {
    // Create a TwitterLogin instance
    bool result =false;
    final TwitterLogin twitterLogin = new TwitterLogin(
      consumerKey: TWITTER_CLIENT_ID,
      consumerSecret: TWITTER_CLIENT_SECRET,
    );
    final twitterStatus =await twitterLogin.isSessionActive;
    if(twitterStatus) await twitterLogin.logOut();
    // Trigger the sign-in flow
    final TwitterLoginResult loginResult = await twitterLogin.authorize();
    print(loginResult.errorMessage);

    // Get the Logged In session
    final TwitterSession twitterSession = loginResult.session;

    // Create a credential from the access token
    final AuthCredential twitterAuthCredential =
    TwitterAuthProvider.credential(accessToken: twitterSession.token, secret: twitterSession.secret);

    // Once signed in, return the UserCredential
     final users = await FirebaseAuth.instance.signInWithCredential(twitterAuthCredential);
     var user = users.user.providerData[0];

    print('$user');
    if (user != null ) {
      var param = {
        "email" : user.email,
        "name":user.displayName,
        "provider_id":user.uid
      };
      print(param);
      result = await Provider.of<AppModel>(context).setAuthSocial(param);

      print('signInWithGoogle succeeded: $user');

      return result;
    }


    return result;
  }


  Future<void> signOutGoogle() async {
    await googleSignIn.signOut();

    print("User Signed Out");
  }

  Future<void> signInWithFacebook() async {
    //Trigger the sign-in flow
    final  result = await FacebookAuth.instance.login();

    // Create a credential from the access token
    final FacebookAuthCredential facebookAuthCredential =
    FacebookAuthProvider.credential(result.token);
    final Facebookuser = await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
    print(Facebookuser.user.uid);
    // Once signed in, return the UserCredential
    // return Facebookuser;
    // final FacebookLoginResult result = await facebookSignIn.logIn(['email']);
    //
    // switch (result.status) {
    //   case FacebookLoginStatus.loggedIn:
    //     final FacebookAccessToken accessToken = result.accessToken;
    //     print('''
    //      Logged in!
    //
    //      Token: ${accessToken.token}
    //      User id: ${accessToken.userId}
    //      Expires: ${accessToken.expires}
    //      Permissions: ${accessToken.permissions}
    //      Declined permissions: ${accessToken.declinedPermissions}
    //      ''');
    //     break;
    //   case FacebookLoginStatus.cancelledByUser:
    //     print('Login cancelled by the user.');
    //     break;
    //   case FacebookLoginStatus.error:
    //     print('Something went wrong with the login process.\n'
    //         'Here\'s the error Facebook gave us: ${result.errorMessage}');
    //     break;
    // }
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
                                          onPressed: ()  {
                                            UIBlock.block(context,customLoaderChild: LoadingWidgetFadingCircle(context));
                                            signInWithGoogle().then((value) {
                                              UIBlock.unblock(context);
                                              if(value){
                                                Navigator.pushNamedAndRemoveUntil(
                                                    context,
                                                    HomeScreen.id,(_) => false
                                                );
                                              }else{
                                                scaffoldKey.currentState.showSnackBar(snackBarError);
                                              }
                                            }).catchError((onError){
                                              UIBlock.unblock(context);
                                              scaffoldKey.currentState.showSnackBar(snackBarError);
                                            });

                                          },
                                          child: SizedBox(
                                            width: double.infinity,
                                            child: Text(
                                              "GOOGLE",
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontFamily: 'Brandon',
                                                  fontWeight: FontWeight.w800,
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
                      /*Container(
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
                                          onPressed: () async {
                                            // final  result = await FacebookAuth.instance.login();
                                            FacebookAuth.instance.login().then((value){
                                              print(value);

                                            }).catchError((onError){
                                              print(onError);
                                            });

                                            // Create a credential from the access token
                                            // final FacebookAuthCredential facebookAuthCredential =
                                            // FacebookAuthProvider.credential(result.token);
                                            // final Facebookuser = await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
                                            // print(Facebookuser.user.uid);
                                            // print("facebook");
                                            // UIBlock.block(context,customLoaderChild: LoadingWidgetFadingCircle(context));
                                            // signInWithFacebook().then((value) {
                                            //   UIBlock.unblock(context);
                                            // }).catchError((onError){
                                            //   UIBlock.unblock(context);
                                            // });
                                          },
                                          child: SizedBox(
                                            width: double.infinity,
                                            child: Text(
                                              "FACEBOOK",
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontFamily: 'Brandon',
                                                  fontWeight: FontWeight.w800,
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
                      ),*/
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
                                            icon: Image.asset("assets/images/twitter.png"),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: FlatButton(
                                          onPressed: () {
                                            UIBlock.block(context,customLoaderChild: LoadingWidgetFadingCircle(context));
                                            signInWithTwitter().then((value) {
                                              UIBlock.unblock(context);
                                              if(value){
                                                Navigator.pushNamedAndRemoveUntil(
                                                    context,
                                                    HomeScreen.id,(_) => false
                                                );
                                              }else{
                                                scaffoldKey.currentState.showSnackBar(snackBarError);
                                              }
                                            }).catchError((onError){
                                              UIBlock.unblock(context);
                                              scaffoldKey.currentState.showSnackBar(snackBarError);
                                            });

                                          },
                                          child: SizedBox(
                                            width: double.infinity,
                                            child: Text(
                                              "TWITTER",
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontFamily: 'Brandon',
                                                  fontWeight: FontWeight.w800,
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

