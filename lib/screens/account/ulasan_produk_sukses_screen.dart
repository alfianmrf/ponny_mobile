import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:ponny/common/constant.dart';
import 'package:ponny/model/App.dart';
import 'package:ponny/model/Review.dart';
import 'package:ponny/screens/product_details_screen.dart';
import 'package:ponny/util/globalUrl.dart';
import 'package:ponny/widgets/PonnyBottomNavbar.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class UlasanProdukSuksesScreen extends StatefulWidget {
  static const String id = "pesanan_selesai_Screen";
  @override
  _UlasanProdukSuksesStateScreen createState() =>
      _UlasanProdukSuksesStateScreen();
}

class _UlasanProdukSuksesStateScreen extends State<UlasanProdukSuksesScreen> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  ScrollController _scrollController = new ScrollController();
  var refreshKey = GlobalKey<RefreshIndicatorState>();
  List<Review> listReview =[];
  bool isLoading =true;
  int current_page=0;
  int last_page =0;
  String NextPage;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _getData();
      _scrollController.addListener(() {
        if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent) {
          _getMoreData();
        }
      });
    });
  }

  Widget _buildProgressIndicator() {
    return new Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Center(
        child: new Opacity(
          opacity: isLoading ? 1.0 : 00,
          child: LoadingWidget(context),
        ),
      ),
    );
  }

  Future<Null> _getData()  async {
    setState(() {
      isLoading = true;
      NextPage=null;
      listReview=[];
    });
    final token = Provider.of<AppModel>(context,listen: false).auth.access_token;
    final response = await http.get(myReview,headers: { HttpHeaders.contentTypeHeader: 'application/json', HttpHeaders.authorizationHeader: "Bearer $token"});
    if(response.statusCode == 200)
    {
      print(response.body);
      final responseJson = json.decode(response.body);


      setState(() {
        for (Map item in responseJson["data"]) {
          listReview.add(Review.fromJson(item));
        }
        isLoading =false;
        current_page = responseJson['pagination']['current_page'];
        last_page = responseJson['pagination']['last_page'];
        NextPage = responseJson['pagination']["next_page_url"];
      });
    }

  }
  void _getMoreData() async {
    if(NextPage != null && !isLoading  && current_page <= last_page){
      setState(() {
        isLoading = true;
        current_page ++;
      });
      final token = Provider.of<AppModel>(context,listen: false).auth.access_token;
      final response = await http.get(NextPage,headers: { HttpHeaders.contentTypeHeader: 'application/json', HttpHeaders.authorizationHeader: "Bearer $token"});
      final responseJson = json.decode(response.body);
      setState(() {
        for (Map item in responseJson["data"]) {
          listReview.add(Review.fromJson(item));
        }
        isLoading =false;
        current_page = responseJson['pagination']['current_page'];
        last_page = responseJson['pagination']['last_page'];
        NextPage = responseJson['pagination']["next_page_url"];
      });
    }
  }
  Widget _buildList() {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: listReview.length + 1,
      itemBuilder: (BuildContext context, int index) {
        if (index == listReview.length) {
          return _buildProgressIndicator();
        }
        else {
          return InkWell(
            onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetailsScreen(product: listReview[index].product,)));
            },
            child: Container(
              margin: EdgeInsets.only(
                top: 30,
                left: 20,
                right: 20,
              ),
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Text(
                      listReview[index].product.name,
                      style: TextStyle(
                        fontFamily: "Yeseva",
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.symmetric(vertical: 5),
                    child: Text.rich(TextSpan(children: <InlineSpan>[
                      WidgetSpan(
                        child:  RatingBar.builder(
                          initialRating: listReview[index].rating,
                          minRating: 0,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemSize: 25.0,
                          itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
                          itemBuilder: (context, index) => Icon(
                            Icons.favorite,
                            color: Color(0xffF48262),
                          ),
                          unratedColor: Color(0xffFBD2CD),
                        ),
                      ),
                      WidgetSpan(
                        child: Container(
                          margin: EdgeInsets.only(left: 10),
                          padding: EdgeInsets.symmetric(horizontal: 5),
                          child: Text(
                            listReview[index].rating.toString(),
                            style: TextStyle(
                              color: Color(0xffF48262),
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'Brandon',
                            ),
                          ),
                        ),
                      ),
                      if(listReview[index].statusBeli == 1)
                        WidgetSpan(
                          child: Container(
                            margin: EdgeInsets.only(left: 10),
                            padding: EdgeInsets.symmetric(horizontal: 5),
                            child: Text(
                              'Verified by Phoebe',
                              style: TextStyle(
                                  fontFamily: 'Brandon',
                                  fontSize: 10
                              ),
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(3),
                            ),
                          ),
                        )
                    ])),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: Text(
                            listReview[index].comment,
                            style: TextStyle(
                              fontFamily: "Brandon",
                              fontWeight: FontWeight.w400,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  if(listReview[index].photos.length>0)
                    ListView(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        GridView.count(
                            shrinkWrap: true,
                            primary: true,
                            physics:  const NeverScrollableScrollPhysics(),
                            padding: const EdgeInsets.all(10.0),
                            childAspectRatio: 100/140,
                            crossAxisSpacing: 10.0,
                            crossAxisCount: 3,
                            children: <Widget>[
                              for(String path in listReview[index].photos)Container(
                                  child: CachedNetworkImage(
                                    imageUrl: img_url+path,
                                    placeholder: (context, url) => LoadingWidgetPulse(context),
                                    errorWidget: (context, url, error) => Image.asset('assets/images/basic.jpg'),
                                    width: MediaQuery.of(context).size.width*0.15,
                                    fit: BoxFit.cover,
                                  )
                              ),
                            ]),
                      ],
                    ),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    height: 1,
                    color: Color(0xffF48262),
                  ),
                ],
              ),
            ),
          );
        }
      },
      controller: _scrollController,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 65,
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
          'Ulasan Produk',
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
        child: Column(
          children: <Widget>[
            new Expanded(
                child:
                RefreshIndicator(
                  key: refreshKey,
                  child:  _buildList(),
                  onRefresh: _getData,
                )
            ),
          ],
        ),
      ),
      bottomNavigationBar: new PonnyBottomNavbar(selectedIndex: 4),
    );
  }
}
