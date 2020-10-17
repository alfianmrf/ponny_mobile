import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:lodash_dart/lodash_dart.dart';
import 'package:ponny/model/Product.dart';
import 'package:ponny/screens/product_details_screen.dart';
import 'package:ponny/util/globalUrl.dart';
import 'package:lodash_dart/lodash_dart.dart' as _;



Widget LoadingWidget(context) => Center(
  child: SpinKitThreeBounce(
    color:  Color(0xffF48262),
    size: 25.0,
  ),
);


Widget LoadingWidgetFadingcube(context) => Center(
  child: SpinKitFadingCube(
    color:  Color(0xffF48262),
    size: 25.0,
  ),
);

Widget getProduct(context,Product product) => Column(
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
              child: Image.network(
                img_url+product.thumbnail_image,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
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
                child: Icon(
                  Icons.favorite_border,
                  color: Color(0xffF48262),
                  size: 20,
                ),
              ),
            ),
          ],
        ),
      ),
      Container(
        alignment: Alignment.bottomCenter,
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
        product.name,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontFamily: 'Brandon',
          fontSize: 14,
        ),
      ),
      Text(
        NumberFormat.simpleCurrency(locale: "id_ID",decimalDigits: 0 ).format(product.base_discounted_price),
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


Widget getDetailColumnProduct(context,List<Product> products) {
  List<Widget> _tmp =[];
  if(products.length ==1){

    _tmp.add(
      Expanded(
        flex: 1,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 5),
          child: getProduct(context,products[0]),
        ),
      ),
    );
    _tmp.add(
      Expanded(
        flex: 1,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 5),

        ),
      ),
    );
    _tmp.add(
      Expanded(
          flex: 1,
          child:Container(
            padding: EdgeInsets.symmetric(horizontal: 5),
          ),
      ),
    );

  }else if(products.length == 2){
    _tmp.add(
      Expanded(
        flex: 1,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 5),
          child: getProduct(context,products[0]),
        ),
      ),
    );
    _tmp.add(
      Expanded(
        flex: 1,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 5),
          child: getProduct(context,products[1]),
        ),
      ),
    );
    _tmp.add(
      Expanded(
        flex: 1,
        child:Container(
          padding: EdgeInsets.symmetric(horizontal: 5),
        ),
      ),
    );
  }else{
    for( Product product in products){
      _tmp.add(
        Expanded(
          flex: 1,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: getProduct(context,product),
          ),
        ),
      );
    }
  }

  return Container(
    child: Row(
      children: _tmp
    ),
  );
}

List<Widget> getColumProduct(context,List<Product> data,int sizes) {
  final tmp = Lodash().chunk(array: data, size: sizes);
  List<Widget> _result = [];

  for(List<Product> products in tmp){
    _result.add(getDetailColumnProduct(context,products));
  }
  return _result;
}

