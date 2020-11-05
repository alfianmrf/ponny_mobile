import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:ponny/common/constant.dart';
import 'package:ponny/model/App.dart';
import 'package:ponny/model/Cart.dart';
import 'package:ponny/model/Product.dart';
import 'package:ponny/model/Review.dart';
import 'package:ponny/model/WishProduct.dart';
import 'package:ponny/screens/cart_screen.dart';
import 'package:ponny/screens/review_screen.dart';
import 'package:ponny/util/globalUrl.dart';
import 'package:provider/provider.dart';
import 'package:uiblock/uiblock.dart';

import 'account/daftar_keinginan_screen.dart';
import 'login.dart';
import 'package:http/http.dart' as http;

class ProductDetailsScreen extends StatefulWidget {
  static const String id = "product_details_screen";
  Product product;
  ProductDetailsScreen({Key key,this.product});

  @override
  _ProductDetailsScreenState createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  ScrollController _scrollController = new ScrollController();
  List<Review> listReview =[];
  bool isLoading =true;
  int current_page=0;
  int last_page =0;
  String NextPage;


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _getData();
      _scrollController.addListener(() {
        if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent) {
          _getMoreData();
        }
      });
    });
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
                child: Image.network(
                  img_url+widget.product.thumbnail_image,
                  width: MediaQuery.of(context).size.width*0.2,
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      widget.product.brand.name,
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Brandon'
                      ),
                    ),
                    Text(
                        widget.product.name.length > 20 ? widget.product.name.substring(0, 20)+'...' : widget.product.name,
                      style: TextStyle(
                          fontFamily: 'Brandon'
                      ),
                    ),
                    if(widget.product.varian.isNotEmpty)
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

  void showWishDialog(BuildContext context) {
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
                child: Image.network(
                  img_url+widget.product.thumbnail_image,
                  width: MediaQuery.of(context).size.width*0.2,
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      widget.product.brand.name,
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Brandon'
                      ),
                    ),
                    Text(
                      widget.product.name.length > 20 ? widget.product.name.substring(0, 20)+'...' : widget.product.name,
                      style: TextStyle(
                          fontFamily: 'Brandon'
                      ),
                    ),
                    if(widget.product.varian.isNotEmpty)
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

  Widget _buildProgressIndicator() {
    return new Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Center(
        child: new Opacity(
          opacity: isLoading ? 1.0 : 00,
          child: LoadingWidget(context),
        ),
      ),
    );
  }

  Future<Null> _getData()  async {
    String token = Provider.of<AppModel>(context,listen: false).auth.access_token;
    setState(() {
      isLoading = true;
      NextPage=null;
      listReview=[];
    });
    final response = await http.get(reviewList+"/"+widget.product.id.toString(), headers: { HttpHeaders.contentTypeHeader: 'application/json', HttpHeaders.authorizationHeader: "Bearer $token"});
    if(response.statusCode == 200)
    {
      print(response.body);
      final responseJson = json.decode(response.body);


      setState(() {
        for (Map item in responseJson["data"]) {
          listReview.add(Review.fromJson(item));
        }
        isLoading =false;
        current_page = responseJson['pagination']['current_page'];
        last_page = responseJson['pagination']['last_page'];
        NextPage = responseJson['pagination']["next_page_url"];
      });
    }

  }
  void _getMoreData() async {
    if(NextPage != null && !isLoading  && current_page <= last_page){
      String token = Provider.of<AppModel>(context,listen: false).auth.access_token;
      setState(() {
        isLoading = true;
        current_page ++;
      });
      final response = await http.get(NextPage,headers: { HttpHeaders.contentTypeHeader: 'application/json',HttpHeaders.authorizationHeader: "Bearer $token" });
      final responseJson = json.decode(response.body);

      setState(() {
        for (Map item in responseJson["data"]) {
          listReview.add(Review.fromJson(item));
        }
        isLoading =false;
        current_page = responseJson['pagination']['current_page'];
        last_page = responseJson['pagination']['last_page'];
        NextPage = responseJson['pagination']["next_page_url"];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    List<String> listBahanAktif = widget.product.bahan_aktif != null? widget.product.bahan_aktif.split(',') : [];
    final cardData = Provider.of<CartModel>(context);
    int  jmlCard= Provider.of<CartModel>(context).getCountOfquantity();
    List<Widget> ListRekomedasi;
    
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Theme.of(context).primaryColor,
      body: Stack(
        children: <Widget>[
          Scaffold(
            backgroundColor: Color(0xffFDF8F0),
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              leading:IconButton(
                icon: Icon(Icons.arrow_back_ios),
                onPressed: () =>Navigator.pop(context),
              ),
              iconTheme: IconThemeData(
                color: Color(0xffF48262),
              ),
              actions: <Widget>[

                IconButton(

                  icon: new Stack(
                      children: <Widget>[
                        Provider.of<AppModel>(context).loggedIn?
                        new Container(
                          padding: EdgeInsets.all(5),
                          child: Provider.of<WishModel>(context).loading ? LoadingRing(context) : Icon(Icons.favorite_border),
                        ):new Container(
                          padding: EdgeInsets.all(5),
                          child: Icon(Icons.favorite_border),
                        ),
                        if(Provider.of<WishModel>(context).countwishlist > 0)
                          new Positioned(  // draw a red marble
                            top: 0.0,
                            right: 0.0,
                            child: Container(
                              width: 12,
                              height: 12,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(40),
                                color: Colors.redAccent,
                              ),
                              child: Center(
                                child: Text(
                                  Provider.of<WishModel>(context).countwishlist.toString(),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Brandon',
                                    fontSize: 8,
                                  ),
                                ),
                              ),
                            ),
                          )
                      ]
                  ),
                  onPressed: () {
                    if(Provider.of<AppModel>(context).loggedIn){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>  DaftarKeinginanScreen()),
                      );
                    }else{
                      Navigator.push(context,new MaterialPageRoute(
                        builder: (BuildContext context) => new LoginScreen(),
                      ));
                    }
                  },
                ),
                IconButton(
                  icon: new Stack(
                      children: <Widget>[
                        new Container(
                          padding: EdgeInsets.all(5),
                          child: Icon(Icons.shopping_cart),
                        ),
                        if(jmlCard>0)
                          new Positioned(  // draw a red marble
                            top: 0.0,
                            right: 0.0,
                            child: Container(
                              width: 12,
                              height: 12,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(40),
                                color: Colors.redAccent,
                              ),
                              child: Center(
                                child: Text(
                                  jmlCard.toString(),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Brandon',
                                    fontSize: 8,
                                  ),
                                ),
                              ),
                            ),
                          )
                      ]
                  ),
                  onPressed: () {
                    Navigator.of(context).pushReplacementNamed(CartScreen.id);
                  },
                ),
              ],
            ),
            body: Container(
              margin: MediaQuery.of(context).padding,
              child: SingleChildScrollView(
                controller: _scrollController,
                child: Column(
                  children: <Widget>[
                    Container(
                      height: MediaQuery.of(context).size.width * 1.2,
                      child: new Swiper(
                        itemBuilder: (BuildContext context, int index) {
                          return new Image.network(
                            img_url+widget.product.photos[index],
                            fit: BoxFit.cover,
                          );
                        },
                        itemCount: widget.product.photos.length,
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
                              widget.product.brand.name,
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
                                  child: Text(widget.product.nomer_bpom != null ? widget.product.nomer_bpom :"", style: TextStyle(fontSize: 12),),
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
                              widget.product.name,
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
                                      initialRating: widget.product.rating,
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
                                      text: '('+widget.product.review_count.toString()+')',
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
                                    widget.product.home_discounted_price,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'Brandon',
                                      fontSize: 16,
                                      decoration: widget.product.is_flash_deal != null ? TextDecoration.lineThrough :null,
                                    ),
                                  ),
                                  if(widget.product.is_flash_deal != null)
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 10),
                                    child: Text(
                                      NumberFormat.simpleCurrency(locale: "id_ID",decimalDigits: 0 ).format(widget.product.base_discounted_price),
                                      style: TextStyle(
                                        color: Color(0xffF48262),
                                        fontFamily: 'Brandon',
                                        fontSize: 18,
                                        decoration: TextDecoration.none,
                                      ),
                                    ),
                                  ),
                                  if(widget.product.is_flash_deal != null)
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: 7),
                                    child:  widget.product.is_flash_deal.discount_type == "percent"? Text(
                                      '('+widget.product.is_flash_deal.discount.toString()+'%)',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'Brandon'
                                      ),
                                    ) : Text(
                                      "- "+NumberFormat.simpleCurrency(locale: "id_ID",decimalDigits: 0 ).format(widget.product.is_flash_deal.discount),
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
                          for(Varian item in widget.product.varian)(
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              padding: EdgeInsets.only(top: 9.0),
                              child: Row(
                                children: <Widget>[
                                  Text(item.atribut_name+" :"),
                                  for(String xitem in item.values)(
                                      Container(
                                        margin: EdgeInsets.symmetric(horizontal: 7),
                                        padding: EdgeInsets.symmetric(horizontal: 7),
                                        child: Text(
                                          xitem,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontFamily: 'Brandon'
                                          ),
                                        ),
                                        decoration: BoxDecoration(
                                          border: Border.all(color: Color(0xffF48262)),
                                          borderRadius: BorderRadius.circular(5),
                                        ),
                                      )
                                  )
                                ],
                              ),
                            )
                          )
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
                                       widget.product.description,
                                      style: TextStyle(
                                        fontFamily: 'Brandon',
                                        fontSize: 13,
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
                                IntrinsicHeight(
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                        flex: 4,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            border: Border(
                                              right: BorderSide( //                   <--- left side
                                                color: Color(0xffF48262),
                                                width: 5.0,
                                              ),
                                            ),
                                          ),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: List.generate(listBahanAktif.length, (index){
                                              return Container(
                                                width: MediaQuery.of(context).size.width,
                                                decoration: BoxDecoration(
                                                  border: Border(
                                                    bottom: BorderSide( //                   <--- left side
                                                      color: Color(0xffF48262),
                                                      width: 1.0,
                                                    ),
                                                  ),
                                                ),
                                                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                                                child: Text(
                                                  listBahanAktif[index],
                                                  style: TextStyle(
                                                    fontFamily: 'Brandon',
                                                    fontSize: 13,
                                                  ),
                                                ),
                                              );
                                            }),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 6,
                                        child: Container(
                                          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                                          child: Align(
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              widget.product.komposisi,
                                              style: TextStyle(
                                                fontFamily: 'Brandon',
                                                fontSize: 13,
                                              ),
                                              textAlign: TextAlign.justify,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        color: Color(0xffF48262),
                                        width: 5.0,
                                      ),
                                      top: BorderSide(
                                        color: Color(0xffF48262),
                                        width: 5.0,
                                      ),
                                    ),
                                  ),
                                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                                  child: Container(
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
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      widget.product.penggunaan != null ? widget.product.penggunaan : "",
                                      style: TextStyle(
                                        fontFamily: 'Brandon',
                                        fontSize: 13,
                                      ),
                                      textAlign: TextAlign.justify,
                                    ),
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
                            height: MediaQuery.of(context).size.width * .7,
                            child: Consumer<ProductModel>(
                              builder: (context,value,child){
                                if(value.loadingRekomendasi){
                                  return LoadingWidgetFadingCircle(context);
                                }else{
                                  ListRekomedasi = getColumProduct(context,value.Recomendasi,3);
                                  return  new Swiper(
                                    itemBuilder: (BuildContext context, int index) {
                                      return ListRekomedasi[index];
                                    },
                                    itemCount: ListRekomedasi.length,
                                    pagination: null,
                                    control: null,
                                    autoplay: false,
                                  );
                                }
                              },
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              margin: EdgeInsets.only(top: 25, bottom: 15),
                              child: InkWell(
                                onTap: (){
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ReviewScreen(),
                                    ),
                                  );
                                },
                                child: Container(
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
                            ),
                          ),
                          for(Review review in listReview)
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
                                              image:  NetworkImage(review.user.avatarOriginal != null ? img_url+ review.user.avatarOriginal : review.user.gender == "P" ? img_url+"frontend/images/avatar/avatar-female.png" : img_url+ "frontend/images/avatar/avatar-male.png" )
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
                                            review.user.name,
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
                                              child:  RatingBar(
                                                initialRating: widget.product.rating,
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
                                            if(review.statusBeli == 1)
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
                                          review.comment,
                                          style: TextStyle(
                                            fontFamily: 'Brandon',
                                            fontSize: 12,
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(top: 5),
                                          child: Row(
                                            children: review.photos.map((e) => Container(
                                              margin: EdgeInsets.only(right: 7),
                                              child:  CachedNetworkImage(
                                              imageUrl: img_url+e,
                                              placeholder: (context, url) => LoadingWidgetPulse(context),
                                              errorWidget: (context, url, error) => Image.asset('assets/images/basic.jpg'),
                                              width: MediaQuery.of(context).size.width*0.15,
                                              fit: BoxFit.cover,
                                              )
                                            )).toList()

                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if(isLoading)
                            _buildProgressIndicator()
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
                    onPressed: () {
                      if(Provider.of<AppModel>(context).loggedIn) {
                        UIBlock.block(context,customLoaderChild: LoadingWidget(context));
                        Provider.of<WishModel>(context).addProductToWish(widget.product, Provider.of<AppModel>(context).auth.access_token).then((value){
                          UIBlock.unblock(context);
                          if(value){
                            showWishDialog(context);
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
                      if(Provider.of<AppModel>(context).loggedIn){
                        UIBlock.block(context,customLoaderChild: LoadingWidget(context));
                        cardData.addProductToCart(widget.product,Provider.of<AppModel>(context).auth.access_token).then((value){
                          UIBlock.unblock(context);
                          showAlertDialog(context);
                        });
                      }else{
                        Navigator.push(context,new MaterialPageRoute(
                          builder: (BuildContext context) => new LoginScreen(),
                        ));
                      }
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
