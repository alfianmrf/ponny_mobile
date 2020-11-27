import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:like_button/like_button.dart';
import 'package:ponny/common/constant.dart';
import 'package:ponny/main.dart';
import 'package:ponny/model/App.dart';
import 'package:ponny/model/FlashDeal.dart';
import 'package:ponny/model/Product.dart';
import 'package:ponny/model/User.dart';
import 'package:ponny/screens/bantuan_screen.dart';
import 'package:ponny/screens/home_screen.dart';
import 'package:ponny/screens/account_screen.dart';
import 'package:ponny/screens/Browse_Screen.dart';
import 'package:ponny/screens/forums_screen.dart';
import 'package:ponny/screens/Forum_screen.dart';
import 'package:ponny/screens/konsultasi_screen.dart';
import 'package:ponny/screens/login.dart';
import 'package:ponny/screens/product_details_screen.dart';
import 'package:ponny/util/globalUrl.dart';
import 'package:provider/provider.dart';
import 'package:ponny/screens/Browse_Screen.dart';

class MyProductFlash extends StatelessWidget {
  final VoidCallback onFavorit;
  final VoidCallback onUnFavorit;
  final VoidCallback onTobag;

  bool IsLiked = false;// new code
  FlashSaleProduct productFlash;
  MyProductFlash({@required this.productFlash,this.onFavorit,this.onTobag,this.IsLiked,this.onUnFavorit});

  Future<bool> onclick(_bool) async {
    print(_bool);
    if(!_bool){
      this.onFavorit();
      return true;
    }else{
      this.onUnFavorit();
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
   final product = productFlash.product;
    return  Column(
      children: <Widget>[
        Container(
          child: Stack(
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  Navigator.push(context, new MaterialPageRoute(
                    builder: (BuildContext context) => new ProductDetailsScreen(product: product,),
                  ));
                },
                child: Container(
                  color: Colors.white,
                  height: MediaQuery.of(context).size.width*0.35,
                  child: CachedNetworkImage(
                    imageUrl: img_url+product.thumbnail_image,
                    placeholder: (context, url) => LoadingWidgetPulse(context),
                    errorWidget: (context, url, error) => Image.asset('assets/images/basic.jpg'),
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              if(product.is_flash_deal != null)
                Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5.0),
                          child:
                          product.is_flash_deal.discount_type == "amount" ?
                          Text(
                            "- "+NumberFormat.simpleCurrency(locale: "id_ID",decimalDigits: 0 ).format(product.is_flash_deal.discount),
                            style: TextStyle(
                                color: Colors.white, fontFamily: 'Brandon'),
                          ): Text(
                            product.is_flash_deal.discount.toString()+'%',
                            style: TextStyle(
                                color: Colors.white, fontFamily: 'Brandon'),
                          ),
                        ),
                        color: Color(0xffF48262),
                      )),
                ),
              LikeButton(
                mainAxisAlignment: MainAxisAlignment.end,
                padding: EdgeInsets.all(0),
                onTap: onclick,
                isLiked: IsLiked,
                likeBuilder: (bool isLiked) {
                  return Icon(
                    isLiked ? Icons.favorite : Icons.favorite_border,
                    color: Color(0xffF48262),
                    size: 20,
                  );
                },
              ),
            ],
          ),
        ),
        Container(
          alignment: Alignment.bottomCenter,
          child: InkWell(
            onTap: (){
              this.onTobag();
            },
            child: Container(
            width: MediaQuery.of(context).size.width,
            child: const Text(
              'ADD TO BAG',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontFamily: 'Brandon'),
            ),
            color: Color(0xffF3C1B5),
          ),)
        ),
        Container(
          alignment: Alignment.bottomCenter,
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: const Text(
              'QUICK VIEW',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontFamily: 'Brandon'),
            ),
            color: Color(0xffC0AFA0),
          ),
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 5),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(3), bottomRight: Radius.circular(3)),
                border: Border.all(width: 1, color: Color(0xffF48262))
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 7.0),
                      child: MarqueeWidget(
                        direction: Axis.horizontal,
                        child: Text(
                          product.brand.name,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Yeseva',
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    Text(
                      product.name,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Brandon',
                        fontSize: 14,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                    Text(
                      product.home_discounted_price,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Brandon',
                        fontSize: 14,
                      ),
                    ),
                    if(product.is_flash_deal != null)
                      Center(
                        child: RichText(
                          text: TextSpan(
                              text: NumberFormat.simpleCurrency(locale: "id_ID",decimalDigits: 0 ).format(product.base_price),
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Brandon',
                                fontSize: 12,
                                decoration: TextDecoration.lineThrough,
                              ),
                              children: [
                                if(product.is_flash_deal.discount_type == 'percent')
                                  TextSpan(
                                    text: '('+product.is_flash_deal.discount.toString()+'%)',
                                    style: TextStyle(
                                      color: Color(0xffF48262),
                                      fontFamily: 'Brandon',
                                      fontSize: 12,
                                      decoration: TextDecoration.none,
                                    ),
                                  ),
                              ]),
                        ),
                      ),
                    Text.rich(TextSpan(children: <InlineSpan>[
                      WidgetSpan(
                        child: RatingBar(
                          initialRating: product.rating,
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
                          text: '('+product.review_count.toString()+')',
                          style: TextStyle(
                            fontSize: 12,
                          ))
                    ])),
                  ],
                ),
                Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(1),
                      ),
                      child: ClipRRect(
                        child: LinearProgressIndicator(
                          backgroundColor: Color(0xffFBDFD2),
                          value: productFlash.percentase/100,
                          valueColor: AlwaysStoppedAnimation<Color>(Color(0xffF48262)),
                          minHeight: 5,
                        ),
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      child: Text(
                        // 'Segera Habis',
                        'Tersisa '+productFlash.qty.toString(),
                        // 'Masih Tersedia',
                        style: TextStyle(
                          fontFamily: 'Brandon',
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

}