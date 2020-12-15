import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:ponny/common/constant.dart';
import 'package:ponny/model/App.dart';
import 'package:ponny/model/Cart.dart';
import 'package:ponny/model/Product.dart';
import 'package:ponny/model/WishProduct.dart';
import 'package:ponny/screens/login.dart';
import 'package:ponny/util/globalUrl.dart';
import 'package:ponny/widgets/MyProduct.dart';
import 'package:ponny/widgets/PonnyBottomNavbar.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:ponny/screens/product_details_screen.dart';
import 'package:ponny/screens/Browse_Screen.dart';
import 'package:provider/provider.dart';
import 'package:uiblock/uiblock.dart';
import 'package:http/http.dart' as http;

class ShopSale extends StatefulWidget {
  ShopSale({Key key}) : super(key: key);

  @override
  _ShopSaleState createState() => _ShopSaleState();
}

class _ShopSaleState extends State<ShopSale> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool loadingProduct=true;
  ScrollController _scrollController = new ScrollController();
  bool loadmore = false;
  List<Product> dataProduct=[];
  String NextUrl;
  int current_page=1;
  int last_page =1;
  String filter;
  String _q ="";
  TextEditingController _seachcontroller = new TextEditingController();
  int total=0;
  var _currentSliderValue = RangeValues(0, 3000000);
  List<String> checked = [];
  bool LoadingBrand=true;
  int subKategorysearch = 0;
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      getProductSearch();
      _scrollController.addListener(() {
        if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent) {
          loadMore();
        }
      });
    });

  }

  getProductSearch(){
    setState(() {
      loadingProduct =true;
      loadmore =false;
      dataProduct=[];
    });
    var param =<String,dynamic>{
    };

    if(_q.isNotEmpty){
      param.addAll({
        "q":_q
      });
      print(param);
    }

    http.post(shopSalelist,headers: { HttpHeaders.contentTypeHeader: 'application/json'},body: json.encode(param)).then((value){
      if(value.statusCode == 200){
        final result = json.decode(value.body);
        setState(() {
          current_page = result["products"]["current_page"];
          last_page =  result["products"]["last_page"];
          total = result["products"]["total"];
          for(Map item in result["products"]["data"]){
            dataProduct.add(Product.fromJson(item["availability"]));
          }
          loadmore =false;
          loadingProduct= false;
        });
      }
    }).catchError((onError){
      setState(() {
        loadmore =false;
        loadingProduct =false;
      });
    });
  }



  loadMore() {
    if (current_page < last_page) {
      setState(() {
        loadmore = true;
        current_page++;
      });
      var param = <String, dynamic>{"page": current_page};
      if (_q.isNotEmpty) {
        param.addAll({
          "q": _q
        });
        print(param);
      }
      http.post(shopSalelist,headers: { HttpHeaders.contentTypeHeader: 'application/json'}, body: json.encode(param)).then((value) {
        if (value.statusCode == 200) {
          final result = json.decode(value.body);
          setState(() {
            current_page = result["products"]["current_page"];
            last_page = result["products"]["last_page"];
            total = result["products"]["total"];
            for (Map item in result["products"]["data"]) {
              dataProduct.add(Product.fromJson(item["availability"]));
            }
            loadmore = false;
          });
        }
      }).catchError((onError) {
        setState(() {
          loadmore = false;
        });
      });
    }
  }
  Widget _buildProgressIndicator() {
    return new Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Center(
        child: new Opacity(
          opacity: loadmore ? 1.0 : 00,
          child: LoadingWidget(context),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      resizeToAvoidBottomInset: false,
      backgroundColor: Hexcolor('#FCF8F0'),
      body: Column(
        children: [ Container(
                height: 35,
              ),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Colors.white),
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.only(left: 10, top: 10, right: 10),
            child: Row(children: [
              Icon(Icons.search, color: Color(0xffF48262)),
              Expanded(
                  child: TextField(
                    controller: _seachcontroller,
                onSubmitted: (String q){
                      setState(() {
                        _q=q;
                      });
                      getProductSearch();
                },
                cursorColor: Colors.black,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.go,
                decoration:
                    new InputDecoration.collapsed(hintText: "Search..."),
              ))
            ]),
          ),
          Container(
            margin: EdgeInsets.all(5),
            child: Row(
              children: [
                Container(
                  child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: Color(0xffF48262),
                        size: 26,
                      )),
                ),
                Container(
                  child: Text(
                    "Shop Sale",
                    style: TextStyle(
                      fontSize: 24,
                      fontFamily: "Yeseva",
                      fontWeight: FontWeight.w500,
                      color: Color(0xffF48262),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 20),
            height: 1,
            color: Color(0xffF3C1B5),
          ),
          Expanded(
            child:SingleChildScrollView(
            controller: _scrollController,
            child: loadingProduct?Container(
              height:150,
              child: Center(
                child: LoadingWidgetFadingCircle(context),
              ),
            ): Column(children: [
              Container(
                child: GridView.count(
                  childAspectRatio: 0.45,
                  padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 10.0),
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  physics: ScrollPhysics(),
                  children: [
                    for( Product item_product in dataProduct)
                      MyProduct(
                        product: item_product,
                        IsLiked: Provider.of<WishModel>(context).rawlist.firstWhere((element) => element.productId == item_product.id, orElse: () => null) != null ? true:false,
                        onFavorit: (){
                          if(Provider.of<AppModel>(context).loggedIn) {
                            Provider.of<WishModel>(context).addProductToWish(item_product, Provider.of<AppModel>(context).auth.access_token);
                          }else{
                            Navigator.push(context,new MaterialPageRoute(
                              builder: (BuildContext context) => new LoginScreen(),
                            ));
                          }
                        },
                        onUnFavorit: (){
                          if(Provider.of<AppModel>(context).loggedIn) {
                            Provider.of<WishModel>(context).removeProductFromWish(item_product, Provider.of<AppModel>(context).auth.access_token);
                          }else{
                            Navigator.push(context,new MaterialPageRoute(
                              builder: (BuildContext context) => new LoginScreen(),
                            ));
                          }
                        },
                        onTobag: (){
                          if(Provider.of<AppModel>(context).loggedIn){
                            UIBlock.block(context,customLoaderChild: LoadingWidget(context));
                            Provider.of<CartModel>(context).addProductToCart(item_product,Provider.of<AppModel>(context).auth.access_token,null).then((value){
                              UIBlock.unblock(context);
                              showAlertDialog(context,item_product);
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
              _buildProgressIndicator()
            ],
            )
          )
          )],
      ),
      bottomNavigationBar: new PonnyBottomNavbar(selectedIndex: 1),
    );
  }
}


