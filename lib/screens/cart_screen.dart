import 'dart:convert';
// import 'dart:html';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:lodash_dart/lodash_dart.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:ponny/common/constant.dart';
import 'package:ponny/model/App.dart';
import 'package:ponny/model/Cart.dart';
import 'package:ponny/model/Product.dart';
import 'package:ponny/model/MetodePengirimanModel.dart';
import 'package:ponny/model/User.dart';
import 'package:ponny/model/WishProduct.dart';
import 'package:ponny/model/listCabangModel.dart';
import 'package:ponny/screens/PilihSample.dart';
import 'package:ponny/screens/account/happy_skin_reward_screen.dart';
import 'package:ponny/screens/login.dart';
import 'package:ponny/screens/pages.dart';
import 'package:ponny/screens/product_details_screen.dart';
import 'package:ponny/util/globalUrl.dart';
import 'package:ponny/widgets/PonnyBottomNavbar.dart';
import 'package:ponny/screens/shipping_screen.dart';
import 'package:provider/provider.dart';
import 'package:ponny/model/Cart.dart';
import 'package:uiblock/uiblock.dart';
import 'package:http/http.dart' as http;
import 'dart:io' show HttpHeaders, Platform;


class CartScreen extends StatefulWidget {
  static const String id = "cart_screen";

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  TextEditingController _code = TextEditingController();
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  Future<Null> _updateCart()  async {
    var token = Provider.of<AppModel>(context).auth.access_token;
    final response = await http.get(listCarturl,headers: { HttpHeaders.contentTypeHeader: 'application/json',HttpHeaders.authorizationHeader: "Bearer $token" });
    if(response.statusCode == 200)
    {
      final responseJson = json.decode(response.body);
      print("DATA CART");
      print(responseJson['data']);
    }else{
      print("DATA CART");
      print(response.statusCode);
    }

  }

  Future<void>_getSummaryPoint() async {
    String available = Provider.of<ListCabang>(context).cabangClick == null ? "" : json.encode(Provider.of<ListCabang>(context).cabangClick.availableProduct);
    var token = Provider.of<AppModel>(context).auth.access_token;
    Provider.of<CartModel>(context).shipping = null;
    Provider.of<CartModel>(context).getPointSummary(Provider.of<ListCabang>(context).setPointValue, available , token);
  }

  Future<void>_getUnavaliableProduct() async{
    print("get unav");
    Provider.of<ListCabang>(context).unavaliable = [];
    for (var item in Provider.of<CartModel>(context).listCardOfitem){
      Provider.of<ListCabang>(context).addDataUn(item);
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _getSummaryPoint();
      _updateCart();
      _getUnavaliableProduct();
      await Provider.of<CartModel>(context).RemoveCoupon();
      await Provider.of<UserModel>(context).getUser(
          Provider.of<AppModel>(context, listen: false).auth.access_token);
       Provider.of<ListCabang>(context).setDataUnavaliable = null;

    });
  }

  int _n1 = 1;
  int _n2 = 1;
  List<dynamic> detailImage;
  bool productOutOfStock = true;


  void add1() {
    setState(() {
      _n1++;
    });
  }

  void add2() {
    setState(() {
      _n2++;
    });
  }

  void minus1() {
    setState(() {
      if (_n1 != 1) _n1--;
    });
  }

  void minus2() {
    setState(() {
      if (_n2 != 1) _n2--;
    });
  }

  String dropdownValue = 'One';

  
  void _methodeModalBottomSheet(context) {
    final size = MediaQuery.of(context).size;
    Provider.of<ListCabang>(context).unavaliable = [];
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(15))),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        builder: (BuildContext bc) {
          return Container(
            child: new Wrap(
              children: <Widget>[
                new Column(
                  children: [
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.only(top: 5),
                      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 9),
                      child: Row(
                        children: [
                          Text(
                            "Detail Pembayaran",
                            style: TextStyle(
                              fontFamily: "Brandon",
                              fontWeight: FontWeight.w600,
                              color: Color(0xffF48262),
                              fontSize: 20,
                            ),
                          ),
                          Spacer(),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pop(false);
                            },
                            child: Container(
                                width: 30,
                                height: 30,
                                child: Icon(Icons.close,
                                    color: Color(0xffF48262))),
                          )
                        ],
                      ),
                    ),
                    Divider(color: Color(0xffF48262)),
                    Padding(
                      padding: EdgeInsets.only(bottom: 20),
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/images/perjalanan@4x.png',
                            width: 46,
                            height: 46,
                            fit: BoxFit.contain,
                          ),
                          Text(
                            "Delivery",
                            style: TextStyle(
                              fontFamily: "Brandon",
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                              fontSize: 15,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              "Pihak kurir akan mengirimkan belanjaanmu ke alamat penerima.",
                              style: TextStyle(
                                fontFamily: "Brandon",
                                color: Colors.black,
                                fontSize: 14,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            child: Divider(
                              color: Color(0xffF48262),
                            ),
                          ),
                          Image.asset(
                            'assets/images/perjalanan@4x.png',
                            width: 46,
                            height: 46,
                            fit: BoxFit.contain,
                          ),
                          Text(
                            "Pick Up In Store",
                            style: TextStyle(
                              fontFamily: "Brandon",
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                              fontSize: 15,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              "Ambil sendiri belanjaanmu di toko Ponny Beaute terdekat, yuk!\nOiya, pastikan stok produk tersedia, ya.",
                              style: TextStyle(
                                fontFamily: "Brandon",
                                color: Colors.black,
                                fontSize: 14,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          );
        });
  }

  void _changeMethodeModalBottomSheet(context) {
    final size = MediaQuery.of(context).size;
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(15))),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        builder: (BuildContext bc) {
          return Container(
            child: new Wrap(
              children: <Widget>[
                new Column(
                  children: [
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.only(top: 5),
                      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 9),
                      child: Row(
                        children: [
                          Text(
                            "METODE PENGIRIMAN",
                            style: TextStyle(
                              fontFamily: "Brandon",
                              fontWeight: FontWeight.w600,
                              color: Color(0xffF48262),
                              fontSize: 20,
                            ),
                          ),
                          Spacer(),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pop(false);
                            },
                            child: Container(
                                width: 30,
                                height: 30,
                                child: Icon(Icons.close,
                                    color: Color(0xffF48262))),
                          )
                        ],
                      ),
                    ),
                    Divider(color: Color(0xffF48262)),
                    Padding(
                      padding: EdgeInsets.only(bottom: 20),
                      child: Column(
                        children: [
                          Container(
                              child: GestureDetector(
                                onTap: () {
                                    Provider.of<ListCabang>(context).setDataUnavaliable = true;
                                    Provider.of<ListCabang>(context).cabangClick = null;
                                    Navigator.pop(context);
                                },
                                child: Column(children: [
                            Padding(
                                padding: EdgeInsets.only(left: 20),
                                child: Row(children: [
                                  Image.asset(
                                    'assets/images/perjalanan@4x.png',
                                    width: 25,
                                    height: 25,
                                    fit: BoxFit.contain,
                                  ),
                                  SizedBox(width: 7),
                                  Text(
                                    "Delivery",
                                    style: TextStyle(
                                      fontFamily: "Brandon",
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                      fontSize: 15,
                                    ),
                                  )
                                ]),
                            ),
                            Container(
                                margin: EdgeInsets.symmetric(horizontal: 5),
                                child: Text(
                                  "Pesanan akan dikirim ke alamat penerima yang sudah kamu pilih",
                                  style: TextStyle(
                                    fontFamily: "Brandon",
                                    color: Colors.black45,
                                    fontSize: 13,
                                  ),
                                ),
                            ),
                          ]),
                              )),
                          Padding(
                              padding: EdgeInsets.symmetric(horizontal: 15),
                              child: Divider(
                                color: Color(0xffF48262),
                              )),
                          GestureDetector(
                            onTap: () {
                              Provider.of<MetodePengiriman>(context);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ListTokoPengirimanScreen()),
                              );
                            },
                            child: Container(
                              child: Column(
                                children: [
                                  Padding(
                                      padding: EdgeInsets.only(left: 20),
                                      child: Row(children: [
                                        Image.asset(
                                          'assets/images/perjalanan@4x.png',
                                          width: 25,
                                          height: 25,
                                          fit: BoxFit.contain,
                                        ),
                                        SizedBox(width: 7),
                                        Text(
                                          "Pick Up",
                                          style: TextStyle(
                                            fontFamily: "Brandon",
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black,
                                            fontSize: 15,
                                          ),
                                        )
                                      ])),
                                  Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 5),
                                    child: Text(
                                      "Pesanan akan dikirim ke alamat penerima yang sudah kamu pilih",
                                      style: TextStyle(
                                        fontFamily: "Brandon",
                                        color: Colors.black45,
                                        fontSize: 13,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          );
        });
  }

  void showSample() {
    showMaterialModalBottomSheet(
      context: context,
      useRootNavigator: true,
      builder: (context, scrollController) => Container(
        child: Container(
          height: MediaQuery.of(context).size.height * .65,
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                color: Color(0xffF48262),
                height: MediaQuery.of(context).size.width * .1,
                width: MediaQuery.of(context).size.width,
                child: Text(
                  'PILIH SAMPLE',
                  style: TextStyle(
                      fontFamily: 'Brandon', fontSize: 16, color: Colors.white),
                ),
              ),
              Container(
                height: 300,
                child: SingleChildScrollView(
                  child: GridView.count(
                    primary: false,
                    padding: const EdgeInsets.all(20),
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    crossAxisCount: 2,
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.all(8),
                        child: const Text("He'd have you all unravel at the"),
                        color: Colors.teal[100],
                      ),
                      Container(
                        padding: const EdgeInsets.all(8),
                        child: const Text('Heed not the rabble'),
                        color: Colors.teal[200],
                      ),
                      Container(
                        padding: const EdgeInsets.all(8),
                        child: const Text('Sound of screams but the'),
                        color: Colors.teal[300],
                      ),
                      Container(
                        padding: const EdgeInsets.all(8),
                        child: const Text('Who scream'),
                        color: Colors.teal[400],
                      ),
                      Container(
                        padding: const EdgeInsets.all(8),
                        child: const Text('Revolution is coming...'),
                        color: Colors.teal[500],
                      ),
                      Container(
                        padding: const EdgeInsets.all(8),
                        child: const Text('Revolution, they...'),
                        color: Colors.teal[600],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void>addWishlistUnavaliable(Product id) async {
    if(Provider.of<AppModel>(context).loggedIn) {
        Provider.of<WishModel>(context).addProductToWish(id, Provider.of<AppModel>(context).auth.access_token);
        if ( Provider.of<WishModel>(context).success == true ) showWishDialog(context, id);

    }else{
      Navigator.push(context,new MaterialPageRoute(
        builder: (BuildContext context) => new LoginScreen(),
      ));
    }
  }


  void showWishDialog(BuildContext context, Product product) {
    // set up the AlertDialog
    SimpleDialog alert = SimpleDialog(
      backgroundColor: Color(0xfffdf8f0),
      contentPadding: EdgeInsets.all(5.0),
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(top: 30),
          child: Icon(
            Icons.favorite,
            color: Color(0xffF48262),
            size: 40,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Center(
              child: Text(
                'DITAMBAHKAN KE WISHLIST',
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
                      product.name.length > 20 ? product.name.substring(0, 20)+'...' : product.name,
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

  void showDeleteDialog(BuildContext context, Product product,int id) {
    // set up the AlertDialog
    SimpleDialog alert = SimpleDialog(
      backgroundColor: Color(0xfffdf8f0),
      contentPadding: EdgeInsets.all(5.0),
      children: [
        Container(
          padding: EdgeInsets.only(top: 30,bottom: 15),
          child: Icon(
            Icons.favorite,
            color: Color(0xffF48262),
            size: 40,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Center(
              child: Text(
                'ANDA YAKIN MENGHAPUS DATA ?',
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
                      product.name.length > 20 ? product.name.substring(0, 20)+'...' : product.name,
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
        Padding(
          padding: EdgeInsets.fromLTRB(20, 0, 20, 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              
              RaisedButton(onPressed: (){
                Navigator.pop(context);
              },
                  color: Color(0xffF48262),
                  child: Text("Tidak",style: TextStyle(fontFamily: 'Brandon',
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: Colors.white)),
              ),
              RaisedButton(onPressed: (){
                UIBlock.block(context,
                    customLoaderChild:
                    LoadingWidget(
                        context));
                Provider.of<CartModel>(context).DeleteProductToCart(
                    id,
                    Provider.of<AppModel>(
                        context)
                        .auth
                        .access_token)
                    .then((value) {
                      UIBlock.unblock(context);
                      Navigator.pop(context);
                });
              },
                color: Color(0xffF48262),
                child: Text("Ya",style: TextStyle(fontFamily: 'Brandon',
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Colors.white)),
              )
            ],
          ),
        )
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

  void selectTypeMethodPayment(){
    print("ini data ==>"+Provider.of<ListCabang>(context).isDelivery.toString());
    var cabang = Provider.of<ListCabang>(context);

    if(cabang.isDelivery != true ){
      if (cabang.unavaliable.length == 0 && cabang.cabangClick != null || cabang.isDelivery == true){
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => RincianPengambilanScreen()),
        );
      }
      else
        {
          final snackBar = SnackBar(
            content: Text(
                cabang.cabangClick == null && cabang.isDelivery != true ? 'Maaf, Metode pengiriman kosong' : 'Maaf, Produk ada yang tidak tersedia',
                style: TextStyle(
                    color: Colors
                        .white)),
            backgroundColor:
            Colors.redAccent,
          );
          scaffoldKey
              .currentState
              .showSnackBar(
              snackBar);
        }

    }
    else{
      var value = Provider.of<CartModel>(context);
      int index = value.listCardOfitem.indexWhere((element) => element.product.is_shown == false);
      if(index<0){
        FocusScope.of(context)
            .requestFocus(FocusNode());
        UIBlock.block(context,
            customLoaderChild: LoadingWidget(context));
        value.RemoveShipping().then((value) {
          UIBlock.unblock(context);
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ShippingScreen()),
          ).then((value) => _getSummaryPoint());
        });
      }else{
        String product = value.listCardOfitem[index].product.name;
        final snackBar = SnackBar(
          content: Text("Produk ${product} tidak tersedia",style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.redAccent,
        );
        scaffoldKey.currentState.showSnackBar(snackBar);
      }
    }
  }

  @override

  Widget build(BuildContext context) {

    _getUnavaliableProduct();
    final size = MediaQuery.of(context).size;
    var method = Provider.of<ListCabang>(context);
    int jumlahSample =
        Provider.of<CartModel>(context).listUseSample.length ?? 0;

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        titleSpacing: 20.0,
        elevation: 0.0,
        automaticallyImplyLeading: false,
        title: Text(
          'Keranjang Belanja',
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
      body: Stack(children: <Widget>[
        Scaffold(
          backgroundColor: Color(0xffFDF8F0),
          body: Container(
            child: SingleChildScrollView(
              child: Consumer<CartModel>(
                builder: (context, value, child) {
                  if (value.loadingCard) {
                    return Center(
                      child: LoadingWidgetFadingCircle(context),
                    );
                  } else {
                    if (value.listCardOfitem.isEmpty) {
                      return new Container(
                        height: MediaQuery.of(context).size.height,
                        child: Center(
                          child: Text("Keranjang Belanja Kosong"),
                        ),
                      );
                    } else {
                      return new Column(
                        children: <Widget>[
                          for (final item in value.listCardOfitem)
                            (
                                Container(
                              width: MediaQuery.of(context).size.width * 0.95,
                              padding: EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: value.listCardOfitem.indexOf(item) ==
                                            value.listCardOfitem.length - 1
                                        ? Colors.transparent
                                        : Color(0xffF48262),
                                    width: 1.0,
                                  ),
                                ),
                              ),
                              child: IntrinsicHeight(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.25,
                                      padding: EdgeInsets.only(right: 7),
                                      child: GestureDetector(
                                        onTap: (){
                                          if(item.product.is_shown)
                                          Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context)=> new ProductDetailsScreen(product: item.product,)));
                                        },
                                        child: CachedNetworkImage(
                                          imageUrl:
                                              item.product.thumbnail_image != null
                                                  ? img_url +
                                                      item.product.thumbnail_image
                                                  : "",
                                          placeholder: (context, url) =>
                                              LoadingWidgetPulse(context),
                                          errorWidget: (context, url, error) =>
                                              Image.asset(
                                                  'assets/images/210x265.png'),
                                          width:
                                              MediaQuery.of(context).size.width,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.35,
                                      padding: EdgeInsets.only(right: 7),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            item.product.brand.name,
                                            style: TextStyle(
                                              fontFamily: 'Yeseva',
                                              fontSize: 16,
                                            ),
                                          ),
                                          Text(
                                            item.variant != null? item.product.name + " - " + item.variant:item.product.name,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontFamily: 'Brandon',
                                              fontSize: 14,
                                            ),
                                          ),

                                          Text(
                                            NumberFormat.simpleCurrency(
                                                    locale: "id_ID",
                                                    decimalDigits: 0)
                                                .format(item != null
                                                    ? item.price
                                                    : 0),
                                            style: TextStyle(
                                              fontFamily: 'Brandon',
                                              fontSize: 15,
                                              color: Color(0xffF48262),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(top: 10),
                                            child: Text(
                                              'JUMLAH',
                                              style: TextStyle(
                                                  fontFamily: 'Brandon',
                                                  fontSize: 12),
                                            ),
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Color(0xffF48262)),
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                            child: Wrap(
                                              crossAxisAlignment:
                                                  WrapCrossAlignment.center,
                                              children: <Widget>[
                                                SizedBox(
                                                    width: 25,
                                                    height: 25,
                                                    child: FloatingActionButton(
                                                      backgroundColor:
                                                          Color(0xffFDF8F0),
                                                      elevation: 0.0,
                                                      highlightElevation: 0.0,
                                                      heroTag:  item.variant != null?
                                                      "btnmin" +item.product.id
                                                              .toString()+"btnmin" +item.variant:item.product.id
                                                          .toString(),
                                                      child: Text(
                                                        '-',
                                                        style: TextStyle(
                                                          color:
                                                              Color(0xffF48262),
                                                          fontFamily: 'Brandon',
                                                          fontWeight:
                                                              FontWeight.w700,
                                                        ),
                                                      ),
                                                      onPressed: () {
                                                        UIBlock.block(context,
                                                            customLoaderChild:
                                                                LoadingWidget(
                                                                    context));
                                                        value.RemoveProductToCart(
                                                                item.product,
                                                                Provider.of<AppModel>(
                                                                        context)
                                                                    .auth
                                                                    .access_token, item.variant)
                                                            .then((value) {
                                                          UIBlock.unblock(
                                                              context);
                                                        });
                                                      },
                                                    )),
                                                Container(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 10),
                                                  child: Text(
                                                      item.quantity.toString()),
                                                ),
                                                SizedBox(
                                                    width: 25,
                                                    height: 25,
                                                    child: FloatingActionButton(
                                                      backgroundColor:
                                                          Color(0xffFDF8F0),
                                                      elevation: 0.0,
                                                      highlightElevation: 0.0,
                                                      heroTag:
                                                          item.variant != null?
                                                          "btnplus" + item.product.id
                                                          .toString()+item.variant:"btnplus" +item.product.id
                                                          .toString(),
                                                      child: Text(
                                                        '+',
                                                        style: TextStyle(
                                                          color:
                                                              Color(0xffF48262),
                                                          fontFamily: 'Brandon',
                                                          fontWeight:
                                                              FontWeight.w700,
                                                        ),
                                                      ),
                                                      onPressed: () {
                                                        var _param;
                                                        if(item.product.varian.toString()!='[]'){
                                                          if(item.variant != null)
                                                          _param = '{"varian": "${item.variant}", "product_id": ${item.product.id}, "quantity": 1, "price": ${item.product.base_price}}';
                                                        }
                                                        // print("PARAM: "+_param);
                                                        // print(item.variant);
                                                        VarianResult varian_result;
                                                        if(item.variant!=null){
                                                          varian_result = new VarianResult.fromJson(json.decode(_param));
                                                        }
                                                        UIBlock.block(context,
                                                            customLoaderChild:
                                                                LoadingWidget(
                                                                    context));
                                                        value
                                                            .addProductToCart(
                                                                item.product,
                                                                Provider.of<AppModel>(
                                                                        context)
                                                                    .auth
                                                                    .access_token,
                                                            item.variant==null?null:varian_result)
                                                            // null)
                                                            .then((value) {
                                                          UIBlock.unblock(
                                                              context);
                                                          if (value != null &&
                                                              value.statusCode !=
                                                                  200) {
                                                            final snackBar =
                                                                SnackBar(
                                                              content: Text(
                                                                  value.message,
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white)),
                                                              backgroundColor:
                                                                  Colors
                                                                      .redAccent,
                                                            );
                                                            scaffoldKey
                                                                .currentState
                                                                .showSnackBar(
                                                                    snackBar);
                                                          }
                                                        });
                                                      },
                                                    )),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.25,
                                      child: Column(
                                        children: <Widget>[
                                          Container(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Text(
                                                  'TOTAL',
                                                  style: TextStyle(
                                                      fontFamily: 'Brandon',
                                                      fontSize: 12),
                                                ),
                                                Text(
                                                  NumberFormat.simpleCurrency(
                                                          locale: "id_ID",
                                                          decimalDigits: 0)
                                                      .format((item.price *
                                                          item.quantity)),
                                                  style: TextStyle(
                                                      fontFamily: 'Brandon',
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            child: Align(
                                              alignment: Alignment.bottomRight,
                                              child: GestureDetector(
                                                onTap: () {
                                                  UIBlock.block(context,
                                                      customLoaderChild:
                                                          LoadingWidget(
                                                              context));
                                                  value.DeleteProductToCart(item.id, Provider.of<AppModel>(context).auth.access_token).then((value) {
                                                    _getSummaryPoint();
                                                    UIBlock.unblock(context);
                                                  });
                                                },
                                                child: ImageIcon(
                                                  AssetImage(
                                                      'assets/images/trash.png'),
                                                  color: Color(0xffF48262),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )),
                          for (final item in value.listProductPoin)
                            (Container(
                              width: MediaQuery.of(context).size.width * 0.95,
                              padding: EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: Color(0xffF48262),
                                    width: 1.0,
                                  ),
                                ),
                              ),
                              child: IntrinsicHeight(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.25,
                                      padding: EdgeInsets.only(right: 7),
                                      child: CachedNetworkImage(
                                        imageUrl: img_url +
                                            item.product.thumbnail_image,
                                        placeholder: (context, url) =>
                                            LoadingWidgetPulse(context),
                                        errorWidget: (context, url, error) =>
                                            Image.asset(
                                                'assets/images/basic.jpg'),
                                        width:
                                            MediaQuery.of(context).size.width,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.35,
                                      padding: EdgeInsets.only(right: 7),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            item.product.brand.name,
                                            style: TextStyle(
                                              fontFamily: 'Yeseva',
                                              fontSize: 16,
                                            ),
                                          ),
                                          Text(
                                            item.product.name,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontFamily: 'Brandon',
                                              fontSize: 14,
                                            ),
                                          ),
                                          Text(
                                            (item.jml_point * item.qty)
                                                    .toString() +
                                                " POIN",
                                            style: TextStyle(
                                              fontFamily: 'Brandon',
                                              fontSize: 15,
                                              color: Color(0xffF48262),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(top: 10),
                                            child: Text(
                                              'JUMLAH',
                                              style: TextStyle(
                                                  fontFamily: 'Brandon',
                                                  fontSize: 12),
                                            ),
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Color(0xffF48262)),
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                            child: Wrap(
                                              crossAxisAlignment:
                                                  WrapCrossAlignment.center,
                                              children: <Widget>[
                                                SizedBox(
                                                    width: 25,
                                                    height: 25,
                                                    child: FloatingActionButton(
                                                      backgroundColor:
                                                          Color(0xffFDF8F0),
                                                      elevation: 0.0,
                                                      highlightElevation: 0.0,
                                                      heroTag: "btnminpoin" +
                                                          item.product.id
                                                              .toString(),
                                                      child: Text(
                                                        '-',
                                                        style: TextStyle(
                                                          color:
                                                              Color(0xffF48262),
                                                          fontFamily: 'Brandon',
                                                          fontWeight:
                                                              FontWeight.w700,
                                                        ),
                                                      ),
                                                      onPressed: () {
                                                        UIBlock.block(context,
                                                            customLoaderChild:
                                                                LoadingWidget(
                                                                    context));
                                                        value.RemoveRedemToCart(
                                                                item,
                                                                Provider.of<AppModel>(
                                                                        context)
                                                                    .auth
                                                                    .access_token)
                                                            .then((value) {
                                                          UIBlock.unblock(
                                                              context);
                                                        });
                                                      },
                                                    )),
                                                Container(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 10),
                                                  child:
                                                      Text(item.qty.toString()),
                                                ),
                                                SizedBox(
                                                    width: 25,
                                                    height: 25,
                                                    child: FloatingActionButton(
                                                      backgroundColor:
                                                          Color(0xffFDF8F0),
                                                      elevation: 0.0,
                                                      highlightElevation: 0.0,
                                                      heroTag: "btnpluspoin" +
                                                          item.product.id
                                                              .toString(),
                                                      child: Text(
                                                        '+',
                                                        style: TextStyle(
                                                          color:
                                                              Color(0xffF48262),
                                                          fontFamily: 'Brandon',
                                                          fontWeight:
                                                              FontWeight.w700,
                                                        ),
                                                      ),
                                                      onPressed: () {
                                                        if (value.gettotalPoin() +
                                                                item
                                                                    .jml_point <=
                                                            Provider.of<UserModel>(
                                                                    context)
                                                                .user
                                                                .point) {
                                                          UIBlock.block(context,
                                                              customLoaderChild:
                                                                  LoadingWidget(
                                                                      context));
                                                          value
                                                              .addRedemToCart(
                                                                  item,
                                                                  Provider.of<AppModel>(
                                                                          context)
                                                                      .auth
                                                                      .access_token)
                                                              .then((value) {
                                                            UIBlock.unblock(
                                                                context);
                                                          });
                                                        }
                                                      },
                                                    )),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.25,
                                      child: Column(
                                        children: <Widget>[
                                          Container(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Text(
                                                  'TOTAL',
                                                  style: TextStyle(
                                                      fontFamily: 'Brandon',
                                                      fontSize: 12),
                                                ),
                                                Text(
                                                  "GRATIS",
                                                  style: TextStyle(
                                                      fontFamily: 'Brandon',
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            child: Align(
                                              alignment: Alignment.bottomRight,
                                              child: GestureDetector(
                                                onTap: () {
                                                  UIBlock.block(context,
                                                      customLoaderChild:
                                                          LoadingWidget(
                                                              context));
                                                  value.DeleteRendemProduct(item, Provider.of<AppModel>(context).auth.access_token).then((value) {
                                                    _getSummaryPoint();
                                                    UIBlock.unblock(context);
                                                  });
                                                },
                                                child: ImageIcon(
                                                  AssetImage(
                                                      'assets/images/trash.png'),
                                                  color: Color(0xffF48262),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )),
                          for (final item in value.listUseSample)
                            (Container(
                              width: MediaQuery.of(context).size.width * 0.95,
                              padding: EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: Color(0xffF48262),
                                    width: 1.0,
                                  ),
                                ),
                              ),
                              child: IntrinsicHeight(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.25,
                                      padding: EdgeInsets.only(right: 7),
                                      child: CachedNetworkImage(
                                        imageUrl:
                                            img_url + item.thumbnail_image,
                                        placeholder: (context, url) =>
                                            LoadingWidgetPulse(context),
                                        errorWidget: (context, url, error) =>
                                            Image.asset(
                                                'assets/images/basic.jpg'),
                                        width:
                                            MediaQuery.of(context).size.width,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.35,
                                      padding: EdgeInsets.only(right: 7),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            item.brand.name,
                                            style: TextStyle(
                                              fontFamily: 'Yeseva',
                                              fontSize: 16,
                                            ),
                                          ),
                                          Text(
                                            item.name.length > 20
                                                ? item.name.substring(0, 20) +
                                                    '...'
                                                : item.name,
                                            style: TextStyle(
                                              fontFamily: 'Brandon',
                                              fontSize: 14,
                                            ),
                                          ),
                                          Text(
                                            "Sample",
                                            style: TextStyle(
                                                fontFamily: 'Brandon',
                                                fontSize: 15,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.25,
                                      child: Column(
                                        children: <Widget>[
                                          Container(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Text(
                                                  'TOTAL',
                                                  style: TextStyle(
                                                      fontFamily: 'Brandon',
                                                      fontSize: 12),
                                                ),
                                                Text(
                                                  "GRATIS",
                                                  style: TextStyle(
                                                      fontFamily: 'Brandon',
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            child: Align(
                                              alignment: Alignment.bottomRight,
                                              child: GestureDetector(
                                                onTap: () {
                                                  UIBlock.block(context,
                                                      customLoaderChild:
                                                          LoadingWidget(
                                                              context));
                                                  value.DeleteProductSample(item, Provider.of<AppModel>(context).auth.access_token).then((value) {
                                                    _getSummaryPoint();
                                                    UIBlock.unblock(context);
                                                  });
                                                },
                                                child: ImageIcon(
                                                  AssetImage(
                                                      'assets/images/trash.png'),
                                                  color: Color(0xffF48262),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )),
                          Container(
                            height: 10,
                            width: MediaQuery.of(context).size.width,
                            color: Colors.white,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.all(15),
                            child: IntrinsicHeight(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    child: Container(
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 10),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 5),
                                      width: MediaQuery.of(context).size.width *
                                          0.4,
                                      decoration: BoxDecoration(
                                        color: Color(0xffF48262),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Image.asset(
                                              "assets/images/pilih_sample.png"),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                'PILIH SAMPLE',
                                                style: TextStyle(
                                                    fontFamily: 'Brandon',
                                                    fontSize: 12,
                                                    color: Colors.white),
                                              ),
                                              Text(
                                                'YANG KAMU',
                                                style: TextStyle(
                                                    fontFamily: 'Brandon',
                                                    fontSize: 12,
                                                    color: Colors.white),
                                              ),
                                              Text(
                                                'INGINKAN: $jumlahSample/2',
                                                style: TextStyle(
                                                    fontFamily: 'Brandon',
                                                    fontSize: 12,
                                                    color: Colors.white),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    onTap: () {
                                      if (jumlahSample < 2) {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  PilihSample()),
                                        );
                                      }
                                    },
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                HappySkinRewardScreen()),
                                      );
                                    },
                                    child: Container(
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 10),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 5),
                                      width: MediaQuery.of(context).size.width *
                                          0.4,
                                      decoration: BoxDecoration(
                                        color: Color(0xffF48262),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Image.asset(
                                              "assets/images/tukar_poin.png"),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              Text(
                                                'TUKAR POIN MU',
                                                style: TextStyle(
                                                    fontFamily: 'Brandon',
                                                    fontSize: 12,
                                                    color: Colors.white),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          productOutOfStock != null && productOutOfStock == true
                              ? Container(
                                  height: 10,
                                  width: MediaQuery.of(context).size.width,
                                  color: Colors.white,
                                )
                              : Container(),
                          productOutOfStock != null && productOutOfStock == true
                              ? Consumer<ListCabang>(
                              builder: (context, value, child){
                                return Container(
                                  width: MediaQuery.of(context).size.width,
                                  padding: EdgeInsets.symmetric(vertical: 7),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 15),
                                            child: Text(
                                              'METODE PENGIRIMAN',
                                              style: TextStyle(
                                                fontFamily: 'Brandon',
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              textAlign: TextAlign.left,
                                            ),
                                          ),
                                          Spacer(),
                                          GestureDetector(
                                            onTap: () {
                                              _methodeModalBottomSheet(context);
                                            },
                                            child: Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 15),
                                                child: Icon(Icons.help_outline,
                                                    color: Colors.black54,
                                                    size: 20)),
                                          )
                                        ],
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          _changeMethodeModalBottomSheet(
                                              context);
                                        },
                                        child: Container(
                                          padding: EdgeInsets.only(
                                              left: 14, right: 10,top: 10,bottom: 10),
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 15, vertical: 8),
                                          width:
                                          MediaQuery.of(context).size.width,

                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              border: Border.all(
                                                  width: 1,
                                                  color: Color(0xffF48262)
                                                      .withOpacity(0.37)),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10))),
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(children: [
                                                value.cabangClick == null ? SizedBox(): Image.asset(
                                                  'assets/images/perjalanan@4x.png',
                                                  width: 25,
                                                  height: 25,
                                                  fit: BoxFit.contain,
                                                ),
                                                SizedBox(width: 7),
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                  Text(
                                                    value.cabangClick == null ? "Pilih metode pengiriman": "Pick Up In Store",
                                                    style: TextStyle(
                                                      fontFamily: "Brandon",
                                                      fontWeight: FontWeight.w600,
                                                      color: Colors.black,
                                                      fontSize: 13,
                                                    ),
                                                  ),
                                                  Text(value.isDelivery == true ? "Menggunakan Delivery" : value.cabangClick == null ?  "Mau diantar atau diambil sendiri nih? Kamu bisa pilih loh!" : method.cabangClick.alamatCabang,
                                                      style: TextStyle(
                                                        fontFamily: 'Brandon',
                                                        fontSize: 10,
                                                        color: Colors.black45,
                                                      )
                                                  ),
                                                ],)

                                              ]),
                                              Icon(Icons.arrow_forward_ios,
                                                  color: Color(0xffF48262),
                                                  size: 16)
                                            ],
                                          ),
                                        ),
                                      ),
                                      Column(
                                        children: [
                                          value.cabangClick != null && value.setUnavailable.length != 0 && value.isDelivery != true ? Row(
                                            children: [
                                              Icon(
                                                Icons.priority_high,
                                                color: Color(0xffF48262),
                                                size: 27,
                                              ),
                                              Container(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                    0.9,
                                                child: TextBuild(
                                                  value:
                                                  "Oops,sorry! Produk pilihanmu stoknya lagi nggak tersedia untuk pickup di ${value.cabangClick.namaCabang}, nih.",
                                                ),
                                              )
                                            ],
                                          ) : SizedBox(),
                                        ],
                                      ),
                                     value.cabangClick != null && value.setUnavailable.length != 0 && value.isDelivery != true ? Padding(
                                        padding: EdgeInsets.only(
                                            left: 25, top: 10, bottom: 10),
                                        child: Row(
                                          children: [
                                            Container(
                                              margin:
                                              EdgeInsets.only(right: 10),
                                              height: 25,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                  BorderRadius.circular(20),
                                                  border: Border.all(
                                                      color: Color(0xffF48262)
                                                          .withOpacity(0.22))),
                                              child: FlatButton(
                                                  padding: EdgeInsets.zero,
                                                  materialTapTargetSize:
                                                  MaterialTapTargetSize
                                                      .shrinkWrap,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                    BorderRadius.circular(
                                                        20),
                                                  ),
                                                  color: Colors.white,
                                                  onPressed: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) => ListTokoPengirimanScreen()),
                                                    );
                                                  },
                                                  child: TextBuild(
                                                    value: "Ganti Toko",
                                                    size: 12,
                                                    warna: Color(0xffF48262),
                                                  )),
                                            ),
                                            Container(
                                              height: 25,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                  BorderRadius.circular(20),
                                                  border: Border.all(
                                                      color: Color(0xffF48262)
                                                          .withOpacity(0.22))),
                                              child: FlatButton(
                                                  padding: EdgeInsets.zero,
                                                  materialTapTargetSize:
                                                  MaterialTapTargetSize
                                                      .shrinkWrap,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                    BorderRadius.circular(
                                                        20),
                                                  ),
                                                  color: Colors.white,
                                                  onPressed: () {
                                                    Provider.of<ListCabang>(context).setDataUnavaliable = true;
                                                    Provider.of<ListCabang>(context).dataCabang = null;
                                                  },
                                                  child: TextBuild(
                                                    value: "Coba Delivery",
                                                    size: 12,
                                                    warna: Color(0xffF48262),
                                                  )),
                                            )
                                          ],
                                        ),
                                      ) : SizedBox(),
                                      value.cabangClick != null && value.setUnavailable.length != 0  && value.isDelivery != true ?  Container(
                                        height: 10,
                                        width:
                                        MediaQuery.of(context).size.width,
                                        color: Colors.white,
                                      ) : SizedBox(),
                                      value.cabangClick != null && value.setUnavailable.length != 0  && value.isDelivery != true?  ListView.separated(
                                        scrollDirection: Axis.vertical,
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemCount: value.setUnavailable.length,
                                        separatorBuilder:
                                            (BuildContext context, int index) {
                                          return Divider();
                                        },
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          var unavailable = value.setUnavailable;
                                          return Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 20, horizontal: 10),
                                            child: Row(
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  children: [
                                                    detailImage == null
                                                        ? Container(
                                                      width: 110,
                                                      height: 110,
                                                      color: Colors
                                                          .grey[300],
                                                      child: Image.asset(
                                                          'assets/images/210x265.png'),
                                                    )
                                                        : Container(
                                                      width: 110,
                                                      height: 110,
                                                      decoration: BoxDecoration(
                                                          image: DecorationImage(
                                                              image: NetworkImage(
                                                                  "$img_url${detailImage[0]}"),
                                                              fit: BoxFit
                                                                  .cover)),
                                                    )
                                                  ],
                                                ),
                                                Container(
                                                  width: size.width * 0.58,
                                                  padding:
                                                  EdgeInsets.only(left: 15),

                                                  child: Column(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment
                                                        .start,
                                                    children: [
                                                      Text(
                                                        unavailable[index].product.brand.name,
                                                        style: TextStyle(
                                                          fontWeight:
                                                          FontWeight.w600,
                                                          fontFamily: 'Yeseva',
                                                          fontSize: 16,
                                                        ),
                                                      ),
                                                      TextBuild(
                                                        value: unavailable[index].product.name,
                                                      ),
                                                      SizedBox(height: 7),
                                                      Row(
                                                        children: [
                                                          Container(
                                                            margin:
                                                            EdgeInsets.only(
                                                                top: 20),
                                                            height: 31,
                                                            decoration: BoxDecoration(
                                                                borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                    20),
                                                                border: Border.all(
                                                                    color: Color(
                                                                        0xffF48262)
                                                                        .withOpacity(
                                                                        0.22))),
                                                            child: FlatButton(
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                  horizontal:
                                                                  13),
                                                              materialTapTargetSize:
                                                              MaterialTapTargetSize
                                                                  .shrinkWrap,
                                                              color:
                                                              Colors.white,
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius:
                                                                  BorderRadius.all(
                                                                      Radius.circular(
                                                                          20))),
                                                              onPressed: () {
                                                                addWishlistUnavaliable(unavailable[index].product);
                                                              },
                                                              child: TextBuild(
                                                                value:
                                                                "Masukan daftar keinginan",
                                                                size: 12,
                                                                warna: Color(
                                                                    0xffF48262),
                                                              ),
                                                            ),
                                                          ),
                                                          GestureDetector(
                                                            onTap: (){
                                                              showDeleteDialog(context, unavailable[index].product,unavailable[index].id);
                                                            },
                                                            child: Container(
                                                              margin:
                                                              EdgeInsets.only(
                                                                  top: 20,
                                                                  left: 10),
                                                              width: 25,
                                                              height: 25,
                                                              child: Icon(
                                                                Icons.delete,
                                                                color: Color(
                                                                    0xffF48262),
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      ) : SizedBox(),
                                    ],
                                  ),
                                );
                              }

                              )
                              : Container(),
                          Container(
                            height: 10,
                            width: MediaQuery.of(context).size.width,
                            color: Colors.white,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.symmetric(vertical: 7),
                            child: Column(
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.95,
                                  padding: EdgeInsets.symmetric(horizontal: 15),
                                  child: Text(
                                    'KODE PROMO',
                                    style: TextStyle(
                                      fontFamily: 'Brandon',
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                                IntrinsicHeight(
                                  child: Stack(
                                    alignment:
                                        Alignment(1.0, 0.0), // right & center
                                    children: <Widget>[
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.95,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 15),
                                        height: 35,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                            width: 1,
                                            color: Color(0xffF48262),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.95,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 15),
                                        child: TextField(
                                          style: TextStyle(
                                              fontFamily: 'Brandon',
                                              fontWeight: FontWeight.bold),
                                          controller: _code
                                            ..text = (value.coupon != null &&
                                                    value.coupon.coupon_id !=
                                                        null)
                                                ? value.coupon.code
                                                : null,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            focusedBorder: InputBorder.none,
                                            enabledBorder: InputBorder.none,
                                            errorBorder: InputBorder.none,
                                            disabledBorder: InputBorder.none,
                                            fillColor: Colors.transparent,
                                            hintText: 'Masukkan Kode Promo',
                                            hintStyle: TextStyle(
                                                fontFamily: 'Brandon',
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black26),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        child: Positioned(
                                          child: FlatButton(
                                            child: Text(
                                              "PAKAI",
                                              style: TextStyle(
                                                fontFamily: 'Brandon',
                                                fontSize: 14,
                                                color: Color(0xffF48262),
                                                fontWeight: FontWeight.bold,
                                              ),
                                              textAlign: TextAlign.right,
                                            ),
                                            onPressed: () {
                                              if (_code.value.text.isNotEmpty) {
                                                UIBlock.block(context,
                                                    customLoaderChild:
                                                        LoadingWidget(context));
                                                value.AppyCoupon(
                                                        _code.value.text,
                                                        Provider.of<AppModel>(
                                                                context)
                                                            .auth
                                                            .access_token)
                                                    .then((values) {
                                                  UIBlock.unblock(context);
                                                  if (value.coupon != null &&
                                                      value.coupon.code !=
                                                          null) {
                                                    if (value.coupon
                                                            .calculated ==
                                                        "0") {
                                                      final snackBar = SnackBar(
                                                        content: Text(
                                                            'Minimum belanja belum mencukupi!',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white)),
                                                        backgroundColor:
                                                            Colors.redAccent,
                                                      );
                                                      scaffoldKey.currentState
                                                          .showSnackBar(
                                                              snackBar);
                                                    } else {
                                                      final snackBar = SnackBar(
                                                        content: Text(
                                                            'Success.',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white)),
                                                        backgroundColor:
                                                            Colors.green,
                                                      );
                                                      scaffoldKey.currentState
                                                          .showSnackBar(
                                                              snackBar);
                                                    }
                                                  } else {
                                                    final snackBar = SnackBar(
                                                      content: Text(
                                                          'Code promo tidak berlaku!',
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .white)),
                                                      backgroundColor:
                                                          Colors.redAccent,
                                                    );
                                                    scaffoldKey.currentState
                                                        .showSnackBar(snackBar);
                                                  }
                                                });
                                              }
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                productOutOfStock != null &&
                                        productOutOfStock == true
                                    ? Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 12),
                                        child: Divider(
                                          color: Color(0xffF48262),
                                        ),
                                      )
                                    : Container(),
                                productOutOfStock != null &&
                                        productOutOfStock == true
                                    ? Padding(
                                        padding: EdgeInsets.only(left: 12),
                                        child: Row(
                                          children: [
                                            Image.asset(
                                              'assets/images/Asset 13.png',
                                              width: 30,
                                              height: 30,
                                              fit: BoxFit.contain,
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    Text(
                                                        "Poin yang dapat ditukar",
                                                        style: TextStyle(
                                                          fontFamily: 'Brandon',
                                                          fontSize: 14,
                                                          color: Colors.black,
                                                        )),
                                                    SizedBox(width: 8),
                                                    Icon(Icons.help_outline,
                                                        size: 16,
                                                        color: Colors.black54),
                                                  ],
                                                ),
                                                Text("-${value.summary.available_point_to_use}",
                                                    style: TextStyle(
                                                      fontFamily: 'Brandon',
                                                      fontSize: 14,
                                                      color: Color(0xffF48262),
                                                    )),
                                              ],
                                            ),
                                            Spacer(),
                                            Transform.scale(
                                              scale: 0.72,
                                              child: CupertinoSwitch(
                                                value: Provider.of<ListCabang>(context).setPointValue,
                                                onChanged: (value) {
                                                  Provider.of<ListCabang>(context).setPointValue = value;
                                                  _getSummaryPoint();
                                                },
                                                trackColor: Colors.grey[200],
                                                activeColor: Color(0xffF48262),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    : Container(),
                                productOutOfStock != null &&
                                        productOutOfStock == true
                                    ? Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 12),
                                        child: Divider(
                                          color: Color(0xffF48262),
                                        ),
                                      )
                                    : Container(),
                              ],
                            ),
                          ),
                          Container(
                            height: 10,
                            width: MediaQuery.of(context).size.width,
                            color: Colors.white,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.95,
                            padding: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 7),
                            child: IntrinsicHeight(
                              child: Column(
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.symmetric(vertical: 5),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(
                                          'SUB TOTAL',
                                          style: TextStyle(
                                            fontFamily: 'Brandon',
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          value.summary.subtotal,
                                          style: TextStyle(
                                            fontFamily: 'Brandon',
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  if (value.coupon != null)
                                    if (value.coupon.coupon_id != null)
                                      if (value.summary.discount != "Rp0")
                                        Padding(
                                          padding:
                                              EdgeInsets.symmetric(vertical: 5),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Text(
                                                'POTONGAN DISKON',
                                                style: TextStyle(
                                                  fontFamily: 'Brandon',
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Text(
                                                value.summary.discount,
                                                style: TextStyle(
                                                  fontFamily: 'Brandon',
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(vertical: 5),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(
                                          'TOTAL',
                                          style: TextStyle(
                                            fontFamily: 'Brandon',
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          value.setSumarry.total,
                                          style: TextStyle(
                                            fontFamily: 'Brandon',
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(vertical: 5),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(
                                          'Poin yang didapat',
                                          style: TextStyle(
                                            fontFamily: 'Brandon',
                                            fontSize: 14,
                                            color: Color(0xffF48262),
                                          ),
                                        ),
                                        Text(
                                          '+ ' +
                                              value.summary.earnPoint
                                                  .toString(),
                                          style: TextStyle(
                                            fontFamily: 'Brandon',
                                            fontSize: 14,
                                            color: Color(0xffF48262),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.95,
                            padding: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 7),
                            child: FlatButton(
                              color: Color(0xffF48262),
                              child: Text(
                                'LANJUT PEMBAYARAN',
                                style: TextStyle(
                                  fontFamily: 'Brandon',
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(7.0),
                              ),
                              onPressed: () {
                                selectTypeMethodPayment();
                                // int index = value.listCardOfitem.indexWhere((element) => element.product.is_shown == false);
                                // if(index<0){
                                //   FocusScope.of(context)
                                //       .requestFocus(FocusNode());
                                //   UIBlock.block(context,
                                //       customLoaderChild: LoadingWidget(context));
                                //   value.RemoveShipping().then((value) {
                                //     UIBlock.unblock(context);
                                //     Navigator.push(
                                //       context,
                                //       MaterialPageRoute(
                                //           builder: (context) => ShippingScreen()),
                                //     );
                                //   });
                                // }else{
                                //   String product = value.listCardOfitem[index].product.name;
                                //   final snackBar = SnackBar(
                                //     content: Text("Produk ${product} tidak tersedia",style: TextStyle(color: Colors.white)),
                                //     backgroundColor: Colors.redAccent,
                                //   );
                                //   scaffoldKey.currentState.showSnackBar(snackBar);
                                // }
                              },
                            ),
                          ),
                        ],
                      );
                    }
                  }
                },
              ),
            ),
          ),
        )
      ]),
      bottomNavigationBar: new PonnyBottomNavbar(selectedIndex: 0),
    );
  }
}

class DetailAffiliateTextStyle extends StatelessWidget {
  const DetailAffiliateTextStyle({Key key, this.nama, this.sizing})
      : super(key: key);

  final String nama;
  final FontWeight sizing;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Text(nama,
        style: TextStyle(
            fontFamily: "Brandon",
            fontSize: size.width * 0.04,
            fontWeight: sizing));
  }
}
