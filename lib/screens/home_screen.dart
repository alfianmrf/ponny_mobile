import 'dart:async';
import 'dart:collection';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ponny/common/constant.dart';
import 'package:ponny/model/App.dart';
import 'package:ponny/model/Cart.dart';
import 'package:ponny/model/Product.dart';
import 'package:ponny/model/Slider.dart';
import 'package:ponny/model/User.dart';
import 'package:ponny/screens/flash_sale_screen.dart';
import 'package:ponny/model/WishProduct.dart';
import 'package:ponny/screens/login.dart';
import 'package:ponny/screens/product_details_screen.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:ponny/util/globalUrl.dart';
import 'package:ponny/widgets/PonnyBottomNavbar.dart';
import 'package:ponny/widgets/PonnyAppBar.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ponny/screens/cart_screen.dart';

import 'account/daftar_keinginan_screen.dart';

class HomeScreen extends StatefulWidget {
  static const String id = "home_screen";

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Timer _timer;

  final double targetElevation = 3;
  final targetColor = Color(0xfffdf8f0);
  var _color = Colors.transparent;
  double _elevation = 0;
  ScrollController _controller;

  showModal() {
    return _timer = Timer(Duration(seconds: 2), () {
      showAlertDialog(context);
    });
  }




  @override
  void initState() {
    super.initState();
    showModal();
    _controller = ScrollController();
    _controller.addListener(_scrollListener);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _getCartOfitem();
      _getWishListCount();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller?.removeListener(_scrollListener);
    _controller?.dispose();
  }

  void _scrollListener() {
    double newElevation = _controller.offset > 1 ? targetElevation : 0;
    final newColor = _controller.offset > 1 ? targetColor : Colors.transparent;
    if (_elevation != newElevation) {
      setState(() {
        _elevation = newElevation;
      });
    }
    if (_color != newColor) {
      setState(() {
        _color = newColor;
      });
    }
  }

  Future<void> _getCartOfitem() async {
    final auth = Provider.of<AppModel>(context);
    if(auth.loggedIn){
      await Provider.of<CartModel>(context).getCart(auth.auth.access_token);
    }
  }

  Future<void> _getWishListCount() async {
    final auth = Provider.of<AppModel>(context);
    if(auth.loggedIn){
      await Provider.of<WishModel>(context).getCountWislist(auth.auth.access_token);
    }
  }

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);



  Widget title(String nameTitle) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Text(
        nameTitle,
        style: TextStyle(
          fontFamily: 'Yeseva',
          fontSize: 20,
        ),
      ),
    );
  }

  Widget blog() {
    return Column(
      children: <Widget>[
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 5.0),
            child: Text(
              'BASIC SKINCARE',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontFamily: 'Brandon',
                fontSize: 14,
              ),
            ),
          ),
        ),
        Image.asset(
          "assets/images/blogImage.png",
          height: 200,
          fit: BoxFit.cover,
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 5.0),
            child: Text(
              'BEDA EYE GEL, EYE CREAM DAN EYE SERUM',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontFamily: 'Brandon',
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
            textAlign: TextAlign.left,
            style: TextStyle(
              fontFamily: 'Brandon',
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }



  void showAlertDialog(BuildContext context) {
    // set up the AlertDialog
    SimpleDialog alert = SimpleDialog(
      backgroundColor: Color(0xfffdf8f0),
      contentPadding: EdgeInsets.all(5.0),
      children: <Widget>[
        Align(
          alignment: Alignment.centerRight,
          child: IconButton(
              icon: Icon(Icons.close),
              color: Color(0xffF48262),
              onPressed: () {
                Navigator.of(context).pop();
              }),
        ),
        Center(
            child: Image.asset(
          'assets/images/ponny.png',
          height: 100,
        )),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Center(
              child: Text(
            'HALO!',
            style: TextStyle(
              fontFamily: 'Brandon',
              fontWeight: FontWeight.w600,
              fontSize: 20,
            ),
          )),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Center(
              child: Text(
            'Nikmati diskon 10% untuk pesanan pertamamu. Mau? Tulis email aktifmu di bawah ini dan Phoebe akan kirim kode promonya ke email.',
            style: TextStyle(
              fontFamily: 'Brandon',
              fontSize: 14,
            ),
            textAlign: TextAlign.center,
          )),
        ),
        Padding(
          padding: EdgeInsets.only(top: 20, bottom: 10, left: 30, right: 30),
          child: TextFormField(
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              hintText: 'Email',
              hintStyle: TextStyle(color: Color(0xffBCBDC0)),
              labelText: 'Email',
              labelStyle: TextStyle(color: Colors.black),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                borderSide: BorderSide(
                  color: Color(0xffF48262),
                  width: 1.0,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                borderSide: BorderSide(
                  color: Color(0xffF48262),
                  width: 1.0,
                ),
              ),
            ),
            keyboardType: TextInputType.emailAddress,
            validator: (String value) {
              if (value.isEmpty) {
                return 'Email tidak boleh kosong';
              } else if (!value.contains('@')) {
                return 'Email tidak valid';
              }
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 30),
          child: Center(
            child: Wrap(children: <Widget>[
              FlatButton(
                color: Color(0xffF48262),
                padding: EdgeInsets.symmetric(horizontal: 30),
                textColor: Colors.white,
                onPressed: () {},
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Text(
                  "DAFTAR",
                  style: TextStyle(
                    fontSize: 16.0,
                    fontFamily: 'Brandon',
                  ),
                ),
              ),
            ]),
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

  Future<bool> _onWillPop() async {
    return (await showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: new Text('Are you sure?'),
        content: new Text('Do you want to exit an App'),
        actions: <Widget>[
          new FlatButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: new Text('No'),
          ),
          new FlatButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: new Text('Yes'),
          ),
        ],
      ),
    )) ?? false;
  }


  // bool checkDialog = false;

  @override
  Widget build(BuildContext context) {

    final silder = Provider.of<SliderModel>(context).listSlider;
    List<Widget> ListFlash;
    List<Widget> ListBestsale;
    List<Widget> ListPhobe;
    final jmlCard = Provider.of<CartModel>(context).getCountOfquantity();




    return new WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Stack(children: <Widget>[
        Scaffold(
          backgroundColor: Color(0xffFDF8F0),
          extendBodyBehindAppBar: true,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(100.0),
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(vertical: 5),
                  margin: MediaQuery.of(context).padding,
                  color: Color(0xffF48262),
                  child: Center(
                    child: Text(
                      'GRATIS ONGKIR DENGAN PEMBELANJAAN RP 250.000',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Brandon',
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
                new AppBar(
                  primary: false,
                  title: Image.asset('assets/images/PonnyBeaute.png', fit: BoxFit.contain, height: 46),
                  centerTitle: true,
                  backgroundColor: _color,
                  elevation: _elevation,
                  leading: Icon(
                    Icons.search,
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
                            Provider.of<AppModel>(context).loggedIn?
                            new Container(
                              padding: EdgeInsets.all(5),
                              child: Provider.of<CartModel>(context).loadingCard? LoadingRing(context): Icon(Icons.shopping_cart),
                            ):new Container(
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
                        if(Provider.of<AppModel>(context).loggedIn){
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CartScreen()),
                          );
                        }else{
                          Navigator.push(context,new MaterialPageRoute(
                            builder: (BuildContext context) => new LoginScreen(),
                          ));
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          body: new Container(
              margin: MediaQuery.of(context).padding,
              child: SingleChildScrollView(
                  controller: _controller,
                  child: Column(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.width * 0.65,
                color: Colors.white,
                child: Center(
                  child: new Swiper(
                    itemBuilder: (BuildContext context, int index) {
                      return new CachedNetworkImage(
                        imageUrl: img_url+silder[index].photo,
                        placeholder: (context, url) => LoadingWidgetPulse(context),
                        errorWidget: (context, url, error) => Image.asset('assets/images/basic.jpg'),
                        fit: BoxFit.cover,
                      );
                    },
                    itemCount: silder.length,
                    pagination: new SwiperPagination(
                        margin: new EdgeInsets.all(5.0),
                        builder: new DotSwiperPaginationBuilder(
                            color: Color(0xffE6E7E9),
                            activeColor: Color(0xffF48262))),
                    control: null,
                    autoplay: true,
                  ),
                ),
              ),
              Container(
                color: Color(0xffFACAC1),
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.only(top: 8, bottom: 3),
                child: Image.asset('assets/images/flash-sale.png', height: 40),
              ),
              Container(
                color: Color(0xffFBDFD2),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Text(
                        'Happy Skin',
                        style: TextStyle(
                          fontFamily: 'Yeseva',
                          fontSize: 26,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Padding(
                              padding: EdgeInsets.only(right: 10),
                              child: Text(
                                'DIMULAI DALAM',
                                style: TextStyle(
                                  fontFamily: 'Brandon',
                                ),
                                textAlign: TextAlign.right,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Row(
                                children: [
                                  Container(
                                    width: 24,
                                    height: 24,
                                    decoration: BoxDecoration(
                                      color: Color(0xffF48262),
                                      borderRadius: BorderRadius.circular(3),
                                    ),
                                    child: Center(
                                      child: Text(
                                        '12',
                                        style: TextStyle(
                                          fontFamily: 'Brandon',
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 5),
                                    child: Text(
                                      ':',
                                      style: TextStyle(
                                        fontFamily: 'Brandon',
                                        color: Color(0xffF48262),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 24,
                                    height: 24,
                                    decoration: BoxDecoration(
                                      color: Color(0xffF48262),
                                      borderRadius: BorderRadius.circular(3),
                                    ),
                                    child: Center(
                                      child: Text(
                                        '12',
                                        style: TextStyle(
                                          fontFamily: 'Brandon',
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 5),
                                    child: Text(
                                      ':',
                                      style: TextStyle(
                                        fontFamily: 'Brandon',
                                        color: Color(0xffF48262),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 24,
                                    height: 24,
                                    decoration: BoxDecoration(
                                      color: Color(0xffF48262),
                                      borderRadius: BorderRadius.circular(3),
                                    ),
                                    child: Center(
                                      child: Text(
                                        '27',
                                        style: TextStyle(
                                          fontFamily: 'Brandon',
                                          color: Colors.white,
                                        ),
                                      ),
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
                      height: MediaQuery.of(context).size.width*0.95,
                      padding: EdgeInsets.only(top: 10),
                      child: Consumer<ProductModel>(
                        builder: (context,value,child){
                          if(value.loadingBestSale){
                            return LoadingWidgetFadingCircle(context);
                          }else{
                            ListFlash = getColumProductFlash(context,value.Best_sell,3);
                            return  new Swiper(
                              itemBuilder: (BuildContext context, int index) {
                                return ListFlash[index];
                              },
                              itemCount: ListFlash.length,
                              pagination: null,
                              control: null,
                              autoplay: false,
                            );
                          }
                        },
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: FlatButton(
                        height: 30,
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        onPressed: (){
                          Navigator.push(context, new MaterialPageRoute(
                            builder: (BuildContext context) => new FlashSaleScreen(),
                          ));
                        },
                        color: Color(0xffF48262),
                        child: Text(
                          'LIHAT SEMUA',
                          style: TextStyle(
                            fontFamily: 'Brandon',
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              title("Best Seller"),
              Container(
                height: MediaQuery.of(context).size.width * .8,
                child: Consumer<ProductModel>(
                  builder: (context,value,child){
                    if(value.loadingBestSale){
                      return LoadingWidgetFadingCircle(context);
                    }else{
                      ListBestsale = getColumProduct(context,value.Best_sell,3);
                      return  new Swiper(
                        itemBuilder: (BuildContext context, int index) {
                          return ListBestsale[index];
                        },
                        itemCount: ListBestsale.length,
                        pagination: null,
                        control: null,
                        autoplay: false,
                      );
                    }
                  },
                ),
              ),
              Container(
                height: 1.5,
                width: MediaQuery.of(context).size.width * 0.9,
                color: Color(0xffF48262),
              ),
              title("Phoebe's Choice"),
              Container(
                height: MediaQuery.of(context).size.width * .8,
                child: Consumer<ProductModel>(
                  builder: (context,value,child){
                    if(value.loadingPhobe){
                      return LoadingWidgetFadingCircle(context);
                    }else{
                      ListPhobe = getColumProduct(context,value.PhoebeChoices,3);
                      return  new Swiper(
                        itemBuilder: (BuildContext context, int index) {
                          return ListPhobe[index];
                        },
                        itemCount: ListPhobe.length,
                        pagination: null,
                        control: null,
                        autoplay: false,
                      );
                    }
                  },
                ),
              ),
              Container(
                color: Color(0xffFBDFD2),
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(vertical: 15),
                child: Image.asset('assets/images/blog.png',
                    fit: BoxFit.contain, height: 40),
              ),
              Container(
                color: Color(0xffFBDFD2),
                height: MediaQuery.of(context).size.height * .70,
                child: new Swiper(
                  itemBuilder: (BuildContext context, int index) {
                    return GridView.count(
                      shrinkWrap: true,
                      primary: false,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                      childAspectRatio: 0.35,
                      crossAxisCount: 2,
                      children: <Widget>[
                        blog(),
                        blog(),
                      ],
                    );
                  },
                  itemCount: 3,
                  pagination: new SwiperPagination(
                      margin: new EdgeInsets.symmetric(
                          horizontal: 5.0, vertical: 15.0),
                      builder: new DotSwiperPaginationBuilder(
                          color: Color(0xffE6E7E9),
                          activeColor: Color(0xffF48262))),
                  control: null,
                  autoplay: false,
                ),
              ),
            ],
          ))),
        ),
      ]),
      bottomNavigationBar: new PonnyBottomNavbar(selectedIndex: 0),
      ),
    );
  }
}

class SecondRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Second Route"),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Go back!'),
        ),
      ),
    );
  }
}
