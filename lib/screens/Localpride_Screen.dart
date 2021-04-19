import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:lodash_dart/lodash_dart.dart';
import 'package:ponny/common/constant.dart';
import 'package:ponny/model/App.dart';
import 'package:ponny/model/Cart.dart';
import 'package:ponny/model/LocalPride.dart';
import 'package:ponny/model/Product.dart';
import 'package:ponny/model/WishProduct.dart';
import 'package:ponny/screens/Browse_Screen.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:ponny/screens/Detail_Brand_Screen.dart';
import 'package:ponny/screens/login.dart';
import 'package:ponny/screens/product_details_screen.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:ponny/util/globalUrl.dart';
import 'package:ponny/widgets/MyProduct.dart';
import 'package:ponny/widgets/PonnyBottomNavbar.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:uiblock/uiblock.dart';
import 'package:ponny/common/constant.dart' as cost;

class LocalPride extends StatefulWidget {
  LocalPride({Key key}) : super(key: key);

  @override
  _LocalPrideState createState() => _LocalPrideState();
}

class _LocalPrideState extends State<LocalPride> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    getLocalpride1();
  }

  getLocalpride1() async{
    LocalPrideResult localPride;
    final res = await http.get(localprideUrl);
    if(res.statusCode == 200){
      final responejson = json.decode(res.body);
      localPride = new LocalPrideResult.fromJson(responejson);
      print("HASIL");
      print(localPride);
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> ListRekomedasi;


    Future<LocalPrideResult> getLocalpride() async {
      LocalPrideResult localPride;
      final res = await http.get(localprideUrl);
      if(res.statusCode == 200){
        final responejson = json.decode(res.body);
        localPride = new LocalPrideResult.fromJson(responejson);
        print("HASIL");
        print(localPride);
      }
      return localPride;
    }

    return Scaffold(
      key: scaffoldKey,
      resizeToAvoidBottomInset: false,
      backgroundColor: Hexcolor('#FCF8F0'),
      body: FutureBuilder<LocalPrideResult>(
      future: getLocalpride(),
      builder: (BuildContext context, AsyncSnapshot<LocalPrideResult> snapshot){
        if(snapshot.hasData){
          return Column(
            children: [
              Column(
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
                            "Bangga Produk Indonesia",
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
                ],
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        child: Image.network(
                          img_url+snapshot.data.banner,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(20),
                        child: Text(
                          "Produk Unggulan",
                          style: TextStyle(
                            fontSize: 22,
                            fontFamily: "Yeseva",
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Container(
                        height: 75,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data.brands.length,
                          itemBuilder: (BuildContext context, int index) => Padding(
                            padding: EdgeInsets.symmetric(horizontal: 21),
                            child:InkWell(
                              onTap: (){
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          DetailBrand(brand: snapshot.data.brands[index], )),

                                );
                              },
                              child:  Container(
                                child: Image.network(img_url+snapshot.data.brands[index].logo,
                                  fit: BoxFit.contain,
                                ),
                                height: 70,
                                width: 70,

                              ),
                            ),
                          ),
                        ),
                      ),

                      Container(
                        margin: EdgeInsets.only(top: 20, bottom: 10, left: 20, right: 20),
                        height: 1,
                        color: Color(0xffF3C1B5),
                      ),
                      Container(
                        margin: EdgeInsets.all(20),
                        child: Text(
                          "Kenapa Produk Lokal?",
                          style: TextStyle(
                            fontSize: 22,
                            fontFamily: "Yeseva",
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            width: 90,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                    height: 60,
                                    width: 60,
                                    child: Image.network(img_url+"frontend/images/local-pride/sesuai-kulit.png",
                                      fit: BoxFit.contain,
                                    )
                                ),
                                Text(
                                  'Sesuai Kondisi Kulit Indonesia',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: 'Brandon',
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: 80,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: 60,
                                  width: 60,
                                  child: Image.network(img_url+"frontend/images/local-pride/harga.png",
                                    fit: BoxFit.contain,
                                  ),
                                ),
                                Text(
                                  'Harga Ramah di Kantong',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: 'Brandon',
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: 90,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  child: Image.network(img_url+"frontend/images/local-pride/dukung.png",
                                    fit: BoxFit.contain,
                                  ),
                                  height: 60,
                                  width: 60,
                                ),
                                Text(
                                  'Dukung Kreasi Anak Bangsa',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: 'Brandon',
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
                        height: 1,
                        color: Color(0xffF3C1B5),
                      ),
                      Container(
                        margin: EdgeInsets.all(20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Produk Rekomendasi",
                              style: TextStyle(
                                fontSize: 20,
                                fontFamily: "Yeseva",
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                            ),
                            // InkWell(
                            //   child: Text(
                            //     "view more",
                            //     style: TextStyle(
                            //         color: Colors.blue,
                            //         decoration: TextDecoration.underline),
                            //   ),
                            //   onTap: () {},
                            // ),
                          ],
                        ),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.width * .75,
                        child: Consumer<ProductModel>(
                          builder: (context,value,child){
                            if(value.loadingRecom){
                              return LoadingWidgetFadingCircle(context);
                            }else{
                              // ListRekomedasi = getColumProduct(context,value.Recomendasi,3);
                              var dataRecom  =Lodash().chunk(array: value.Recom,size: 3);
                              return  new Swiper(
                                itemBuilder: (BuildContext context, int index) {
                                  if(dataRecom[index].length == 3){
                                    return Container(
                                        child: Row(
                                            children: [
                                              for(Product e in dataRecom[index])
                                                Expanded(
                                                  flex: 1,
                                                  child: Container(
                                                    padding: EdgeInsets.symmetric(horizontal: 5),
                                                    child: MyProduct(
                                                      product: e,
                                                      IsLiked: Provider.of<WishModel>(context).rawlist.firstWhere((element) => element.productId == e.id, orElse: () => null) != null ? true:false,
                                                      onFavorit: (){
                                                        if(Provider.of<AppModel>(context).loggedIn) {
                                                          Provider.of<WishModel>(context).addProductToWish(e, Provider.of<AppModel>(context).auth.access_token);
                                                        }else{
                                                          Navigator.push(context,new MaterialPageRoute(
                                                            builder: (BuildContext context) => new LoginScreen(),
                                                          ));
                                                        }
                                                      },
                                                      onUnFavorit: (){
                                                        if(Provider.of<AppModel>(context).loggedIn) {
                                                          Provider.of<WishModel>(context).removeProductFromWish(e, Provider.of<AppModel>(context).auth.access_token);
                                                        }else{
                                                          Navigator.push(context,new MaterialPageRoute(
                                                            builder: (BuildContext context) => new LoginScreen(),
                                                          ));
                                                        }
                                                      },
                                                      onTobag: (){
                                                        if(Provider.of<AppModel>(context).loggedIn){
                                                          UIBlock.block(context,customLoaderChild: LoadingWidget(context));
                                                          Provider.of<CartModel>(context).addProductToCart(e,Provider.of<AppModel>(context).auth.access_token,null).then((value){
                                                            UIBlock.unblock(context);
                                                            cost.showAlertDialog(context,e);
                                                          });
                                                        }else{
                                                          Navigator.push(context,new MaterialPageRoute(
                                                            builder: (BuildContext context) => new LoginScreen(),
                                                          ));
                                                        }
                                                      },
                                                    ),
                                                  ),
                                                ),
                                            ]
                                        )
                                    );
                                  }else if(dataRecom[index].length ==2){
                                    return Container(
                                        child: Row(
                                          children: [
                                            for(Product e in dataRecom[index])
                                              Expanded(
                                                flex: 1,
                                                child: Container(
                                                  padding: EdgeInsets.symmetric(horizontal: 7),
                                                  child: MyProduct(
                                                    product: e,
                                                    onFavorit: (){
                                                      if(Provider.of<AppModel>(context).loggedIn) {
                                                        UIBlock.block(context,customLoaderChild: LoadingWidget(context));
                                                        Provider.of<WishModel>(context).addProductToWish(e, Provider.of<AppModel>(context).auth.access_token).then((value){
                                                          UIBlock.unblock(context);
                                                          if(value){
                                                            cost.showWishDialog(context,e);
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
                                                    onTobag: (){
                                                      if(Provider.of<AppModel>(context).loggedIn){
                                                        UIBlock.block(context,customLoaderChild: LoadingWidget(context));
                                                        Provider.of<CartModel>(context).addProductToCart(e,Provider.of<AppModel>(context).auth.access_token,null).then((value){
                                                          UIBlock.unblock(context);
                                                          cost.showAlertDialog(context,e);
                                                        });
                                                      }else{
                                                        Navigator.push(context,new MaterialPageRoute(
                                                          builder: (BuildContext context) => new LoginScreen(),
                                                        ));
                                                      }
                                                    },
                                                  ),
                                                ),
                                              ),
                                            Expanded(
                                              flex: 1,
                                              child: Container(
                                                padding: EdgeInsets.symmetric(horizontal: 7),

                                              ),
                                            )


                                          ],
                                        )
                                    );
                                  }else{
                                    return Container(
                                        child: Row(
                                          children: [
                                            for(Product e in dataRecom[index])
                                              Expanded(
                                                flex: 1,
                                                child: Container(
                                                  padding: EdgeInsets.symmetric(horizontal: 7),
                                                  child: MyProduct(
                                                    product: e,
                                                    onFavorit: (){
                                                      if(Provider.of<AppModel>(context).loggedIn) {
                                                        UIBlock.block(context,customLoaderChild: LoadingWidget(context));
                                                        Provider.of<WishModel>(context).addProductToWish(e, Provider.of<AppModel>(context).auth.access_token).then((value){
                                                          UIBlock.unblock(context);
                                                          if(value){
                                                            cost.showWishDialog(context,e);
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
                                                    onTobag: (){
                                                      if(Provider.of<AppModel>(context).loggedIn){
                                                        UIBlock.block(context,customLoaderChild: LoadingWidget(context));
                                                        Provider.of<CartModel>(context).addProductToCart(e,Provider.of<AppModel>(context).auth.access_token,null).then((value){
                                                          UIBlock.unblock(context);
                                                          cost.showAlertDialog(context,e);
                                                        });
                                                      }else{
                                                        Navigator.push(context,new MaterialPageRoute(
                                                          builder: (BuildContext context) => new LoginScreen(),
                                                        ));
                                                      }
                                                    },
                                                  ),
                                                ),
                                              ),
                                            Expanded(
                                              flex: 1,
                                              child: Container(
                                                padding: EdgeInsets.symmetric(horizontal: 7),

                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Container(
                                                padding: EdgeInsets.symmetric(horizontal: 7),

                                              ),
                                            )


                                          ],
                                        )
                                    );

                                  }
                                },
                                itemCount: dataRecom.length,
                                pagination: null,
                                control: null,
                                autoplay: false,
                              );
                            }
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 20, bottom: 20),
                        height: 1,
                        color: Color(0xffF3C1B5),
                      ),
                      // ListView.builder(
                      //   shrinkWrap: true,
                      //   physics: NeverScrollableScrollPhysics(),
                      //   padding: EdgeInsets.symmetric(vertical: 20),
                      //   itemCount: snapshot.data.products.length,
                      //   itemBuilder: (context, i) {
                      //     return Text(snapshot.data.products[i].name);
                      //   },
                      // ),
                      Consumer<ProductModel>(
                        builder: (context,value,child){
                          if(value.loadingLocalProduct){
                            return LoadingWidgetFadingCircle(context);
                          }else{
                            var dataLocal = value.Local_product;
                            return new GridView.count(
                              padding: EdgeInsets.fromLTRB(20.0, 0, 20.0, 10.0),
                              shrinkWrap: true,
                              crossAxisCount: 2,
                              childAspectRatio: 0.45,
                              mainAxisSpacing: 10,
                              crossAxisSpacing: 20,
                              physics: ScrollPhysics(),
                              children: [
                                for( Product e in dataLocal)
                                  MyProduct(
                                    product: e,
                                    IsLiked: Provider.of<WishModel>(context).rawlist.firstWhere((element) => element.productId == e.id, orElse: () => null) != null ? true:false,
                                    onFavorit: (){
                                      if(Provider.of<AppModel>(context).loggedIn) {
                                        Provider.of<WishModel>(context).addProductToWish(e, Provider.of<AppModel>(context).auth.access_token);
                                      }else{
                                        Navigator.push(context,new MaterialPageRoute(
                                          builder: (BuildContext context) => new LoginScreen(),
                                        ));
                                      }
                                    },
                                    onUnFavorit: (){
                                      if(Provider.of<AppModel>(context).loggedIn) {
                                        Provider.of<WishModel>(context).removeProductFromWish(e, Provider.of<AppModel>(context).auth.access_token);
                                      }else{
                                        Navigator.push(context,new MaterialPageRoute(
                                          builder: (BuildContext context) => new LoginScreen(),
                                        ));
                                      }
                                    },
                                    onTobag: (){
                                      if(Provider.of<AppModel>(context).loggedIn){
                                        UIBlock.block(context,customLoaderChild: LoadingWidget(context));
                                        Provider.of<CartModel>(context).addProductToCart(e,Provider.of<AppModel>(context).auth.access_token,null).then((value){
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
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        }else{

          return Container(
            height: MediaQuery.of(context).size.height,
              child: Center(
                child: LoadingWidgetFadingCircle(context),
            ),
          );
        }

      }),
      bottomNavigationBar: new PonnyBottomNavbar(selectedIndex: 1),
    );
  }
}

Widget recommendationSection(context, List list) {
  // print(list[0]);
  return Container(
    child: IntrinsicHeight(
      child: Row(
        children: [
          Expanded(
              flex: 1,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: getProduct(context,
                    Product.fromJson(list[0]["data"][0])),
              )),
          Expanded(
              flex: 1,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: getProduct(context,
                    Product.fromJson(list[0]["data"][1])),
              )),
          Expanded(
              flex: 1,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: getProduct(context,
                    Product.fromJson(list[0]["data"][2])),
              )),
        ],
      ),
    ),
  );
}

Widget product(context) {
  return Column(
    children: <Widget>[
      Container(
        child: Stack(
          children: <Widget>[
            GestureDetector(
              onTap: () {
                Navigator.of(context)
                    .pushReplacementNamed(ProductDetailsScreen.id);
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
