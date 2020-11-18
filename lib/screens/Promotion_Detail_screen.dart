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
    return SafeArea(
      child: Scaffold(
          body: Column(
            children: [
              Container(
                height: 35,
              ),
              Container(
                margin: EdgeInsets.all(5),
                child: Row(
                  children: [
                    Container(
                      child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.arrow_back_ios,
                            color: Color(0xffF48262),
                            size: 26,
                          )),
                    ),
                    Container(
                      child: Text(
                        "Promotion",
                        style: TextStyle(
                          fontSize: 24,
                          fontFamily: "Yeseva",
                          fontWeight: FontWeight.w500,
                          color: Color(0xffF48262),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 1,
                color: Color(0xffF3C1B5),
              ),
              Expanded(
                child: Column(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        color: Color(0xffF48262),
                        width: double.infinity,
                        child: Center(
                          child: Text(
                            widget.cupon.title,
                            style: TextStyle(
                              fontSize: 24,
                              fontFamily: "Yeseva",
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Row(children: [
                        Expanded(
                          flex: 3,
                          child: Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            decoration: BoxDecoration(
                                border: Border.all(color: Color(0xffF48262)),
                                borderRadius: BorderRadius.circular(3)),
                            padding: EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Text(
                                    "Keterangan",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontFamily: "Yeseva",
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Html(
                                    data:widget.cupon.keterangan,
                                    style: {
                                      "html": Style(
                                        fontSize: FontSize.small,
                                        fontFamily: "Yeseva",
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
                          child: Column(
                            children: [
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.only(
                                      left: 10, right: 10, top: 10),
                                  decoration: BoxDecoration(
                                      border:
                                          Border.all(color: Color(0xffF48262)),
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(3),
                                          topRight: Radius.circular(3))),
                                  padding: EdgeInsets.all(10),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.local_offer,
                                        color: Color(0xffF48262),
                                      ),
                                      Container(width: 5),
                                      DottedLine(
                                        direction: Axis.vertical,
                                      ),
                                      Container(width: 5),
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
                                              nm_format.format(widget.cupon.details.minBuy),
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontFamily: "Brandon",
                                                fontWeight: FontWeight.w800,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.only(
                                      left: 10, right: 10, bottom: 10),
                                  decoration: BoxDecoration(
                                    border:
                                        Border.all(color: Color(0xffF48262)),
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(3),
                                        bottomRight: Radius.circular(3)),
                                  ),
                                  padding: EdgeInsets.all(10),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.calendar_today,
                                        color: Color(0xffF48262),
                                      ),
                                      Container(width: 5),
                                      DottedLine(
                                        direction: Axis.vertical,
                                      ),
                                      Container(width: 5),
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              child: Text(
                                                "Periode",
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  fontFamily: "Brandon",
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Text(
                                                  start.month == end.month?
                                                  start.day.toString()+" - "+formatter.format(end) : formatter.format(start)+" - "+formatter.format( end),
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontFamily: "Brandon",
                                                  fontWeight: FontWeight.w800,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ]),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: Color(0xffF48262)),
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(3),
                                      bottomRight: Radius.circular(3)),
                                ),
                                padding: EdgeInsets.all(10),
                                child: Row(
                                  children: [
                                    Container(
                                      child: Icon(
                                        Icons.local_activity,
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
                                          Expanded(
                                            child: Text(
                                              widget.cupon.code,
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontFamily: "Brandon",
                                                fontWeight: FontWeight.w800,
                                              ),
                                            ),
                                          ),
                                        ])
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: GestureDetector(
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
                                  color: Hexcolor('#F48262'),
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
                                            fontWeight: FontWeight.w800,
                                            color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Container(
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
                            Container(
                              height: 10,
                            ),
                            for(String item in widget.cupon.syarat)
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Icon(Icons.favorite,
                                      color: Color(0xffF48262)),
                                ),
                                Expanded(
                                  flex: 5,
                                  child: Html(
                                    data: item,
                                    style: {
                                      "html" :Style(
                                        fontSize: FontSize.medium,
                                        fontFamily: "Brandon",
                                        fontWeight: FontWeight.w800,
                                      )
                                    },
                                  ),
                                ),
                              ],
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
          bottomNavigationBar: new PonnyBottomNavbar(selectedIndex: 1)),
    );
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
