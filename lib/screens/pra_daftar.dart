import 'dart:io';
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_twitter_login/flutter_twitter_login.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:ponny/common/constant.dart';
import 'package:ponny/model/App.dart';
import 'package:ponny/screens/Affiliate_Home_screen.dart';
import 'package:ponny/screens/home_screen.dart';
import 'package:ponny/screens/login.dart';
import 'package:ponny/screens/login_otp.dart';
import 'package:ponny/screens/register.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart' as FirebasePakage;
import 'package:google_sign_in/google_sign_in.dart' as google;
import 'package:ponny/util/AppId.dart';
import 'package:provider/provider.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:uiblock/uiblock.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_facebook_login/flutter_facebook_login.dart';

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
    Future<bool> signInWithApple() async {
    await Firebase.initializeApp();
    bool result = false;
   
    final credential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
      webAuthenticationOptions: WebAuthenticationOptions(
        // TODO: Set the `clientId` and `redirectUri` arguments to the values you entered in the Apple Developer portal during the setup
        clientId: 'app.jcurve.ponny-beaute-indonesia',
        redirectUri: Uri.parse(
          'https://myponnybeaute.firebaseapp.com/__/auth/handler',
        ),
      ),
    );

    // This is the endpoint that will convert an authorization code obtained
    // via Sign in with Apple into a session in your system
    final signInWithAppleEndpoint = Uri(
      scheme: 'https',
      host: 'myponnybeaute.firebaseapp.com',
      path: '/__/auth/handler',
      queryParameters: <String, String>{
        'code': credential.authorizationCode,
        'firstName': credential.givenName,
        'lastName': credential.familyName,
        'useBundleId': Platform.isIOS || Platform.isMacOS ? 'true' : 'false',
        if (credential.state != null) 'state': credential.state,
      },
    );

    final session = await http.Client().post(
      signInWithAppleEndpoint,
    );

    // If we got this far, a session based on the Apple ID credential has been created in your system,
    // and you can now set this as the app's session
    if(session.statusCode==200){
       var param = {
        "email": credential.email,
        "name": "${credential.givenName} ${credential.familyName}",
        "provider_id": credential.authorizationCode,
      };
      result = await Provider.of<AppModel>(context).setAuthSocial(param);

      print('signInWithApple succeeded: ${session.statusCode}');

      return result;
    }
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
   Future<bool> signInWithFacebook() async {
    bool result = false;
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final FacebookLogin facebookSignIn = new FacebookLogin();
    final FacebookLoginResult results = await facebookSignIn.logIn(['email']);

    switch (results.status) {
      case FacebookLoginStatus.loggedIn:
        final FacebookAccessToken accessToken = results.accessToken;
        print(results.accessToken.token);
        final FacebookAuthCredential credential =
            FacebookAuthProvider.credential(accessToken.token);
        //  final FirebasePakage.User user = await FirebaseAuth.instance.signInWithCredential(credential);
        
        print(credential);
        var graphResponse = await http.get(
            'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email&access_token=${results.accessToken.token}');

        var profile = json.decode(graphResponse.body);
        print(profile.toString());
        var param = {
          "email": profile['email'],
          "name": profile['first_name'],
          "provider_id": profile['id'],
        };
        print(param);
        result = await Provider.of<AppModel>(context).setAuthSocial(param);

        print('signInWithGoogle succeeded: ${profile['name']}');

        print('''
         Logged in!
         
         Token: ${accessToken.token}
         User id: ${accessToken.userId}
         Expires: ${accessToken.expires}
         Permissions: ${accessToken.permissions}
         Declined permissions: ${accessToken.declinedPermissions}
         ''');
        return result;
        break;
      case FacebookLoginStatus.cancelledByUser:
        print('Login cancelled by the user.');
        break;
        return result;
      case FacebookLoginStatus.error:
        print('Something went wrong with the login process.\n'
            'Here\'s the error Facebook gave us: ${results.errorMessage}');
        break;
        return result;
    }
    // _showMessage('''
    //  Logged in!

    //  Token: ${accessToken.token}
    //  User id: ${accessToken.userId}
    //  Expires: ${accessToken.expires}
    //  Permissions: ${accessToken.permissions}
    //  Declined permissions: ${accessToken.declinedPermissions}
    //  ''');
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
          child: Container(
            width: 260,
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
                      child: Container(
                        padding: EdgeInsets.only(left: 10),
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
           Container(
                        margin: EdgeInsets.symmetric(vertical: 5),
                        child: Container(
                          width: 260,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Hexcolor('#F48262'),
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: IntrinsicHeight(
                            child: Row(
                              crossAxisAlignment:
                              CrossAxisAlignment.stretch,
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
                                      onPressed: () async {
                                        UIBlock.block(context,
                                            customLoaderChild:
                                            LoadingWidgetFadingCircle(
                                                context));

                                        signInWithFacebook().then((value) {
                                          UIBlock.unblock(context);
                                          if (value) {
                                            Navigator
                                                .pushNamedAndRemoveUntil(
                                                context,
                                                HomeScreen.id,
                                                    (_) => false);
                                          } else {
                                            scaffoldKey.currentState
                                                .showSnackBar(
                                                snackBarError);
                                          }
                                        }).catchError((onError) {
                                          UIBlock.unblock(context);
                                          scaffoldKey.currentState
                                              .showSnackBar(snackBarError);
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
                                      icon: Image.asset(
                                          "assets/images/facebookLogo.png"),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: FlatButton(
                                    onPressed: () async {
                                      UIBlock.block(context,
                                          customLoaderChild:
                                          LoadingWidgetFadingCircle(
                                              context));

                                      signInWithFacebook().then((value) {
                                        UIBlock.unblock(context);
                                        if (value) {
                                          Navigator
                                              .pushNamedAndRemoveUntil(
                                              context,
                                              HomeScreen.id,
                                                  (_) => false);
                                        } else {
                                          scaffoldKey.currentState
                                              .showSnackBar(
                                              snackBarError);
                                        }
                                      }).catchError((onError) {
                                        UIBlock.unblock(context);
                                        scaffoldKey.currentState
                                            .showSnackBar(snackBarError);
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
                                    child: Container(
                                      padding: EdgeInsets.only(left: 10),
                                      width: double.infinity,
                                      child: Text(
                                        "FACEBOOK",
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            fontSize: 17,
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
                      ), Container(
              margin: EdgeInsets.symmetric(vertical: 5),
              child: Container(
                width: 260,
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
                          child: Container(
                            padding: EdgeInsets.only(left: 10),
                            width: double.infinity,
                            child: Text(
                              "TWITTER",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: 17,
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
            Container(
              margin: EdgeInsets.symmetric(vertical: 5),
              child: Container(
                width: 260,
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
                                  builder: (context) => LoginOTP(false),
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
                                builder: (context) => LoginOTP(false),
                              ),
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.only(left: 10),
                            width: double.infinity,
                            child: Text(
                              "OTP / SMS",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: 17,
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
            Platform.isIOS
                          ? Container(
                              margin: EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 75),
                              child: SignInWithAppleButton(
                                onPressed: () async {
                                  UIBlock.block(context,
                                      customLoaderChild:
                                          LoadingWidgetFadingCircle(context));
                                  signInWithApple().then((value) {
                                    UIBlock.unblock(context);
                                    if (value) {
                                      Navigator.pushNamedAndRemoveUntil(
                                          context, HomeScreen.id, (_) => false);
                                    } else {
                                      scaffoldKey.currentState
                                          .showSnackBar(snackBarError);
                                    }
                                  }).catchError((onError) {
                                    UIBlock.unblock(context);
                                    scaffoldKey.currentState
                                        .showSnackBar(snackBarError);
                                  });
                                },
                              ),
                            )
                          : Container(
                            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 5),
              child: Container(
                width: 260,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Hexcolor('#F48262'),
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: FlatButton(
                  padding: EdgeInsets.symmetric(horizontal: 0),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AffiliateHomeScreen(),
                      ),
                    );
                  },
                  child: SizedBox(
                    width: double.infinity,
                    child: Text(
                      "DAFTAR JADI REKAN PHOEBE",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 17,
                          fontFamily: 'Brandon',
                          fontWeight: FontWeight.w800,
                          color: Hexcolor('#F48262')),
                    ),
                  ),
                ),
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
