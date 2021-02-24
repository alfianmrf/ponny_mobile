import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:ponny/common/constant.dart';
import 'package:ponny/model/PromotionResult.dart';
import 'package:ponny/widgets/PonnyBottomNavbar.dart';

class PromotionDetailScreen extends StatefulWidget {
  Coupons cupon;
  PromotionDetailScreen({Key key,this.cupon}) : super(key: key);

  @override
  _PromotionDetailScreenState createState() => _PromotionDetailScreenState();
}

class _PromotionDetailScreenState extends State<PromotionDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final start = DateTime.fromMillisecondsSinceEpoch(widget.cupon.startDate*1000);
    final end = DateTime.fromMillisecondsSinceEpoch(widget.cupon.endDate*1000);
    return Scaffold(
        backgroundColor: Hexcolor('#FCF8F0'),
        appBar: AppBar(
          elevation: 0,
          titleSpacing: 0,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios_rounded,
              color: Color(0xffF48262),
            ),
          ),
          title:  Text(
            "Promosi",
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
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                color: Color(0xffF48262),
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 30),
                child: Center(
                  child: Text(
                    widget.cupon.title,
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: "Yeseva",
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Container(
                height: 165,
                child: Row(children: [
                  Expanded(
                    flex: 3,
                    child: Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      decoration: BoxDecoration(
                          border: Border.all(color: Color(0xffF48262)),
                          borderRadius: BorderRadius.circular(10)),
                      padding: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "KETERANGAN",
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: "Brandon",
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          Expanded(
                            child: Html(
                              data: widget.cupon.keterangan,
                              style: {
                                "html": Style(
                                  fontSize: FontSize.small,
                                  fontFamily: "Brandon",
                                  fontWeight: FontWeight.w500,
                                )
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Container(
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1, color: Color(0xffF48262),
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  child: ImageIcon(
                                    AssetImage("assets/images/promosi/minimum-pembelian.png"),
                                    size: 18,
                                    color: Color(0xffF48262),
                                  ),
                                ),
                                DottedLine(
                                  direction: Axis.vertical,
                                  dashColor: Color(0xffF48262),
                                ),
                                Container(width: 10),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.center,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Minimum Pembelian",
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontFamily: "Brandon",
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Text(
                                        widget.cupon.type == "cart_base" ? nm_format.format(double.tryParse(widget.cupon.decodeDetail.minBuy)):"-",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontFamily: "Brandon",
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(width: 10),
                              ],
                            ),
                          ),
                          Container(
                            height: 1,
                            width: double.infinity,
                            color: Color(0xffF48262),
                          ),
                          Expanded(
                            child: Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  child: ImageIcon(
                                    AssetImage("assets/images/promosi/periode.png"),
                                    size: 18,
                                    color: Color(0xffF48262),
                                  ),
                                ),
                                DottedLine(
                                  direction: Axis.vertical,
                                  dashColor: Color(0xffF48262),
                                ),
                                Container(width: 10),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.center,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Periode",
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontFamily: "Brandon",
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Text(
                                        start.month == end.month?
                                        start.day.toString()+" - "+formatter.format(end) : formatter.format(start)+" - "+formatter.format( end),
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontFamily: "Brandon",
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(width: 10),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ]),
              ),
              Container(
                margin:
                EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                    border: Border.all(color: Color(0xffF48262)),
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child: Row(
                          children: [
                            Container(
                              child: ImageIcon(
                                AssetImage("assets/images/promosi/kode-promo.png"),
                                size: 22,
                                color: Color(0xffF48262),
                              ),
                            ),
                            Container(width: 10),
                            Column(
                                mainAxisAlignment:
                                MainAxisAlignment.center,
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Kode Promo",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontFamily: "Brandon",
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    widget.cupon.code,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontFamily: "Brandon",
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ])
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        Clipboard.setData(new ClipboardData(text: widget.cupon.code ));
                        Fluttertoast.showToast(
                            msg: "Copied to Clipboard",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Hexcolor('#F48262'),
                          borderRadius: BorderRadius.only(bottomRight: Radius.circular(10), topRight: Radius.circular(10)),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 20),
                        child: Row(
                          children: [
                            Container(width: 10),
                            Icon(Icons.content_copy,
                                color: Colors.white),
                            Text(
                              "SALIN KODE",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: "Brandon",
                                  color: Colors.white),
                            ),
                            Container(width: 10)
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                margin: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Text(
                        "SYARAT & KETENTUAN",
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: "Brandon",
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    for(String item in widget.cupon.syarat)
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 10),
                            child: Icon(Icons.favorite,
                                color: Color(0xffF48262), size: 18,),
                          ),
                          Expanded(
                            child: Html(
                              data: item,
                              style: {
                                "html" :Style(
                                  fontSize: FontSize.medium,
                                  fontFamily: "Brandon",
                                )
                              },
                            ),
                          ),
                        ],
                      ),

                  ],
                ),
              )
            ],
          ),
        ),
        bottomNavigationBar: new PonnyBottomNavbar(selectedIndex: 1));
  }
}

Widget rectanglebutton(context, String subtext) {
  return ButtonTheme(
    buttonColor: Hexcolor('#F48262'),
    child: RaisedButton(
      onPressed: () {},
      child: Text(
        subtext,
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 14,
            fontFamily: 'Brandon',
            fontWeight: FontWeight.w800,
            letterSpacing: 1,
            color: Colors.white),
      ),
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(5.0),
      side: BorderSide(color: Hexcolor('#F48262')),
    ),
  );
}
