import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:lodash_dart/lodash_dart.dart';
import 'package:ponny/common/constant.dart';
import 'package:ponny/model/App.dart';
import 'package:ponny/model/Cart.dart';
import 'package:ponny/model/Product.dart';
import 'package:ponny/model/User.dart';
import 'package:ponny/model/WishProduct.dart';
import 'package:ponny/screens/account/chat_email_screen.dart';
import 'package:ponny/screens/account_screen.dart';
import 'package:ponny/screens/login.dart';
import 'package:ponny/screens/metode_verifikasi_screen.dart';
import 'package:ponny/screens/pra_daftar.dart';
import 'package:ponny/screens/home_screen.dart';
import 'package:ponny/screens/login_otp.dart';
import 'package:keyboard_attachable/keyboard_attachable.dart';
import 'package:http/http.dart' as http;
import 'package:ponny/screens/produk_rekomendasi_screen.dart';
import 'package:ponny/widgets/MyProduct.dart';
import 'package:ponny/widgets/PonnyBottomNavbar.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uiblock/uiblock.dart';
import 'package:url_launcher/url_launcher.dart' as Launcher;
import 'package:ponny/util/globalUrl.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:ponny/common/constant.dart' as cost;

class SkinTypeScreen extends StatefulWidget {
  static const String id = "skin_type_Screen";
  @override
  _SkinTypeStateScreen createState() => _SkinTypeStateScreen();
}

class _SkinTypeStateScreen extends State<SkinTypeScreen> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  static String videoId = YoutubePlayer.convertUrlToId("https://www.youtube.com/embed/5ou09YALCJw");
  YoutubePlayerController _ytcontroller;
  final VoidCallback onError = null;
  List<Widget> ListRekomedasi;
  List<JenisKulit> daftarJenisKulit = [
    JenisKulit(
      id: 0,
      judul: 'KULIT BERMINYAK',
      subjudul: 'Menggunakan skincare dengan tekstur gel',
      gambar: 'assets/images/kulit/detail kulit berminyak.png',
      keterangan: 'Kulit berminyak ditandai dengan pori-pori besar yang mudah terlihat. Produksi sebum atau minyak pada wajahmu tergolong banyak sehingga kulit wajahmu akan terlihat berminyak hampir di seluruh bagian wajah. Salicylic Acid merupakan salah satu kandungan yang bersahabat untuk kulit berminyak. Tekstur skincare yang tepat untuk kulit berminyak adalah gel.\n\nUntuk tau jenis kulitmu, gunakan kertas minyak atau blotting paper setelah mencuci wajah. Blotting paper akan mengangkat banyak minyak berlebih di wajah, sehingga hampir seluruh bagian kertas akan berubah warna jadi lebih gelap. Tonton video di bawah untuk cari tau lebih lengkap.',
    ),
    JenisKulit(
      id: 1,
      judul: 'KULIT KOMBINASI',
      subjudul: 'Menggunakan skincare dengan tekstur gel atau cream',
      gambar: 'assets/images/kulit/detail kulit kombinasi.png',
      keterangan: 'Kulit kombinasi ditandai dengan wajah yang berminyak di area dahi, batang hidung, dan dagu (T-Zone) sementar area pipi dan rahang (U-Zone) tergolong kering. Biasanya pori-pori terlihat jelas di area T-Zone. Kamu bisa mengkombinasikan produk skincare yang akan kamu pakai untuk merawat jenis kulit ini. Tekstur skincare untuk kulit kombinasi bisa dengan gel maupun cream.\n\nUntuk tau jenis kulitmu, gunakan kertas minyak atau blotting paper setelah mencuci wajah. Mungkin kertas minyak cuma menangkap minyak di area t-zone, sehingga bagian kertas yang berubah warna jadi lebih gelap nggak menyeluruh. Tonton video di bawah untuk cari tau lebih lengkap.',
    ),
    JenisKulit(
      id: 2,
      judul: 'KULIT NORMAL',
      subjudul: 'Menggunakan skincare dengan tekstur apapun',
      gambar: 'assets/images/kulit/detail kulit normal.png',
      keterangan: 'Kulit normal ditandai dengan pori-pori kecil. Jenis kulit normal punya produksi minyak yang imbang sehingga kulit wajahmu nggak terlalu berminyak maupun kering. Kulit normal bisa menggunakan berbagai kandungan skincar dengan tekstur apapun dan jarang menimbulkan reaksi sensitif.\n\nUntuk tau jenis kulitmu, gunakan kertas minyak atau blotting paper setelah mencuci wajah. Pada kulit normal, blotting paper nggak berubah warna terlalu banyak, artinya hanya menyerap sedikit minyak dari wajah. Tonton video di bawah untuk cari tau lebih lengkap.',
    ),
    JenisKulit(
      id: 3,
      judul: 'KULIT KERING',
      subjudul: 'Menggunakan skincare dengan tekstur cream',
      gambar: 'assets/images/kulit/detail kulit kering.png',
      keterangan: 'Kulit kering ditandai dengan kulit yang bersisik, terasa kencang, gatal, dan kusam. Produksi sebum yang kurang membuat kulit tetap kering sehingga jarang terlihat berminyak. Beta Glucan dan Hyaluronic Acid adalah kandungan yang bersahabat dengan kulit kering. Tekstur skincare yang tepat untuk kulit kering adalah cream.\n\nUntuk tau jenis kulitmu, gunakan kertas minyak atau blotting paper setelah mencuci wajah. Pada kulit kering, blotting paper nyaris tidak berubah warna karena minyak yang diangkat dari wajah sangat sedikit. Tonton video di bawah untuk cari tau lebih lengkap.',
    ),
    JenisKulit(
      id: 4,
      judul: 'KULIT SENSITIF',
      subjudul: 'Menggunakan skincare dengan tekstur cream',
      gambar: 'assets/images/kulit/detail kulit sensitif.png',
      keterangan: 'Kulit sensitif ditandai dengan kondisi kulit seperti rosacea, eczema, atau psoriasis. Umumnya kulit sensitif akan menunjukkan reaksi iritasi seperti kemerahan atau sensasi terbakar setelah mencoba produk skincare baru dengan kandungan seperti fragrance. Centella Asiatica merupakan salah satu kandungan yang bersahabat dengan kulit sensitif. Tekstur skincare yang tepat untuk kulit sensitif adalah cream.\n\nUntuk tau jenis kulitmu, gunakan kertas minyak atau blotting paper setelah mencuci wajah. Kalau kulitmu sensitif, blotting paper hanya menyerap sedikit minyak, sehingga nggak terjadi banyak perubahan warna di kertasnya. Tonton video di bawah untuk cari tau lebih lengkap.',
    ),
  ];
  int index = 0;
  void _launch(String url) async {
    if (await Launcher.canLaunch(url)) {
      await Launcher.launch(url, forceWebView: true,);
    } else {
      if (onError != null) {
        onError();
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _ytcontroller = YoutubePlayerController(
      initialVideoId: videoId,
      flags: YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    );
  }

  Future<YoutubePlayerController> ytplayer() async {
    videoId = YoutubePlayer.convertUrlToId(Provider.of<AppModel>(context).setting.embedVideo);
    return YoutubePlayerController(
      initialVideoId: videoId,
      flags: YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final jenisKulit = daftarJenisKulit.firstWhere((element) => element.id==index);
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        titleSpacing: 0.0,
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            color: Color(0xffF48262),
          ),
        ),
        title: Text(
          'Jenis Kulit',
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
      resizeToAvoidBottomInset: false,
      backgroundColor: Hexcolor('#FCF8F0'),
      body: Container(
        child: Column(
          children: [
            IntrinsicHeight(
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      color: index==0 ? Color(0xffFBDFD2) : Color(0xffFAF0E6),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: (){
                            setState(() {
                              index = 0;
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              children: [
                                AspectRatio(
                                  aspectRatio: 1,
                                  child: Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: Color(0xffFACAC3),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Image.asset(
                                      'assets/images/oily-skin.png'
                                    ),
                                  ),
                                ),
                                Container(
                                  width: double.infinity,
                                  margin: EdgeInsets.only(top: 5),
                                  child: Text(
                                    'Kulit\nBerminyak',
                                    style: TextStyle(
                                      fontFamily: 'Brandon',
                                      fontSize: 12,
                                      height: 1,
                                      fontWeight: index==0 ? FontWeight.bold : FontWeight.normal,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      color: index==1 ? Color(0xffFBDFD2) : Color(0xffFAF0E6),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: (){
                            setState(() {
                              index = 1;
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              children: [
                                AspectRatio(
                                  aspectRatio: 1,
                                  child: Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: Color(0xffFACAC3),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Image.asset(
                                        'assets/images/combination-skin.png'
                                    ),
                                  ),
                                ),
                                Container(
                                  width: double.infinity,
                                  margin: EdgeInsets.only(top: 5),
                                  child: Text(
                                    'Kulit\nKombinasi',
                                    style: TextStyle(
                                      fontFamily: 'Brandon',
                                      fontSize: 12,
                                      height: 1,
                                      fontWeight: index==1 ? FontWeight.bold : FontWeight.normal,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      color: index==2 ? Color(0xffFBDFD2) : Color(0xffFAF0E6),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: (){
                            setState(() {
                              index = 2;
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              children: [
                                AspectRatio(
                                  aspectRatio: 1,
                                  child: Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: Color(0xffFACAC3),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Image.asset(
                                        'assets/images/normal-skin.png'
                                    ),
                                  ),
                                ),
                                Container(
                                  width: double.infinity,
                                  margin: EdgeInsets.only(top: 5),
                                  child: Text(
                                    'Kulit\nNormal',
                                    style: TextStyle(
                                      fontFamily: 'Brandon',
                                      fontSize: 12,
                                      height: 1,
                                      fontWeight: index==2 ? FontWeight.bold : FontWeight.normal,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      color: index==3 ? Color(0xffFBDFD2) : Color(0xffFAF0E6),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: (){
                            setState(() {
                              index = 3;
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              children: [
                                AspectRatio(
                                  aspectRatio: 1,
                                  child: Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: Color(0xffFACAC3),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Image.asset(
                                        'assets/images/dry-skin.png'
                                    ),
                                  ),
                                ),
                                Container(
                                  width: double.infinity,
                                  margin: EdgeInsets.only(top: 5),
                                  child: Text(
                                    'Kulit\nKering',
                                    style: TextStyle(
                                      fontFamily: 'Brandon',
                                      fontSize: 12,
                                      height: 1,
                                      fontWeight: index==3 ? FontWeight.bold : FontWeight.normal,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      color: index==4 ? Color(0xffFBDFD2) : Color(0xffFAF0E6),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: (){
                            setState(() {
                              index = 4;
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              children: [
                                AspectRatio(
                                  aspectRatio: 1,
                                  child: Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: Color(0xffFACAC3),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Image.asset(
                                        'assets/images/sensitive-skin.png'
                                    ),
                                  ),
                                ),
                                Container(
                                  width: double.infinity,
                                  margin: EdgeInsets.only(top: 5),
                                  child: Text(
                                    'Kulit\nSensitif',
                                    style: TextStyle(
                                      fontFamily: 'Brandon',
                                      fontSize: 12,
                                      height: 1,
                                      fontWeight: index==4 ? FontWeight.bold : FontWeight.normal,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                      width: double.infinity,
                      child: Text(
                        'JENIS KULITMU ADALAH',
                        style: TextStyle(
                          fontFamily: 'Brandon',
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
                      width: double.infinity,
                      child: Text(
                        jenisKulit.judul,
                        style: TextStyle(
                          fontFamily: 'Brandon',
                          fontSize: 22,
                          color: Color(0xffF48262),
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      child: Image.asset(
                        jenisKulit.gambar,
                        height: 110,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                      child: Center(
                        child: Container(
                          width: 260,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Color(0xffF7BBBB),
                          ),
                          child: Text(
                            jenisKulit.subjudul,
                            style: TextStyle(
                              fontFamily: 'Brandon',
                              fontSize: 12,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(20, 20, 20, 30),
                      child: Text(
                        jenisKulit.keterangan,
                        style: TextStyle(
                          fontFamily: 'Brandon',
                        ),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Stack(
                        children: [
                          Column(
                            children: [
                              Container(
                                height: 20,
                                width: double.infinity,
                              ),
                              Container(
                                color: Color(0xffFBDFD2),
                                height: 20,
                                width: double.infinity,
                              ),
                            ],
                          ),
                          Positioned.fill(
                            child: Center(
                              child: Text(
                                'CARI TAHU JENIS KULITMU',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'Brandon',
                                  color: Color(0xffF48262),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      color: Color(0xffFBDFD2),
                      padding: EdgeInsets.fromLTRB(30, 0, 30, 20),
                      child:Provider.of<AppModel>(context).loadingSetting ? Center(
                        child: LoadingWidgetFadingCircle(context),
                      ) : FutureBuilder(
                          future: ytplayer(),
                          builder: (context, snapshot){
                            if(snapshot.hasData){
                              YoutubePlayerController _ytcontroller = snapshot.data;
                              return YoutubePlayer(
                                controller: _ytcontroller,
                                bottomActions: [
                                  CurrentPosition(),
                                  ProgressBar(isExpanded: true),
                                  RemainingDuration(),
                                ],
                              );
                            }
                            else{
                              return Container();
                            }
                          }
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      alignment: Alignment.centerLeft,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Produk Rekomendasi',
                            style: TextStyle(
                              fontFamily: 'Brandon',
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                            ),
                          ),
                          // GestureDetector(
                          //   onTap: (){
                          //     Navigator.push(context, new MaterialPageRoute(
                          //       builder: (BuildContext context) => new ProdukRekomendasiScreen(),
                          //     ));
                          //   },
                          //   child: Text(
                          //     'lihat selengkapnya',
                          //     style: TextStyle(
                          //       fontFamily: 'Brandon',
                          //       fontSize: 12,
                          //       decoration: TextDecoration.underline,
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.width * .75,
                      child: Consumer<ProductModel>(
                        builder: (context,value,child){
                          if(value.loadingRecom){
                            return LoadingWidgetFadingCircle(context);
                          }else{
                            // ListRekomedasi = getColumProduct(context,value.Recomendasi,3);
                            var dataRecom  =Lodash().chunk(array: value.Recom,size: 3);
                            return  new Swiper(
                              itemBuilder: (BuildContext context, int index) {
                                if(dataRecom[index].length == 3){
                                  return Container(
                                      child: Row(
                                          children: [
                                            for(Product e in dataRecom[index])
                                              Expanded(
                                                flex: 1,
                                                child: Container(
                                                  padding: EdgeInsets.symmetric(horizontal: 5),
                                                  child: MyProduct(
                                                    product: e,
                                                    IsLiked: Provider.of<WishModel>(context).rawlist.firstWhere((element) => element.productId == e.id, orElse: () => null) != null ? true:false,
                                                    onFavorit: (){
                                                      if(Provider.of<AppModel>(context).loggedIn) {
                                                        Provider.of<WishModel>(context).addProductToWish(e, Provider.of<AppModel>(context).auth.access_token);
                                                      }else{
                                                        Navigator.push(context,new MaterialPageRoute(
                                                          builder: (BuildContext context) => new LoginScreen(),
                                                        ));
                                                      }
                                                    },
                                                    onUnFavorit: (){
                                                      if(Provider.of<AppModel>(context).loggedIn) {
                                                        Provider.of<WishModel>(context).removeProductFromWish(e, Provider.of<AppModel>(context).auth.access_token);
                                                      }else{
                                                        Navigator.push(context,new MaterialPageRoute(
                                                          builder: (BuildContext context) => new LoginScreen(),
                                                        ));
                                                      }
                                                    },
                                                    onTobag: (){
                                                      if(Provider.of<AppModel>(context).loggedIn){
                                                        UIBlock.block(context,customLoaderChild: LoadingWidget(context));
                                                        Provider.of<CartModel>(context).addProductToCart(e,Provider.of<AppModel>(context).auth.access_token,null).then((value){
                                                          UIBlock.unblock(context);
                                                          cost.showAlertDialog(context,e);
                                                        });
                                                      }else{
                                                        Navigator.push(context,new MaterialPageRoute(
                                                          builder: (BuildContext context) => new LoginScreen(),
                                                        ));
                                                      }
                                                    },
                                                  ),
                                                ),
                                              ),
                                          ]
                                      )
                                  );
                                }else if(dataRecom[index].length ==2){
                                  return Container(
                                      child: Row(
                                        children: [
                                          for(Product e in dataRecom[index])
                                            Expanded(
                                              flex: 1,
                                              child: Container(
                                                padding: EdgeInsets.symmetric(horizontal: 7),
                                                child: MyProduct(
                                                  product: e,
                                                  onFavorit: (){
                                                    if(Provider.of<AppModel>(context).loggedIn) {
                                                      UIBlock.block(context,customLoaderChild: LoadingWidget(context));
                                                      Provider.of<WishModel>(context).addProductToWish(e, Provider.of<AppModel>(context).auth.access_token).then((value){
                                                        UIBlock.unblock(context);
                                                        if(value){
                                                          cost.showWishDialog(context,e);
                                                        }else{
                                                          scaffoldKey.currentState.showSnackBar(snackBarError);
                                                        }
                                                      });
                                                    }else{
                                                      Navigator.push(context,new MaterialPageRoute(
                                                        builder: (BuildContext context) => new LoginScreen(),
                                                      ));
                                                    }
                                                  },
                                                  onTobag: (){
                                                    if(Provider.of<AppModel>(context).loggedIn){
                                                      UIBlock.block(context,customLoaderChild: LoadingWidget(context));
                                                      Provider.of<CartModel>(context).addProductToCart(e,Provider.of<AppModel>(context).auth.access_token,null).then((value){
                                                        UIBlock.unblock(context);
                                                        cost.showAlertDialog(context,e);
                                                      });
                                                    }else{
                                                      Navigator.push(context,new MaterialPageRoute(
                                                        builder: (BuildContext context) => new LoginScreen(),
                                                      ));
                                                    }
                                                  },
                                                ),
                                              ),
                                            ),
                                          Expanded(
                                            flex: 1,
                                            child: Container(
                                              padding: EdgeInsets.symmetric(horizontal: 7),

                                            ),
                                          )


                                        ],
                                      )
                                  );
                                }else{
                                  return Container(
                                      child: Row(
                                        children: [
                                          for(Product e in dataRecom[index])
                                            Expanded(
                                              flex: 1,
                                              child: Container(
                                                padding: EdgeInsets.symmetric(horizontal: 7),
                                                child: MyProduct(
                                                  product: e,
                                                  onFavorit: (){
                                                    if(Provider.of<AppModel>(context).loggedIn) {
                                                      UIBlock.block(context,customLoaderChild: LoadingWidget(context));
                                                      Provider.of<WishModel>(context).addProductToWish(e, Provider.of<AppModel>(context).auth.access_token).then((value){
                                                        UIBlock.unblock(context);
                                                        if(value){
                                                          cost.showWishDialog(context,e);
                                                        }else{
                                                          scaffoldKey.currentState.showSnackBar(snackBarError);
                                                        }
                                                      });
                                                    }else{
                                                      Navigator.push(context,new MaterialPageRoute(
                                                        builder: (BuildContext context) => new LoginScreen(),
                                                      ));
                                                    }
                                                  },
                                                  onTobag: (){
                                                    if(Provider.of<AppModel>(context).loggedIn){
                                                      UIBlock.block(context,customLoaderChild: LoadingWidget(context));
                                                      Provider.of<CartModel>(context).addProductToCart(e,Provider.of<AppModel>(context).auth.access_token,null).then((value){
                                                        UIBlock.unblock(context);
                                                        cost.showAlertDialog(context,e);
                                                      });
                                                    }else{
                                                      Navigator.push(context,new MaterialPageRoute(
                                                        builder: (BuildContext context) => new LoginScreen(),
                                                      ));
                                                    }
                                                  },
                                                ),
                                              ),
                                            ),
                                          Expanded(
                                            flex: 1,
                                            child: Container(
                                              padding: EdgeInsets.symmetric(horizontal: 7),

                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Container(
                                              padding: EdgeInsets.symmetric(horizontal: 7),

                                            ),
                                          )


                                        ],
                                      )
                                  );

                                }
                              },
                              itemCount: dataRecom.length,
                              pagination: null,
                              control: null,
                              autoplay: false,
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: new PonnyBottomNavbar(selectedIndex: 0),
    );
  }
}

class JenisKulit{
  JenisKulit({this.id, this.judul, this.subjudul, this.gambar, this.keterangan});
  int id;
  String judul;
  String subjudul;
  String gambar;
  String keterangan;
}