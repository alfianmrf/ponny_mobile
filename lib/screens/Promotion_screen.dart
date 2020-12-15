import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
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
    return Scaffold(
      backgroundColor: Hexcolor('#FCF8F0'),
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
          'Promosi',
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
              padding: EdgeInsets.all(20),
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
                        margin: EdgeInsets.all(10),
                        child: Image.network(
                          img_url+kupon.banner,
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
                itemCount: result.promotions != null ? result.promotions.length :0,
                itemBuilder: (context, i) {
                  final promo = result.promotions[i];
                  return GestureDetector(
                    onTap: () {},
                    child: Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 35, vertical: 10),
                      decoration: BoxDecoration(
                          border: Border.all(color: Color(0xffF48262),),
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        children: [
                          Container(
                              child: ClipRRect(
                                borderRadius: BorderRadius.only(topRight: Radius.circular(10), topLeft: Radius.circular(10)),
                                child: CachedNetworkImage(
                                  imageUrl:promo.banner != null?   img_url+promo.banner:"",
                                  placeholder: (context, url) => LoadingWidgetPulse(context),
                                  errorWidget: (context, url, error) => Image.asset('assets/images/new-placeholder-rect.png'),
                                  width: MediaQuery.of(context).size.width,
                                  fit: BoxFit.cover,
                                ),
                              )),
                          Container(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              children: [
                                Text(
                                  promo.caption,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: "Brandon",
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Html(
                                  data: promo.meta_description,
                                  style: {
                                    "html": Style(
                                      fontSize: FontSize.small,
                                      fontFamily: "Brandon",
                                      fontWeight: FontWeight.w500,
                                      textAlign: TextAlign.center,
                                    )
                                  },
                                ),
                              ],
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
        bottomNavigationBar: new PonnyBottomNavbar(selectedIndex: 1),);
  }
}
