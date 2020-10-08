import 'package:flutter/material.dart';

/* Navbar Bottom Bar */
import 'package:ponny/screens/forums_screen.dart';
import 'package:ponny/screens/intro_screen.dart';
import 'package:ponny/screens/home_screen.dart';
import 'package:ponny/screens/forums_screen.dart';
import 'package:ponny/screens/account_screen.dart';

/* Account ==> Menunggu Pembayaran */
import 'package:ponny/screens/menunggu_pembayaran_screen.dart';
import 'package:ponny/screens/menunggu_pembayaran_sukses_screen.dart';
import 'package:ponny/screens/komplain_menunggu_pembayaran_screen.dart';

/* Account ==> Pembayaran Diterima */
import 'package:ponny/screens/pembayaran_diterima_screen.dart';
import 'package:ponny/screens/pembayaran_diterima_sukses_screen.dart';

/* Account ==> Dalam Perjalanan */
import 'package:ponny/screens/dalam_perjalanan_screen.dart';
import 'package:ponny/screens/dalam_perjalanan_sukses_screen.dart';
import 'package:ponny/screens/komplain_dalam_perjalanan_screen.dart';

/* Account ==> Terkirim */
import 'package:ponny/screens/terkirim_screen.dart';
import 'package:ponny/screens/terkirim_sukses_screen.dart';
import 'package:ponny/screens/komplain_terkirim_screen.dart';

/* Account ==> Pesanan Selesai */
import 'package:ponny/screens/pesanan_selesai_screen.dart';
import 'package:ponny/screens/pesanan_selesai_sukses_screen.dart';

/* Account ==> Detail Akun */
import 'package:ponny/screens/detail_akun_screen.dart';
import 'package:ponny/screens/edit_akun_screen.dart';
import 'package:ponny/screens/ubah_password_screen.dart';
import 'package:ponny/screens/edit_alamat_screen.dart';

import 'package:ponny/screens/ulasan_produk_screen.dart';
import 'package:ponny/screens/daftar_keinginan_screen.dart';
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
        TerkirimScreen.id: (context) => TerkirimScreen(),
        KomplainTerkirimScreen.id: (context) => KomplainTerkirimScreen(),
        KomplainDalamPerjalananScreen.id: (context) =>
            KomplainDalamPerjalananScreen(),
        PesananSelesaiScreen.id: (context) => PesananSelesaiScreen(),
        PesananSelesaiSuksesScreen.id: (context) =>
            PesananSelesaiSuksesScreen(),
        UlasanProdukScreen.id: (context) => UlasanProdukScreen(),
        DaftarKeinginanScreen.id: (context) => DaftarKeinginanScreen(),
        DetailAkunScreen.id: (context) => DetailAkunScreen(),
        EditAkunScreen.id: (context) => EditAkunScreen(),
        EditAlamatScreen.id: (context) => EditAlamatScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        PraDaftarScreen.id: (context) => PraDaftarScreen(),
        RegisterScreen.id: (context) => RegisterScreen(),
        ProductDetailsScreen.id: (context) => ProductDetailsScreen(),
        CartScreen.id: (context) => CartScreen()
      },
    );
  }
}
