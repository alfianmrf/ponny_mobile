import 'dart:async';
import 'package:flutter/material.dart';
import 'package:ponny/screens/intro_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home_screen.dart';

class SplashScreen extends StatefulWidget{
  static const String id ="splash_screen";
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>{
  Timer _timer;

  removeScreen() {
    return _timer = Timer(Duration(seconds: 2), () async {
      // SharedPreferences prefs = await SharedPreferences.getInstance();
      // bool rf = prefs.getBool("is_intro") ?? false;
      // if(rf){
      //   Navigator.of(context).pushReplacementNamed(HomeScreen.id);
      // }else{
      //   Navigator.of(context).pushReplacementNamed(IntroScreen.id);
      // }
      Navigator.of(context).pushReplacementNamed(IntroScreen.id);

    });
  }

  @override
  void initState() {
    super.initState();
    removeScreen();
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
        child: Image.asset(
          "assets/images/PonnyBeaute.png",
          width: 250,
        ),
      ),
    );
  }
}