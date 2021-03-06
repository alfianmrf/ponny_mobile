import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:like_button/like_button.dart';
import 'package:ponny/common/constant.dart';
import 'package:ponny/main.dart';
import 'package:ponny/model/App.dart';
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

class MyProduct extends StatelessWidget {
  final VoidCallback onFavorit;
  final VoidCallback onUnFavorit;
  final VoidCallback onTobag;

  bool IsLiked = false; // new code
  Product product;
  MyProduct(
      {@required this.product,
      this.onFavorit,
      this.onTobag,
      this.IsLiked,
      this.onUnFavorit});

  Future<bool> onclick(_bool) async {
    print(_bool);
    if (!_bool) {
      this.onFavorit();
      return true;
    } else {
      this.onUnFavorit();
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: <Widget>[
        Container(
          child: Stack(
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                        builder: (BuildContext context) =>
                            new ProductDetailsScreen(
                          product: product,
                        ),
                      ));
                },
                child: AspectRatio(
                  aspectRatio: 0.7888,
                  child: Container(
                    color: Colors.white,
                    child: CachedNetworkImage(
                      memCacheHeight: 380,
                      memCacheWidth: 300,
                      imageUrl: product.thumbnail_image != null
                          ? img_url + product.thumbnail_image
                          : "",
                      placeholder: (context, url) =>
                          LoadingWidgetPulse(context),
                      errorWidget: (context, url, error) =>
                          Image.asset('assets/images/210x265.png'),
                      width: MediaQuery.of(context).size.width,
                      useOldImageOnUrlChange: true,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              if (product.is_flash_deal != null)
                Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5.0),
                          child: product.is_flash_deal.discount_type == "amount"
                              ? Text(
                                  "- " +
                                      NumberFormat.simpleCurrency(
                                              locale: "id_ID", decimalDigits: 0)
                                          .format(
                                              product.is_flash_deal.discount),
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Brandon'),
                                )
                              : Text(
                                  product.is_flash_deal.discount.toString() +
                                      '%',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Brandon'),
                                ),
                        ),
                        color: Color(0xffF48262),
                      )),
                ),
              if (product.is_flash_deal == null && product.discount > 0)
                Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5.0),
                          child: product.discount_type == "amount"
                              ? Text(
                                  "- " +
                                      NumberFormat.simpleCurrency(
                                              locale: "id_ID", decimalDigits: 0)
                                          .format(product.discount),
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Brandon'),
                                )
                              : Text(
                                  product.discount.toString() + '%',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Brandon'),
                                ),
                        ),
                        color: Color(0xffF48262),
                      )),
                ),
              LikeButton(
                mainAxisAlignment: MainAxisAlignment.end,
                padding: EdgeInsets.all(0),
                isLiked: IsLiked,
                onTap: onclick,
                likeBuilder: (bool isLiked) {
                  //
                  return Icon(
                    isLiked ? Icons.favorite : Icons.favorite_border,
                    color: Color(0xffF48262),
                    size: 20,
                  );
                },
              ),
              // Padding(
              //   padding: EdgeInsets.all(5.0),
              //   child: Align(
              //     alignment: Alignment.topRight,
              //     child: InkWell(
              //         onTap: (){
              //           this.onFavorit();
              //         },
              //         child: Icon(
              //         Icons.favorite_border,
              //         color: Color(0xffF48262),
              //         size: 20,
              //         ),
              //
              //        )
              //     ),
              //   ),
            ],
          ),
        ),
        Container(
          alignment: Alignment.bottomCenter,
          child: InkWell(
            onTap: () {
              if (product.currentStock > 0 && product.varian.length == 0) {
                this.onTobag();
              } else if (product.varian.length > 0) {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                      builder: (BuildContext context) =>
                          new ProductDetailsScreen(
                        product: product,
                      ),
                    ));
              }
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Text(
                product.currentStock > 0 || product.varian.length > 0
                    ? 'TAMBAHKAN'
                    : "STOK HABIS",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontFamily: 'Brandon'),
              ),
              color: Color(0xffF3C1B5),
            ),
          ),
        ),
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
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        MarqueeWidget(
          direction: Axis.horizontal,
          child: Text(
            product.home_discounted_price,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Brandon',
              fontSize: 14,
            ),
          ),
        ),
        if (product.is_flash_deal != null)
          MarqueeWidget(
            child: Center(
              child: RichText(
                text: TextSpan(
                    text: product.home_price,
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Brandon',
                      fontSize: 12,
                      decoration: TextDecoration.lineThrough,
                    ),
                    children: [
                      if (product.is_flash_deal.discount_type == 'percent')
                        TextSpan(
                          text: '(' +
                              product.is_flash_deal.discount.toString() +
                              '%)',
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
          ),
        if (product.is_flash_deal == null && product.discount > 0)
          MarqueeWidget(
            child: Center(
              child: RichText(
                text: TextSpan(
                    text: product.home_price,
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Brandon',
                      fontSize: 12,
                      decoration: TextDecoration.lineThrough,
                    ),
                    children: [
                      if (product.discount_type == 'percent')
                        TextSpan(
                          text: '(' + product.discount.toString() + '%)',
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
          ),
        Text.rich(TextSpan(children: <InlineSpan>[
          WidgetSpan(
            child: RatingBar.builder(
              initialRating: product.rating,
              minRating: 0,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemSize: 14.0,
              itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
              itemBuilder: (context, index) => Icon(
                Icons.favorite,
                color: Color(0xffF48262),
              ),
              unratedColor: Color(0xffFBD2CD),
              ignoreGestures: true,
            ),
          ),
          TextSpan(
              text: '(' + product.review_count.toString() + ')',
              style: TextStyle(
                fontSize: 12,
              ))
        ])),
      ],
    );
  }
}
