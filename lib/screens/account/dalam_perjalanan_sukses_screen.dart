import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:ponny/screens/account_screen.dart';
import 'package:ponny/screens/account/komplain_dalam_perjalanan_screen.dart';
import 'package:ponny/widgets/PonnyBottomNavbar.dart';

class DalamPerjalananSuksesScreen extends StatefulWidget {
  static const String id = "Dalam_Perjalanan_Sukses_Screen";
  @override
  _DalamPerjalananSuksesStateScreen createState() =>
      _DalamPerjalananSuksesStateScreen();
}

class _DalamPerjalananSuksesStateScreen
    extends State<DalamPerjalananSuksesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Hexcolor('#FCF8F0'),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 70,
            ),
            Container(
              padding: EdgeInsets.only(left: 15, bottom: 15),
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 14),
                    child: GestureDetector(
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: Color(0xffF48262),
                        size: 26,
                      ),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  Container(
                    child: Text(
                      "Dalam Perjalanan",
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
            Container(
              margin: EdgeInsets.only(
                top: 20,
                left: 15,
                right: 15,
              ),

              // height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.only(
                      top: 5,
                      bottom: 5,
                    ),
                    child: Text(
                      "#70212",
                      style: TextStyle(
                        fontFamily: "Brandon",
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                      top: 5,
                      left: 25,
                      bottom: 5,
                    ),
                    child: Text(
                      "29/04/2020",
                      style: TextStyle(
                        fontFamily: "Brandon",
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 5, bottom: 5, right: 15),
                    child: Text(
                      "Proses",
                      style: TextStyle(
                        fontFamily: "Brandon",
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                      top: 5,
                      bottom: 5,
                    ),
                    child: Text(
                      "Rp 329.000",
                      style: TextStyle(
                        fontFamily: "Brandon",
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                      top: 5,
                      bottom: 5,
                    ),
                    child: Icon(
                      Icons.keyboard_arrow_up,
                      size: 26,
                      color: Color(0xffF48262),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                top: 10,
                left: 15,
                right: 15,
              ),
              height: 1,
              color: Color(0xffF3C1B5),
            ),
            Container(
              // color: Colors.greenAccent,
              margin: EdgeInsets.only(
                top: 20,
                left: 15,
                right: 15,
              ),
              // color: Colors.greenAccent,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    width: 85,
                    height: 230,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          child: Image.asset(
                            "assets/images/produk.png",
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    alignment: Alignment.topCenter,
                    // color: Colors.yellowAccent,
                    height: 230,
                    // color: Colors.yellowAccent,
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 0),
                          // color: Colors.redAccent,
                          width: 90,
                          child: Text(
                            "Skin Game",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontFamily: "Yeseva",
                              fontSize: 14,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 1),
                          width: 90,
                          child: Text(
                            "Acne Warrior",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontFamily: "Brandon",
                              fontWeight: FontWeight.w200,
                              fontSize: 13,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 1),
                          width: 90,
                          child: Text(
                            "Rp. 125.000",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontFamily: "Brandon",
                              fontWeight: FontWeight.w600,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    // color: Colors.yellowAccent,
                    height: 230,
                    child: Column(
                      children: [
                        Container(
                          width: 80,
                          child: Text(
                            "Subtotal",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontFamily: "Brandon",
                              fontWeight: FontWeight.w500,
                              fontSize: 13,
                            ),
                          ),
                        ),
                        Container(
                          width: 80,
                          child: Text(
                            "Rp. 200.000",
                            style: TextStyle(
                              fontFamily: "Brandon",
                              fontWeight: FontWeight.w300,
                              fontSize: 13,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            top: 5,
                          ),
                          width: 80,
                          child: Text(
                            "Voucher",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontFamily: "Brandon",
                              fontWeight: FontWeight.w500,
                              fontSize: 13,
                            ),
                          ),
                        ),
                        Container(
                          width: 80,
                          child: Text(
                            "Rp. 0",
                            style: TextStyle(
                              fontFamily: "Brandon",
                              fontWeight: FontWeight.w300,
                              fontSize: 13,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            top: 5,
                          ),
                          width: 80,
                          child: Text(
                            "Shipping",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontFamily: "Brandon",
                              fontWeight: FontWeight.w500,
                              fontSize: 13,
                            ),
                          ),
                        ),
                        Container(
                          width: 80,
                          child: Text(
                            "Rp. 50.000",
                            style: TextStyle(
                              fontFamily: "Brandon",
                              fontWeight: FontWeight.w300,
                              fontSize: 13,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            top: 5,
                          ),
                          width: 80,
                          child: Text(
                            "Free Shiping",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontFamily: "Brandon",
                              fontWeight: FontWeight.w500,
                              fontSize: 13,
                            ),
                          ),
                        ),
                        Container(
                          width: 80,
                          child: Text(
                            "Rp. 0",
                            style: TextStyle(
                              fontFamily: "Brandon",
                              fontWeight: FontWeight.w300,
                              fontSize: 13,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            top: 5,
                          ),
                          width: 80,
                          child: Text(
                            "TOTAL",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontFamily: "Brandon",
                              fontWeight: FontWeight.w500,
                              fontSize: 13,
                            ),
                          ),
                        ),
                        Container(
                          width: 80,
                          child: Text(
                            "Rp. 329.000",
                            style: TextStyle(
                              fontFamily: "Brandon",
                              fontWeight: FontWeight.w300,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    // color: Colors.yellowAccent,
                    height: 230,
                    child: Column(
                      children: [
                        Container(
                          width: 100,
                          child: Text(
                            "Payment Method",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              fontFamily: "Brandon",
                            ),
                          ),
                        ),
                        Container(
                          width: 100,
                          child: Text(
                            "BCA Virtual",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              fontFamily: "Brandon",
                            ),
                          ),
                        ),
                        Container(
                          width: 100,
                          child: Text(
                            "Code: 913831450890",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              fontFamily: "Brandon",
                            ),
                          ),
                        ),
                        Container(
                          width: 100,
                          margin: EdgeInsets.only(top: 10),
                          child: Text(
                            "Payment Method",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              fontFamily: "Brandon",
                            ),
                          ),
                        ),
                        Container(
                          width: 100,
                          child: Text(
                            "dita ken,",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              fontFamily: "Brandon",
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                        Container(
                          width: 100,
                          child: Text(
                            "+6281358150928",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              fontFamily: "Brandon",
                            ),
                          ),
                        ),
                        Container(
                          width: 100,
                          child: Text(
                            "Cikini,",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              fontFamily: "Brandon",
                            ),
                          ),
                        ),
                        Container(
                          width: 100,
                          child: Text(
                            "Jakarta Pusat",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              fontFamily: "Brandon",
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 30, left: 15, right: 15),
              padding: EdgeInsets.only(left: 15, right: 15),
              width: MediaQuery.of(context).size.width,
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet<void>(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                        ),
                        backgroundColor: Color(0xffFEF9F0),
                        context: context,
                        builder: (BuildContext context) {
                          return Wrap(
                            children: [
                              Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: 20),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'LACAK PESANAN',
                                            style: TextStyle(
                                              fontFamily: 'Brandon',
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          IconButton(
                                            icon: Icon(
                                              Icons.close,
                                              color: Color(0xffF48262),
                                              size: 24,
                                            ),
                                            onPressed: () => Navigator.pop(context),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      color: Color(0xffFEEEE4),
                                      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                                      child: IntrinsicHeight(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Sicepat',
                                                  style: TextStyle(
                                                    fontFamily: 'Brandon',
                                                  ),
                                                ),
                                                Text(
                                                  'No Resi: ID39202020220939',
                                                  style: TextStyle(
                                                    fontFamily: 'Brandon',
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Container(
                                              alignment: Alignment.bottomRight,
                                              child: Text(
                                                'SALIN',
                                                style: TextStyle(
                                                  fontFamily: 'Brandon',
                                                  color: Color(0xffF48262),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      color: Color(0xffFEF9F0),
                                      padding: EdgeInsets.all(20),
                                      child: Column(
                                        children: [
                                          IntrinsicHeight(
                                            child: Row(
                                              children: [
                                                Container(
                                                  padding: EdgeInsets.only(top: 15),
                                                  width: 30,
                                                  alignment: Alignment.topCenter,
                                                  child: Container(
                                                    width: 10,
                                                    height: 10,
                                                    decoration: BoxDecoration(
                                                      color: Color(0xffF48262),
                                                      shape: BoxShape.circle,
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Container(
                                                    padding: EdgeInsets.symmetric(vertical: 10),
                                                    decoration: BoxDecoration(
                                                      border: Border(
                                                        bottom: BorderSide(
                                                          width: 1,
                                                          color: Color(0xffF48262),
                                                        ),
                                                      ),
                                                    ),
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text(
                                                          'Paket sedang dikirim oleh kurir',
                                                          style: TextStyle(
                                                            fontFamily: 'Brandon',
                                                          ),
                                                        ),
                                                        Text(
                                                          '28-10-2020 13.58',
                                                          style: TextStyle(
                                                            fontFamily: 'Brandon',
                                                            color: Color(0xff6D6E71),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          IntrinsicHeight(
                                            child: Row(
                                              children: [
                                                Container(
                                                  padding: EdgeInsets.only(top: 15),
                                                  width: 30,
                                                  alignment: Alignment.topCenter,
                                                  child: Container(
                                                    width: 10,
                                                    height: 10,
                                                    decoration: BoxDecoration(
                                                      color: Color(0xffF48262),
                                                      shape: BoxShape.circle,
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Container(
                                                    padding: EdgeInsets.symmetric(vertical: 10),
                                                    decoration: BoxDecoration(
                                                      border: Border(
                                                        bottom: BorderSide(
                                                          width: 1,
                                                          color: Color(0xffF48262),
                                                        ),
                                                      ),
                                                    ),
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text(
                                                          'Paket telah diterima Pusat Sortir',
                                                          style: TextStyle(
                                                            fontFamily: 'Brandon',
                                                          ),
                                                        ),
                                                        Text(
                                                          '28-10-2020 13.58',
                                                          style: TextStyle(
                                                            fontFamily: 'Brandon',
                                                            color: Color(0xff6D6E71),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          IntrinsicHeight(
                                            child: Row(
                                              children: [
                                                Container(
                                                  padding: EdgeInsets.only(top: 15),
                                                  width: 30,
                                                  alignment: Alignment.topCenter,
                                                  child: Container(
                                                    width: 10,
                                                    height: 10,
                                                    decoration: BoxDecoration(
                                                      color: Color(0xffF48262),
                                                      shape: BoxShape.circle,
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Container(
                                                    padding: EdgeInsets.symmetric(vertical: 10),
                                                    decoration: BoxDecoration(
                                                      border: Border(
                                                        bottom: BorderSide(
                                                          width: 1,
                                                          color: Color(0xffF48262),
                                                        ),
                                                      ),
                                                    ),
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text(
                                                          'Paket telah dikirim dari Ponny Beaute',
                                                          style: TextStyle(
                                                            fontFamily: 'Brandon',
                                                          ),
                                                        ),
                                                        Text(
                                                          '28-10-2020 13.58',
                                                          style: TextStyle(
                                                            fontFamily: 'Brandon',
                                                            color: Color(0xff6D6E71),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
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
                        },
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        // border: Border.all(
                        //   color: Colors.red[500],
                        // ),
                        color: Color(0xffF3C1B5),
                        borderRadius: BorderRadius.all(
                          Radius.circular(5),
                        ),
                      ),
                      width: 160,
                      height: 35,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            child: Text(
                              "Lacak Pesanan",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: "Brandon",
                                color: Colors.white,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                KomplainDalamPerjalananScreen()),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Color(0xffF3C1B5),
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(5),
                        ),
                      ),
                      width: 160,
                      height: 35,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            child: Text(
                              "Komplain",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: "Brandon",
                                color: Colors.black,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: new PonnyBottomNavbar(selectedIndex: 4),
    );
  }
}
