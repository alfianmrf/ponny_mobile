import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
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
  final VoidCallback onTobag;// new code
  Product product;
  MyProduct({@required this.product,this.onFavorit,this.onTobag});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
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
                  child: CachedNetworkImage(
                    imageUrl:product.thumbnail_image != null?  img_url+product.thumbnail_image:"",
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
              Padding(
                padding: EdgeInsets.all(5.0),
                child: Align(
                  alignment: Alignment.topRight,
                  child: InkWell(
                      onTap: (){
                        this.onFavorit();
                      },
                      child: Icon(
                      Icons.favorite_border,
                      color: Color(0xffF48262),
                      size: 20,
                      ),

                     )
                  ),
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
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 7.0),
          child: Text(
            product.brand.name,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Yeseva',
              fontSize: 16,
            ),
          ),
        ),
        Text(
          product.name.length > 25 ? product.name.substring(0, 25)+'...' : product.name,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Brandon',
            fontSize: 14,
          ),
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
              itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
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
    );
  }

}