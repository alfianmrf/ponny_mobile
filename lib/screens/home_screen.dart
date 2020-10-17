import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ponny/common/constant.dart';
import 'package:ponny/model/Product.dart';
import 'package:ponny/model/Slider.dart';
import 'package:ponny/model/User.dart';
import 'package:ponny/screens/login.dart';
import 'package:ponny/screens/product_details_screen.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:ponny/util/globalUrl.dart';
import 'package:ponny/widgets/PonnyBottomNavbar.dart';
import 'package:ponny/widgets/PonnyAppBar.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static const String id = "home_screen";

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Timer _timer;



  showModal() {
    return _timer = Timer(Duration(seconds: 2), () {
      showAlertDialog(context);
    });
  }

  Widget products() {
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


  @override
  void initState() {
    super.initState();
    showModal();
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

  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Alert Dialog title"),
          content: new Text("Alert Dialog body"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
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
  List<Widget> getBestsale(List<Product> data) {
    List<Widget> _result =[];
    for(Product product in data){
      _result.add(getProduct(context,product));
    }
    return _result;
  }

  // bool checkDialog = false;

  @override
  Widget build(BuildContext context) {

    final bestsale =Provider.of<ProductModel>(context).Best_sell;
    final silder = Provider.of<SliderModel>(context).listSlider;


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
                new PonnyAppBar(),
              ],
            ),
          ),
          body: new Container(
              margin: MediaQuery.of(context).padding,
              child: SingleChildScrollView(
                  child: Column(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.width * 0.65,
                child: new Swiper(
                  itemBuilder: (BuildContext context, int index) {
                    return new Image.network(
                      img_url+silder[index].photo,
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
              title("Best Seller"),
              Container(
                height: MediaQuery.of(context).size.width * .8,
                child: Consumer<ProductModel>(
                  builder: (context,value,child){
                    if(value.loadingBestSale){
                      return LoadingWidgetFadingcube(context);
                    }else{
                      return  new Swiper(
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(horizontal: 5),
                                    child: products(),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(horizontal: 5),
                                    child: products(),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(horizontal: 5),
                                    child: products(),
                                  ),
                                ),
                              ],
                            ),
                          );
                          return GridView.count(
                            shrinkWrap: true,
                            primary: false,
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            childAspectRatio: 0.4,
                            crossAxisCount: 3,
                            children: getBestsale(value.Best_sell),
                          );
                        },
                        itemCount: 3,
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
                    if(value.loadingBestSale){
                      return LoadingWidgetFadingcube(context);
                    }else{
                      return  new Swiper(
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(horizontal: 5),
                                    child: products(),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(horizontal: 5),
                                    child: products(),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(horizontal: 5),
                                    child: products(),
                                  ),
                                ),
                              ],
                            ),
                          );
                          return GridView.count(
                            shrinkWrap: true,
                            primary: false,
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            childAspectRatio: 0.4,
                            crossAxisCount: 3,
                            children: getBestsale(value.Best_sell),
                          );
                        },
                        itemCount: 3,
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
