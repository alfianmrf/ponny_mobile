import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:ponny/common/constant.dart';
import 'package:ponny/model/App.dart';
import 'package:ponny/model/Cart.dart';
import 'package:ponny/model/FlashDeal.dart';
import 'package:ponny/model/Product.dart';
import 'package:ponny/model/ProductFlashDeal.dart';
import 'package:ponny/model/WishProduct.dart';
import 'package:ponny/screens/account_screen.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:ponny/screens/login.dart';
import 'package:ponny/screens/product_details_screen.dart';
import 'package:ponny/util/globalUrl.dart';
import 'package:ponny/widgets/MyProduct.dart';
import 'package:ponny/widgets/MyProductFlash.dart';
import 'package:provider/provider.dart';
import 'package:uiblock/uiblock.dart';
import 'package:waterfall_flow/waterfall_flow.dart';
import 'package:ponny/widgets/PonnyBottomNavbar.dart';

import 'home_screen.dart';

class ProdukRekomendasiScreen extends StatefulWidget {
  static const String id = "Produk_Rekomendasi_Screen";
  @override
  _ProdukRekomendasiStateScreen createState() => _ProdukRekomendasiStateScreen();
}

class _ProdukRekomendasiStateScreen extends State<ProdukRekomendasiScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0.0,
        elevation: 0.0,
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            color: Color(0xffF48262),
          ),
        ),
        title: Text(
          'Produk Rekomendasi',
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
            preferredSize: Size.fromHeight(1.0)
        ),
      ),
      resizeToAvoidBottomInset: false,
      backgroundColor: Hexcolor('#FCF8F0'),
      body: Container(
        child: Consumer<ProductModel>(
          builder: (context,value,child) {
            if (value.loadingRekomendasi) {
              return LoadingWidgetFadingCircle(context);
            } else {
              return GridView.count(
                childAspectRatio: 0.4,
                padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                shrinkWrap: true,
                crossAxisCount: 3,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                physics: ScrollPhysics(),
                children: [
                  for( Product item_product in value.Recomendasi)
                    MyProduct(
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
                          Provider.of<WishModel>(context).addProductToWish(
                              item_product, Provider
                              .of<AppModel>(context)
                              .auth
                              .access_token);
                        } else {
                          Navigator.push(context, new MaterialPageRoute(
                            builder: (
                                BuildContext context) => new LoginScreen(),
                          ));
                        }
                      },
                      onUnFavorit: () {
                        if (Provider
                            .of<AppModel>(context)
                            .loggedIn) {
                          Provider.of<WishModel>(context).removeProductFromWish(
                              item_product, Provider
                              .of<AppModel>(context)
                              .auth
                              .access_token);
                        } else {
                          Navigator.push(context, new MaterialPageRoute(
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
                              customLoaderChild: LoadingWidget(context));
                          Provider.of<CartModel>(context).addProductToCart(
                              item_product, Provider
                              .of<AppModel>(context)
                              .auth
                              .access_token, null).then((value) {
                            UIBlock.unblock(context);
                            showAlertDialog(context, item_product);
                          });
                        } else {
                          Navigator.push(context, new MaterialPageRoute(
                            builder: (
                                BuildContext context) => new LoginScreen(),
                          ));
                        }
                      },
                    ),
                ],
              );
            }
          }
        )
      ),
      bottomNavigationBar: new PonnyBottomNavbar(selectedIndex: 1),
    );
  }
}
