import 'package:flutter/material.dart';
import 'package:ponny/model/Product.dart';
import 'package:ponny/model/Slider.dart';
import 'package:ponny/model/User.dart';
import 'package:ponny/screens/Skinklopedia_Screen.dart';
import 'package:ponny/screens/bank_transfer_screen.dart';
import 'package:ponny/screens/bank_transfer_detail_screen.dart';
import 'package:ponny/screens/konfirmasi_pembayaran_screen.dart';
import 'package:ponny/screens/pesanan_berhasil_screen.dart';
import 'package:ponny/screens/pembayaran_ovo_screen.dart';
import 'package:ponny/screens/pembayaran_gopay_screen.dart';

/* Navbar Bottom Bar */
import 'package:ponny/screens/forums_screen.dart';
import 'package:ponny/screens/Browse_Screen.dart';
import 'package:ponny/screens/intro_screen.dart';
import 'package:ponny/screens/home_screen.dart';
import 'package:ponny/screens/forums_screen.dart';
import 'package:ponny/screens/account_screen.dart';

import 'package:ponny/screens/Browse_Screen.dart';

/* Account ==> Menunggu Pembayaran */
import 'package:ponny/screens/account/menunggu_pembayaran_screen.dart';
import 'package:ponny/screens/account/menunggu_pembayaran_sukses_screen.dart';
import 'package:ponny/screens/account/komplain_menunggu_pembayaran_screen.dart';

/* Account ==> Pembayaran Diterima */
import 'package:ponny/screens/account/pembayaran_diterima_screen.dart';
import 'package:ponny/screens/account/pembayaran_diterima_sukses_screen.dart';

/* Account ==> Dalam Perjalanan */
import 'package:ponny/screens/account/dalam_perjalanan_screen.dart';
import 'package:ponny/screens/account/dalam_perjalanan_sukses_screen.dart';
import 'package:ponny/screens/account/komplain_dalam_perjalanan_screen.dart';

/* Account ==> Terkirim */
import 'package:ponny/screens/account/terkirim_screen.dart';
import 'package:ponny/screens/account/terkirim_sukses_screen.dart';
import 'package:ponny/screens/account/komplain_terkirim_screen.dart';

/* Account ==> Pesanan Selesai */
import 'package:ponny/screens/account/pesanan_selesai_screen.dart';
import 'package:ponny/screens/account/pesanan_selesai_sukses_screen.dart';

/* Account ==> Detail Akun */
import 'package:ponny/screens/account/detail_akun_screen.dart';
import 'package:ponny/screens/account/edit_akun_screen.dart';
import 'package:ponny/screens/ubah_password_screen.dart';
import 'package:ponny/screens/account/edit_alamat_screen.dart';

/* Account ==> Beauty Profile */
import 'package:ponny/screens/account/beauty_profile_screen.dart';

/* Account ==> Happy Skin Reward */
import 'package:ponny/screens/account/happy_skin_reward_screen.dart';

import 'package:ponny/screens/account/ulasan_produk_screen.dart';
import 'package:ponny/screens/account/daftar_keinginan_screen.dart';
import 'package:ponny/screens/splash_screen.dart';
import 'package:ponny/screens/login.dart';
import 'package:ponny/screens/pra_daftar.dart';
import 'package:ponny/screens/register.dart';
import 'package:ponny/screens/product_details_screen.dart';
import 'package:ponny/screens/cart_screen.dart';
import 'package:ponny/screens/shipping_screen.dart';
import 'package:ponny/screens/payment_screen.dart';
import 'package:provider/provider.dart';

/* FAQ*/
import 'package:ponny/screens/FAQ_PengembalianBarang_screen.dart';
import 'package:ponny/screens/FAQ_TopQuestion_screen.dart';
import 'package:ponny/screens/FAQ_screen.dart';

/* Account ==> Syarat dan Ketentuan */
import 'package:ponny/screens/Syarat_Ketentuan_screen.dart';

/* Account ==> Pengiriman */
import 'package:ponny/screens/Pengiriman_screen.dart';

void main() {
  runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => UserModel()),
          ChangeNotifierProvider(create: (context) => SliderModel()),
          ChangeNotifierProvider(create: (context)=> ProductModel()),
        ],
        child: MyApp(),
      ),
  );
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
        accentColor: Colors.red,
      ),
      initialRoute: SplashScreen.id,
      routes: {
        SplashScreen.id: (context) => SplashScreen(),
        IntroScreen.id: (context) => IntroScreen(),
        HomeScreen.id: (context) => HomeScreen(),
        ForumsScreen.id: (context) => ForumsScreen(),
        AccountScreen.id: (context) => AccountScreen(),
        Browse.id: (context) => Browse(),
        Skinklopedia.id: (context) => Skinklopedia(),
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
        BeautyProfileScreen.id: (context) => BeautyProfileScreen(),
        HappySkinRewardScreen.id: (context) => HappySkinRewardScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        PraDaftarScreen.id: (context) => PraDaftarScreen(),
        RegisterScreen.id: (context) => RegisterScreen(),
        ProductDetailsScreen.id: (context) => ProductDetailsScreen(),
        CartScreen.id: (context) => CartScreen(),
        ShippingScreen.id: (context) => ShippingScreen(),
        PaymentScreen.id: (context) => PaymentScreen(),
        BankTransferScreen.id: (context) => BankTransferScreen(),
        BankTransferDetailScreen.id: (context) => BankTransferDetailScreen(),
        KonfirmasiPembayaranScreen.id: (context) => KonfirmasiPembayaranScreen(),
        PesananBerhasilScreen.id: (context) => PesananBerhasilScreen(),
        PembayaranOvoScreen.id: (context) => PembayaranOvoScreen(),
        PembayaranGopayScreen.id: (context) => PembayaranGopayScreen(),
        Browse.id: (context) => Browse(),
        PengembalianBarang.id: (context) => PengembalianBarang(),
        TopQuestionScreen.id: (context) => TopQuestionScreen(),
        FAQScreen.id: (context) => FAQScreen(),
        SyaratKetentuanScreen.id: (context) => SyaratKetentuanScreen(),
        PengirimanScreen.id: (context) => PengirimanScreen() 
      },
    );
  }
}
