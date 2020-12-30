import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:lodash_dart/lodash_dart.dart';
import 'package:ponny/common/constant.dart';
import 'package:ponny/model/App.dart';
import 'package:ponny/model/Cart.dart';
import 'package:ponny/model/Product.dart';
import 'package:ponny/model/WishProduct.dart';
import 'package:ponny/screens/home_screen.dart';
import 'package:ponny/screens/account_screen.dart';
import 'package:ponny/screens/account/daftar_keinginan_sukses_screen.dart';
import 'package:ponny/screens/login.dart';
import 'package:ponny/screens/product_details_screen.dart';
import 'package:ponny/util/globalUrl.dart';
import 'package:ponny/widgets/MyProduct.dart';
import 'package:ponny/widgets/PonnyBottomNavbar.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:uiblock/uiblock.dart';

class DaftarKeinginanScreen extends StatefulWidget {
  static const String id = "daftar_keinginan_Screen";
  @override
  _DaftarKeinginanStateScreen createState() => _DaftarKeinginanStateScreen();
}

class _DaftarKeinginanStateScreen extends State<DaftarKeinginanScreen>{

final _scaffoldKey = GlobalKey<ScaffoldState>();
  var refreshKey = GlobalKey<RefreshIndicatorState>();

  int current_page=0;
  int last_page =0;
  String _valFriends;
  String _q ="";
  String NextPage;
  List<Wish> _result=[];
  bool isLoading = true;
  ScrollController _scrollController = new ScrollController();

@override
void initState() {
  this._getMoreData();
  super.initState();
  WidgetsBinding.instance.addPostFrameCallback((_) async {
    _getData();
  });

  _scrollController.addListener(() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      _getMoreData();
    }
  });

}


void showAlertDialog(BuildContext context,Product product) {
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
                img_url+product.thumbnail_image,
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
                   product.name.length > 20 ?product.name.substring(0, 20)+'...' : product.name,
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
    setState(() {
      isLoading = true;
      NextPage=null;
      _result=[];
    });
    var token = Provider.of<AppModel>(context, listen: false).auth.access_token;
    final response = await http.get(listOfwishlist,headers: { HttpHeaders.contentTypeHeader: 'application/json',HttpHeaders.authorizationHeader: "Bearer $token" });
    if(response.statusCode == 200)
    {
      final responseJson = json.decode(response.body);
      print(responseJson['data']);

      setState(() {
        for (Map item in responseJson['data']){
          if(item != null)
          _result.add(Wish.fromJson(item));
        }
        isLoading =false;
        current_page = responseJson['current_page'];
        last_page = responseJson['last_page'];
        NextPage = responseJson["next_page_url"];
      });
      print(_result.length);

    }else{

    }

  }

  void _getMoreData() async {
    if(NextPage != null && !isLoading  && current_page <= last_page){
      setState(() {
        isLoading = true;
        current_page ++;
      });
      var token = Provider.of<AppModel>(context).auth.access_token;
      final response = await http.get(NextPage,headers: { HttpHeaders.contentTypeHeader: 'application/json',HttpHeaders.authorizationHeader: "Bearer $token" });
      final responseJson = json.decode(response.body);
      print(responseJson);
      setState(() {
        for (Map item in responseJson["data"]) {
          _result.add(Wish.fromJson(item));
        }
      });
      setState(() {
        isLoading =false;
        NextPage = responseJson["next_page_url"];
        last_page = responseJson['last_page'];
      });
    }
  }

Widget _buildList() {
  return ListView.builder(
    scrollDirection: Axis.vertical,
    itemCount: _result.length + 1,
    itemBuilder: (BuildContext context, int index) {
      if (index == _result.length) {
        return _buildProgressIndicator();
      } else {
        return Container(
          margin: EdgeInsets.only(left: 10, right: 10, bottom: 3),
          child: Row(
            children: [
              Container(
                width: 75,
                child: InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetailsScreen(product: _result[index].product,)));
                  },
                  child: CachedNetworkImage(
                    imageUrl: _result[index].product.thumbnail_image != null ? img_url+_result[index].product.thumbnail_image :"",
                    placeholder: (context, url) => LoadingWidgetPulse(context),
                    errorWidget: (context, url, error) => Image.asset('assets/images/210x265.png'),
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.cover,
                  ),
                ) ,
              ),
              Expanded(
                child: InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetailsScreen(product: _result[index].product,)));
                  },
                  child:  Container(
                    padding: EdgeInsets.only(
                        left: 5,
                        right: 5
                    ),
                    width: 90,
                    height: 150,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          child: Text(
                            _result[index].product.brand.name,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontFamily: "Yeseva",
                              fontSize: 12,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 0),
                          child: Text(
                            _result[index].product.name,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontFamily: "Brandon",
                              fontWeight: FontWeight.w200,
                              fontSize: 10,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 0),
                          child: Text(
                            _result[index].product.home_discounted_price,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontFamily: "Brandon",
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        Container(
                          child: Text.rich(TextSpan(children: <InlineSpan>[
                            WidgetSpan(
                              child: RatingBar.builder(
                                initialRating: _result[index].product.rating,
                                minRating: 0,
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                itemCount: 5,
                                itemSize: 12.0,
                                itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
                                itemBuilder: (context, index) => Icon(
                                  Icons.favorite,
                                  color: Color(0xffF48262),
                                ),
                                unratedColor: Color(0xffFBD2CD),
                              ),
                            ),
                            TextSpan(
                                text: '('+_result[index].product.review_count.toString()+')',
                                style: TextStyle(
                                  fontSize: 12,
                                ))
                          ])),
                        )
                        ,
                      ],
                    ),
                  ) ,
                )
                 ,
              ),
              Container(
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: (){
                        UIBlock.block(context,customLoaderChild: LoadingWidget(context));
                        Provider.of<CartModel>(context).addProductToCart(_result[index].product, Provider.of<AppModel>(context).auth.access_token,null).then((value){
                          UIBlock.unblock(context);
                          if(value.statusCode == 200){
                            showAlertDialog(context, _result[index].product);
                          }else{
                            final snackBar = SnackBar(
                              content: Text(value.message,style: TextStyle(color: Colors.white)),
                              backgroundColor: Colors.redAccent,
                            );
                            _scaffoldKey.currentState.showSnackBar(snackBar);
                          }
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: 5),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color(0xffF48262),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: EdgeInsets.all(7),
                          child: Text(
                            "TAMBAH KE KERANJANG",
                            style: TextStyle(
                              fontSize: 10,
                              fontFamily: "Brandon",
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        UIBlock.block(context,customLoaderChild: LoadingWidget(context));
                        Provider.of<WishModel>(context).removeProductFromWish(_result[index].product, Provider.of<AppModel>(context).auth.access_token).then((value){
                          UIBlock.unblock(context);
                          if(value){
                            _getData();
                            _scaffoldKey.currentState.showSnackBar(snackBarSuccess);
                          }else{
                            _scaffoldKey.currentState.showSnackBar(snackBarError);
                          }
                        });
                      },
                      child:Container(
                        height: 22,
                        width: 22,
                        child: ImageIcon(
                          AssetImage('assets/images/trash.png'),
                          color: Color(0xffF48262),
                        ),
                      ) ,
                    )

                  ],
                ),
              ),
            ],
          ),
        );
      }
    },
    controller: _scrollController,

  );
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        titleSpacing: 0.0,
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            color: Color(0xffF48262),
          ),
        ),
        title: Text(
          'Daftar Keinginan',
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
            preferredSize: Size.fromHeight(1.0)),
      ),
      resizeToAvoidBottomInset: false,
      backgroundColor: Hexcolor('#FCF8F0'),
      body: isLoading ? Center(child: LoadingWidget(context),) :  _result.length > 0? _buildList() : SingleChildScrollView(
        child: Column(
          children: <Widget>[
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
                        "assets/images/Asset 10.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      child: Text(
                        "Wishlist-mu masih kosong, nih.",
                        style: TextStyle(
                          fontFamily: "Brandon",
                          fontSize: 14,
                        ),
                      ),
                    ),
                    Container(
                      child: Text(
                        "Yuk, lihat-lihat produk menarik di Ponny Beaute!",
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
                  /*
                  InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => DaftarKeinginanSuksesScreen()));
                    },
                    child: Container(
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
                  ),*/
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10, left: 15, right: 15),
              height: 320,
              // color: Colors.green,
              child: Consumer<ProductModel>(
                  builder: (context,value,child) {
                      if (value.loadingNews) {
                      return Center(
                      child: LoadingWidgetFadingCircle(context),
                      );
                      } else {
                        var listnews = Lodash().chunk(array: value.news, size: 3);
                        return new Swiper(
                          itemCount: listnews.length,
                          itemBuilder: (BuildContext context, int index) {
                            if(listnews[index].length == 3) {
                              return Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween,
                                children: [
                                  for( Product item_product in listnews[index])
                                    Expanded(
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 5),
                                        child: MyProduct(
                                          product: item_product,
                                          IsLiked: Provider
                                              .of<WishModel>(context)
                                              .rawlist
                                              .firstWhere((element) =>
                                          element.productId == item_product.id,
                                              orElse: () => null) != null
                                              ? true
                                              : false,
                                          onFavorit: () {
                                            if (Provider
                                                .of<AppModel>(context)
                                                .loggedIn) {
                                              Provider.of<WishModel>(context)
                                                  .addProductToWish(
                                                  item_product, Provider
                                                  .of<AppModel>(context)
                                                  .auth
                                                  .access_token);
                                            } else {
                                              Navigator.push(context,
                                                  new MaterialPageRoute(
                                                    builder: (
                                                        BuildContext context) => new LoginScreen(),
                                                  ));
                                            }
                                          },
                                          onUnFavorit: () {
                                            if (Provider
                                                .of<AppModel>(context)
                                                .loggedIn) {
                                              Provider.of<WishModel>(context)
                                                  .removeProductFromWish(
                                                  item_product, Provider
                                                  .of<AppModel>(context)
                                                  .auth
                                                  .access_token);
                                            } else {
                                              Navigator.push(context,
                                                  new MaterialPageRoute(
                                                    builder: (
                                                        BuildContext context) => new LoginScreen(),
                                                  ));
                                            }
                                          },
                                          onTobag: () {
                                            if (Provider
                                                .of<AppModel>(context)
                                                .loggedIn) {
                                              UIBlock.block(context,
                                                  customLoaderChild: LoadingWidget(
                                                      context));
                                              Provider.of<CartModel>(context)
                                                  .addProductToCart(
                                                  item_product, Provider
                                                  .of<AppModel>(context)
                                                  .auth
                                                  .access_token, null)
                                                  .then((value) {
                                                UIBlock.unblock(context);
                                                showAlertDialog(
                                                    context, item_product);
                                              });
                                            } else {
                                              Navigator.push(context,
                                                  new MaterialPageRoute(
                                                    builder: (
                                                        BuildContext context) => new LoginScreen(),
                                                  ));
                                            }
                                          },
                                        ),
                                      ),

                                    ),
                                ],
                              );
                            }else if(listnews[index].length == 2){
                              return Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween,
                                children: [
                                  for( Product item_product in listnews[index])
                                    Expanded(
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 5),
                                        child: MyProduct(
                                          product: item_product,
                                          IsLiked: Provider
                                              .of<WishModel>(context)
                                              .rawlist
                                              .firstWhere((element) =>
                                          element.productId == item_product.id,
                                              orElse: () => null) != null
                                              ? true
                                              : false,
                                          onFavorit: () {
                                            if (Provider
                                                .of<AppModel>(context)
                                                .loggedIn) {
                                              Provider.of<WishModel>(context)
                                                  .addProductToWish(
                                                  item_product, Provider
                                                  .of<AppModel>(context)
                                                  .auth
                                                  .access_token);
                                            } else {
                                              Navigator.push(context,
                                                  new MaterialPageRoute(
                                                    builder: (
                                                        BuildContext context) => new LoginScreen(),
                                                  ));
                                            }
                                          },
                                          onUnFavorit: () {
                                            if (Provider
                                                .of<AppModel>(context)
                                                .loggedIn) {
                                              Provider.of<WishModel>(context)
                                                  .removeProductFromWish(
                                                  item_product, Provider
                                                  .of<AppModel>(context)
                                                  .auth
                                                  .access_token);
                                            } else {
                                              Navigator.push(context,
                                                  new MaterialPageRoute(
                                                    builder: (
                                                        BuildContext context) => new LoginScreen(),
                                                  ));
                                            }
                                          },
                                          onTobag: () {
                                            if (Provider
                                                .of<AppModel>(context)
                                                .loggedIn) {
                                              UIBlock.block(context,
                                                  customLoaderChild: LoadingWidget(
                                                      context));
                                              Provider.of<CartModel>(context)
                                                  .addProductToCart(
                                                  item_product, Provider
                                                  .of<AppModel>(context)
                                                  .auth
                                                  .access_token, null)
                                                  .then((value) {
                                                UIBlock.unblock(context);
                                                showAlertDialog(
                                                    context, item_product);
                                              });
                                            } else {
                                              Navigator.push(context,
                                                  new MaterialPageRoute(
                                                    builder: (
                                                        BuildContext context) => new LoginScreen(),
                                                  ));
                                            }
                                          },
                                        ),
                                      ),

                                    ),
                                    Expanded(
                                    child: Container(
                                    ),

                                  )
                                ],
                              );
                            }else{
                              return Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween,
                                children: [
                                  for( Product item_product in listnews[index])
                                    Expanded(
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 5),
                                        child: MyProduct(
                                          product: item_product,
                                          IsLiked: Provider
                                              .of<WishModel>(context)
                                              .rawlist
                                              .firstWhere((element) =>
                                          element.productId == item_product.id,
                                              orElse: () => null) != null
                                              ? true
                                              : false,
                                          onFavorit: () {
                                            if (Provider
                                                .of<AppModel>(context)
                                                .loggedIn) {
                                              Provider.of<WishModel>(context)
                                                  .addProductToWish(
                                                  item_product, Provider
                                                  .of<AppModel>(context)
                                                  .auth
                                                  .access_token);
                                            } else {
                                              Navigator.push(context,
                                                  new MaterialPageRoute(
                                                    builder: (
                                                        BuildContext context) => new LoginScreen(),
                                                  ));
                                            }
                                          },
                                          onUnFavorit: () {
                                            if (Provider
                                                .of<AppModel>(context)
                                                .loggedIn) {
                                              Provider.of<WishModel>(context)
                                                  .removeProductFromWish(
                                                  item_product, Provider
                                                  .of<AppModel>(context)
                                                  .auth
                                                  .access_token);
                                            } else {
                                              Navigator.push(context,
                                                  new MaterialPageRoute(
                                                    builder: (
                                                        BuildContext context) => new LoginScreen(),
                                                  ));
                                            }
                                          },
                                          onTobag: () {
                                            if (Provider
                                                .of<AppModel>(context)
                                                .loggedIn) {
                                              UIBlock.block(context,
                                                  customLoaderChild: LoadingWidget(
                                                      context));
                                              Provider.of<CartModel>(context)
                                                  .addProductToCart(
                                                  item_product, Provider
                                                  .of<AppModel>(context)
                                                  .auth
                                                  .access_token, null)
                                                  .then((value) {
                                                UIBlock.unblock(context);
                                                showAlertDialog(
                                                    context, item_product);
                                              });
                                            } else {
                                              Navigator.push(context,
                                                  new MaterialPageRoute(
                                                    builder: (
                                                        BuildContext context) => new LoginScreen(),
                                                  ));
                                            }
                                          },
                                        ),
                                      ),

                                    ),
                                    Expanded(
                                    child: Container(
                                    )
                                  ),
                                  Expanded(
                                    child: Container(
                                    ),
                                  )
                                ],
                              );
                            }
                          },
                          control: null,
                          autoplay: true,
                        );



                      }
                  }
              ),
            ),
          ],
        ),
      ) ,
      bottomNavigationBar: new PonnyBottomNavbar(selectedIndex: 4),
    );
  }
}
