import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:like_button/like_button.dart';
import 'package:lodash_dart/lodash_dart.dart';
import 'package:ponny/model/FlashDeal.dart';
import 'package:ponny/model/Product.dart';
import 'package:ponny/screens/product_details_screen.dart';
import 'package:ponny/util/globalUrl.dart';
import 'package:lodash_dart/lodash_dart.dart' as _;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:url_launcher/url_launcher.dart';

Widget product(context) {
  return Column(
    children: <Widget>[
      Container(
        child: Stack(
          children: <Widget>[
            GestureDetector(
              onTap: (){
              },
              child: Image.asset(
                "assets/images/produk.png",
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10.0),
              child: Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.0),
                      child: const Text(
                        '35%',
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
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: const Text(
            'TAMBAHKAN',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontFamily: 'Brandon'),
          ),
          color: Color(0xffF3C1B5),
        ),
      ),
      Padding(
        padding: EdgeInsets.only(top: 7.0),
        child: MarqueeWidget(
          direction: Axis.horizontal,
          child: Text(
            'Skin Game',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Yeseva',
              fontSize: 16,
            ),
          ),
        ),
      ),
      Text(
        'Acne Warrior',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontFamily: 'Brandon',
          fontSize: 14,
        ),
      ),
      Text(
        'Rp. 125.000',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontFamily: 'Brandon',
          fontSize: 14,
        ),
      ),
      Center(
        child: RichText(
          text: TextSpan(
              text: 'Rp. 125.000',
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'Brandon',
                fontSize: 12,
                decoration: TextDecoration.lineThrough,
              ),
              children: [
                TextSpan(
                  text: '(35%)',
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
          child: RatingBar.builder(
            initialRating: 4,
            minRating: 1,
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
            text: '(5)',
            style: TextStyle(
              fontSize: 12,
            ))
      ])),
    ],
  );
}

Widget LoadingWidget(context) => Center(
  child: SpinKitThreeBounce(
    color:  Color(0xffF48262),
    size: 25.0,
  ),
);

Widget LoadingRing(context) => Center(
  child: SpinKitDualRing(
    color:  Color(0xffF48262),
    size: 15.0,
  ),
);

Widget LoadingWidgetFadingCircle(context) => Center(
  child: SpinKitCircle(
    color:  Color(0xffF48262),
    size: 45.0,
  ),
);

Widget LoadingWidgetPulse(context) => Center(
  child: SpinKitPulse(
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
              child: AspectRatio(
                aspectRatio: 0.7888,
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
      InkWell(
        onTap: (){
          Navigator.push(context, new MaterialPageRoute(
            builder: (BuildContext context) => new ProductDetailsScreen(product: product,),
          ));
        },
        child: Container(
          alignment: Alignment.bottomCenter,
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: const Text(
              'TAMBAHKAN',
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
            text: '('+product.review_count.toString()+')',
            style: TextStyle(
              fontSize: 12,
            ))
      ])),
    ],
  );

Widget getProductFlash(context,FlashSaleProduct productFlash) {
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
            child: AspectRatio(
              aspectRatio: 0.7888,
              child: Container(
                color: Colors.white,
                child: CachedNetworkImage(
                  imageUrl: img_url+product.thumbnail_image,
                  placeholder: (context, url) => LoadingWidgetPulse(context),
                  errorWidget: (context, url, error) => Image.asset('assets/images/basic.jpg'),
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
                ),
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
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: const Text(
          'TAMBAHKAN',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white, fontFamily: 'Brandon'),
        ),
        color: Color(0xffF3C1B5),
      ),
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
                    child: RatingBar.builder(
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
                      ignoreGestures: true,
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




Widget getDetailColumnProduct(context,List<Product> products) {
  List<Widget> _tmp =[];
  if(products.length ==1){

    _tmp.add(
      Expanded(
        flex: 1,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 7),
          child: getProduct(context,products[0]),
        ),
      ),
    );
    _tmp.add(
      Expanded(
        flex: 1,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 7),

        ),
      ),
    );
    _tmp.add(
      Expanded(
          flex: 1,
          child:Container(
            padding: EdgeInsets.symmetric(horizontal: 7),
          ),
      ),
    );

  }else if(products.length == 2){
    _tmp.add(
      Expanded(
        flex: 1,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 7),
          child: getProduct(context,products[0]),
        ),
      ),
    );
    _tmp.add(
      Expanded(
        flex: 1,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 7),
          child: getProduct(context,products[1]),
        ),
      ),
    );
    _tmp.add(
      Expanded(
        flex: 1,
        child:Container(
          padding: EdgeInsets.symmetric(horizontal: 7),
        ),
      ),
    );
  }else{
    for( Product product in products){
      _tmp.add(
        Expanded(
          flex: 1,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 7),
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

Widget getDetailColumnProductFlash(context,List<FlashSaleProduct> products) {
  List<Widget> _tmp =[];
  if(products.length ==1){

    _tmp.add(
      Expanded(
        flex: 1,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 7),
          child: getProductFlash(context,products[0]),
        ),
      ),
    );
    _tmp.add(
      Expanded(
        flex: 1,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 7),

        ),
      ),
    );
    _tmp.add(
      Expanded(
        flex: 1,
        child:Container(
          padding: EdgeInsets.symmetric(horizontal: 7),
        ),
      ),
    );

  }else if(products.length == 2){
    _tmp.add(
      Expanded(
        flex: 1,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 7),
          child: getProductFlash(context,products[0]),
        ),
      ),
    );
    _tmp.add(
      Expanded(
        flex: 1,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 7),
          child: getProductFlash(context,products[1]),
        ),
      ),
    );
    _tmp.add(
      Expanded(
        flex: 1,
        child:Container(
          padding: EdgeInsets.symmetric(horizontal: 7),
        ),
      ),
    );
  }else{
    for( FlashSaleProduct product in products){
      _tmp.add(
        Expanded(
          flex: 1,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 7),
            child: getProductFlash(context,product),
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

List<Widget> getColumProductFlash(context,List<FlashSaleProduct> data,int sizes) {
  final tmp = Lodash().chunk(array: data, size: sizes);
  List<Widget> _result = [];
  for(List<FlashSaleProduct> products in tmp){
    _result.add(getDetailColumnProductFlash(context,products));
  }
  return _result;
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}

final snackBarError = SnackBar(
  content: Text('Terjadi kesalahan pada server, silakan coba kembali nanti.!',style: TextStyle(color: Colors.white)),
  backgroundColor: Colors.redAccent,
);

final snackBarSuccess = SnackBar(
  content: Text('Success',style: TextStyle(color: Colors.white)),
  backgroundColor: Colors.green,
);

final nm_format= NumberFormat.simpleCurrency(locale: "id_ID",decimalDigits: 0 );

void showAlertDialog(BuildContext context,Product product) {
  // set up the AlertDialog
  SimpleDialog alert = SimpleDialog(
    backgroundColor: Color(0xfffdf8f0),
    contentPadding: EdgeInsets.all(5.0),
    children: <Widget>[
      Align(
        alignment: Alignment.centerRight,
        child: IconButton(
            icon: Icon(Icons.close),
            color: Color(0xffF48262),
            onPressed: () {
              Navigator.of(context).pop();
            }),
      ),
      Container(
        padding: EdgeInsets.only(top: 30),
        child: ImageIcon(
          AssetImage('assets/images/home/cart.png'),color: Color(0xffF48262),size: 30,
        ),
      ),
      Padding(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Center(
            child: Text(
              'DITAMBAHKAN KE KERANJANG',
              style: TextStyle(
                fontFamily: 'Brandon',
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: Color(0xffF48262),
              ),
            )),
      ),
      Padding(
        padding: EdgeInsets.only(top: 15, bottom: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.symmetric(horizontal: 5),
              child: CachedNetworkImage(
                imageUrl:  product.thumbnail_image != null ? img_url+product.thumbnail_image : "",
                placeholder: (context, url) => LoadingWidgetPulse(context),
                errorWidget: (context, url, error) => Image.asset('assets/images/210x265.png'),
                width: MediaQuery.of(context).size.width*0.2,
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      product.brand.name,
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Brandon'
                      ),
                    ),
                    Text(
                      product.name,
                      style: TextStyle(
                          fontFamily: 'Brandon'
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if(product.varian.isNotEmpty)
                      Text(
                        '120ml',
                        style: TextStyle(
                            fontFamily: 'Brandon'
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
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
void showWishDialog(BuildContext context, Product product) {
  // set up the AlertDialog
  SimpleDialog alert = SimpleDialog(
    backgroundColor: Color(0xfffdf8f0),
    contentPadding: EdgeInsets.all(5.0),
    children: <Widget>[
      Container(
        padding: EdgeInsets.only(top: 30),
        child: Icon(
          Icons.favorite,
          color: Color(0xffF48262),
          size: 40,
        ),
      ),
      Padding(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Center(
            child: Text(
              'DITAMBAHKAN KE WISHLIST',
              style: TextStyle(
                fontFamily: 'Brandon',
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: Color(0xffF48262),
              ),
            )),
      ),
      Padding(
        padding: EdgeInsets.only(top: 15, bottom: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.symmetric(horizontal: 5),
              child: CachedNetworkImage(
                imageUrl:  product.thumbnail_image != null ? img_url+product.thumbnail_image : "",
                placeholder: (context, url) => LoadingWidgetPulse(context),
                errorWidget: (context, url, error) => Image.asset('assets/images/210x265.png'),
                width: MediaQuery.of(context).size.width*0.2,
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    product.brand.name,
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Brandon'
                    ),
                  ),
                  Text(
                    product.name.length > 20 ? product.name.substring(0, 20)+'...' : product.name,
                    style: TextStyle(
                        fontFamily: 'Brandon'
                    ),
                  ),
                  if(product.varian.isNotEmpty)
                    Text(
                      '120ml',
                      style: TextStyle(
                          fontFamily: 'Brandon'
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}


DateTime convertDateFromString(String strDate){
  DateTime todayDate = DateTime.parse(strDate);
  return todayDate;
}
final DateFormat formatter = DateFormat('dd MMMM yyyy');

Widget getNewArival(context,List<Product> products){
  return Container(
    child: Column(
      children: [
        Container(
          padding: EdgeInsets.only(top: 20, left: 15, right: 15),
          child: Container(
            decoration: new BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10)),
              border: Border.all(
                width: 1,
                color: Color(0xffF3C1B5),
              ),
            ),
            height: 280,
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: Image.asset(
                    "assets/images/Asset 7.png",
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Text(
                    "You have no orders.",
                    style: TextStyle(
                      fontFamily: "Brandon",
                      fontSize: 14,
                    ),
                  ),
                ),
                Container(
                  child: Text(
                    "Shop top brands and cult favorites now.",
                    style: TextStyle(
                      fontFamily: "Brandon",
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 38, left: 15, right: 15),
          height: 30,
          // color: Colors.green,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Text(
                  "NEW ARRIVALS",
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: "Brandon",
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Container(
                child: Text(
                  "view more",
                  style: TextStyle(
                    fontFamily: "Brandon",
                    fontSize: 16,
                    fontWeight: FontWeight.w200,
                    color: Colors.blueGrey,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 10, left: 15, right: 15),
          height: 320,
          // color: Colors.green,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Column(
                  children: [
                    Container(
                      height: 150,
                      width: 120,
                      child: Stack(
                        overflow: Overflow.visible,
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width,
                            child: Image.asset(
                              "assets/images/produk.png",
                              fit: BoxFit.cover,
                            ),
                          ),
                          LikeButton(
                            mainAxisAlignment: MainAxisAlignment.end,
                            padding: EdgeInsets.all(0),
                            likeBuilder: (bool isLiked) {
                              return Icon(
                                isLiked ? Icons.favorite : Icons.favorite_border,
                                color: Color(0xffF48262),
                                size: 20,
                              );
                            },
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 15),
                            width: 50,
                            height: 30,
                            color: Color(0xffF48262),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "35%",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontFamily: "Brandon",
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 7, bottom: 7),
                      width: 120,
                      color: Color(0xffF3C1B5),
                      child: Text(
                        "TAMBAHKAN",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: "Brandon",
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      width: 120,
                      child: Text(
                        "Skin Game",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: "Yeseva",
                          fontSize: 14,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 0),
                      width: 120,
                      child: Text(
                        "Acne Warrior",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: "Brandon",
                          fontWeight: FontWeight.w200,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 0),
                      width: 120,
                      child: Text(
                        "Rp 100.000",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: "Brandon",
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 2),
                      child: Row(
                        children: [
                          Container(
                            child: Text(
                              "Rp 125.000",
                              style: TextStyle(
                                decoration: TextDecoration.lineThrough,
                                fontFamily: "Brandon",
                                fontSize: 12,
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 3),
                            child: Text(
                              "(35%)",
                              style: TextStyle(
                                color: Color(0xffF48262),
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 4),
                      child: Row(
                        children: [
                          Container(
                            child: Icon(
                              Icons.favorite,
                              size: 15,
                              color: Color(0xffF48262),
                            ),
                          ),
                          Container(
                            child: Icon(
                              Icons.favorite,
                              size: 15,
                              color: Color(0xffF48262),
                            ),
                          ),
                          Container(
                            child: Icon(
                              Icons.favorite,
                              size: 15,
                              color: Color(0xffF48262),
                            ),
                          ),
                          Container(
                            child: Icon(
                              Icons.favorite,
                              size: 15,
                              color: Color(0xffF48262),
                            ),
                          ),
                          Container(
                            child: Icon(
                              Icons.favorite,
                              size: 15,
                              color: Color(0xffF3C1B5),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 4),
                            child: Text(
                              "(5)",
                              style: TextStyle(
                                fontFamily: "Brandon",
                                fontSize: 14,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: Column(
                  children: [
                    Container(
                      height: 150,
                      width: 120,
                      child: Stack(
                        overflow: Overflow.visible,
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width,
                            child: Image.asset(
                              "assets/images/produk.png",
                              fit: BoxFit.cover,
                            ),
                          ),
                          LikeButton(
                            mainAxisAlignment: MainAxisAlignment.end,
                            padding: EdgeInsets.all(0),
                            likeBuilder: (bool isLiked) {
                              return Icon(
                                isLiked ? Icons.favorite : Icons.favorite_border,
                                color: Color(0xffF48262),
                                size: 20,
                              );
                            },
                          ),
                          // Container(
                          //   margin: EdgeInsets.only(top: 15),
                          //   width: 50,
                          //   height: 30,
                          //   color: Color(0xffF48262),
                          //   child: Row(
                          //     mainAxisAlignment: MainAxisAlignment.center,
                          //     children: [
                          //       Text(
                          //         "35%",
                          //         style: TextStyle(
                          //           fontSize: 12,
                          //           fontFamily: "Brandon",
                          //           color: Colors.white,
                          //           fontWeight: FontWeight.w700,
                          //         ),
                          //       ),
                          //     ],
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 7, bottom: 7),
                      width: 120,
                      color: Color(0xffF3C1B5),
                      child: Text(
                        "TAMBAHKAN",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: "Brandon",
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      width: 120,
                      child: Text(
                        "Skin Game",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: "Yeseva",
                          fontSize: 14,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 0),
                      width: 120,
                      child: Text(
                        "Acne Warrior",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: "Brandon",
                          fontWeight: FontWeight.w200,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 0),
                      width: 120,
                      child: Text(
                        "Rp 125.000",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: "Brandon",
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 4),
                      child: Row(
                        children: [
                          Container(
                            child: Icon(
                              Icons.favorite,
                              size: 15,
                              color: Color(0xffF48262),
                            ),
                          ),
                          Container(
                            child: Icon(
                              Icons.favorite,
                              size: 15,
                              color: Color(0xffF48262),
                            ),
                          ),
                          Container(
                            child: Icon(
                              Icons.favorite,
                              size: 15,
                              color: Color(0xffF48262),
                            ),
                          ),
                          Container(
                            child: Icon(
                              Icons.favorite,
                              size: 15,
                              color: Color(0xffF48262),
                            ),
                          ),
                          Container(
                            child: Icon(
                              Icons.favorite,
                              size: 15,
                              color: Color(0xffF3C1B5),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 4),
                            child: Text(
                              "(5)",
                              style: TextStyle(
                                fontFamily: "Brandon",
                                fontSize: 14,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: Column(
                  children: [
                    Container(
                      height: 150,
                      width: 120,
                      child: Stack(
                        overflow: Overflow.visible,
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width,
                            child: Image.asset(
                              "assets/images/produk.png",
                              fit: BoxFit.cover,
                            ),
                          ),
                          LikeButton(
                            mainAxisAlignment: MainAxisAlignment.end,
                            padding: EdgeInsets.all(0),
                            likeBuilder: (bool isLiked) {
                              return Icon(
                                isLiked ? Icons.favorite : Icons.favorite_border,
                                color: Color(0xffF48262),
                                size: 20,
                              );
                            },
                          ),
                          // Container(
                          //   margin: EdgeInsets.only(top: 15),
                          //   width: 50,
                          //   height: 30,
                          //   color: Color(0xffF48262),
                          //   child: Row(
                          //     mainAxisAlignment: MainAxisAlignment.center,
                          //     children: [
                          //       Text(
                          //         "35%",
                          //         style: TextStyle(
                          //           fontSize: 12,
                          //           fontFamily: "Brandon",
                          //           color: Colors.white,
                          //           fontWeight: FontWeight.w700,
                          //         ),
                          //       ),
                          //     ],
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 7, bottom: 7),
                      width: 120,
                      color: Color(0xffF3C1B5),
                      child: Text(
                        "TAMBAHKAN",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: "Brandon",
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      width: 120,
                      child: Text(
                        "Skin Game",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: "Yeseva",
                          fontSize: 14,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 0),
                      width: 120,
                      child: Text(
                        "Acne Warrior",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: "Brandon",
                          fontWeight: FontWeight.w200,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 0),
                      width: 120,
                      child: Text(
                        "Rp 125.000",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: "Brandon",
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 4),
                      child: Row(
                        children: [
                          Container(
                            child: Icon(
                              Icons.favorite,
                              size: 15,
                              color: Color(0xffF48262),
                            ),
                          ),
                          Container(
                            child: Icon(
                              Icons.favorite,
                              size: 15,
                              color: Color(0xffF48262),
                            ),
                          ),
                          Container(
                            child: Icon(
                              Icons.favorite,
                              size: 15,
                              color: Color(0xffF48262),
                            ),
                          ),
                          Container(
                            child: Icon(
                              Icons.favorite,
                              size: 15,
                              color: Color(0xffF48262),
                            ),
                          ),
                          Container(
                            child: Icon(
                              Icons.favorite,
                              size: 15,
                              color: Color(0xffF3C1B5),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 4),
                            child: Text(
                              "(5)",
                              style: TextStyle(
                                fontFamily: "Brandon",
                                fontSize: 14,
                              ),
                            ),
                          )
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
  );
}

class MarqueeWidget extends StatefulWidget {
  final Widget child;
  final Axis direction;
  final Duration animationDuration, backDuration, pauseDuration;

  MarqueeWidget({
    @required this.child,
    this.direction: Axis.horizontal,
    this.animationDuration: const Duration(milliseconds: 3000),
    this.backDuration: const Duration(milliseconds: 800),
    this.pauseDuration: const Duration(milliseconds: 800),
  });

  @override
  _MarqueeWidgetState createState() => _MarqueeWidgetState();
}

class _MarqueeWidgetState extends State<MarqueeWidget> {
  ScrollController scrollController;

  @override
  void initState() {
    scrollController = ScrollController(initialScrollOffset: 50.0);
    WidgetsBinding.instance.addPostFrameCallback(scroll);
    super.initState();
  }

  @override
  void dispose(){
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: widget.child,
      scrollDirection: widget.direction,
      controller: scrollController,
    );
  }

  void scroll(_) async {
    while (scrollController.hasClients) {
      await Future.delayed(widget.pauseDuration);
      if(scrollController.hasClients)
        await scrollController.animateTo(
            scrollController.position.maxScrollExtent,
            duration: widget.animationDuration,
            curve: Curves.ease);
      await Future.delayed(widget.pauseDuration);
      if(scrollController.hasClients)
        await scrollController.animateTo(0.0,
            duration: widget.backDuration, curve: Curves.easeOut);
    }
  }

}



