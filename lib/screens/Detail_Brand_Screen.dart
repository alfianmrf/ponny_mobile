import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:ponny/common/constant.dart';
import 'package:ponny/model/App.dart';
import 'package:ponny/model/Brand.dart';
import 'package:ponny/model/Cart.dart';
import 'package:ponny/model/Product.dart';
import 'package:ponny/model/WishProduct.dart';
import 'package:ponny/util/globalUrl.dart';
import 'package:ponny/widgets/MyProduct.dart';
import 'package:ponny/widgets/PonnyBottomNavbar.dart';
import 'package:provider/provider.dart';
import 'package:uiblock/uiblock.dart';
import 'package:waterfall_flow/waterfall_flow.dart';

import 'login.dart';

class DetailBrand extends StatefulWidget {
  @required Brand brand;
  static const String id = "Detail_Brand_Screen";
  DetailBrand({Key key,this.brand});


  @override
  _DetailBrandScreen createState() => _DetailBrandScreen();
}

class _DetailBrandScreen extends State<DetailBrand> {
  ScrollController _scrollController = new ScrollController();
  PersistentBottomSheetController _controller;
  final scafoldkey = GlobalKey<ScaffoldState>();
  bool loadingProduct =true;
  bool loadmore = false;
  List<Product> dataProduct=[];
  String NextUrl;
  String filter;
  String _q ="";
  TextEditingController _seachcontroller = new TextEditingController();
  int total=0;
  var _currentSliderValue = RangeValues(0, 3000000);
  List<String> checked = [];


  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      getProductBrand();

      _scrollController.addListener(() {
        if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent) {
          loadMore();
        }
      });
    });

  }
  getProductBrand(){
    setState(() {
      loadingProduct =true;
      dataProduct=[];
    });
    var param ={
      "keyword":_q,
      "brand_id":widget.brand.id.toString()
    };
    if(_q.isNotEmpty){
      param ={
        "keyword":_q,
        "brand_id":widget.brand.id.toString()
        };
    }else{
      param ={
        "brand_id":widget.brand.id.toString()
      };
    }
    Provider.of<ProductModel>(context).searchProduct(searchProductUrl, param).then((value){

          if(value != null){

            setState(() {
              NextUrl =value.nextUrl;
              dataProduct.addAll(value.products);
              total = value.total;
              loadingProduct =false;
            });
          }else{
            setState(() {
              loadingProduct =false;
            });
          }
    });
  }
  loadMore(){
    if(NextUrl != null){
      setState(() {
        loadmore =true;
      });
      Provider.of<ProductModel>(context).searchProduct(NextUrl, null).then((value){
        if(value != null){
          setState(() {
            NextUrl =value.nextUrl;
            dataProduct.addAll(value.products);
            loadingProduct =false;
          });
        }else{
          setState(() {
            loadingProduct =false;
          });
        }
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

  onSearchTextChanged(String text) async {

    setState(() {
      _q = text;
    });
    getProductBrand();
  }

  void _settingModalBottomSheet()  {
    showModalBottomSheet(
        backgroundColor: Hexcolor('#FCF8F0'),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30))),
        context: context,
        useRootNavigator: true,
        builder: (builder) {
          return StatefulBuilder(builder: (BuildContext context, setState) {
            return Container(
              padding: EdgeInsets.all(10),
              child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Icon(
                          Icons.keyboard_arrow_up,
                          color: Color(0xffF48262),
                        ),
                      ),
                      Center(
                        child: Container(
                          margin: EdgeInsets.only(bottom: 10),
                          child: Text(
                            "Filter",
                            style: TextStyle(
                              fontSize: 24,
                              fontFamily: "Yeseva",
                              fontWeight: FontWeight.w500,
                              color: Color(0xffF48262),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 1,
                        color: Color(0xffF3C1B5),
                      ),
                      Container(
                        margin: EdgeInsets.all(10),
                        child: Text(
                          "URUTKAN",
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: "Yeseva",
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      CheckboxGroup(
                          activeColor: Color(0xffF48262),
                          checked: checked,
                          onSelected: (List selected) => setState(() {
                            if (selected.length > 1) {
                              selected.removeAt(0);
                            } else {
                              print("only one");
                            }
                            checked = selected;
                          }),
                          labels: <String>[
                            "Terlaris",
                            "Baru",
                            "Harga: Tinggi - Rendah",
                            "Harga: Rendah - Tinggi"
                          ]),
                      // Container(
                      //   margin: EdgeInsets.only(top: 10, bottom: 10),
                      //   height: 1,
                      //   color: Color(0xffF3C1B5),
                      // ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     Container(
                      //       margin: EdgeInsets.all(10),
                      //       child: Text(
                      //         "BRANDS",
                      //         style: TextStyle(
                      //           fontSize: 20,
                      //           fontFamily: "Yeseva",
                      //           fontWeight: FontWeight.w500,
                      //         ),
                      //       ),
                      //     ),
                      //     IconButton(
                      //       icon: Icon(expandBrand ? Icons.remove : Icons.add),
                      //       color: Color(0xffF48262),
                      //       onPressed: () {
                      //         setState(() {
                      //           expandBrand = !expandBrand;
                      //         });
                      //       },
                      //     )
                      //   ],
                      // ),
                      // Container(
                      //   child: expandBrand
                      //       ? Column(
                      //     children: [
                      //       checkboxtiles("Aeris"),
                      //       checkboxtiles("Biyu"),
                      //       checkboxtiles("iUNIK"),
                      //       checkboxtiles("Thayers"),
                      //       checkboxtiles("The Ordinary"),
                      //       checkboxtiles("Upmost Beauty"),
                      //     ],
                      //   )
                      //       : Container(),
                      // ),
                      Container(
                        margin: EdgeInsets.only(
                          top: 10,
                          bottom: 10,
                        ),
                        height: 1,
                        color: Color(0xffF3C1B5),
                      ),
                      Container(
                        margin: EdgeInsets.all(10),
                        child: Text(
                          "BY PRICE",
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: "Yeseva",
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      RangeSlider(
                        activeColor: Color(0xffF48262),
                        values: _currentSliderValue,
                        min: 0,
                        max: 3000000,
                        divisions: 30,
                        labels: RangeLabels(
                            nm_format.format(_currentSliderValue.start.round().isNegative ? 0 : _currentSliderValue.start.round()) ,
                            nm_format.format(_currentSliderValue.end.round())
                        ),
                        onChanged: (RangeValues values) {
                          setState(() {
                            _currentSliderValue = values;
                          });
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [Text("Rp.0"), Text("Rp 3.000.000")],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.all(10),
                              child: RaisedButton(
                                onPressed: () {
                                  setState(() {
                                   checked = [];
                                   _currentSliderValue = RangeValues(0, 3000000);

                                  });
                                },
                                color: Color(0xffF48262),
                                child: Text(
                                  "RESET",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w800),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child:
                            Container(
                              margin: EdgeInsets.all(10),
                              child: RaisedButton(
                                onPressed: () {


                                  getProductBrand();
                                  // Navigator.pop(context);
                                  // var param ={
                                  //   "keyword":_q.isEmpty ? "" : _q,
                                  //   "brand_id":widget.brand.id.toString(),
                                  //   "min_price": _currentSliderValue.start.round().toString(),
                                  //   "max_price": _currentSliderValue.end.round().toString()
                                  // };
                                  // if(checked.length > 0){
                                  //   param ={
                                  //     "keyword":_q.isEmpty ? "" : _q,
                                  //     "brand_id":widget.brand.id.toString(),
                                  //     "min_price": _currentSliderValue.start.round().toString(),
                                  //     "max_price": _currentSliderValue.end.round().toString(),
                                  //     "scope": getOrdering()
                                  //   };
                                  // }
                                  //
                                  // Provider.of<ProductModel>(context).searchProduct(searchProductUrl, param).then((value){
                                  //   if(value != null){
                                  //
                                  //     setState(() {
                                  //       NextUrl =value.nextUrl;
                                  //       dataProduct.addAll(value.products);
                                  //       total = value.total;
                                  //       loadingProduct =false;
                                  //     });
                                  //     Navigator.pop(context);
                                  //   }else{
                                  //     setState(() {
                                  //       loadingProduct =false;
                                  //     });
                                  //     Navigator.pop(context);
                                  //   }
                                  //
                                  // });


                                },
                                color: Color(0xffF48262),
                                child: Text(
                                  "GUNAKAN",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w800),
                                ),
                              ),
                            ),
                          )
                        ],
                      )
                    ]),
              ),
            );
          });
        });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      key: scafoldkey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        titleSpacing: 0.0,
        elevation: 0.0,
        title: Container(
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
                  onTap: () {

                  },
                  onChanged: onSearchTextChanged,
                  cursorColor: Colors.black,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.go,
                  decoration:
                  new InputDecoration.collapsed(hintText: ""),
                ))
          ]),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(50.0),
          child: Container(
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
                    widget.brand.name,
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
        ),
      ),
      backgroundColor: Hexcolor('#FCF8F0'),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.width,
              color: Colors.white,
              child: CachedNetworkImage(
                imageUrl: img_url+widget.brand.logo,
                placeholder: (context, url) => LoadingWidgetPulse(context),
                errorWidget: (context, url, error) => Image.asset('assets/images/basic.jpg'),
                fit: BoxFit.contain,
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    width: 1,
                    color: Color(0xffF48262),
                  ),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Headline About Brand',
                    style: TextStyle(
                      fontFamily: 'Yeseva',
                      fontSize: 16,
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top: 5)),
                  Text(
                    widget.brand.metaDescription != null ? widget.brand.metaDescription :"-",
                    style: TextStyle(
                      fontFamily: 'Brandon',
                    ),
                  ),
                ],
              ),
            ),
            loadingProduct?Container(
              height:150,
              child: Center(
                child: LoadingWidgetFadingCircle(context),
              ),
            ) :
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                         '$total items',
                        style: TextStyle(
                          fontFamily: 'Brandon',
                          fontSize: 16,
                        ),
                      ),
                      FlatButton(
                        onPressed: (){
                          showModalBottomSheet<void>(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                            ),
                            backgroundColor: Color(0xffFEF9F0),
                            context: context,

                            builder: (BuildContext context) {
                              _setSatte(){
                                setState(() {
                                  loadingProduct=true;
                                  dataProduct = [];
                                });
                                var param ={
                                  "keyword":_q.isEmpty ? "" : _q,
                                  "brand_id":widget.brand.id.toString(),
                                  "min_price": _currentSliderValue.start.round().toString(),
                                  "max_price": _currentSliderValue.end.round().toString()
                                };
                                if(checked.length > 0){
                                  param ={
                                    "keyword":_q.isEmpty ? "" : _q,
                                    "brand_id":widget.brand.id.toString(),
                                    "min_price": _currentSliderValue.start.round().toString(),
                                    "max_price": _currentSliderValue.end.round().toString(),
                                    "scope": getOrdering()
                                  };
                                }
                                Provider.of<ProductModel>(context).searchProduct(searchProductUrl, param).then((value){
                                  if(value != null){

                                    setState(() {
                                      NextUrl =value.nextUrl;
                                      dataProduct.addAll(value.products);
                                      total = value.total;
                                      loadingProduct =false;
                                    });

                                  }else{
                                    setState(() {
                                      loadingProduct =false;
                                    });

                                  }
                                });

                              }
                              return StatefulBuilder(builder: (BuildContext context, setState) {
                                return Container(
                                  padding: EdgeInsets.all(10),
                                  child: SingleChildScrollView(
                                    child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Center(
                                            child: Icon(
                                              Icons.keyboard_arrow_up,
                                              color: Color(0xffF48262),
                                            ),
                                          ),
                                          Center(
                                            child: Container(
                                              margin: EdgeInsets.only(bottom: 10),
                                              child: Text(
                                                "Filter",
                                                style: TextStyle(
                                                  fontSize: 24,
                                                  fontFamily: "Yeseva",
                                                  fontWeight: FontWeight.w500,
                                                  color: Color(0xffF48262),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            height: 1,
                                            color: Color(0xffF3C1B5),
                                          ),
                                          Container(
                                            margin: EdgeInsets.all(10),
                                            child: Text(
                                              "URUTKAN",
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontFamily: "Yeseva",
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                          CheckboxGroup(
                                              activeColor: Color(0xffF48262),
                                              checked: checked,
                                              onSelected: (List selected) => setState(() {
                                                if (selected.length > 1) {
                                                  selected.removeAt(0);
                                                } else {
                                                  print("only one");
                                                }
                                                checked = selected;
                                              }),
                                              labels: <String>[
                                                "Terlaris",
                                                "Baru",
                                                "Harga: Tinggi - Rendah",
                                                "Harga: Rendah - Tinggi"
                                              ]),
                                          // Container(
                                          //   margin: EdgeInsets.only(top: 10, bottom: 10),
                                          //   height: 1,
                                          //   color: Color(0xffF3C1B5),
                                          // ),
                                          // Row(
                                          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          //   children: [
                                          //     Container(
                                          //       margin: EdgeInsets.all(10),
                                          //       child: Text(
                                          //         "BRANDS",
                                          //         style: TextStyle(
                                          //           fontSize: 20,
                                          //           fontFamily: "Yeseva",
                                          //           fontWeight: FontWeight.w500,
                                          //         ),
                                          //       ),
                                          //     ),
                                          //     IconButton(
                                          //       icon: Icon(expandBrand ? Icons.remove : Icons.add),
                                          //       color: Color(0xffF48262),
                                          //       onPressed: () {
                                          //         setState(() {
                                          //           expandBrand = !expandBrand;
                                          //         });
                                          //       },
                                          //     )
                                          //   ],
                                          // ),
                                          // Container(
                                          //   child: expandBrand
                                          //       ? Column(
                                          //     children: [
                                          //       checkboxtiles("Aeris"),
                                          //       checkboxtiles("Biyu"),
                                          //       checkboxtiles("iUNIK"),
                                          //       checkboxtiles("Thayers"),
                                          //       checkboxtiles("The Ordinary"),
                                          //       checkboxtiles("Upmost Beauty"),
                                          //     ],
                                          //   )
                                          //       : Container(),
                                          // ),
                                          Container(
                                            margin: EdgeInsets.only(
                                              top: 10,
                                              bottom: 10,
                                            ),
                                            height: 1,
                                            color: Color(0xffF3C1B5),
                                          ),
                                          Container(
                                            margin: EdgeInsets.all(10),
                                            child: Text(
                                              "BY PRICE",
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontFamily: "Yeseva",
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                          RangeSlider(
                                            activeColor: Color(0xffF48262),
                                            values: _currentSliderValue,
                                            min: 0,
                                            max: 3000000,
                                            divisions: 30,
                                            labels: RangeLabels(
                                                nm_format.format(_currentSliderValue.start.round().isNegative ? 0 : _currentSliderValue.start.round()) ,
                                                nm_format.format(_currentSliderValue.end.round())
                                            ),
                                            onChanged: (RangeValues values) {
                                              setState(() {
                                                _currentSliderValue = values;
                                              });
                                            },
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [Text("Rp.0"), Text("Rp 3.000.000")],
                                          ),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Container(
                                                  margin: EdgeInsets.all(10),
                                                  child: RaisedButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        checked = [];
                                                        _currentSliderValue = RangeValues(0, 3000000);

                                                      });
                                                    },
                                                    color: Color(0xffF48262),
                                                    child: Text(
                                                      "RESET",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight: FontWeight.w800),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child:
                                                Container(
                                                  margin: EdgeInsets.all(10),
                                                  child: RaisedButton(
                                                    onPressed: () {
                                                      _setSatte();
                                                      Navigator.pop(context);
                                                    },
                                                    color: Color(0xffF48262),
                                                    child: Text(
                                                      "GUNAKAN",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight: FontWeight.w800),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          )
                                        ]),
                                  ),
                                );
                              });

                            },
                          );
                        },
                        color: Color(0xffF48262),
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        height: 30,
                        child: Row(
                          children: [
                            Icon(
                              Icons.tune,
                              color: Colors.white,
                            ),
                            Text(
                              'Filter',
                              style: TextStyle(
                                fontFamily: 'Brandon',
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                WaterfallFlow.count(
                  padding: EdgeInsets.fromLTRB(20.0, 0, 20.0, 10.0),
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 20,
                  physics: ScrollPhysics(),
                  children: [
                    for( Product e in dataProduct)
                      MyProduct(
                        product: e,
                        onFavorit: (){
                          if(Provider.of<AppModel>(context).loggedIn) {
                            UIBlock.block(context,customLoaderChild: LoadingWidget(context));
                            Provider.of<WishModel>(context).addProductToWish(e, Provider.of<AppModel>(context).auth.access_token).then((value){
                              UIBlock.unblock(context);
                              if(value){
                                showWishDialog(context,e);
                              }else{
                                scafoldkey.currentState.showSnackBar(snackBarError);
                              }
                            });
                          }else{
                            Navigator.push(context,new MaterialPageRoute(
                              builder: (BuildContext context) => new LoginScreen(),
                            ));
                          }
                        },
                        onTobag: (){
                          if(Provider.of<AppModel>(context).loggedIn){
                            UIBlock.block(context,customLoaderChild: LoadingWidget(context));
                            Provider.of<CartModel>(context).addProductToCart(e,Provider.of<AppModel>(context).auth.access_token).then((value){
                              UIBlock.unblock(context);
                              showAlertDialog(context,e);
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
                _buildProgressIndicator()
              ],
            )

          ],
        ),
      ),
      bottomNavigationBar: new PonnyBottomNavbar(selectedIndex: 1),
    );
  }
  String getOrdering(){
    String result;
    if(checked.length>0){
      String val = checked[0];
      if(val == "Terlaris"){
        result = "popularity";
      }else if(val  == "Baru"){
        result = "new_arrival";
      }else if(val  == "Harga: Tinggi - Rendah"){
        result = "price_high_to_low";
      }else if(val  == "arga: Rendah - Tinggi"){
        result = "price_low_to_high";
      }
    }
    return result;
  }
}
class Search extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            query = "";
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: Icon(
          Icons.arrow_back,
        ),
        onPressed: () {
          Navigator.pop(context);
        });
  }

  String selectedResults;

  @override
  Widget buildResults(BuildContext context) {
    return Container(child: Center(child: Text(selectedResults)));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    throw UnimplementedError();
  }
}
Widget checkboxtiles(String subtext) {
  bool checkedvalue = false;
  return StatefulBuilder(
    builder: (BuildContext context, setState) {
      return Column(
        children: [
          CheckboxListTile(
            activeColor: Color(0xffF48262),
            title: Text(
              subtext,
              style: TextStyle(
                  fontSize: 18,
                  fontFamily: "Yeseva",
                  fontWeight: FontWeight.w500),
            ),
            value: checkedvalue,
            onChanged: (bool newValue) {
              setState(() {
                checkedvalue = newValue;
              });
            },
            controlAffinity:
            ListTileControlAffinity.leading, //  <-- leading Checkbox
          ),
        ],
      );
    },
  );
}
