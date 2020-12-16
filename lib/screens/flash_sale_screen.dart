import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:ponny/common/constant.dart';
import 'package:ponny/model/App.dart';
import 'package:ponny/model/Cart.dart';
import 'package:ponny/model/FlashDeal.dart';
import 'package:ponny/model/Product.dart';
import 'package:ponny/model/ProductFlashDeal.dart';
import 'package:ponny/model/WishProduct.dart';
import 'package:ponny/screens/account_screen.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:ponny/screens/login.dart';
import 'package:ponny/screens/product_details_screen.dart';
import 'package:ponny/util/globalUrl.dart';
import 'package:ponny/widgets/MyProductFlash.dart';
import 'package:provider/provider.dart';
import 'package:uiblock/uiblock.dart';
import 'package:waterfall_flow/waterfall_flow.dart';
import 'package:ponny/widgets/PonnyBottomNavbar.dart';

import 'home_screen.dart';

class FlashSaleScreen extends StatefulWidget {
  static const String id = "Flash_Sale_Screen";
  @override
  _FlashSaleStateScreen createState() => _FlashSaleStateScreen();
}

class _FlashSaleStateScreen extends State<FlashSaleScreen> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    final flashdeal = Provider.of<ProductModel>(context).flashsale;

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0.0,
        elevation: 0.0,
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            color: Color(0xffF48262),
          ),
        ),
        title: Text(
          flashdeal.detail.title,
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
            preferredSize: Size.fromHeight(1.0)
        ),
      ),
      resizeToAvoidBottomInset: false,
      backgroundColor: Hexcolor('#FCF8F0'),
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 10, bottom: 10),
              color: Hexcolor('#FACAC3'),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: Text(
                      "FLASH SALE",
                      style: TextStyle(
                        fontFamily: "Brandon",
                        fontWeight: FontWeight.w600,
                        fontSize: 22,
                        color: Color(0xffF48262),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 120,
              child: CachedNetworkImage(
                imageUrl:flashdeal.detail.banner != null ? img_url+flashdeal.detail.banner : "",
                placeholder: (context, url) => LoadingWidgetPulse(context),
                errorWidget: (context, url, error) => Image.asset('assets/images/1680x600.png'),
                fit: BoxFit.cover,
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 15, bottom: 15),
              // color: Colors.green,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: Text(
                      DateTime.now().isBefore(DateTime.fromMillisecondsSinceEpoch(flashdeal.detail.startDate * 1000))? 'DIMULAI DALAM':'BERAKHIR DALAM',
                      style: TextStyle(
                        fontFamily: "Brandon",
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Container(
                    child: Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: CountdownTimer(
                            endTime: DateTime.now().isBefore(DateTime.fromMillisecondsSinceEpoch(flashdeal.detail.startDate * 1000)) ?flashdeal.detail.startDate*1000:flashdeal.detail.endDate*1000,
                            onEnd:(){
                              UIBlock.block(context,customLoaderChild: LoadingWidget(context));
                              Provider.of<ProductModel>(context).getFlashSale().then((value){
                                UIBlock.unblock(context);
                                Navigator.pushNamedAndRemoveUntil(
                                    context,
                                    HomeScreen.id,(_) => false
                                );
                              }).catchError((onError){
                                UIBlock.unblock(context);
                              });

                            },
                            widgetBuilder: (BuildContext context, CurrentRemainingTime time) {
                              return Row(
                                children: [
                                  Container(
                                    width: 24,
                                    height: 24,
                                    decoration: BoxDecoration(
                                      color: Color(0xffF48262),
                                      borderRadius: BorderRadius.circular(3),
                                    ),
                                    child: Center(
                                      child: Text(
                                        time.days != null ? time.days.toString():"00",
                                        style: TextStyle(
                                          fontFamily: 'Brandon',
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 5),
                                    child: Text(
                                      ':',
                                      style: TextStyle(
                                        fontFamily: 'Brandon',
                                        color: Color(0xffF48262),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 24,
                                    height: 24,
                                    decoration: BoxDecoration(
                                      color: Color(0xffF48262),
                                      borderRadius: BorderRadius.circular(3),
                                    ),
                                    child: Center(
                                      child: Text(
                                        time.hours != null ?time.hours.toString(): "00",
                                        style: TextStyle(
                                          fontFamily: 'Brandon',
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 5),
                                    child: Text(
                                      ':',
                                      style: TextStyle(
                                        fontFamily: 'Brandon',
                                        color: Color(0xffF48262),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 24,
                                    height: 24,
                                    decoration: BoxDecoration(
                                      color: Color(0xffF48262),
                                      borderRadius: BorderRadius.circular(3),
                                    ),
                                    child: Center(
                                      child: Text(
                                        time.min != null ? time.min.toString(): "00",
                                        style: TextStyle(
                                          fontFamily: 'Brandon',
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 5),
                                    child: Text(
                                      ':',
                                      style: TextStyle(
                                        fontFamily: 'Brandon',
                                        color: Color(0xffF48262),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 24,
                                    height: 24,
                                    decoration: BoxDecoration(
                                      color: Color(0xffF48262),
                                      borderRadius: BorderRadius.circular(3),
                                    ),
                                    child: Center(
                                      child: Text(
                                        time.sec != null? time.sec.toString() :"00",
                                        style: TextStyle(
                                          fontFamily: 'Brandon',
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            }
                        )
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView( child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                    GridView.count(
                    childAspectRatio: 0.38,
                    padding: EdgeInsets.fromLTRB(20.0, 0, 20.0, 10.0),
                    shrinkWrap: true,
                    crossAxisCount: 3,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 15,
                      physics: ScrollPhysics(),
                    children: [
                      for(FlashSaleProduct e in flashdeal.flash_products)
                        Container(
                          child: MyProductFlash(
                            productFlash: e,
                            IsLiked: Provider.of<WishModel>(context).rawlist.firstWhere((element) => element.productId == e.product.id, orElse: () => null) != null ? true:false,
                            onFavorit: (){
                              if(Provider.of<AppModel>(context).loggedIn) {
                                Provider.of<WishModel>(context).addProductToWish(e.product, Provider.of<AppModel>(context).auth.access_token);
                              }else{
                                Navigator.push(context,new MaterialPageRoute(
                                  builder: (BuildContext context) => new LoginScreen(),
                                ));
                              }
                            },
                            onUnFavorit: (){
                              if(Provider.of<AppModel>(context).loggedIn) {
                                Provider.of<WishModel>(context).removeProductFromWish(e.product, Provider.of<AppModel>(context).auth.access_token);
                              }else{
                                Navigator.push(context,new MaterialPageRoute(
                                  builder: (BuildContext context) => new LoginScreen(),
                                ));
                              }
                            },
                            onTobag: (){
                              if(Provider.of<AppModel>(context).loggedIn){
                                UIBlock.block(context,customLoaderChild: LoadingWidget(context));
                                Provider.of<CartModel>(context).addProductToCart(e.product,Provider.of<AppModel>(context).auth.access_token,null).then((value){
                                  UIBlock.unblock(context);
                                  showAlertDialog(context,e.product);
                                });
                              }else{
                                Navigator.push(context,new MaterialPageRoute(
                                  builder: (BuildContext context) => new LoginScreen(),
                                ));
                              }
                            },
                          ),
                        )
                    ],
                  ),
                ]
            ),
            ),
            )
          ],
        ),
      ),
      bottomNavigationBar: new PonnyBottomNavbar(selectedIndex: 1),
    );
  }
}
