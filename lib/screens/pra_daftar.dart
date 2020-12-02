import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_twitter_login/flutter_twitter_login.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:ponny/common/constant.dart';
import 'package:ponny/model/App.dart';
import 'package:ponny/screens/home_screen.dart';
import 'package:ponny/screens/login.dart';
import 'package:ponny/screens/login_otp.dart';
import 'package:ponny/screens/register.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart' as FirebasePakage;
import 'package:google_sign_in/google_sign_in.dart' as google;
import 'package:ponny/util/AppId.dart';
import 'package:provider/provider.dart';
import 'package:uiblock/uiblock.dart';

class PraDaftarScreen extends StatefulWidget {
  static const String id = "pradaftar_Screen";
  @override
  _PraDaftarScreen createState() => _PraDaftarScreen();
}

class _PraDaftarScreen extends State<PraDaftarScreen> {
  final FirebasePakage.FirebaseAuth _auth = FirebasePakage.FirebaseAuth.instance;
  final google.GoogleSignIn googleSignIn = google.GoogleSignIn();
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: SingleChildScrollView(
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
                          buttonColor: Hexcolor('#FCF8F0'),
                          height: 35.0,
                          child: FlatButton(
                            color: Hexcolor('#FCF8F0'),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginScreen()),
                              );
                            },
                            child: Text(
                              "MASUK",
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
                    Expanded(
                      flex: 1,
                      child: Container(
                        padding: EdgeInsets.only(left: 10),
                        child: ButtonTheme(
                          buttonColor: Hexcolor('#F48262'),
                          minWidth: 180.0,
                          height: 35.0,
                          child: FlatButton(
                            color: Hexcolor('#F48262'),
                            onPressed: () {},
                            child: Text(
                              "DAFTAR",
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
                  ]),
            ),
            Container(
              height: 50,
            ),
            Container(
              decoration: new BoxDecoration(
                color: Hexcolor('#F48262'),
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 2.0),
              height: 140,
              alignment: Alignment.center,
              // color: Hexcolor('#F48262'),
              width: 220.0,
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    alignment: Alignment.center,
                    child: Text(
                      "HAPPY",
                      style: TextStyle(
                        fontSize: 45,
                        fontFamily: "Brandon",
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 0),
                    alignment: Alignment.center,
                    child: Text(
                      "SKIN",
                      style: TextStyle(
                        fontSize: 25,
                        fontFamily: "Yeseva",
                        fontWeight: FontWeight.w300,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 30,
            ),
            Container(
              alignment: Alignment.center,
              child: Column(
                children: <Widget>[
                  Text(
                    "Cus, daftarkan dirimu",
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: "Yeseva",
                    ),
                  ),
                  Container(
                    height: 8,
                  ),
                  Text(
                    "HAPPY SKIN REWARD",
                    style: TextStyle(fontSize: 22, fontFamily: 'Yeseva'),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              alignment: Alignment.center,
              child: Column(
                children: <Widget>[
                  Text(
                    "BEBAS pilih sample sesukamu. GRATIS hadiah bulanan.",
                    style: TextStyle(fontFamily: 'Brandon'),
                  ),
                  Text("DISKON gede-gedean. Temukan penawaran lainnya.",
                      style: TextStyle(fontFamily: 'Brandon')),
                ],
              ),
            ),
            Container(
              height: 70,
            ),
            Container(
              child: ButtonTheme(
                buttonColor: Hexcolor('#F48262'),
                padding: EdgeInsets.symmetric(horizontal: 75, vertical: 10),
                child: FlatButton(
                  color: Hexcolor('#F48262'),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RegisterScreen()),
                    );
                  },
                  child: Text(
                    "DAFTAR",
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
                          'atau daftar dengan',
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
                                  onPressed: () {},
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
    );
  }
}
