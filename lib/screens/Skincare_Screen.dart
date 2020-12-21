import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:ponny/common/constant.dart';
import 'package:ponny/model/App.dart';
import 'package:ponny/model/Brand.dart';
import 'package:ponny/model/Cart.dart';
import 'package:ponny/model/Category.dart';
import 'package:ponny/model/Product.dart';
import 'package:ponny/model/WishProduct.dart';
import 'package:ponny/screens/Browse_Screen.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:ponny/util/globalUrl.dart';
import 'package:ponny/widgets/MyProduct.dart';
import 'package:ponny/widgets/PonnyBottomNavbar.dart';
import 'package:ponny/screens/product_details_screen.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:provider/provider.dart';
import 'package:uiblock/uiblock.dart';
import 'package:waterfall_flow/waterfall_flow.dart';
import 'package:http/http.dart' as http;

import 'login.dart';

class Skincare extends StatefulWidget {
  static const String id = "Skincare_Screen";
  Category category;
  Skincare({Key key,this.category});

  @override
  _SkincareState createState() => _SkincareState();
}

class _SkincareState extends State<Skincare> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool loadingProduct=true;
  ScrollController _scrollController = new ScrollController();
  bool loadmore = false;
  List<Product> dataProduct=[];
  List<Brandcheked> listBrand =[];
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
  int skinconcern_id = 0;

  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      getProductSearch();
      getBrandAll();

      _scrollController.addListener(() {
        if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent) {
          loadMore();
        }
      });
    });

  }

  Future<void> getBrandAll()  {
    http.get(brandSearch).then((value) {
      if(value.statusCode == 200){
        final respone =  json.decode(value.body);
        print("loadingbrand");
        setState(() {
          for(Map item in respone){
            var brand = Brand.fromJson(item);
            listBrand.add(Brandcheked( brand: brand,value: false));
          }
          LoadingBrand =false;
        });
      }
    });

  }

  getProductSearch(){
    setState(() {
      loadingProduct =true;
      loadmore =false;
      dataProduct=[];
    });
    var param =<String,dynamic>{
      "category_id":widget.category.id
    };
    if(_q.isNotEmpty){

      param.addAll({
        "keyword":_q
      });
      print(param);
    }
    if(subKategorysearch>0){
      param.addAll({ "subcategory_id": subKategorysearch});
    }

    if(skinconcern_id>0){
      param.addAll({ "skinconcern_id": skinconcern_id});
    }

    Provider.of<ProductModel>(context).searchProduct(searchProductUrl, param).then((value){

      if(value != null){

        setState(() {
          NextUrl =value.nextUrl;
          current_page = value.meta.currentPage;
          last_page = value.meta.lastPage;
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
    if(current_page < last_page){
      setState(() {
        loadmore =true;
        current_page++;
      });
      var param=<String,dynamic>{ "category_id":widget.category.id, "min_price": _currentSliderValue.start.round().toString(),
        "max_price": _currentSliderValue.end.round().toString(),"page":current_page};
      if(_q.isNotEmpty){

        param.addAll({
          "keyword":_q
        });
        print(param);
      }
      if(subKategorysearch>0){
        param.addAll({ "subcategory_id": subKategorysearch});
      }
      if(skinconcern_id>0){
        param.addAll({ "skinconcern_id": skinconcern_id});
      }
      List<int> _brandSelect = [];
      listBrand.where((element) => element.value == true).forEach((element) { _brandSelect.add(element.brand.id); });
      if(_brandSelect.length>0){
        param.addAll({"brand_id": "["+_brandSelect.join(',')+"]"});
      }

      if(checked.length > 0){
        param.addAll({"scope": getOrdering()});
      }
      Provider.of<ProductModel>(context).searchProduct(searchProductUrl, param).then((value){
        if(value != null){
          setState(() {
            NextUrl =value.nextUrl;
            dataProduct.addAll(value.products);
            loadingProduct =false;
          });
        }else{
          setState(() {
            loadingProduct =false;
            loadmore =false;
          });
        }
      }).catchError((onError){
        setState(() {
          loadingProduct =false;
          loadmore =false;
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
    return Container(
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          key: scaffoldKey,
            resizeToAvoidBottomInset: false,
            backgroundColor: Hexcolor('#FCF8F0'),
            body: Column(
              children: [
                Container(
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
                          cursorColor: Colors.black,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.go,
                          onChanged: (String text) async {

                            setState(() {
                              _q = text;
                            });
                            getProductSearch();
                          },
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
                          widget.category.id==11?'PERALATAN KECANTIKAN':widget.category.id==9?'SKINCARE':widget.category.id==10?'HAIR & MAKEUP':widget.category.id==15?'MASALAH KULIT':'',
                          style: TextStyle(
                            fontSize: 22,
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
                  height: 1,
                  color: Color(0xffF3C1B5),
                ),
                if(widget.category.subcategories.length > 0)
                Container(
                  margin: EdgeInsets.all(10),
                  height: 110,
                  width: double.infinity,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: widget.category.subcategories.length,
                    itemBuilder: (context, i) {
                      final sub = widget.category.subcategories[i];
                      return Container(
                          margin: EdgeInsets.all(10),
                          child: rectanglebutton(context, sub.name,sub.icon_mobile,sub.id));
                    },
                  ),
                ),
                if(widget.category.subcategories.length == 0)
                  Container(
                    margin: EdgeInsets.all(10),
                    height: 110,
                    width: double.infinity,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: widget.category.masalahKulit.length,
                      itemBuilder: (context, i) {
                        final sub = widget.category.masalahKulit[i];
                        print(sub.icon);
                        return Container(
                            margin: EdgeInsets.all(10),
                            child: rectanglebutton2(context, sub.name,sub.icon,sub.id));
                      },
                    ),
                  ),


                Container(
                  height: 1,
                  color: Color(0xffF3C1B5),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '$total Produk',
                        style: TextStyle(
                          fontFamily: 'Brandon',
                          fontSize: 16,
                        ),
                      ),
                      FlatButton(
                        onPressed: (){
                          _settingModalBottomSheet(context);
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

                Expanded(
                    child:SingleChildScrollView(
                      controller: _scrollController,
                      child: loadingProduct?Container(
                        height:150,
                        child: Center(
                          child: LoadingWidgetFadingCircle(context),
                        ),
                      ) :
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GridView.count(
                            childAspectRatio: 0.45,
                            padding: EdgeInsets.fromLTRB(20.0, 0, 20.0, 10.0),
                            shrinkWrap: true,
                            crossAxisCount: 2,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 20,
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
                          _buildProgressIndicator()
                        ],
                      ),
                    )
                )

              ],
            ),
            bottomNavigationBar: new PonnyBottomNavbar(selectedIndex: 1)),
      ),
    );
  }

  Widget rectanglebutton(context, String subtext, String subimg,int id) {
    return ButtonTheme(
      buttonColor: subKategorysearch == id ? Color(0xffF3C1B5) : Colors.white,
      minWidth: 100.0,
      height: 100.0,
      padding: EdgeInsets.symmetric(horizontal: 0),
      child: RaisedButton(
        onPressed: () {
          if(subKategorysearch ==  0){
            setState(() {
              subKategorysearch=id;
            });
          }else if(subKategorysearch > 0 && subKategorysearch !=  id){
            setState(() {
              subKategorysearch=id;
            });
          }else{
            subKategorysearch=0;
          }
          getProductSearch();
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CachedNetworkImage(
              imageUrl:subimg != null?  img_url+subimg:"",
              placeholder: (context, url) => LoadingWidgetPulse(context),
              errorWidget: (context, url, error) => Image.asset('assets/images/basic.jpg'),
              height: 50,
              width: 70,
              fit: BoxFit.contain,
            ),
            Container(height: 5,),
            Container(
              width: 95,
              child:Text(
                subtext,
                style: TextStyle(
                  fontSize: 13,
                  fontFamily: 'Brandon',
                  height: 1,
                ),
                textAlign: TextAlign.center,
              ),
            ),

          ],
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        side: BorderSide(color: Hexcolor('#F48262')),
      ),
    );
  }
  Widget rectanglebutton2(context, String subtext, String subimg,int id) {
    return ButtonTheme(
      buttonColor: skinconcern_id == id ? Color(0xffF3C1B5) : Colors.white,
      minWidth: 100.0,
      height: 100.0,
      padding: EdgeInsets.symmetric(horizontal: 0),
      child: RaisedButton(
        onPressed: () {
          if(skinconcern_id ==  0){
            setState(() {
              skinconcern_id=id;
            });
          }else if(skinconcern_id > 0 && skinconcern_id !=  id){
            setState(() {
              skinconcern_id=id;
            });
          }else{
            skinconcern_id=0;
          }
          getProductSearch();
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CachedNetworkImage(
              imageUrl:subimg != null?  img_url+"frontend/images/beauty-profile-modal/"+subimg:"",
              placeholder: (context, url) => LoadingWidgetPulse(context),
              errorWidget: (context, url, error) => Image.asset('assets/images/basic.jpg'),
              height: 50,
              width: 70,
              fit: BoxFit.contain,
            ),
            Container(height: 5,),
            Container(
              width: 95,
              child:Text(
                subtext,
                style: TextStyle(
                  fontSize: 13,
                  fontFamily: 'Brandon',
                  height: 1,
                ),
                textAlign: TextAlign.center,
              ),
            ),

          ],
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        side: BorderSide(color: Hexcolor('#F48262')),
      ),
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


  void _settingModalBottomSheet(context) {
    bool expandUrutkan = false;
    bool expandBrand = false;
    bool expandConcern = false;
    bool expandSkinType = false;
    bool expandPrice = false;


    showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Hexcolor('#FCF8F0'),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30))),
        context: context,
        builder: (builder) {
          _filter(){
            setState(() {
              loadingProduct =true;
              loadmore =false;
              dataProduct=[];
            });
            List<int> _brandSelect = [];
            listBrand.where((element) => element.value == true).forEach((element) { _brandSelect.add(element.brand.id); });
            var param=<String,dynamic>{ "category_id":widget.category.id, "min_price": _currentSliderValue.start.round().toString(),
              "max_price": _currentSliderValue.end.round().toString()};
            if(_q.isNotEmpty){
              param.addAll({ "keyword":_q});

            }
            if(_brandSelect.length>0){
              param.addAll({"brand_id": "["+_brandSelect.join(',')+"]"});
            }

            if(checked.length > 0){
              param.addAll({"scope": getOrdering()});
            }

            print(param);
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
          _reset(){
            setState(() {
              checked = [];
              subKategorysearch=0;
              listBrand.where((element) => element.value == true).forEach((element) { element.value =false;});
              _currentSliderValue = RangeValues(0, 3000000);
            });
            getProductSearch();
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
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
                          IconButton(
                            icon: Icon(expandUrutkan ? Icons.remove : Icons.add),
                            color: Color(0xffF48262),
                            onPressed: () {
                              setState(() {
                                expandUrutkan = !expandUrutkan;
                              });
                            },
                          )
                        ],
                      ),
                      Container(
                        child: expandUrutkan
                            ? CheckboxGroup(
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
                            ])
                            : Container(),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10, bottom: 10),
                        height: 1,
                        color: Color(0xffF3C1B5),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            margin: EdgeInsets.all(10),
                            child: Text(
                              "BRANDS",
                              style: TextStyle(
                                fontSize: 20,
                                fontFamily: "Yeseva",
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          IconButton(
                            icon: Icon(expandBrand ? Icons.remove : Icons.add),
                            color: Color(0xffF48262),
                            onPressed: () {
                              setState(() {
                                expandBrand = !expandBrand;
                              });
                            },
                          )
                        ],
                      ),
                      Container(
                        child: expandBrand
                            ? LoadingBrand? Container(child: Center(child: LoadingWidget(context),)): Column(
                            children: listBrand.map((e) => checkboxtiles(e)).toList()
                        )
                            : Container(),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        height: 1,
                        color: Color(0xffF3C1B5),
                      ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     Container(
                      //       margin: EdgeInsets.all(10),
                      //       child: Text(
                      //         "BY CONCERN",
                      //         style: TextStyle(
                      //           fontSize: 20,
                      //           fontFamily: "Yeseva",
                      //           fontWeight: FontWeight.w500,
                      //         ),
                      //       ),
                      //     ),
                      //     IconButton(
                      //       icon: Icon(expandConcern ? Icons.remove : Icons.add),
                      //       color: Color(0xffF48262),
                      //       onPressed: () {
                      //         setState(() {
                      //           expandConcern = !expandConcern;
                      //         });
                      //       },
                      //     )
                      //   ],
                      // ),
                      // Container(
                      //   child: expandConcern
                      //       ? Column(
                      //     children: [
                      //
                      //     ],
                      //   )
                      //       : Container(),
                      // ),
                      // Container(
                      //   margin: EdgeInsets.only(top: 10),
                      //   height: 1,
                      //   color: Color(0xffF3C1B5),
                      // ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     Container(
                      //       margin: EdgeInsets.all(10),
                      //       child: Text(
                      //         "BY SKIN TYPE",
                      //         style: TextStyle(
                      //           fontSize: 20,
                      //           fontFamily: "Yeseva",
                      //           fontWeight: FontWeight.w500,
                      //         ),
                      //       ),
                      //     ),
                      //     IconButton(
                      //       icon: Icon(expandSkinType ? Icons.remove : Icons.add),
                      //       color: Color(0xffF48262),
                      //       onPressed: () {
                      //         setState(() {
                      //           expandSkinType = !expandSkinType;
                      //         });
                      //       },
                      //     )
                      //   ],
                      // ),
                      // Container(
                      //   child: expandSkinType
                      //       ? Column(
                      //     children: [
                      //
                      //     ],
                      //   )
                      //       : Container(),
                      // ),
                      // Container(
                      //   margin: EdgeInsets.only(top: 10),
                      //   height: 1,
                      //   color: Color(0xffF3C1B5),
                      // ),
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
                      Container(
                        child: expandPrice
                            ? Column(
                          children: [

                          ],
                        )
                            : Container(),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        height: 1,
                        color: Color(0xffF3C1B5),
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
                                  _reset();
                                  Navigator.pop(context);
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
                            child: Container(
                              margin: EdgeInsets.all(10),
                              child: RaisedButton(
                                onPressed: () {
                                  _filter();
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
        });
  }

  Widget checkboxtiles(Brandcheked brandcheked) {
    return StatefulBuilder(
      builder: (BuildContext context, setState) {
        return Column(
          children: [
            CheckboxListTile(
              activeColor: Color(0xffF48262),
              title: Text(
                brandcheked.brand.name,
                style: TextStyle(
                    fontSize: 18,
                    fontFamily: "Yeseva",
                    fontWeight: FontWeight.w500),
              ),
              value: brandcheked.value,
              onChanged: (bool newValue) {
                setState(() {
                  listBrand.firstWhere((element) => element.brand.id == brandcheked.brand.id).value = newValue;
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
}
class Brandcheked{
  bool value;
  Brand brand;
  Brandcheked({this.value,this.brand });
}


