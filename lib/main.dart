import 'package:flutter/material.dart';
import 'package:ponny/screens/intro_screen.dart';
import 'package:ponny/screens/home_screen.dart';
import 'package:ponny/screens/splash_screen.dart';
import 'package:ponny/screens/login.dart';
import 'package:ponny/screens/pra_daftar.dart';
import 'package:ponny/screens/register.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ponny Beaute',
      theme: ThemeData(
        primaryColor: Color(0xFFFDF8F0),
      ),
      initialRoute: SplashScreen.id,
      routes: {
        SplashScreen.id: (context) => SplashScreen(),
        IntroScreen.id: (context) => IntroScreen(),
        HomeScreen.id: (context) => HomeScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        PraDaftarScreen.id: (context) => PraDaftarScreen(),
        RegisterScreen.id: (context) => RegisterScreen()
      },
    );
  }
}
