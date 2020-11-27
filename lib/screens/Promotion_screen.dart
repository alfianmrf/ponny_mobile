import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:ponny/common/constant.dart';
import 'package:ponny/model/PromotionResult.dart';
import 'package:ponny/screens/Promotion_Detail_screen.dart';
import 'package:ponny/util/globalUrl.dart';
import 'package:ponny/widgets/PonnyBottomNavbar.dart';
import 'package:ponny/screens/product_details_screen.dart';
import 'package:http/http.dart' as http;

class PromotionScreen extends StatefulWidget {
  PromotionScreen({Key key}) : super(key: key);

  @override
  _PromotionScreenState createState() => _PromotionScreenState();
}

class _PromotionScreenState extends State<PromotionScreen> {
  PromotionResult result = PromotionResult();
  bool loading = true;
  final keyScaffold = GlobalKey<ScaffoldState>();


  @override
  void initState() {
    super.initState();
    getData();

  }

  Future<void> getData() async {
    try{
      final res=  await http.get(getpromo);
      if(res.statusCode == 200){
        final responeJson = json.decode(res.body);
       setState(() {
         result = PromotionResult.fromJson(responeJson);
         loading =false;
       });

       // print(result.coupons.length);
      }
    }catch(e){
      print(e.toString());
      setState(() {
        loading =false;
      });
      keyScaffold.currentState.showSnackBar(snackBarError);

    }
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          titleSpacing: 0.0,
          elevation: 0.0,
          leading: IconButton(
            onPressed: (){
              Navigator.pop(context,false);
            },
            icon: Icon(
              Icons.arrow_back_ios_rounded,
              color: Color(0xffF48262),
            ),
          ),
          title: Text(
            'Promotion',
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
        key: keyScaffold,
          body: loading ? Container(
            child: Center(
              child: LoadingWidgetFadingCircle(context),
            ),
          ) :

          Column(
            children: [
              Container(
                height: 1,
                color: Color(0xffF3C1B5),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: Text(
                  "Kupon Diskon",
                  style: TextStyle(
                    fontSize: 24,
                    fontFamily: "Yeseva",
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: result.promotions != null ? result.promotions.length :0,
                  itemBuilder: (context, i) {
                    final promo = result.promotions[i];
                    return GestureDetector(
                      onTap: () {
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => PromotionDetailScreen()));
                      },
                      child: Container(
                          margin: EdgeInsets.all(10),
                          child: CachedNetworkImage(
                            imageUrl:promo.banner != null?   img_url+promo.banner:"",
                            placeholder: (context, url) => LoadingWidgetPulse(context),
                            errorWidget: (context, url, error) => Image.asset('assets/images/basic.jpg'),
                            width: MediaQuery.of(context).size.width,
                            fit: BoxFit.cover,
                          ),
                      )
                    );
                  },
                ),
              ),
              Expanded(
                flex: 3,
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: result.coupons !=null ? result.coupons.length :0,
                  itemBuilder: (context, i) {
                    final kupon = result.coupons[i];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PromotionDetailScreen(cupon: kupon,)));
                      },
                      child: Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 35, vertical: 10),
                        decoration: BoxDecoration(
                            border: Border.all(color: Color(0xffF3C1B5)),
                            borderRadius: BorderRadius.circular(3)),
                        child: Column(
                          children: [
                            Container(
                                child: Image.network(
                              img_url+kupon.banner,
                              fit: BoxFit.cover,
                            )),
                            Container(
                              padding: EdgeInsets.all(20),
                              child: Text(
                                kupon.title,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontFamily: "Yeseva",
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
          bottomNavigationBar: new PonnyBottomNavbar(selectedIndex: 1)),
    );
  }
}
