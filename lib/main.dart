import 'package:flutter/material.dart';
import 'package:ponny/screens/forums_screen.dart';
import 'package:ponny/screens/intro_screen.dart';
import 'package:ponny/screens/home_screen.dart';
import 'package:ponny/screens/forums_screen.dart';
import 'package:ponny/screens/account_screen.dart';
import 'package:ponny/screens/menunggu_pembayaran_screen.dart';
import 'package:ponny/screens/menunggu_pembayaran_sukses_screen.dart';
import 'package:ponny/screens/komplain_menunggu_pembayaran_screen.dart';
import 'package:ponny/screens/pembayaran_diterima_screen.dart';
import 'package:ponny/screens/dalam_perjalanan_screen.dart';
import 'package:ponny/screens/dalam_perjalanan_sukses_screen.dart';
import 'package:ponny/screens/komplain_dalam_perjalanan_screen.dart';
import 'package:ponny/screens/terkirim_screen.dart';
import 'package:ponny/screens/splash_screen.dart';
import 'package:ponny/screens/login.dart';
import 'package:ponny/screens/pra_daftar.dart';
import 'package:ponny/screens/register.dart';
import 'package:ponny/screens/product_details_screen.dart';
import 'package:ponny/screens/cart_screen.dart';

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
        ForumsScreen.id: (context) => ForumsScreen(),
        AccountScreen.id: (context) => AccountScreen(),
        MenungguPembayaranScreen.id: (context) => MenungguPembayaranScreen(),
        MenungguPembayaranSuksesScreen.id: (context) =>
            MenungguPembayaranSuksesScreen(),
        KomplainMenungguPembayaranScreen.id: (context) =>
            KomplainMenungguPembayaranScreen(),
        PembayaranDiterimaScreen.id: (context) => PembayaranDiterimaScreen(),
        DalamPerjalananScreen.id: (context) => DalamPerjalananScreen(),
        DalamPerjalananSuksesScreen.id: (context) =>
            DalamPerjalananSuksesScreen(),
        KomplainDalamPerjalananScreen.id: (context) =>
            KomplainDalamPerjalananScreen(),
        TerkirimScreen.id: (context) => TerkirimScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        PraDaftarScreen.id: (context) => PraDaftarScreen(),
        RegisterScreen.id: (context) => RegisterScreen(),
        ProductDetailsScreen.id: (context) => ProductDetailsScreen(),
        CartScreen.id: (context) => CartScreen()
      },
    );
  }
}
