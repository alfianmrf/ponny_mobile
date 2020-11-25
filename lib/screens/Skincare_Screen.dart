import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:ponny/common/constant.dart';
import 'package:ponny/model/Brand.dart';
import 'package:ponny/model/Category.dart';
import 'package:ponny/model/Product.dart';
import 'package:ponny/screens/Browse_Screen.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:ponny/util/globalUrl.dart';
import 'package:ponny/widgets/PonnyBottomNavbar.dart';
import 'package:ponny/screens/product_details_screen.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:provider/provider.dart';
import 'package:waterfall_flow/waterfall_flow.dart';
import 'package:http/http.dart' as http;

class Skincare extends StatefulWidget {
  static const String id = "Skincare_Screen";
  Category category;
  Skincare({Key key,this.category});

  @override
  _SkincareState createState() => _SkincareState();
}

class _SkincareState extends State<Skincare> {
  bool loadingProduct=true;
  ScrollController _scrollController = new ScrollController();
  bool loadmore = false;
  List<Product> dataProduct=[];
  List<Brandcheked> listBrand =[];
  String NextUrl;
  String filter;
  String _q ="";
  TextEditingController _seachcontroller = new TextEditingController();
  int total=0;
  var _currentSliderValue = RangeValues(0, 3000000);
  List<String> checked = [];
  bool LoadingBrand=true;

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
    var param ={
      "keyword":_q,
      "category_id":widget.category.id
    };
    if(_q.isNotEmpty){

      param ={
        "keyword":_q,
        "category_id":widget.category.id
      };
      print(param);
    }else{
      param ={
        "category_id":widget.category.id
      };
      print(param);
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
                              Navigator.of(context)
                                  .pushReplacementNamed(Browse.id);
                            },
                            icon: Icon(
                              Icons.arrow_back_ios,
                              color: Color(0xffF48262),
                              size: 26,
                            )),
                      ),
                      Container(
                        child: Text(
                          widget.category.name,
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
                  height: 1,
                  color: Color(0xffF3C1B5),
                ),
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
                          child: rectanglebutton(context, sub.name));
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
                        '$total items',
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
                        WaterfallFlow.count(
                          padding: EdgeInsets.fromLTRB(20.0, 0, 20.0, 10.0),
                          shrinkWrap: true,
                          crossAxisCount: 2,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 20,
                          physics: ScrollPhysics(),
                          children: [
                            for( Product product in dataProduct)
                              getProduct(context, product),
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

  Widget rectanglebutton(context, String subtext) {
    return ButtonTheme(
      buttonColor: Hexcolor('#FCF8F0'),
      minWidth: 100.0,
      height: 100.0,
      child: RaisedButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Skincare()));
        },
        child: Text(
          subtext,
          style: TextStyle(
              fontSize: 14,
              fontFamily: 'Brandon',
              fontWeight: FontWeight.w800,
              letterSpacing: 1,
              color: Hexcolor('#F48262')),
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
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
    List<String> checked = [];

    showModalBottomSheet(
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
              listBrand.where((element) => element.value == true).forEach((element) { element.value =false;});
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


