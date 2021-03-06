import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:lodash_dart/lodash_dart.dart';
import 'package:ponny/common/constant.dart';
import 'package:ponny/model/App.dart';
import 'package:ponny/model/Cart.dart';
import 'package:ponny/model/Product.dart';
import 'package:ponny/model/ProductPoin.dart';
import 'package:ponny/model/StockVariant.dart';
import 'package:ponny/model/User.dart';
import 'package:ponny/screens/Blog_Detail_screen.dart';
import 'package:ponny/screens/account_screen.dart';
import 'package:ponny/util/globalUrl.dart';
import 'package:ponny/widgets/PonnyBottomNavbar.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:uiblock/uiblock.dart';

class HappySkinRewardScreen extends StatefulWidget {
  static const String id = "Happy_Skin_Reward_Screen";
  @override
  _HappySkinRewardStateScreen createState() => _HappySkinRewardStateScreen();
}

class _HappySkinRewardStateScreen extends State<HappySkinRewardScreen>
    with SingleTickerProviderStateMixin {
  int tabIndex = 0;
  TabController tabController;
  List<ProductPoin> lessThan200=[];
  List<ProductPoin> more200to500=[];
  List<ProductPoin> moreThan500=[];
  bool loading = true;


  @override
  void initState() {
    super.initState();
    tabController = TabController(vsync: this, length: 2, initialIndex: 0);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      Provider.of<UserModel>(context).getUser(Provider.of<AppModel>(context,listen: false).auth.access_token).then((value){
        getListOfProduct();
      });

    });
  }

  Future<void> getListOfProduct() async {
    final respon =  await http.get(rdmProduk);
    print(respon.body);
    if(respon.statusCode == 200){
      final responseJson = json.decode(respon.body);

        setState(() {
        for(Map item in responseJson["lessThan200"]){

          int s =0;
          if(item["product"]!= null && item["product"]["stocks"] != null){
            s= item["product"]["current_stock"];
            item["product"]["stocks"].forEach((v) {
              s+=v["qty"];
            });
          }
          if(item["product"]!= null && s>0)
          lessThan200.add(ProductPoin(item["id"],item["jml_point"],Product.fromJson(item["product"]["availability"]),1));
        }
        for(Map item in responseJson["200to500"]){

          int s =0;
          if(item["product"]!= null && item["product"]["stocks"] != null){
            s= item["product"]["current_stock"];
            item["product"]["stocks"].forEach((v) {
              s+=v["qty"];
            });
          }

          if(item["product"]!= null && s>0)
          more200to500.add(ProductPoin(item["id"],item["jml_point"],Product.fromJson(item["product"]["availability"]),1));
        }
        for(Map item in responseJson["moreThan500"]){
          int s =0;
          if(item["product"] != null && item["product"]["stocks"] != null){
            s= item["product"]["current_stock"];
            item["product"]["stocks"].forEach((v) {
              s+=v["qty"];
            });
          }

          if(item["product"]!= null && s>0)
          moreThan500.add(ProductPoin(item["id"],item["jml_point"],Product.fromJson(item["product"]["availability"]),1));
        }
        loading =false;
        });

      }

    }






  @override
  Widget build(BuildContext context) {
    int usepoin = Provider.of<CartModel>(context).gettotalPoin();
    int mypoin = Provider.of<UserModel>(context).user.point;
    int sisa = mypoin-usepoin;
    return DefaultTabController(
      length: 3,
      // initialIndex: tabIndex,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Hexcolor('#FCF8F0'),
        appBar: AppBar(
          elevation: 0,
          titleSpacing: 0,
          leading: IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => AccountScreen(),
                ),
              );
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Color(0xffF48262),
              size: 26,
            ),
          ),
          title:  Text(
            "Happy Skin Reward",
            style: TextStyle(
              fontSize: 24,
              fontFamily: "Yeseva",
              fontWeight: FontWeight.w500,
              color: Color(0xffF48262),
            ),
          ),
          bottom: PreferredSize(
              child: Container(
                color: Color(0xffF48262),
                height: 1.0,
              ),
              preferredSize: Size.fromHeight(1.0)),
        ),
        body: loading ? Container(
          height: MediaQuery.of(context).size.height,
          child: Center(
            child: LoadingWidgetFadingCircle(context),
          ),
        ):
        Container(
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: 20, bottom: 20),
                color: Hexcolor('#FDEDE4'),
                child: Column(
                  children: [
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            child: Text(
                              "POIN KAMU ADA",
                              style: TextStyle(
                                fontFamily: "Brandon",
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            child: RichText(
                              text: TextSpan(
                                text: sisa.toString(),
                                style: TextStyle(
                                  color: Color(0xffF48262),
                                  fontFamily: 'Brandon',
                                  fontSize: 28,
                                  fontWeight: FontWeight.w600,
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: ' POIN',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'Brandon',
                                      fontSize: 28,
                                      fontWeight: FontWeight.w600,
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
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      width: 1,
                      color: Hexcolor("#F59379"),
                    ),
                  ),
                ),
                child: TabBar(
                  indicatorColor: Color(0xffF48262),
                  tabs: [
                    Tab(
                      child: Text(
                        "100 - 250 POIN",
                        style: TextStyle(
                          fontFamily: "Brandon",
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    Tab(
                      child: Text(
                        "251 - 500 POIN",
                        style: TextStyle(
                          fontFamily: "Brandon",
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    Tab(
                      child: Text(
                         "500+ POIN ",
                        style: TextStyle(
                          fontFamily: "Brandon",
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    seratus_point(products: lessThan200,),
                    lebih_duaratus_point(products: more200to500,),
                    lebih_500_point(products: moreThan500,)
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: new PonnyBottomNavbar(selectedIndex: 4),
      ),
    );
  }
}

class seratus_point extends StatefulWidget {
  List<ProductPoin> products;
  seratus_point({Key key,this.products});
  @override
  _SeratusPointScreen createState() => _SeratusPointScreen();
}

class _SeratusPointScreen extends State<seratus_point> {
  @override
  Widget build(BuildContext context) {
    int usepoin = Provider.of<CartModel>(context).gettotalPoin();
    int mypoin = Provider.of<UserModel>(context).user.point;
    int sisa = mypoin-usepoin;
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children:Lodash().chunk(array: widget.products, size: 2).map((e){
            if(e.length == 2)
            return Container(
              margin: EdgeInsets.only(top: 15, bottom: 15),
              padding: EdgeInsets.only(left: 15, right: 15, top: 0, bottom: 0),
              child: IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for(ProductPoin productPoin in e)(
                        Flexible(
                          flex: 1,
                          fit:FlexFit.tight,
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Column(
                              children: [
                                AspectRatio(
                                  aspectRatio: 0.7888,
                                  child: Container(
                                    child: CachedNetworkImage(
                                      imageUrl: img_url+productPoin.product.thumbnail_image,
                                      placeholder: (context, url) => LoadingWidgetPulse(context),
                                      errorWidget: (context, url, error) => Image.asset('assets/images/basic.jpg'),
                                      width: MediaQuery.of(context).size.width,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(
                                          top: 5,
                                        ),
                                        child: Text(
                                          productPoin.product.brand.name,
                                          style: TextStyle(
                                            fontFamily: "Yeseva",
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                    top: 5,
                                  ),
                                  child: Text(
                                    productPoin.product.name,
                                    style: TextStyle(
                                      fontFamily: "Brandon",
                                      fontSize: 14,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                    top: 5,
                                  ),
                                  child: Text(
                                    productPoin.jml_point.toString()+" POIN",
                                    style: TextStyle(
                                      fontFamily: "Brandon",
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Container(
                                        child:productPoin.jml_point <= sisa?
                                        FlatButton(
                                          color: Color(0xffF48262),
                                          textColor: Colors.white,
                                          disabledColor: Colors.grey,
                                          disabledTextColor: Colors.black,
                                          padding: EdgeInsets.all(8.0),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          onPressed: () {
                                            UIBlock.block(context,customLoaderChild: LoadingWidget(context));
                                            Provider.of<CartModel>(context).addRedemToCart(productPoin, Provider.of<AppModel>(context,listen: false).auth.access_token).then((value) {
                                              UIBlock.unblock(context);
                                              showAlertDialog(context,productPoin.product);
                                            }).catchError((onError){
                                              UIBlock.unblock(context);
                                            });
                                          },
                                          child: Text(
                                            "Tukar",
                                            style: TextStyle(fontSize: 16.0),
                                          ),
                                        ):
                                        FlatButton(
                                          color: Color(0xffF48262),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          textColor: Colors.white,
                                          disabledColor: Colors.grey,
                                          disabledTextColor: Colors.black,
                                          height: 0,
                                          minWidth: 0,
                                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                                          onPressed: () {
                                          },
                                          child: Text(
                                            "Tukar",
                                            style: TextStyle(fontSize: 16.0, fontFamily: 'Brandon'),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                    ),
                  ],
                ),
              ),
            );
            else
              return Container(
                margin: EdgeInsets.only(top: 15, bottom: 15),
                padding: EdgeInsets.only(left: 15, right: 15, top: 0, bottom: 0),
                child: IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for(ProductPoin productPoin in e)(
                          Flexible(
                            flex: 1,
                            fit:FlexFit.tight,
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Column(
                                children: [
                                  AspectRatio(
                                    aspectRatio: 0.7888,
                                    child: Container(
                                      child: CachedNetworkImage(
                                        imageUrl: img_url+productPoin.product.thumbnail_image,
                                        placeholder: (context, url) => LoadingWidgetPulse(context),
                                        errorWidget: (context, url, error) => Image.asset('assets/images/basic.jpg'),
                                        width: MediaQuery.of(context).size.width,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(
                                            top: 5,
                                          ),
                                          child: Text(
                                            productPoin.product.brand.name,
                                            style: TextStyle(
                                              fontFamily: "Yeseva",
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                      top: 5,
                                    ),
                                    child: Text(
                                      productPoin.product.name,
                                      style: TextStyle(
                                        fontFamily: "Brandon",
                                        fontSize: 14,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                      top: 5,
                                    ),
                                    child: Text(
                                      productPoin.jml_point.toString()+" POIN",
                                      style: TextStyle(
                                        fontFamily: "Brandon",
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Container(
                                          child:productPoin.jml_point <= sisa?
                                          FlatButton(
                                            color: Color(0xffF48262),
                                            textColor: Colors.white,
                                            disabledColor: Colors.grey,
                                            disabledTextColor: Colors.black,
                                            padding: EdgeInsets.all(8.0),
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                            onPressed: () {
                                              UIBlock.block(context,customLoaderChild: LoadingWidget(context));
                                              Provider.of<CartModel>(context).addRedemToCart(productPoin, Provider.of<AppModel>(context,listen: false).auth.access_token).then((value) {
                                                UIBlock.unblock(context);
                                                showAlertDialog(context,productPoin.product);
                                              }).catchError((onError){
                                                UIBlock.unblock(context);
                                              });
                                            },
                                            child: Text(
                                              "Tukar",
                                              style: TextStyle(fontSize: 16.0),
                                            ),
                                          ):
                                          FlatButton(
                                            color: Color(0xffF48262),
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                            textColor: Colors.white,
                                            disabledColor: Colors.grey,
                                            disabledTextColor: Colors.black,
                                            height: 0,
                                            minWidth: 0,
                                            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                                            onPressed: () {
                                            },
                                            child: Text(
                                              "Tukar",
                                              style: TextStyle(fontSize: 16.0, fontFamily: 'Brandon'),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                      ),
                      Flexible(
                        flex: 1,
                        fit:FlexFit.tight,
                        child: Container(
                        ),
                      )
                    ],
                  ),
                ),
              );
          }).toList()
        ),
      ),
    );
  }
}

class lebih_duaratus_point extends StatefulWidget {
  List<ProductPoin> products;
  lebih_duaratus_point({Key key,this.products});
  @override
  _LebihDuaRatusPointScreen createState() => _LebihDuaRatusPointScreen();
}

class _LebihDuaRatusPointScreen extends State<lebih_duaratus_point> {
  @override
  Widget build(BuildContext context) {
    int usepoin = Provider.of<CartModel>(context).gettotalPoin();
    int mypoin = Provider.of<UserModel>(context).user.point;
    int sisa = mypoin-usepoin;
    return Container(
      child: SingleChildScrollView(
        child: Column(
            children:Lodash().chunk(array: widget.products, size: 2).map((e){
              if(e.length == 2)
                return Container(
                  margin: EdgeInsets.only(top: 15, bottom: 15),
                  padding: EdgeInsets.only(left: 15, right: 15, top: 0, bottom: 0),
                  child: IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        for(ProductPoin productPoin in e)(
                            Flexible(
                              flex: 1,
                              fit:FlexFit.tight,
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Column(
                                  children: [
                                    AspectRatio(
                                      aspectRatio: 0.7888,
                                      child: Container(
                                        child: CachedNetworkImage(
                                          imageUrl: img_url+productPoin.product.thumbnail_image,
                                          placeholder: (context, url) => LoadingWidgetPulse(context),
                                          errorWidget: (context, url, error) => Image.asset('assets/images/basic.jpg'),
                                          width: MediaQuery.of(context).size.width,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(
                                              top: 5,
                                            ),
                                            child: Text(
                                              productPoin.product.brand.name,
                                              style: TextStyle(
                                                fontFamily: "Yeseva",
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(
                                        top: 5,
                                      ),
                                      child: Text(
                                        productPoin.product.name,
                                        style: TextStyle(
                                          fontFamily: "Brandon",
                                          fontSize: 14,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(
                                        top: 5,
                                      ),
                                      child: Text(
                                        productPoin.jml_point.toString()+" POIN",
                                        style: TextStyle(
                                          fontFamily: "Brandon",
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          Container(
                                            child:productPoin.jml_point <= sisa?
                                            FlatButton(
                                              color: Color(0xffF48262),
                                              textColor: Colors.white,
                                              disabledColor: Colors.grey,
                                              disabledTextColor: Colors.black,
                                              padding: EdgeInsets.all(8.0),
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(10),
                                              ),
                                              onPressed: () {
                                                UIBlock.block(context,customLoaderChild: LoadingWidget(context));
                                                Provider.of<CartModel>(context).addRedemToCart(productPoin, Provider.of<AppModel>(context,listen: false).auth.access_token).then((value) {
                                                  UIBlock.unblock(context);
                                                  showAlertDialog(context,productPoin.product);
                                                }).catchError((onError){
                                                  UIBlock.unblock(context);
                                                });
                                              },
                                              child: Text(
                                                "Tukar",
                                                style: TextStyle(fontSize: 16.0),
                                              ),
                                            ):
                                            FlatButton(
                                              color: Color(0xffF48262),
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(10),
                                              ),
                                              textColor: Colors.white,
                                              disabledColor: Colors.grey,
                                              disabledTextColor: Colors.black,
                                              height: 0,
                                              minWidth: 0,
                                              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                                              onPressed: () {
                                              },
                                              child: Text(
                                                "Tukar",
                                                style: TextStyle(fontSize: 16.0, fontFamily: 'Brandon'),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )
                        ),
                      ],
                    ),
                  ),
                );
              else
                return Container(
                  margin: EdgeInsets.only(top: 15, bottom: 15),
                  padding: EdgeInsets.only(left: 15, right: 15, top: 0, bottom: 0),
                  child: IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        for(ProductPoin productPoin in e)(
                            Flexible(
                              flex: 1,
                              fit:FlexFit.tight,
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Column(
                                  children: [
                                    AspectRatio(
                                      aspectRatio: 0.7888,
                                      child: Container(
                                        child: CachedNetworkImage(
                                          imageUrl: img_url+productPoin.product.thumbnail_image,
                                          placeholder: (context, url) => LoadingWidgetPulse(context),
                                          errorWidget: (context, url, error) => Image.asset('assets/images/basic.jpg'),
                                          width: MediaQuery.of(context).size.width,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(
                                              top: 5,
                                            ),
                                            child: Text(
                                              productPoin.product.brand.name,
                                              style: TextStyle(
                                                fontFamily: "Yeseva",
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(
                                        top: 5,
                                      ),
                                      child: Text(
                                        productPoin.product.name,
                                        style: TextStyle(
                                          fontFamily: "Brandon",
                                          fontSize: 14,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(
                                        top: 5,
                                      ),
                                      child: Text(
                                        productPoin.jml_point.toString()+" POIN",
                                        style: TextStyle(
                                          fontFamily: "Brandon",
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          Container(
                                            child:productPoin.jml_point <= sisa?
                                            FlatButton(
                                              color: Color(0xffF48262),
                                              textColor: Colors.white,
                                              disabledColor: Colors.grey,
                                              disabledTextColor: Colors.black,
                                              padding: EdgeInsets.all(8.0),
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(10),
                                              ),
                                              onPressed: () {
                                                UIBlock.block(context,customLoaderChild: LoadingWidget(context));
                                                Provider.of<CartModel>(context).addRedemToCart(productPoin, Provider.of<AppModel>(context,listen: false).auth.access_token).then((value) {
                                                  UIBlock.unblock(context);
                                                  showAlertDialog(context,productPoin.product);
                                                }).catchError((onError){
                                                  UIBlock.unblock(context);
                                                });
                                              },
                                              child: Text(
                                                "Tukar",
                                                style: TextStyle(fontSize: 16.0),
                                              ),
                                            ):
                                            FlatButton(
                                              color: Color(0xffF48262),
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(10),
                                              ),
                                              textColor: Colors.white,
                                              disabledColor: Colors.grey,
                                              disabledTextColor: Colors.black,
                                              height: 0,
                                              minWidth: 0,
                                              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                                              onPressed: () {
                                              },
                                              child: Text(
                                                "Tukar",
                                                style: TextStyle(fontSize: 16.0, fontFamily: 'Brandon'),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )
                        ),
                        Flexible(
                          flex: 1,
                          fit:FlexFit.tight,
                          child: Container(
                          ),
                        )
                      ],
                    ),
                  ),
                );
            }).toList()
        ),
      ),
    );
  }
}

class lebih_500_point extends StatefulWidget {
  List<ProductPoin> products;
  lebih_500_point({Key key,this.products});
  @override
  _LebihLimaRatusPointScreen createState() => _LebihLimaRatusPointScreen();
}

class _LebihLimaRatusPointScreen extends State<lebih_500_point> {
  @override
  Widget build(BuildContext context) {
    int usepoin = Provider.of<CartModel>(context).gettotalPoin();
    int mypoin = Provider.of<UserModel>(context).user.point;
    int sisa = mypoin-usepoin;
    return Container(
      child: SingleChildScrollView(
        child: Column(
            children:Lodash().chunk(array: widget.products, size: 2).map((e){
              if(e.length == 2)
                return Container(
                  margin: EdgeInsets.only(top: 15, bottom: 15),
                  padding: EdgeInsets.only(left: 15, right: 15, top: 0, bottom: 0),
                  child: IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        for(ProductPoin productPoin in e)(
                            Flexible(
                              flex: 1,
                              fit:FlexFit.tight,
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Column(
                                  children: [
                                    AspectRatio(
                                      aspectRatio: 0.7888,
                                      child: Container(
                                        child: CachedNetworkImage(
                                          imageUrl: img_url+productPoin.product.thumbnail_image,
                                          placeholder: (context, url) => LoadingWidgetPulse(context),
                                          errorWidget: (context, url, error) => Image.asset('assets/images/basic.jpg'),
                                          width: MediaQuery.of(context).size.width,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(
                                              top: 5,
                                            ),
                                            child: Text(
                                              productPoin.product.brand.name,
                                              style: TextStyle(
                                                fontFamily: "Yeseva",
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(
                                        top: 5,
                                      ),
                                      child: Text(
                                        productPoin.product.name,
                                        style: TextStyle(
                                          fontFamily: "Brandon",
                                          fontSize: 14,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(
                                        top: 5,
                                      ),
                                      child: Text(
                                        productPoin.jml_point.toString()+" POIN",
                                        style: TextStyle(
                                          fontFamily: "Brandon",
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          Container(
                                            child:productPoin.jml_point <= sisa?
                                            FlatButton(
                                              color: Color(0xffF48262),
                                              textColor: Colors.white,
                                              disabledColor: Colors.grey,
                                              disabledTextColor: Colors.black,
                                              padding: EdgeInsets.all(8.0),
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(10),
                                              ),
                                              onPressed: () {
                                                UIBlock.block(context,customLoaderChild: LoadingWidget(context));
                                                Provider.of<CartModel>(context).addRedemToCart(productPoin, Provider.of<AppModel>(context,listen: false).auth.access_token).then((value) {
                                                  UIBlock.unblock(context);
                                                  showAlertDialog(context,productPoin.product);
                                                }).catchError((onError){
                                                  UIBlock.unblock(context);
                                                });
                                              },
                                              child: Text(
                                                "Tukar",
                                                style: TextStyle(fontSize: 16.0),
                                              ),
                                            ):
                                            FlatButton(
                                              color: Color(0xffF48262),
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(10),
                                              ),
                                              textColor: Colors.white,
                                              disabledColor: Colors.grey,
                                              disabledTextColor: Colors.black,
                                              height: 0,
                                              minWidth: 0,
                                              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                                              onPressed: () {
                                              },
                                              child: Text(
                                                "Tukar",
                                                style: TextStyle(fontSize: 16.0, fontFamily: 'Brandon'),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )
                        ),
                      ],
                    ),
                  ),
                );
              else
                return Container(
                  margin: EdgeInsets.only(top: 15, bottom: 15),
                  padding: EdgeInsets.only(left: 15, right: 15, top: 0, bottom: 0),
                  child: IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        for(ProductPoin productPoin in e)(
                            Flexible(
                              flex: 1,
                              fit:FlexFit.tight,
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Column(
                                  children: [
                                    AspectRatio(
                                      aspectRatio: 0.7888,
                                      child: Container(
                                        child: CachedNetworkImage(
                                          imageUrl: img_url+productPoin.product.thumbnail_image,
                                          placeholder: (context, url) => LoadingWidgetPulse(context),
                                          errorWidget: (context, url, error) => Image.asset('assets/images/basic.jpg'),
                                          width: MediaQuery.of(context).size.width,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(
                                              top: 5,
                                            ),
                                            child: Text(
                                              productPoin.product.brand.name,
                                              style: TextStyle(
                                                fontFamily: "Yeseva",
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(
                                        top: 5,
                                      ),
                                      child: Text(
                                        productPoin.product.name,
                                        style: TextStyle(
                                          fontFamily: "Brandon",
                                          fontSize: 14,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(
                                        top: 5,
                                      ),
                                      child: Text(
                                        productPoin.jml_point.toString()+" POIN",
                                        style: TextStyle(
                                          fontFamily: "Brandon",
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          Container(
                                            child:productPoin.jml_point <= sisa?
                                            FlatButton(
                                              color: Color(0xffF48262),
                                              textColor: Colors.white,
                                              disabledColor: Colors.grey,
                                              disabledTextColor: Colors.black,
                                              padding: EdgeInsets.all(8.0),
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(10),
                                              ),
                                              onPressed: () {
                                                UIBlock.block(context,customLoaderChild: LoadingWidget(context));
                                                Provider.of<CartModel>(context).addRedemToCart(productPoin, Provider.of<AppModel>(context,listen: false).auth.access_token).then((value) {
                                                  UIBlock.unblock(context);
                                                  showAlertDialog(context,productPoin.product);
                                                }).catchError((onError){
                                                  UIBlock.unblock(context);
                                                });
                                              },
                                              child: Text(
                                                "Tukar",
                                                style: TextStyle(fontSize: 16.0),
                                              ),
                                            ):
                                            FlatButton(
                                              color: Color(0xffF48262),
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(10),
                                              ),
                                              textColor: Colors.white,
                                              disabledColor: Colors.grey,
                                              disabledTextColor: Colors.black,
                                              height: 0,
                                              minWidth: 0,
                                              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                                              onPressed: () {
                                              },
                                              child: Text(
                                                "Tukar",
                                                style: TextStyle(fontSize: 16.0, fontFamily: 'Brandon'),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )
                        ),
                        Flexible(
                          flex: 1,
                          fit:FlexFit.tight,
                          child: Container(
                          ),
                        )
                      ],
                    ),
                  ),
                );
            }).toList()
        ),
      ),
    );
  }
}


