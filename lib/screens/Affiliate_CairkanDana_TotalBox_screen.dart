import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:ponny/common/constant.dart';
import 'package:ponny/model/AffiliateResult.dart';
import 'package:ponny/model/User.dart';
import 'package:ponny/screens/Affiliate_CairkanDana_screen.dart';
import 'package:ponny/screens/account/affiliate_about_screen.dart';
import 'package:ponny/widgets/PonnyBottomNavbar.dart';
import 'package:intl/intl.dart';
import 'package:ponny/util/globalUrl.dart';
import 'package:provider/provider.dart';

class CairkanDanaTotalScreen extends StatefulWidget {
  int total, use, session;
  String sales, img;
  CairkanDanaTotalScreen(
      {this.total, this.session, this.use, this.sales, this.img});
  @override
  _CairkanDanaTotalScreenState createState() => _CairkanDanaTotalScreenState();
}

class _CairkanDanaTotalScreenState extends State<CairkanDanaTotalScreen> {
  int session;

  @override
  Widget build(BuildContext context) {
    final formatCurrency =
        new NumberFormat.simpleCurrency(locale: 'id_ID', decimalDigits: 0);

    final user = Provider.of<UserModel>(context).user;

    final size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Hexcolor('#FCF8F0'),
        appBar: AppBar(
            elevation: 0,
            titleSpacing: 0,
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back_ios,
                    color: Color(0xffF48262), size: 26)),
            title: Text(
              'Cairkan Dana',
              style: TextStyle(
                  fontSize: 24,
                  fontFamily: "Yeseva",
                  fontWeight: FontWeight.w500,
                  color: Color(0xffF48262)),
            ),
            bottom: PreferredSize(
                child: Container(color: Color(0xffF48262), height: 1.0),
                preferredSize: Size.fromHeight(1.0))),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                  width: size.width,
                  height: 210,
                  decoration: BoxDecoration(color: Hexcolor('#FCF8F0')),
                  child: Stack(
                    children: [
                      Container(
                        width: size.width,
                        height: size.height * 0.28,
                        color: Colors.red,
                        child: CachedNetworkImage(
                          imageUrl: "$img_url${widget.img}",
                          placeholder: (context, url) =>
                              LoadingWidgetPulse(context),
                          errorWidget: (context, url, error) =>
                              Image.asset('assets/images/basic.jpg'),
                          fit: BoxFit.fill,
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        left: 0,
                        child: Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: size.width * 0.05),
                          width: size.width,
                          height: size.height * 0.14,
                          decoration: BoxDecoration(
                              color: Hexcolor('#FCF8F0'),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          child: Padding(
                            padding: EdgeInsets.only(top: size.height * 0.021),
                            child: Column(
                              children: [
                                Text("Hallo,",
                                    style: TextStyle(
                                        fontFamily: "Yeseva",
                                        fontSize: size.height * 0.034,
                                        fontWeight: FontWeight.w600)),
                                Text(
                                  user.last_name != null
                                      ? (user.name + " " + user.last_name)
                                          .toUpperCase()
                                      : user.name.toUpperCase(),
                                  style: TextStyle(
                                    fontFamily: "Brandon",
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xffF48262),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
              Column(
                children: [
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(left: size.width * 0.04),
                    child: Text("Result from campaigns",
                        style: TextStyle(
                            fontFamily: "Brandon",
                            fontWeight: FontWeight.w600,
                            fontSize: size.height * 0.023)),
                  ),
                  Container(
                    width: size.width,
                    margin:
                        EdgeInsets.symmetric(horizontal: size.width * 0.027),
                    padding: EdgeInsets.only(top: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 5),
                            padding: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 10),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                    color: Color(0xffF48262), width: 1),
                                borderRadius: BorderRadius.circular(5)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Sessions",
                                  style: TextStyle(
                                      fontFamily: "Brandon", fontSize: 12),
                                  textAlign: TextAlign.left,
                                ),
                                Text("${widget.session}",
                                    style: TextStyle(fontFamily: "Brandon"),
                                    textAlign: TextAlign.left)
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 5),
                            padding: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 10),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                    color: Color(0xffF48262), width: 1),
                                borderRadius: BorderRadius.circular(5)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Yang Terpakai",
                                    style: TextStyle(
                                        fontFamily: "Brandon", fontSize: 12),
                                    textAlign: TextAlign.left),
                                Text("${widget.use}",
                                    style: TextStyle(fontFamily: "Brandon"),
                                    textAlign: TextAlign.left),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 5),
                            padding: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 10),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                    color: Color(0xffF48262), width: 1),
                                borderRadius: BorderRadius.circular(5)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Pendapatan",
                                    style: TextStyle(
                                        fontFamily: "Brandon", fontSize: 12),
                                    textAlign: TextAlign.left),
                                Text("${formatCurrency.format(widget.total)}",
                                    style: TextStyle(fontFamily: "Brandon"),
                                    textAlign: TextAlign.left)
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: size.width,
                    margin: EdgeInsets.symmetric(
                        horizontal: size.width * 0.037,
                        vertical: size.height * 0.037),
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Color(0xffF48262), width: 1),
                        borderRadius: BorderRadius.circular(5)),
                    child: Padding(
                      padding: EdgeInsets.only(top: size.height * 0.02),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(children: [
                            ImageIcon(AssetImage('assets/images/wallet.png'),
                                color: Color(0xffF48262)),
                            Padding(
                              padding: EdgeInsets.only(left: size.width * 0.03),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("TOTAL",
                                      style: TextStyle(
                                          color: Colors.black45,
                                          fontFamily: "Brandon",
                                          fontSize: size.width * 0.035,
                                          fontWeight: FontWeight.w600)),
                                  Text("${formatCurrency.format(widget.total)}",
                                      style: TextStyle(
                                          fontFamily: "Brandon",
                                          fontSize: size.width * 0.046,
                                          fontWeight: FontWeight.w700))
                                ],
                              ),
                            ),
                            Spacer(),
                            Container(
                                child: RaisedButton(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 5),
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  CairkanDanaScreen(
                                                    total: widget.total,
                                                    img: widget.img,
                                                  )));
                                    },
                                    elevation: 0,
                                    child: Text("CAIRKAN DANA",
                                        style: TextStyle(
                                            fontFamily: "Brandon",
                                            color: Colors.white,
                                            fontSize: size.width * 0.034,
                                            fontWeight: FontWeight.w700)),
                                    color: Color(0xffF48262)))
                          ]),
                          Divider(color: Color(0xffF48262)),
                          Row(
                            children: [
                              Text(
                                  "Pelajari lebih lengkap mengenai pencarian dana,",
                                  style: TextStyle(
                                      fontFamily: "Brandon",
                                      fontSize: size.height * 0.02),
                                  textAlign: TextAlign.left),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              AboutRefund(widget.img)));
                                },
                                child: Container(
                                    width: 40,
                                    height: size.height * 0.03,
                                    child: Text(" disini",
                                        style: TextStyle(
                                            color: Hexcolor('#ffF48262'),
                                            fontFamily: "Brandon",
                                            fontSize: size.height * 0.02))),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        bottomNavigationBar: new PonnyBottomNavbar(selectedIndex: 4));
  }
}
