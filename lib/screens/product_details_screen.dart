import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:ponny/screens/cart_screen.dart';

class ProductDetailsScreen extends StatefulWidget {
  static const String id = "product_details_screen";

  @override
  _ProductDetailsScreenState createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  @override
  void initState() {
    super.initState();
  }

  Widget product() {
    return Column(
      children: <Widget>[
        Container(
          child: Stack(
            children: <Widget>[
              GestureDetector(
                onTap: (){
                  Navigator.of(context).pushReplacementNamed(ProductDetailsScreen.id);
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
            'Skin Game',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Yeseva',
              fontSize: 16,
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
            child: RatingBar(
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

  void showAlertDialog(BuildContext context) {
    // set up the AlertDialog
    SimpleDialog alert = SimpleDialog(
      backgroundColor: Color(0xfffdf8f0),
      contentPadding: EdgeInsets.all(5.0),
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(top: 30),
          child: Icon(
            Icons.shopping_cart,
            color: Color(0xffF48262),
            size: 40,
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
                child: Image.asset(
                  'assets/images/produk_1.png',
                  width: MediaQuery.of(context).size.width*0.2,
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Skin Game',
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Brandon'
                      ),
                    ),
                    Text(
                      'Acne Warrior',
                      style: TextStyle(
                          fontFamily: 'Brandon'
                      ),
                    ),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Stack(
        children: <Widget>[
          Scaffold(
            backgroundColor: Color(0xffFDF8F0),
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              leading: Icon(
                Icons.arrow_back_ios,
              ),
              iconTheme: IconThemeData(
                color: Color(0xffF48262),
              ),
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.favorite_border),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(Icons.shopping_cart),
                  onPressed: () {
                    Navigator.of(context).pushReplacementNamed(CartScreen.id);
                  },
                ),
              ],
            ),
            body: Container(
              margin: MediaQuery.of(context).padding,
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Container(
                      height: MediaQuery.of(context).size.width * 1.2,
                      child: new Swiper(
                        itemBuilder: (BuildContext context, int index) {
                          return new Image.asset(
                            "assets/images/produk_2.png",
                            fit: BoxFit.cover,
                          );
                        },
                        itemCount: 3,
                        pagination: new SwiperPagination(
                            margin: new EdgeInsets.all(5.0),
                            builder: new DotSwiperPaginationBuilder(
                                color: Color(0xffE6E7E9), activeColor: Color(0xffF48262))),
                        control: null,
                        autoplay: false,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10, left: 15, right: 15),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "AERIS",
                              style: TextStyle(
                                fontFamily: 'Brandon',
                                fontSize: 20,
                              ),
                            ),
                            Row(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                                  margin: EdgeInsets.only(right: 10),
                                  child: Text('BPOM NA18190125265', style: TextStyle(fontSize: 12),),
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black),
                                      borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                                Icon(
                                  Icons.share,
                                  color: Color(0xffF48262),
                                ),
                              ],
                            ),
                          ]
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Sister Blendie',
                              style: TextStyle(
                                fontFamily: 'Brandon',
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text.rich(
                                TextSpan(children: <InlineSpan>[
                                  WidgetSpan(
                                    child: RatingBar(
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
                                    ),
                                  ),
                                  TextSpan(
                                      text: '(5)',
                                      style: TextStyle(
                                        fontSize: 12,
                                      )
                                  )
                                ]
                                )
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 7),
                              child: Row(
                                children: <Widget>[
                                  Text(
                                    'Rp. 125.000',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'Brandon',
                                      fontSize: 16,
                                      decoration: TextDecoration.lineThrough,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 10),
                                    child: Text(
                                      'Rp 85.000',
                                      style: TextStyle(
                                        color: Color(0xffF48262),
                                        fontFamily: 'Brandon',
                                        fontSize: 18,
                                        decoration: TextDecoration.none,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: 7),
                                    child: Text(
                                      '35%',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'Brandon'
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                      color: Color(0xffF48262),
                                      borderRadius: BorderRadius.circular(3),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Row(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                  child: Text(
                                    '60 ml',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'Brandon'
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Color(0xffF48262)),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 20),
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                  child: Text(
                                    '100 ml',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'Brandon'
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Color(0xffF48262)),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 30),
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              border: Border.all(color: Color(0xffF48262)),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'KETERANGAN',
                                      style: TextStyle(
                                        fontFamily: 'Brandon',
                                        fontSize: 15,
                                        height: 1.7,
                                      ),
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide( //                   <--- left side
                                        color: Color(0xffF48262),
                                        width: 5.0,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Os quiatur? Quidus dolore voluptia volecti omnis qui si blacea sequia sit ut reptatent atinis cus aut dunt delliquiae. Icias et iusdae rersp d igenis experio ssectus aut eatur? Nam dolu ptaerum neces id moloreperum et lab is volecepu dam etus molorporeium qui dolo bereperum volorep uditis mostiis eatur? Epelit, omniet ut que eos sit raerum faces lictat.',
                                      style: TextStyle(
                                        fontFamily: 'Brandon',
                                        fontSize: 12,
                                      ),
                                      textAlign: TextAlign.justify,
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide( //                   <--- left side
                                        color: Color(0xffF48262),
                                        width: 5.0,
                                      ),
                                    ),
                                  ),
                                ),
                                Row(
                                  children: <Widget>[
                                    Expanded(
                                      flex: 4,
                                      child: Container(
                                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            'BAHAN AKTIF',
                                            style: TextStyle(
                                              fontFamily: 'Brandon',
                                              fontSize: 15,
                                              height: 1.7,
                                            ),
                                          ),
                                        ),
                                        decoration: BoxDecoration(
                                          border: Border(
                                            bottom: BorderSide( //                   <--- left side
                                              color: Color(0xffF48262),
                                              width: 5.0,
                                            ),
                                            right: BorderSide( //                   <--- left side
                                              color: Color(0xffF48262),
                                              width: 5.0,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 6,
                                      child: Container(
                                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                'KOMPOSISI',
                                                style: TextStyle(
                                                  fontFamily: 'Brandon',
                                                  fontSize: 15,
                                                  height: 1.7,
                                                ),
                                              ),
                                            ),
                                            Icon(
                                              Icons.keyboard_arrow_down,
                                              color: Color(0xffF48262),
                                            ),
                                          ],
                                        ),
                                        decoration: BoxDecoration(
                                          border: Border(
                                            bottom: BorderSide(
                                              color: Color(0xffF48262),
                                              width: 5.0,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          'CARA PENGGUNAAN',
                                          style: TextStyle(
                                            fontFamily: 'Brandon',
                                            fontSize: 15,
                                            height: 1.7,
                                          ),
                                        ),
                                      ),
                                      Icon(
                                        Icons.keyboard_arrow_down,
                                        color: Color(0xffF48262),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 20),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Produk Rekomendasi',
                              style: TextStyle(
                                fontFamily: 'Brandon',
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                              ),
                            ),
                          ),
                          Container(
                            height: 250,
                            child: new Swiper(
                              itemBuilder: (BuildContext context, int index) {
                                return GridView.count(
                                  shrinkWrap: true,
                                  primary: false,
                                  padding: const EdgeInsets.symmetric(horizontal: 5),
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10,
                                  childAspectRatio: 0.4,
                                  crossAxisCount: 3,
                                  children: <Widget>[
                                    product(),
                                    product(),
                                    product(),
                                  ],
                                );
                              },
                              itemCount: 3,
                              pagination: null,
                              control: null,
                              autoplay: false,
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              margin: EdgeInsets.only(top: 25, bottom: 15),
                              padding: EdgeInsets.symmetric(horizontal: 15),
                              child: Text(
                                'TULIS REVIEW',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Brandon',
                                  fontSize: 15,
                                ),
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(color: Color(0xffF48262)),
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.all(10),
                            margin: EdgeInsets.only(bottom: 10),
                            decoration: BoxDecoration(
                              border: Border.all(color: Color(0xffF48262)),
                              color: Color(0xffFDDCC3),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Expanded(
                                  flex: 1,
                                  child: AspectRatio(
                                    aspectRatio: 1,
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: AssetImage('assets/images/produk.png')
                                          )
                                      ),
                                    ),
                                  )
                                ),
                                Expanded(
                                  flex: 4,
                                  child: Container(
                                    alignment: Alignment.topLeft,
                                    padding: EdgeInsets.only(left: 10),
                                    child: Column(
                                      children: <Widget>[
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            'Aninda Anita',
                                            style: TextStyle(
                                              fontFamily: 'Yeseva',
                                              fontSize: 15,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          margin: EdgeInsets.symmetric(vertical: 5),
                                          child: Text.rich(TextSpan(children: <InlineSpan>[
                                            WidgetSpan(
                                              child: RatingBar(
                                                initialRating: 4,
                                                minRating: 1,
                                                direction: Axis.horizontal,
                                                allowHalfRating: true,
                                                itemCount: 5,
                                                itemSize: 14.0,
                                                itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
                                                ratingWidget: RatingWidget(
                                                  full: Icon(
                                                    Icons.favorite,
                                                    color: Color(0xffF48262),
                                                  ),
                                                  empty: Icon(
                                                    Icons.favorite_border,
                                                    color: Color(0xffF48262),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            WidgetSpan(
                                              child: Container(
                                                margin: EdgeInsets.only(left: 10),
                                                padding: EdgeInsets.symmetric(horizontal: 5),
                                                child: Text(
                                                  'Verified by Phoebe',
                                                  style: TextStyle(
                                                      fontFamily: 'Brandon',
                                                      fontSize: 10
                                                  ),
                                                ),
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius: BorderRadius.circular(3),
                                                ),
                                              ),
                                            )
                                          ])),
                                        ),
                                        Text(
                                          'Kualitas barangnya baik, pengiriman cukup cepat produk diterima dengan baik dan juga sedang promo',
                                          style: TextStyle(
                                            fontFamily: 'Brandon',
                                            fontSize: 12,
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(top: 5),
                                          child: Row(
                                            children: <Widget>[
                                              Container(
                                                margin: EdgeInsets.only(right: 7),
                                                child: Image.asset(
                                                  'assets/images/produk_1.png',
                                                  width: MediaQuery.of(context).size.width*0.15,
                                                ),
                                              ),
                                              Container(
                                                margin: EdgeInsets.only(right: 7),
                                                child: Image.asset(
                                                  'assets/images/produk_1.png',
                                                  width: MediaQuery.of(context).size.width*0.15,
                                                ),
                                              ),
                                              Container(
                                                margin: EdgeInsets.only(right: 7),
                                                child: Image.asset(
                                                  'assets/images/produk_1.png',
                                                  width: MediaQuery.of(context).size.width*0.15,
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
                          Container(
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.all(10),
                            margin: EdgeInsets.only(bottom: 10),
                            decoration: BoxDecoration(
                              border: Border.all(color: Color(0xffF48262)),
                              color: Color(0xffFDDCC3),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Expanded(
                                    flex: 1,
                                    child: AspectRatio(
                                      aspectRatio: 1,
                                      child: Container(
                                        width: MediaQuery.of(context).size.width,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: AssetImage('assets/images/produk.png')
                                            )
                                        ),
                                      ),
                                    )
                                ),
                                Expanded(
                                  flex: 4,
                                  child: Container(
                                    alignment: Alignment.topLeft,
                                    padding: EdgeInsets.only(left: 10),
                                    child: Column(
                                      children: <Widget>[
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            'Aninda Anita',
                                            style: TextStyle(
                                              fontFamily: 'Yeseva',
                                              fontSize: 15,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          margin: EdgeInsets.symmetric(vertical: 5),
                                          child: Text.rich(TextSpan(children: <InlineSpan>[
                                            WidgetSpan(
                                              child: RatingBar(
                                                initialRating: 4,
                                                minRating: 1,
                                                direction: Axis.horizontal,
                                                allowHalfRating: true,
                                                itemCount: 5,
                                                itemSize: 14.0,
                                                itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
                                                ratingWidget: RatingWidget(
                                                  full: Icon(
                                                    Icons.favorite,
                                                    color: Color(0xffF48262),
                                                  ),
                                                  empty: Icon(
                                                    Icons.favorite_border,
                                                    color: Color(0xffF48262),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            WidgetSpan(
                                              child: Container(
                                                margin: EdgeInsets.only(left: 10),
                                                padding: EdgeInsets.symmetric(horizontal: 5),
                                                child: Text(
                                                  'Verified by Phoebe',
                                                  style: TextStyle(
                                                      fontFamily: 'Brandon',
                                                      fontSize: 10
                                                  ),
                                                ),
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius: BorderRadius.circular(3),
                                                ),
                                              ),
                                            )
                                          ])),
                                        ),
                                        Text(
                                          'Kualitas barangnya baik, pengiriman cukup cepat produk diterima dengan baik dan juga sedang promo',
                                          style: TextStyle(
                                            fontFamily: 'Brandon',
                                            fontSize: 12,
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(top: 5),
                                          child: Row(
                                            children: <Widget>[
                                              Container(
                                                margin: EdgeInsets.only(right: 7),
                                                child: Image.asset(
                                                  'assets/images/produk_1.png',
                                                  width: MediaQuery.of(context).size.width*0.15,
                                                ),
                                              ),
                                              Container(
                                                margin: EdgeInsets.only(right: 7),
                                                child: Image.asset(
                                                  'assets/images/produk_1.png',
                                                  width: MediaQuery.of(context).size.width*0.15,
                                                ),
                                              ),
                                              Container(
                                                margin: EdgeInsets.only(right: 7),
                                                child: Image.asset(
                                                  'assets/images/produk_1.png',
                                                  width: MediaQuery.of(context).size.width*0.15,
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
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            bottomNavigationBar: Container(
              width: MediaQuery.of(context).size.width,
              height: 58,
              decoration: BoxDecoration(
                color: Color(0xfffdf8f0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: ButtonBar(
                alignment: MainAxisAlignment.center,
                children: <Widget>[
                  FlatButton(
                    child: Icon(
                      Icons.favorite_border,
                      color: Colors.white,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7.0),
                    ),
                    color: Color(0xffF48262),
                    onPressed: () {/** */},
                  ),
                  FlatButton(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7.0),
                    ),
                    child: Text(
                      'MASUKKAN KERANJANG',
                      style: TextStyle(
                        fontFamily: 'Brandon',
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    color: Color(0xffF48262),
                    onPressed: () {
                      showAlertDialog(context);
                    },
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
