import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:ponny/common/constant.dart';
import 'package:ponny/model/App.dart';
import 'package:ponny/model/Cart.dart';
import 'package:ponny/model/FaqHeader.dart';
import 'package:ponny/model/Product.dart';
import 'package:ponny/model/ProductPoin.dart';
import 'package:ponny/model/User.dart';
import 'package:ponny/screens/account/happy_skin_reward_screen.dart';
import 'package:ponny/util/globalUrl.dart';
import 'package:ponny/widgets/PonnyBottomNavbar.dart';
import 'package:ponny/screens/product_details_screen.dart';
import 'package:gradient_text/gradient_text.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:uiblock/uiblock.dart';

class UntungReward extends StatefulWidget {
  static const String id = "UntungReward";

  @override
  _UntungRewardState createState() => _UntungRewardState();
}

class _UntungRewardState extends State<UntungReward> {
  List<ProductPoin> reward=[];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      getListOfProduct();
    });
  }
  Future<void> getListOfProduct() async {
    final respon =  await http.get(rdmProduk);
    print(respon.body);
    if(respon.statusCode == 200){
      final responseJson = json.decode(respon.body);

      setState(() {
        for(Map item in responseJson["lessThan200"]){
          reward.add(ProductPoin(item["id"],item["jml_point"],Product.fromJson(item["product"]["availability"]),1));
        }
        for(Map item in responseJson["200to500"]){
          reward.add(ProductPoin(item["id"],item["jml_point"],Product.fromJson(item["product"]["availability"]),1));
        }
        for(Map item in responseJson["moreThan500"]){
          reward.add(ProductPoin(item["id"],item["jml_point"],Product.fromJson(item["product"]["availability"]),1));
        }
        loading =false;
      });
    }

  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel>(context).user;
    int usepoin = Provider.of<CartModel>(context).gettotalPoin();
    int mypoin = Provider.of<UserModel>(context).user.point;
    int sisa = mypoin-usepoin;
    final faq = Provider.of<AppModel>(context,listen: false).listFaq.firstWhere((element) => element.id == 6);

    Widget getProduct(productPoin){
      return Container(
        // color: Colors.red,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 160,
              height: 210,
              child: CachedNetworkImage(
                imageUrl: img_url+productPoin.product.thumbnail_image,
                placeholder: (context, url) => LoadingWidgetPulse(context),
                errorWidget: (context, url, error) => Image.asset('assets/images/basic.jpg'),
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(
                      top: 5,
                    ),
                    child: Text(
                      productPoin.product.brand.name,
                      style: TextStyle(
                        fontFamily: "Yeseva",
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                top: 5,
              ),
              child: Text(
                productPoin.product.name.length > 20 ?productPoin.product.name.substring(0,20)+"..." : productPoin.product.name,
                style: TextStyle(
                  fontFamily: "Brandon",
                  fontSize: 14,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                top: 5,
              ),
              child: Text(
                productPoin.jml_point.toString()+" POIN",
                style: TextStyle(
                  fontFamily: "Brandon",
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Container(
              child:productPoin.jml_point <= sisa?
              FlatButton(
                color: Color(0xffF48262),
                textColor: Colors.white,
                padding: EdgeInsets.all(8.0),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                onPressed: () {
                  UIBlock.block(context,customLoaderChild: LoadingWidget(context));
                  Provider.of<CartModel>(context).addRedemToCart(productPoin, Provider.of<AppModel>(context,listen: false).auth.access_token).then((value) {
                    UIBlock.unblock(context);
                    showAlertDialog(context,productPoin.product);
                  }).catchError((onError){
                    UIBlock.unblock(context);
                  });
                },
                child: Text(
                  "Tukar",
                  style: TextStyle(fontSize: 16.0, fontFamily: 'Brandon'),
                ),
              ):
              FlatButton(
                onPressed: (){},
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                color: Color(0xffF48262),
                textColor: Colors.white,
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Tukar",
                  style: TextStyle(fontSize: 16.0, fontFamily: 'Brandon'),
                ),
              )
              ,
            )
          ],
        ),
      );
    }
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Hexcolor('#FCF8F0'),
        appBar: AppBar(
          titleSpacing: -10.0,
          elevation: 0.0,
          leading: Transform.translate(
            offset: Offset(-5, 0),
            child: IconButton(
              onPressed: (){
                Navigator.pop(context,false);
              },
              icon: Icon(
                Icons.arrow_back_ios_rounded,
                color: Color(0xffF48262),
              ),
            ),
          ),
          title: Text(
            'Keuntungan Happy Skin Reward',
            style: TextStyle(
              fontSize: 18,
              fontFamily: 'Yeseva',
              color: Hexcolor('#F48262'),
            ),
          ),
          bottom: PreferredSize(
              child: Container(
                color: Color(0xffF48262),
                height: 1.0,
              ),
              preferredSize: Size.fromHeight(1.0)
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: double.infinity,
                color: Color(0xffF3C1B5),
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  children: [
                    FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Text(
                        "Happy Skin Reward",
                        style: TextStyle(
                          fontSize: 24,
                          fontFamily: "Yeseva",
                        ),
                      ),
                    ),
                    Container(height: 20),
                    FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Text(
                        user.name+" "+user.last_name,
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: "Brandon",
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: FittedBox(
                                  fit: BoxFit.fitWidth,
                                  child: Text(
                                    user.dashboard.membershipTitle
                                        .toUpperCase(),
                                    style: TextStyle(
                                        color: Hexcolor('#b08d00'),
                                        fontSize: 24,
                                        fontFamily: "Brandon",
                                        fontWeight: FontWeight.w800),
                                  ),
                                ),
                              ),
                              Expanded(
                                  flex: 3,
                                  child: new LinearPercentIndicator(
                                    percent: user.dashboard.percent / 100,
                                    progressColor: Colors.red,
                                    backgroundColor: Color(0xffF3B5B5),
                                  )),
                              Expanded(
                                child: FittedBox(
                                  fit: BoxFit.fitWidth,
                                  child: Text(
                                    user.dashboard.next.toUpperCase(),
                                    style: TextStyle(
                                        color: Hexcolor('#b08d00'),
                                        fontSize: 24,
                                        fontFamily: "Brandon",
                                        fontWeight: FontWeight.w800),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          FittedBox(
                            fit: BoxFit.fitWidth,
                            child: Text(
                              "Belanja "+
                                  nm_format
                                      .format(user.dashboard.toNext) +" lagi untuk naik tingkat ke " + user.dashboard.next + " Skin",
                              style: TextStyle(
                                  fontSize: 10,
                                  fontFamily: "Brandon",
                                  fontWeight: FontWeight.w800),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Container(
                alignment: Alignment.center,
                margin:
                EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                child: Text(
                  "Wujudkan impian happy skin dan dapatkan keuntungan menarik lainnya melalui poin yang kamu dapatkan",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: "Brandon",
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(10),
                child: Text(
                  "REWARD",
                  style: TextStyle(
                      fontSize: 24,
                      fontFamily: "Yeseva",
                      fontWeight: FontWeight.w500),
                ),
              ),
              Container(
                alignment: Alignment.center,
                child: Text(
                  "Tukarkan poin yang sudah dikumpulkan dan pilih hadiah yang kamu suka.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 14,
                      fontFamily: "Brandon",
                      fontWeight: FontWeight.w500),
                ),
              ),
              loading ? Container(
                child: Center(
                  child: LoadingWidgetFadingCircle(context),
                ),
              ):
              Row(
                children: [
                  Expanded(
                      flex: 1,
                      child: Container(
                          margin: EdgeInsets.all(20),
                          child: (reward.length>0 && reward.elementAt(0) != null)?
                          getProduct(reward.elementAt(0)):Container() )),
                  Expanded(
                      flex: 1,
                      child: Container(
                          margin: EdgeInsets.all(20),
                          child: (reward.length>1 && reward.elementAt(1) != null)?
                          getProduct(reward.elementAt(1)):Container()))
                ],
              ),
              InkWell(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            HappySkinRewardScreen()),

                  );
                },
                child: Container(
                  margin: EdgeInsets.only(bottom: 20),
                  alignment: Alignment.center,
                  child: Text("Lihat Semua Rewards",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 18,
                          fontFamily: "Brandon",
                          fontWeight: FontWeight.w500,
                          color: Color(0xffF48262))),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                height: 1,
                color: Color(0xffF48262),
              ),
              Container(
                margin: EdgeInsets.all(10),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 20),
                      alignment: Alignment.center,
                      child: Text(
                        "KUMPULKAN POIN",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 24,
                          fontFamily: "Yeseva",
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 20),
                      alignment: Alignment.center,
                      child: Text(
                        "Dapatkan keuntungan menarik lainnya melalui poin yang bisa kamu dapatkan dengan cara-cara berikut:",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 14,
                            fontFamily: "Brandon",
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          Expanded(
                              child: Align(
                                child: AspectRatio(
                                  aspectRatio: 1 / 1,
                                  child: Container(
                                      margin: EdgeInsets.all(3),
                                      child: buttonGroups(
                                          "assets/images/keuntunganHappySkin/belanja.png",
                                          "Belanja",
                                          "Dapatkan 10 poin setiap pembelanjaan senilai Rp.25.000")),
                                ),
                              )),
                          Expanded(
                              child: Align(
                                child: AspectRatio(
                                  aspectRatio: 1 / 1,
                                  child: Container(
                                      margin: EdgeInsets.all(3),
                                      child: buttonGroups(
                                          "assets/images/keuntunganHappySkin/daftar-akun.png",
                                          "Daftar Akun",
                                          "Dapatkan 50 poin dengan membuat akun")),
                                ),
                              )),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          Expanded(
                              child: Align(
                                child: AspectRatio(
                                  aspectRatio: 1 / 1,
                                  child: Container(
                                      margin: EdgeInsets.all(3),
                                      child: buttonGroups(
                                          "assets/images/keuntunganHappySkin/ulang-tahun.png",
                                          "Ulang Tahun",
                                          "Dapatkan poin hingga 2% ekstra lebih banyak saat belanja di hari ulang tahun")),
                                ),
                              )),
                          Expanded(
                              child: Align(
                                child: AspectRatio(
                                  aspectRatio: 1 / 1,
                                  child: Container(
                                      margin: EdgeInsets.all(3),
                                      child: buttonGroups(
                                          "assets/images/keuntunganHappySkin/lengkapi-profil-kecantikan.png",
                                          "Lengkapi Profil Kecantikan",
                                          "Dapatkan 50 poin setelah melengkapi Profil Kecantikan")),
                                ),
                              )),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          Expanded(
                              child: Align(
                                child: AspectRatio(
                                  aspectRatio: 1 / 1,
                                  child: Container(
                                      margin: EdgeInsets.all(3),
                                      child: buttonGroups(
                                          "assets/images/keuntunganHappySkin/tulis-ulasan-produk.png",
                                          "Tulis ulasan produk",
                                          "Dapatkan 25 poin setiap meninggalkan satu ulasan")),
                                ),
                              )),
                          Expanded(
                              child: Align(
                                child: AspectRatio(
                                  aspectRatio: 1 / 1,
                                  child: Container(
                                      margin: EdgeInsets.all(3),
                                      child: buttonGroups(
                                          "assets/images/keuntunganHappySkin/unduh-mobile-app.png",
                                          "Unduh Mobile App",
                                          "Dapatkan 30 poin dengan mengunduh aplikasi Ponny Beaute")),
                                ),
                              )),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          Expanded(
                              child: Align(
                                child: AspectRatio(
                                  aspectRatio: 1 / 1,
                                  child: Container(
                                      margin: EdgeInsets.all(3),
                                      child: buttonGroups(
                                          "assets/images/keuntunganHappySkin/kode-referal.png",
                                          "Kode Referal",
                                          "Bagikan kode referalmu dan dapatkan 50.000 poin untuk kamu")),
                                ),
                              )),
                          Expanded(
                              child: Align(
                                child: AspectRatio(
                                  aspectRatio: 1 / 1,
                                  child: Container(
                                      margin: EdgeInsets.all(3),
                                      child: buttonGroups(
                                          "assets/images/keuntunganHappySkin/gratis-sampel.png",
                                          "Gratis Sampel",
                                          "Setiap kamu belanja pasti dapet 2 sampel gratis loh!")),
                                ),
                              )),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin:
                EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                height: 1,
                color: Color(0xffF3C1B5),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 20),
                alignment: Alignment.center,
                child: Text(
                  "LEVEL\n HAPPY SKIN REWARD",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontFamily: "Yeseva",
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              tableLevelReward(context),
              Container(
                margin:
                EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                height: 1,
                color: Color(0xffF3C1B5),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 20),
                alignment: Alignment.center,
                child: Text(
                  "CARA MENDAPATKAN\nKEUNTUNGAN",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontFamily: "Yeseva",
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    fit: FlexFit.loose,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Flexible(
                          fit: FlexFit.loose,
                          child: Container(
                            margin: EdgeInsets.all(10),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Flexible(
                                    fit: FlexFit.loose,
                                    child: Image.asset(
                                      "assets/images/happySkin/buat-akun.png", width: 70, height: 70, fit: BoxFit.contain,)),
                                Flexible(
                                  fit: FlexFit.loose,
                                  child: FittedBox(
                                    child: Text(
                                      "BUAT AKUN",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: "Brandon",
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                  ),
                                ),
                                Flexible(
                                  fit: FlexFit.loose,
                                  child: FittedBox(
                                    child: Text(
                                      "Daftar dengan alamat\nemail aktif",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: "Brandon",
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Flexible(
                          fit: FlexFit.loose,
                          child: Container(
                            margin: EdgeInsets.all(10),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Flexible(
                                    fit: FlexFit.loose,
                                    child: Image.asset(
                                      "assets/images/happySkin/kumpulkan-koin.png", width: 70, height: 70, fit: BoxFit.contain,)),
                                Flexible(
                                  fit: FlexFit.loose,
                                  child: FittedBox(
                                    child: Text(
                                      "KUMPULKAN POIN",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: "Brandon",
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                  ),
                                ),
                                Flexible(
                                  fit: FlexFit.loose,
                                  child: FittedBox(
                                    child: Text(
                                      "Dengan terus belanja\ndan beragam cara lainnya",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: "Brandon",
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    fit: FlexFit.loose,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Flexible(
                          fit: FlexFit.loose,
                          child: Container(
                            margin: EdgeInsets.all(10),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Flexible(
                                    fit: FlexFit.loose,
                                    child: Image.asset(
                                      "assets/images/happySkin/dapatkan-hadiah.png", width: 70, height: 70, fit: BoxFit.contain,)),
                                Flexible(
                                  fit: FlexFit.loose,
                                  child: FittedBox(
                                    child: Text(
                                      "DAPATKAN HADIAH",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: "Brandon",
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                  ),
                                ),
                                Flexible(
                                  fit: FlexFit.loose,
                                  child: FittedBox(
                                    child: Text(
                                      "Tukarkan poin dengan\nberbagai hadiah eksklusif",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: "Brandon",
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Flexible(
                          fit: FlexFit.loose,
                          child: Container(
                            margin: EdgeInsets.all(10),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Flexible(
                                    fit: FlexFit.loose,
                                    child: Image.asset(
                                      "assets/images/happySkin/naik-tingkat.png", width: 70, height: 70, fit: BoxFit.contain,)),
                                Flexible(
                                  fit: FlexFit.loose,
                                  child: FittedBox(
                                    child: Text(
                                      "NAIK TINGKAT",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: "Brandon",
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                  ),
                                ),
                                Flexible(
                                  fit: FlexFit.loose,
                                  child: FittedBox(
                                    child: Text(
                                      "Tingkatkan level membership\nuntuk dapat keuntungan lebih",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: "Brandon",
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                margin:
                EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                height: 1,
                color: Color(0xffF3C1B5),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 20),
                child: Text(
                  "FAQs",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontFamily: "Yeseva",
                  ),
                ),
              ),
              for(Faq item in faq.faq)
                faqCollapsed(item),
              Container(
                height: 20,
              )
            ],
          ),
        ),
        bottomNavigationBar: new PonnyBottomNavbar(selectedIndex: 4));
  }

}



Widget buttonGroups(String iconImg, String title, String subtitle) {
  return Container(
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(width: 1, color: Color(0xffF48262),)
    ),
    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
    child: Column(
      children: [
        Image.asset(iconImg, height: 40,),
        Container(height: 5,),
        Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 12,
            fontFamily: 'Brandon',
            fontWeight: FontWeight.w800,
          ),
        ),
        Text(
          subtitle,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 12,
            fontFamily: 'Brandon',
          ),
        ),
      ],
    ),
  );
}

Widget faqCollapsed(Faq item) {
  bool isCollapsed = true;

  return StatefulBuilder(
    builder: (BuildContext context, setState) {
      return Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 30),
            padding: EdgeInsets.symmetric(vertical: 5),
            child: IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      child: Text(
                        item.ask,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'Brandon',
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: isCollapsed ? Icon(Icons.add) : Icon(Icons.remove),
                    color: Color(0xffF48262),
                    onPressed: () {
                      setState(() {
                        isCollapsed = !isCollapsed;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            height: 1,
            color: Color(0xffF48262),
          ),
          isCollapsed
              ? Container()
              : Container(
            decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 1, color: Color(0xffF48262),))),
            margin: EdgeInsets.symmetric(horizontal: 20),
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            child: Text(
              item.ans,style: TextStyle(
              fontSize: 14,
              fontFamily: 'Brandon',
            ),
            ),
          ),
        ],
      );
    },
  );
}

Widget tableLevelReward(context) {
  return Container(
    width: double.infinity,
    height: 500,
    child: Row(
      children: [
        rowReward(
            5,
            " ",
            styledText(
              "Pembelanjaan dalam 1 tahun",
            ),
            styledText(
              "Menukar poin dengan hadiah",
            ),
            styledText(
              "Poin ekstra di Hari Ulang Tahun",
            ),
            styledText(
              "Gratis Pengiriman Standar",
            ),
            styledText(
              "Kupon Ulang Tahun",
            ),
            styledText(
              "Ekstra poin untuk member",
            ),
            styledText(
              "Ekstra diskon 5% untuk member*",
            ),
            styledText(
              "Prioritas utama tentang diskon",
            ),
            Alignment.centerLeft,
            Color(0xffF48262),
            Colors.white),
        Container(width: 3),
        rowReward(
            3,
            "DEWY",
            styledText(
              "3 juta",
            ),
            Icon(Icons.favorite, color: Color(0xffF48262), size: 18,),
            styledText(
              "0,5%",
            ),
            Icon(Icons.favorite, color: Color(0xffF48262), size: 18,),
            styledText(
              " ",
            ),
            styledText(
              "0,5%",
            ),
            Icon(Icons.favorite, color: Color(0xffF48262), size: 18,),
            Icon(Icons.favorite, color: Color(0xffF48262), size: 18,),
            Alignment.center,
            Color(0xffF48262),
            Color(0xffF48262)),
        Container(width: 3),
        rowReward(
            4,
            "HEALTHY",
            styledText(
              "6 juta",
            ),
            Icon(Icons.favorite, color: Color(0xffF48262), size: 18,),
            styledText(
              "1%",
            ),
            Icon(Icons.favorite, color: Color(0xffF48262), size: 18,),
            Icon(Icons.favorite, color: Color(0xffF48262), size: 18,),
            styledText(
              "0,75%",
            ),
            Icon(Icons.favorite, color: Color(0xffF48262), size: 18,),
            Icon(Icons.favorite, color: Color(0xffF48262), size: 18,),
            Alignment.center,
            Hexcolor("#4a0a07"),
            Hexcolor("#4a0a07")),
        Container(width: 3),
        rowReward(
            4,
            "GLOWING",
            styledText(
              "8 juta",
            ),
            Icon(Icons.favorite, color: Color(0xffF48262), size: 18,),
            styledText(
              "1,5%",
            ),
            Icon(Icons.favorite, color: Color(0xffF48262), size: 18,),
            Icon(Icons.favorite, color: Color(0xffF48262), size: 18,),
            styledText(
              "1%",
            ),
            Icon(Icons.favorite, color: Color(0xffF48262), size: 18,),
            Icon(Icons.favorite, color: Color(0xffF48262), size: 18,),
            Alignment.center,
            Hexcolor("#9aa19f"),
            Hexcolor("#8c8c8c")),
        Container(width: 3),
        rowReward(
            4,
            "OH HAPPY",
            styledText(
              ">10 juta",
            ),
            Icon(Icons.favorite, color: Color(0xffF48262), size: 18,),
            styledText(
              "2%",
            ),
            Icon(Icons.favorite, color: Color(0xffF48262), size: 18,),
            Icon(Icons.favorite, color: Color(0xffF48262), size: 18,),
            styledText(
              "1,25%",
            ),
            Icon(Icons.favorite, color: Color(0xffF48262), size: 18,),
            Icon(Icons.favorite, color: Color(0xffF48262), size: 18,),
            Alignment.center,
            Hexcolor("#8a7a00"),
            Hexcolor("#b8a200")),
      ],
    ),
  );
}

Widget rowReward(
    int flexNum,
    String rankS,
    Widget row1,
    Widget row2,
    Widget row3,
    Widget row4,
    Widget row5,
    Widget row6,
    Widget row7,
    Widget row8,
    Alignment aligns,
    Color color1,
    Color color2) {
  return Expanded(
    flex: flexNum,
    child: Column(
      children: [
        Expanded(
          child: Container(
            alignment: Alignment.center,
            width: double.infinity,
            color: Color(0xffF9E0D4),
            child: GradientText(rankS,
                gradient: LinearGradient(colors: [
                  color1,
                  color2,
                ]),
                style: TextStyle(
                  fontSize: 12,
                  fontFamily: 'Brandon',
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center),
          ),
        ),
        Expanded(
          child: Container(
              padding: EdgeInsets.symmetric(horizontal: 5),
              alignment: aligns,
              width: double.infinity,
              color: Color(0xffFDEDE4),
              child: row1),
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 5),
            alignment: aligns,
            width: double.infinity,
            color: Color(0xffFDEDE4),
            child: row2,
          ),
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 5),
            alignment: aligns,
            width: double.infinity,
            color: Color(0xffFDEDE4),
            child: row3,
          ),
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 5),
            alignment: aligns,
            width: double.infinity,
            color: Color(0xffFDEDE4),
            child: row4,
          ),
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 5),
            alignment: aligns,
            width: double.infinity,
            color: Color(0xffFDEDE4),
            child: row5,
          ),
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 5),
            alignment: aligns,
            width: double.infinity,
            color: Color(0xffFDEDE4),
            child: row6,
          ),
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 5),
            alignment: aligns,
            width: double.infinity,
            color: Color(0xffFDEDE4),
            child: row7,
          ),
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 5),
            alignment: aligns,
            width: double.infinity,
            color: Color(0xffFDEDE4),
            child: row8,
          ),
        ),
      ],
    ),
  );
}

Widget styledText(String rowText) {
  return Text(
    rowText,
    style: TextStyle(
      fontSize: 12,
      fontFamily: 'Brandon',
    ),
  );
}
