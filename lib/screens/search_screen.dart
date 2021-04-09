import 'package:flutter/material.dart';
import 'package:ponny/common/constant.dart';
import 'package:ponny/model/App.dart';
import 'package:ponny/model/Brand.dart';
import 'package:ponny/model/Category.dart';
import 'package:ponny/model/ItemBlog.dart';
import 'package:ponny/model/Order.dart';
import 'package:ponny/model/Product.dart';
import 'package:ponny/model/Voucher.dart';
import 'package:ponny/model/WishProduct.dart';
import 'package:ponny/screens/Blog_screen.dart';
import 'package:ponny/screens/Detail_Brand_Screen.dart';
import 'package:ponny/screens/Skincare_Screen.dart';
import 'package:ponny/screens/WaitingPage.dart';
import 'package:ponny/screens/konsultasi_screen.dart';
import 'package:ponny/screens/payment_voucher_screen.dart';
import 'package:ponny/screens/product_details_screen.dart';
import 'package:ponny/util/globalUrl.dart';
import 'package:ponny/widgets/PonnyBottomNavbar.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart' as Launcher;

import 'Browse_Screen.dart' as b;
import 'account/daftar_keinginan_screen.dart';
import 'account/hubungi_kami_screen.dart';
import 'login.dart';

class SearchScreen extends StatefulWidget {
  static const String id = "search_screen";
  String q;
  SearchScreen({this.q});
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<SearchScreen> {
  bool loading =true;
  SearchGlobalResult result;
  final _search = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      setState(() {
        _search.text = widget.q;
      });
      _searchData();

    });
  }
  void _searchData(){
    if(_search.text.isNotEmpty){
      var param={
        "q":_search.value.text
      };
      Provider.of<AppModel>(context).search(param).then((value){
        setState(() {
          result = value;
          loading =false;
        });
      });
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFDF8F0),
      body: Stack(children: <Widget>[
        Scaffold(
          backgroundColor: Color(0xffFDF8F0),
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(136.0),
            child: SafeArea(
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(vertical: 5),
                    color: Color(0xffF48262),
                    child: Center(
                      child: Text(
                        'GRATIS ONGKIR DENGAN PEMBELANJAAN RP 250.000',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Brandon',
                        ),
                        textScaleFactor: .8,
                      ),
                    ),
                  ),
                  new AppBar(
                    primary: false,
                    title: Image.asset('assets/images/PonnyBeaute.png', fit: BoxFit.contain, height: 46),
                    centerTitle: true,
                    backgroundColor: Color(0xfffdf8f0),
                    elevation: 0,
                    leading: IconButton(
                      onPressed: (){
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => b.Browse()));
                      },
                      icon: ImageIcon(
                          AssetImage('assets/images/home/search.png')
                      ),
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
                                child: Provider.of<WishModel>(context).loading ? LoadingRing(context) : ImageIcon(
                                  AssetImage('assets/images/home/wishlist.png'),
                                ),
                              ):new Container(
                                padding: EdgeInsets.all(5),
                                child: ImageIcon(
                                  AssetImage('assets/images/home/wishlist.png'),
                                ),
                              ),
                              if(Provider.of<WishModel>(context).countwishlist > 0 && Provider.of<AppModel>(context).loggedIn)
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
                    ],
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Colors.white),
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    margin: EdgeInsets.only(left: 10, top: 10, right: 10),
                    child: Row(children: [
                      Icon(Icons.search, color: Color(0xffF48262)),
                      Expanded(
                          child: TextField(
                            onTap: () {
                              showSearch(context: null, delegate: b.Search());
                            },
                            onSubmitted: (String q){
                              FocusScope.of(context).requestFocus(new FocusNode());
                              setState(() {
                                loading=true;
                              });
                              _searchData();
                            },
                            controller: _search,
                            cursorColor: Colors.black,
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.go,
                            decoration:
                            new InputDecoration.collapsed(),
                          )),
                      InkWell(
                        onTap: (){
                          Navigator.pushNamedAndRemoveUntil(
                              context,
                              b.Browse.id,(_) => false
                          );
                        },
                        child: Icon(Icons.close, color: Color(0xffF48262)),
                      )
                      ,
                    ]),
                  ),
                ],
              ),
            ),
          ),
          body: loading ?  Container(
            child: Center(
              child: LoadingWidgetFadingCircle(context),
            ),
          ) :Container(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    color: Color(0xffFBDFD2),
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                    child: Text(
                      'PENCARIAN TERBANYAK',
                      style: TextStyle(
                        fontFamily: 'Brandon',
                        fontSize: 15
                      ),
                    ),
                  ),
                  for(Product item in result.products)
                  InkWell(
                    onTap: (){
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => ProductDetailsScreen(product: item)));
                    },
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                      child: Text(
                        item.name,
                        style: TextStyle(
                          fontFamily: 'Brandon',
                        ),
                      ),
                    ),
                  ) ,
                  for(Brand item in result.brands)
                  InkWell(
                    onTap: (){
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => DetailBrand(brand: item)));
                    },
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                      child: Text(
                        item.name,
                        style: TextStyle(
                          fontFamily: 'Brandon',
                        ),
                      ),
                    ),
                  ) ,
                  Container(
                    width: double.infinity,
                    color: Color(0xffFBDFD2),
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                    child: Text(
                      'KATEGORI',
                      style: TextStyle(
                          fontFamily: 'Brandon',
                          fontSize: 15
                      ),
                    ),
                  ),
                  for(Category item in result.categorys)
                    InkWell(
                      onTap: (){
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Skincare(category: item)));
                      },
                     child:  Container(
                       width: double.infinity,
                       padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                       child: Text(
                         item.name,
                         style: TextStyle(
                           fontFamily: 'Brandon',
                         ),
                       ),
                     ),
                    ),

                  Container(
                    width: double.infinity,
                    color: Color(0xffFBDFD2),
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                    child: Text(
                      'ARTIKEL',
                      style: TextStyle(
                          fontFamily: 'Brandon',
                          fontSize: 15
                      ),
                    ),
                  ),
                  for(ItemBlog item in result.blogs)
                    InkWell(
                      onTap: (){
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Blog()));
                      },
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                        child: Text(
                          item.title,
                          style: TextStyle(
                            fontFamily: 'Brandon',
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ]),
      bottomNavigationBar: new PonnyBottomNavbar(selectedIndex: 1),
    );
  }

}
