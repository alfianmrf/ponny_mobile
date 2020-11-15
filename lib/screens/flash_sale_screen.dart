import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:ponny/common/constant.dart';
import 'package:ponny/model/FlashDeal.dart';
import 'package:ponny/model/Product.dart';
import 'package:ponny/model/ProductFlashDeal.dart';
import 'package:ponny/screens/account_screen.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:ponny/screens/product_details_screen.dart';
import 'package:ponny/util/globalUrl.dart';
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
              child: Image.network(img_url+flashdeal.detail.banner,
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
              child: Container(
                // color: Colors.green,
                margin: EdgeInsets.only(left: 20, right: 20, bottom: 5),
                child: WaterfallFlow.count(
                  crossAxisCount: 3,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 10,
                  children: [
                    for(FlashSaleProduct productflash in flashdeal.flash_products)
                    Container(
                      // width: (screenWidth - 50) / 3,
                      // color: Colors.purpleAccent,
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              GestureDetector(
                                onTap: (){
                                  Navigator.push(context, new MaterialPageRoute(
                                    builder: (BuildContext context) => new ProductDetailsScreen(product: productflash.product,),
                                  ));
                                },
                                child:CachedNetworkImage(
                                  imageUrl: img_url+productflash.product.thumbnail_image,
                                  placeholder: (context, url) => LoadingWidgetPulse(context),
                                  errorWidget: (context, url, error) => Image.asset('assets/images/basic.jpg'),
                                  width: MediaQuery.of(context).size.width,
                                  fit: BoxFit.cover,
                                ) ,
                              ),
                              Positioned(
                                top: 12,
                                child: Container(
                                  height: 25,
                                  width: 60,
                                  color: Color(0xffF48262),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        child: Text(
                                          productflash.product.is_flash_deal.discount_type == "amount" ? "- "+NumberFormat.simpleCurrency(locale: "id_ID",decimalDigits: 0 ).format(productflash.product.is_flash_deal.discount) :productflash.product.is_flash_deal.discount.toString()+'%' ,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontFamily: "Brandon",
                                            fontSize: 11,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 5,
                                right: 5,
                                child: Icon(
                                  Icons.favorite_border,
                                  size: 16,
                                  color: Color(0xffF48262),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 2, bottom: 2),
                            color: Hexcolor('#FACAC3'),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  onTap: (){
                                    Navigator.push(context, new MaterialPageRoute(
                                      builder: (BuildContext context) => new ProductDetailsScreen(product: productflash.product,),
                                    ));
                                  },
                                  child: Container(
                                    child: Text(
                                      "ADD TO BAG",
                                      style: TextStyle(
                                        fontFamily: "Brandon",
                                        fontWeight: FontWeight.w700,
                                        fontSize: 12,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                )
                                ,
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 10, bottom: 5),
                            // color: Colors.red,
                            child: Column(
                              children: [
                                Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        child: Text(
                                          productflash.product.brand.name,
                                          style: TextStyle(
                                            fontFamily: "Yeseva",
                                            fontSize: 13,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: 100,
                                        child: Text(
                                          productflash.product.name.length > 25 ? productflash.product.name.substring(0, 23)+'...' : productflash.product.name,
                                          style: TextStyle(
                                            fontFamily: "Brandon",
                                            fontSize: 13,
                                            fontWeight: FontWeight.w300,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        child: Text(
                                          productflash.product.home_discounted_price,
                                          style: TextStyle(
                                            fontFamily: "Brandon",
                                            fontSize: 13,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                if(productflash.product.is_flash_deal != null)
                                Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        child: RichText(
                                          text: TextSpan(
                                            children: <TextSpan>[
                                              TextSpan(
                                                text: NumberFormat.simpleCurrency(locale: "id_ID",decimalDigits: 0 ).format(productflash.product.base_price),
                                                style: TextStyle(
                                                  fontFamily: "Brandon",
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.w400,
                                                  decoration: TextDecoration
                                                      .lineThrough,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              if(productflash.product.is_flash_deal.discount_type == 'percent')
                                              TextSpan(
                                                text: '('+productflash.product.is_flash_deal.discount.toString()+'%)',
                                                style: TextStyle(
                                                  fontFamily: "Brandon",
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.w400,
                                                  color: Color(0xffF48262),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Text.rich(TextSpan(children: <InlineSpan>[
                                  WidgetSpan(
                                    child: RatingBar(
                                      initialRating: productflash.product.rating,
                                      minRating: 0,
                                      direction: Axis.horizontal,
                                      allowHalfRating: true,
                                      itemCount: 5,
                                      itemSize: 14.0,
                                      itemBuilder: (context, index) => Icon(
                                        Icons.favorite,
                                        color: Color(0xffF48262),
                                      ),
                                      unratedColor: Color(0xffFBD2CD),
                                    ),
                                  ),
                                  TextSpan(
                                      text: '('+productflash.product.review_count.toString()+')',
                                      style: TextStyle(
                                        fontSize: 12,
                                      ))
                                ])),
                                Container(
                                  margin: EdgeInsets.only(top: 6, bottom: 4),
                                  child: LinearPercentIndicator(
                                    lineHeight: 8.0,
                                    percent: productflash.percentase/100,
                                    progressColor: Color(0xffF48262),
                                  ),
                                ),
                                Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        child: Text(
                                          "Tersisa "+productflash.qty.toString(),
                                          style: TextStyle(
                                            fontFamily: "Brandon",
                                            fontSize: 12,
                                            fontWeight: FontWeight.w300,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: new PonnyBottomNavbar(selectedIndex: 1),
    );
  }
}
