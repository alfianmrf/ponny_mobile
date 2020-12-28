import 'package:flutter/material.dart';
import 'package:ponny/model/Address.dart';
import 'package:ponny/model/Cart.dart';
import 'package:ponny/model/Category.dart';
import 'package:ponny/model/Product.dart';
import 'package:ponny/model/Slider.dart';
import 'package:ponny/model/User.dart';
import 'package:ponny/model/Voucher.dart';
import 'package:ponny/model/chatEmail.dart';
import 'package:ponny/model/PostandComment.dart';
import 'package:ponny/screens/Skinklopedia_Screen.dart';
import 'package:ponny/screens/Detail_Brand_Screen.dart';
import 'package:ponny/screens/bank_transfer_screen.dart';
import 'package:ponny/screens/bank_transfer_detail_screen.dart';
import 'package:ponny/screens/bantuan_screen.dart';
import 'package:ponny/screens/konfirmasi_pembayaran_screen.dart';
import 'package:ponny/screens/konsultasi_screen.dart';
import 'package:ponny/screens/pesanan_berhasil_screen.dart';
import 'package:ponny/screens/pembayaran_ovo_screen.dart';
import 'package:ponny/screens/pembayaran_gopay_screen.dart';

/* Navbar Bottom Bar */
import 'package:ponny/screens/Forum_screen.dart';
import 'package:ponny/screens/Browse_Screen.dart';
import 'package:ponny/screens/intro_screen.dart';
import 'package:ponny/screens/home_screen.dart';
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

/*Account ==> Affiliate*/
import 'package:ponny/screens/Affiliate_Home_screen.dart';
import 'package:ponny/screens/Affiliate_LogedIn_screen.dart';
import 'package:ponny/screens/Affiliate_CairkanDana_screen.dart';
import 'model/App.dart';
import 'model/Order.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:ponny/screens/Blog_screen.dart';
import 'model/WishProduct.dart';

import 'package:ponny/screens/daftarLogin_screen.dart';

import 'package:ponny/screens/kartu_screen.dart';

import 'package:ponny/screens/Keuntungan_HappyReward_screen.dart';

import 'package:ponny/screens/RincianPoint_screen.dart';

import 'package:ponny/screens/account/hubungi_kami_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AppModel()),
        ChangeNotifierProvider(create: (context) => CategoryModel()),
        ChangeNotifierProvider(create: (context) => SliderModel()),
        ChangeNotifierProvider(create: (context) => ProductModel()),
        ChangeNotifierProvider(create: (context) => CartModel()),
        ChangeNotifierProvider(create: (context) => WishModel()),
        ChangeNotifierProvider(create: (context) => AddressModel()),
        ChangeNotifierProvider(create: (context) => OrderModel()),
        ChangeNotifierProvider(create: (context) => UserModel()),
        ChangeNotifierProvider(create: (context) => VoucherModel()),
        ChangeNotifierProvider(create: (context) => ChatEmail()),
        ChangeNotifierProvider(create: (context) => PostandComment()),

       
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
      builder: (BuildContext context, Widget child) {
        final MediaQueryData data = MediaQuery.of(context);
        return MediaQuery(
          data: data.copyWith(textScaleFactor: 1),
          child: child,
        );
      },
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
        ForumData.id: (context) => ForumData(),
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
        KonfirmasiPembayaranScreen.id: (context) =>
            KonfirmasiPembayaranScreen(),
        PesananBerhasilScreen.id: (context) => PesananBerhasilScreen(),
        PembayaranOvoScreen.id: (context) => PembayaranOvoScreen(),
        PembayaranGopayScreen.id: (context) => PembayaranGopayScreen(),
        Browse.id: (context) => Browse(),
        PengembalianBarang.id: (context) => PengembalianBarang(),
        TopQuestionScreen.id: (context) => TopQuestionScreen(),
        FAQScreen.id: (context) => FAQScreen(),
        SyaratKetentuanScreen.id: (context) => SyaratKetentuanScreen(),
        PengirimanScreen.id: (context) => PengirimanScreen(),
        AffiliateHomeScreen.id: (context) => AffiliateHomeScreen(),
        AffiliateLogedIn.id: (context) => AffiliateLogedIn(),
        CairkanDanaScreen.id: (context) => CairkanDanaScreen(),
        HubungiKamiScreen.id: (context) => HubungiKamiScreen(),
        Blog.id: (context) => Blog(),
        DetailBrand.id: (context) => DetailBrand(),
        DaftarLoginScreen.id: (context) => DaftarLoginScreen(),
        KartuScreen.id: (context) => KartuScreen(),
        KonsultasiScreen.id: (context) => KonsultasiScreen(),
        ForumData.id: (context) => ForumData(),
        UntungReward.id: (context) => UntungReward(),
        RincianPoint.id: (context) => RincianPoint(),
        BantuanScreen.id: (context) => BantuanScreen()
      },
    );
  }
}
