import 'dart:async';
import 'package:flutter/material.dart';
import 'package:ponny/screens/intro_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:package_info/package_info.dart';

import 'home_screen.dart';

class SplashScreen extends StatefulWidget{
  static const String id ="splash_screen";
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>{
  Timer _timer;

  String _appName;
  String _versionName;
  String _versionCode;
  String _packageName;

  Future _init() async {
    final _packageInfo = await PackageInfo.fromPlatform();

    return _packageInfo.version;
  }

  removeScreen() {
    return _timer = Timer(Duration(seconds: 2), () async {
      if(isInDebugMode){
        SharedPreferences prefs = await SharedPreferences.getInstance();
        bool rf = prefs.getBool("is_intro") ?? false;
        if(rf){
          Navigator.of(context).pushReplacementNamed(HomeScreen.id);
        }else{
          Navigator.of(context).pushReplacementNamed(IntroScreen.id);
        }
      }else{
        Navigator.of(context).pushReplacementNamed(IntroScreen.id);

      }


    });
  }
  bool get isInDebugMode {
    bool inDebugMode = false;
    assert(inDebugMode = true);
    return inDebugMode;
  }

  @override
  void initState() {
    removeScreen();
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: Image.asset(
                "assets/images/PonnyBeaute.png",
                width: 250,
              ),
            ),
            FutureBuilder(
              future: _init(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  _versionName = snapshot.data;
                  return Text(
                    'Version '+_versionName,
                    style: TextStyle(
                      fontFamily: 'Brandon',
                    ),
                  );
                } else {
                  return Container();
                }
              },
            ),
            Container(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}