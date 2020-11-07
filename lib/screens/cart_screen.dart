import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lodash_dart/lodash_dart.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:ponny/common/constant.dart';
import 'package:ponny/model/App.dart';
import 'package:ponny/model/Cart.dart';
import 'package:ponny/model/User.dart';
import 'package:ponny/screens/PilihSample.dart';
import 'package:ponny/screens/account/happy_skin_reward_screen.dart';
import 'package:ponny/util/globalUrl.dart';
import 'package:ponny/widgets/PonnyBottomNavbar.dart';
import 'package:ponny/screens/shipping_screen.dart';
import 'package:provider/provider.dart';
import 'package:ponny/model/Cart.dart';
import 'package:uiblock/uiblock.dart';

class CartScreen extends StatefulWidget {
  static const String id = "cart_screen";

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  TextEditingController _code = TextEditingController();
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
     await Provider.of<CartModel>(context).RemoveCoupon();
     await Provider.of<UserModel>(context).getUser(Provider.of<AppModel>(context,listen: false).auth.access_token);
    });

  }

  int _n1 = 1;
  int _n2 = 1;

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
      if (_n1 != 1)
        _n1--;
    });
  }

  void minus2() {
    setState(() {
      if (_n2 != 1)
        _n2--;
    });
  }

  String dropdownValue = 'One';

  void showSample(){
    showMaterialModalBottomSheet(
      context: context,
      useRootNavigator: true,
      builder: (context, scrollController) => Container(
        child: Container(
          height: MediaQuery.of(context).size.height*.65,
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                color:  Color(0xffF48262),
                height: MediaQuery.of(context).size.width*.1,
                width: MediaQuery.of(context).size.width,
                child: Text(
                  'PILIH SAMPLE',
                  style: TextStyle(
                      fontFamily: 'Brandon',
                      fontSize: 16,
                      color: Colors.white
                  ),
                ),
              ),
              Container(
                height: 300,
                child: SingleChildScrollView(
                  child:GridView.count(
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

  @override
  Widget build(BuildContext context) {
    int jumlahSample = Provider.of<CartModel>(context).listUseSample.length??0;
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Theme.of(context).primaryColor,
      body: Stack(children: <Widget>[
        Scaffold(
          backgroundColor: Color(0xffFDF8F0),
          body: Container(
            margin: MediaQuery.of(context).padding,
            child: SingleChildScrollView(
              child:
              Consumer<CartModel>(
                builder: (context,value,child){
                  if(value.loadingCard){
                    return Center(
                     child: LoadingWidgetFadingCircle(context),
                    );
                  }else{
                    if(value.listCardOfitem.isEmpty){
                     return new Container( height: MediaQuery.of(context).size.height, child: Center(child: Text("Kerajang Belaja Kosong"),),);
                    }else {


                      return new Column(
                        children: <Widget>[
                          Container(
                            width: MediaQuery
                                .of(context)
                                .size
                                .width,
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 30),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: Color(0xffF48262),
                                  width: 1.0,
                                ),
                              ),
                            ),
                            child: Text(
                              'Keranjang Belanja',
                              style: TextStyle(
                                fontFamily: 'Yeseva',
                                fontSize: 22,
                                color: Color(0xffF48262),
                              ),
                            ),
                          ),
                          for(final item in value.listCardOfitem)(
                              Container(
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width * 0.95,
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
                                        width: MediaQuery
                                            .of(context)
                                            .size
                                            .width * 0.25,
                                        padding: EdgeInsets.only(right: 7),
                                        child: CachedNetworkImage(
                                          imageUrl: img_url+ item.product.thumbnail_image,
                                          placeholder: (context, url) => LoadingWidgetPulse(context),
                                          errorWidget: (context, url, error) => Image.asset('assets/images/basic.jpg'),
                                          width: MediaQuery.of(context).size.width,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Container(
                                        width: MediaQuery
                                            .of(context)
                                            .size
                                            .width * 0.35,
                                        padding: EdgeInsets.only(right: 7),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment
                                              .start,
                                          children: <Widget>[
                                            Text(
                                              item.product.brand.name,
                                              style: TextStyle(
                                                fontFamily: 'Yeseva',
                                                fontSize: 16,
                                              ),
                                            ),
                                            Text(
                                              item.product.name.length > 20 ? item.product.name.substring(0, 20)+'...' : item.product.name,
                                              style: TextStyle(
                                                fontFamily: 'Brandon',
                                                fontSize: 14,
                                              ),
                                            ),
                                            Text(
                                              NumberFormat.simpleCurrency(locale: "id_ID",decimalDigits: 0 ).format(item.product.base_discounted_price),
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
                                                borderRadius: BorderRadius.circular(
                                                    5),
                                              ),
                                              child: Wrap(
                                                crossAxisAlignment: WrapCrossAlignment
                                                    .center,
                                                children: <Widget>[
                                                  SizedBox(
                                                      width: 25,
                                                      height: 25,
                                                      child: FloatingActionButton(
                                                        backgroundColor: Color(
                                                            0xffFDF8F0),
                                                        elevation: 0.0,
                                                        highlightElevation: 0.0,
                                                        heroTag: "btnmin"+item.product.id.toString(),
                                                        child: Text(
                                                          '-',
                                                          style: TextStyle(
                                                            color: Color(
                                                                0xffF48262),
                                                            fontFamily: 'Brandon',
                                                            fontWeight: FontWeight
                                                                .w700,
                                                          ),
                                                        ),
                                                        onPressed:(){
                                                          UIBlock.block(context,customLoaderChild: LoadingWidget(context));
                                                          value.RemoveProductToCart(item.product,Provider.of<AppModel>(context).auth.access_token).then((value) {
                                                            UIBlock.unblock(context);
                                                          });
                                                        },
                                                      )
                                                  ),
                                                  Container(
                                                    padding: EdgeInsets.symmetric(
                                                        horizontal: 10),
                                                    child: Text(item.quantity.toString()),
                                                  ),
                                                  SizedBox(

                                                      width: 25,
                                                      height: 25,
                                                      child: FloatingActionButton(
                                                        backgroundColor: Color(
                                                            0xffFDF8F0),
                                                        elevation: 0.0,
                                                        highlightElevation: 0.0,
                                                        heroTag: "btnplus"+item.product.id.toString(),
                                                        child: Text(
                                                          '+',
                                                          style: TextStyle(
                                                            color: Color(
                                                                0xffF48262),
                                                            fontFamily: 'Brandon',
                                                            fontWeight: FontWeight
                                                                .w700,
                                                          ),
                                                        ),
                                                        onPressed: (){
                                                          UIBlock.block(context,customLoaderChild: LoadingWidget(context));
                                                          value.addProductToCart(item.product,Provider.of<AppModel>(context).auth.access_token).then((value){
                                                            UIBlock.unblock(context);
                                                          });

                                                        },
                                                      )
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: MediaQuery
                                            .of(context)
                                            .size
                                            .width * 0.25,
                                        child: Column(
                                          children: <Widget>[
                                            Container(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment
                                                    .start,
                                                children: <Widget>[
                                                  Text(
                                                    'TOTAL',
                                                    style: TextStyle(
                                                        fontFamily: 'Brandon',
                                                        fontSize: 12
                                                    ),
                                                  ),
                                                  Text(
                                                    NumberFormat.simpleCurrency(locale: "id_ID",decimalDigits: 0 ).format((item.product.base_discounted_price*item.quantity)),
                                                    style: TextStyle(
                                                        fontFamily: 'Brandon',
                                                        fontSize: 14,
                                                        fontWeight: FontWeight.w600
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              child: Align(
                                                alignment: Alignment.bottomRight,
                                                child:  IconButton(
                                                  onPressed: (){
                                                    UIBlock.block(context,customLoaderChild: LoadingWidget(context));
                                                    value.DeleteProductToCart(item.product,Provider.of<AppModel>(context).auth.access_token).then((value) {
                                                      UIBlock.unblock(context);
                                                    });
                                                  },
                                                  icon: Icon(Icons.delete_outline,
                                                      color: Color(0xffF48262)),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                          ),
                          for(final item in value.listProductPoin)(
                              Container(
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width * 0.95,
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
                                        width: MediaQuery
                                            .of(context)
                                            .size
                                            .width * 0.25,
                                        padding: EdgeInsets.only(right: 7),
                                        child: CachedNetworkImage(
                                          imageUrl: img_url+ item.product.thumbnail_image,
                                          placeholder: (context, url) => LoadingWidgetPulse(context),
                                          errorWidget: (context, url, error) => Image.asset('assets/images/basic.jpg'),
                                          width: MediaQuery.of(context).size.width,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Container(
                                        width: MediaQuery
                                            .of(context)
                                            .size
                                            .width * 0.35,
                                        padding: EdgeInsets.only(right: 7),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment
                                              .start,
                                          children: <Widget>[
                                            Text(
                                              item.product.brand.name,
                                              style: TextStyle(
                                                fontFamily: 'Yeseva',
                                                fontSize: 16,
                                              ),
                                            ),
                                            Text(
                                              item.product.name.length > 20 ? item.product.name.substring(0, 20)+'...' : item.product.name,
                                              style: TextStyle(
                                                fontFamily: 'Brandon',
                                                fontSize: 14,
                                              ),
                                            ),
                                            Text(
                                              (item.jml_point*item.qty).toString()+" POIN",
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
                                                borderRadius: BorderRadius.circular(
                                                    5),
                                              ),
                                              child: Wrap(
                                                crossAxisAlignment: WrapCrossAlignment
                                                    .center,
                                                children: <Widget>[
                                                  SizedBox(
                                                      width: 25,
                                                      height: 25,
                                                      child: FloatingActionButton(
                                                        backgroundColor: Color(
                                                            0xffFDF8F0),
                                                        elevation: 0.0,
                                                        highlightElevation: 0.0,
                                                        heroTag: "btnminpoin"+item.product.id.toString(),
                                                        child: Text(
                                                          '-',
                                                          style: TextStyle(
                                                            color: Color(
                                                                0xffF48262),
                                                            fontFamily: 'Brandon',
                                                            fontWeight: FontWeight
                                                                .w700,
                                                          ),
                                                        ),
                                                        onPressed:(){
                                                          UIBlock.block(context,customLoaderChild: LoadingWidget(context));
                                                          value.RemoveRedemToCart(item,Provider.of<AppModel>(context).auth.access_token).then((value) {
                                                            UIBlock.unblock(context);
                                                          });
                                                        },
                                                      )
                                                  ),
                                                  Container(
                                                    padding: EdgeInsets.symmetric(
                                                        horizontal: 10),
                                                    child: Text(item.qty.toString()),
                                                  ),
                                                  SizedBox(

                                                      width: 25,
                                                      height: 25,
                                                      child: FloatingActionButton(
                                                        backgroundColor: Color(
                                                            0xffFDF8F0),
                                                        elevation: 0.0,
                                                        highlightElevation: 0.0,
                                                        heroTag: "btnpluspoin"+item.product.id.toString(),
                                                        child: Text(
                                                          '+',
                                                          style: TextStyle(
                                                            color: Color(
                                                                0xffF48262),
                                                            fontFamily: 'Brandon',
                                                            fontWeight: FontWeight
                                                                .w700,
                                                          ),
                                                        ),
                                                        onPressed: (){
                                                          if(value.gettotalPoin()+item.jml_point<=Provider.of<UserModel>(context).user.point){
                                                            UIBlock.block(context,customLoaderChild: LoadingWidget(context));
                                                            value.addRedemToCart(item,Provider.of<AppModel>(context).auth.access_token).then((value){
                                                              UIBlock.unblock(context);
                                                            });
                                                          }
                                                        },
                                                      )
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: MediaQuery
                                            .of(context)
                                            .size
                                            .width * 0.25,
                                        child: Column(
                                          children: <Widget>[
                                            Container(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment
                                                    .start,
                                                children: <Widget>[
                                                  Text(
                                                    'TOTAL',
                                                    style: TextStyle(
                                                        fontFamily: 'Brandon',
                                                        fontSize: 12
                                                    ),
                                                  ),
                                                  Text(
                                                    "GRATIS",
                                                    style: TextStyle(
                                                        fontFamily: 'Brandon',
                                                        fontSize: 14,
                                                        fontWeight: FontWeight.w600
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              child: Align(
                                                alignment: Alignment.bottomRight,
                                                child:  IconButton(
                                                  onPressed: (){
                                                    UIBlock.block(context,customLoaderChild: LoadingWidget(context));
                                                    value.DeleteRendemProduct(item,Provider.of<AppModel>(context).auth.access_token).then((value) {
                                                      UIBlock.unblock(context);
                                                    });
                                                  },
                                                  icon: Icon(Icons.delete_outline,
                                                      color: Color(0xffF48262)),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                          ),

                          for(final item in value.listUseSample)(

                              Container(
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width * 0.95,
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
                                        width: MediaQuery
                                            .of(context)
                                            .size
                                            .width * 0.25,
                                        padding: EdgeInsets.only(right: 7),
                                        child: CachedNetworkImage(
                                          imageUrl: img_url+ item.thumbnail_image,
                                          placeholder: (context, url) => LoadingWidgetPulse(context),
                                          errorWidget: (context, url, error) => Image.asset('assets/images/basic.jpg'),
                                          width: MediaQuery.of(context).size.width,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Container(
                                        width: MediaQuery
                                            .of(context)
                                            .size
                                            .width * 0.35,
                                        padding: EdgeInsets.only(right: 7),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment
                                              .start,
                                          children: <Widget>[
                                            Text(
                                              item.brand.name,
                                              style: TextStyle(
                                                fontFamily: 'Yeseva',
                                                fontSize: 16,
                                              ),
                                            ),
                                            Text(
                                              item.name.length > 20 ? item.name.substring(0, 20)+'...' : item.name,
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
                                                fontWeight: FontWeight.w600
                                              ),
                                            ),

                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: MediaQuery
                                            .of(context)
                                            .size
                                            .width * 0.25,
                                        child: Column(
                                          children: <Widget>[
                                            Container(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment
                                                    .start,
                                                children: <Widget>[
                                                  Text(
                                                    'TOTAL',
                                                    style: TextStyle(
                                                        fontFamily: 'Brandon',
                                                        fontSize: 12
                                                    ),
                                                  ),
                                                  Text(
                                                    "GRATIS",
                                                    style: TextStyle(
                                                        fontFamily: 'Brandon',
                                                        fontSize: 14,
                                                        fontWeight: FontWeight.w600
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              child: Align(
                                                alignment: Alignment.bottomRight,
                                                child:  IconButton(
                                                  onPressed: (){
                                                    UIBlock.block(context,customLoaderChild: LoadingWidget(context));
                                                    value.DeleteProductSample(item,Provider.of<AppModel>(context).auth.access_token).then((value) {
                                                      UIBlock.unblock(context);
                                                    });
                                                  },
                                                  icon: Icon(Icons.delete_outline,
                                                      color: Color(0xffF48262)),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                          ),

                          Container(
                            width: MediaQuery
                                .of(context)
                                .size
                                .width,
                            padding: EdgeInsets.all(15),
                            child: IntrinsicHeight(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    child: Container(
                                      margin: EdgeInsets.symmetric(
                                          horizontal: 10),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 5),
                                      width: MediaQuery
                                          .of(context)
                                          .size
                                          .width * 0.4,
                                      decoration: BoxDecoration(
                                        color: Color(0xffF48262),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment
                                            .spaceBetween,
                                        children: <Widget>[
                                          Image.asset(
                                              "assets/images/pilih_sample.png"),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment
                                                .start,
                                            children: <Widget>[
                                              Text(
                                                'PILIH SAMPLE',
                                                style: TextStyle(
                                                    fontFamily: 'Brandon',
                                                    fontSize: 12,
                                                    color: Colors.white
                                                ),
                                              ),
                                              Text(
                                                'YANG KAMU',
                                                style: TextStyle(
                                                    fontFamily: 'Brandon',
                                                    fontSize: 12,
                                                    color: Colors.white
                                                ),
                                              ),
                                              Text(
                                                'INGINKAN: $jumlahSample/2',
                                                style: TextStyle(
                                                    fontFamily: 'Brandon',
                                                    fontSize: 12,
                                                    color: Colors.white
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    onTap: (){
                                      if(jumlahSample<2) {
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
                                    onTap:(){
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                HappySkinRewardScreen()),
                                      );
                                    },
                                    child:Container(
                                      margin: EdgeInsets.symmetric(
                                          horizontal: 10),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 5),
                                      width: MediaQuery
                                          .of(context)
                                          .size
                                          .width * 0.4,
                                      decoration: BoxDecoration(
                                        color: Color(0xffF48262),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment
                                            .spaceBetween,
                                        children: <Widget>[
                                          Image.asset(
                                              "assets/images/tukar_poin.png"),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment
                                                .start,
                                            mainAxisAlignment: MainAxisAlignment
                                                .center,
                                            children: <Widget>[
                                              Text(
                                                'TUKAR POIN MU',
                                                style: TextStyle(
                                                    fontFamily: 'Brandon',
                                                    fontSize: 12,
                                                    color: Colors.white
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ) ,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            width: MediaQuery
                                .of(context)
                                .size
                                .width * 0.95,
                            padding: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 7),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: Color(0xffF48262),
                                  width: 1.0,
                                ),
                              ),
                            ),


                            child: IntrinsicHeight(

                              child:Stack(
                                alignment: Alignment(1.0,0.0), // right & center
                                children: <Widget>[
                                  TextField(
                                    controller: _code..text = (value.coupon != null && value.coupon.coupon_id != null) ? value.coupon.code : null,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        enabledBorder: InputBorder.none,
                                        errorBorder: InputBorder.none,
                                        disabledBorder: InputBorder.none,
                                        fillColor: Colors.transparent,
                                        labelText: 'KODE PROMO',
                                        hintText: 'Enter KODE PROMO',
                                    ),
                                  ),
                                  Positioned(
                                    child:FlatButton (
                                      child: Text("PAKAI",style: TextStyle(fontFamily: 'Brandon',
                                        fontSize: 14,
                                        color: Color(0xffF48262),
                                        ) ,
                                        textAlign: TextAlign.right,
                                        ),
                                      onPressed: () {
                                        if(_code.value.text.isNotEmpty){
                                          UIBlock.block(context,customLoaderChild: LoadingWidget(context));
                                          value.AppyCoupon(_code.value.text, Provider.of<AppModel>(context).auth.access_token).then((values){
                                            UIBlock.unblock(context);
                                            if(value.coupon != null && value.coupon.code != null){
                                              final snackBar = SnackBar(
                                                content: Text('Success.',style: TextStyle(color: Colors.white)),
                                                backgroundColor: Colors.green,
                                              );
                                              scaffoldKey.currentState.showSnackBar(snackBar);
                                            }else{
                                              final snackBar = SnackBar(
                                                content: Text('Code promo tidak berlaku!',style: TextStyle(color: Colors.white)),
                                                backgroundColor: Colors.redAccent,
                                              );
                                              scaffoldKey.currentState.showSnackBar(snackBar);
                                            }
                                          });
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            width: MediaQuery
                                .of(context)
                                .size
                                .width * 0.95,
                            padding: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 7),
                            child: IntrinsicHeight(
                              child: Column(
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.symmetric(vertical: 5),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment
                                          .spaceBetween,
                                      children: <Widget>[
                                        Text(
                                          'SUB TOTAL',
                                          style: TextStyle(
                                            fontFamily: 'Brandon',
                                            fontSize: 14,
                                          ),
                                        ),
                                        Text(
                                          value.summary.subtotal,
                                          style: TextStyle(
                                            fontFamily: 'Brandon',
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  if(value.coupon != null )
                                  Padding(
                                    padding: EdgeInsets.symmetric(vertical: 5),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment
                                          .spaceBetween,
                                      children: <Widget>[
                                        Text(
                                          'POTONGAN DISKON',
                                          style: TextStyle(
                                            fontFamily: 'Brandon',
                                            fontSize: 14,
                                          ),
                                        ),
                                        Text(
                                          value.summary.discount,
                                          style: TextStyle(
                                            fontFamily: 'Brandon',
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(vertical: 5),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment
                                          .spaceBetween,
                                      children: <Widget>[
                                        Text(
                                          'TOTAL',
                                          style: TextStyle(
                                            fontFamily: 'Brandon',
                                            fontSize: 14,
                                          ),
                                        ),
                                        Text(
                                          value.summary.total,
                                          style: TextStyle(
                                            fontFamily: 'Brandon',
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(vertical: 5),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment
                                          .spaceBetween,
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
                                          '+ '+value.summary.earnPoint.toString(),
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
                            width: MediaQuery
                                .of(context)
                                .size
                                .width * 0.95,
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
                                FocusScope.of(context).requestFocus(FocusNode());
                                UIBlock.block(context,customLoaderChild: LoadingWidget(context));
                                value.RemoveShipping().then((value){
                                  UIBlock.unblock(context);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ShippingScreen()),
                                  );
                                });
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
      bottomNavigationBar: new PonnyBottomNavbar(selectedIndex: 1),
    );
  }
}
