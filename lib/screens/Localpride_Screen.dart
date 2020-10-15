import 'package:flutter/material.dart';
import 'package:ponny/screens/Browse_Screen.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:ponny/screens/product_details_screen.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:ponny/widgets/PonnyBottomNavbar.dart';

class LocalPride extends StatefulWidget {
  LocalPride({Key key}) : super(key: key);

  @override
  _LocalPrideState createState() => _LocalPrideState();
}

class _LocalPrideState extends State<LocalPride> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Hexcolor('#FCF8F0'),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Colors.white),
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.only(left: 10, top: 10, right: 10),
                child: Row(children: [
                  Icon(Icons.search, color: Color(0xffF48262)),
                  Expanded(
                      child: TextField(
                    cursorColor: Colors.black,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.go,
                    decoration:
                        new InputDecoration.collapsed(hintText: "Search..."),
                  ))
                ]),
              ),
              Container(
                margin: EdgeInsets.all(5),
                child: Row(
                  children: [
                    Container(
                      child: IconButton(
                          onPressed: () {
                            Navigator.of(context)
                                .pushReplacementNamed(Browse.id);
                          },
                          icon: Icon(
                            Icons.arrow_back_ios,
                            color: Color(0xffF48262),
                            size: 26,
                          )),
                    ),
                    Container(
                      child: Text(
                        "Local Pride",
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
                width: double.infinity,
                child: Image.network(
                  "http://via.placeholder.com/288x188",
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                margin: EdgeInsets.all(20),
                child: Text(
                  "Produk Unggulan",
                  style: TextStyle(
                    fontSize: 22,
                    fontFamily: "Yeseva",
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    color: Colors.grey,
                    height: 70,
                    width: 70,
                  ),
                  Container(
                    color: Colors.grey,
                    height: 70,
                    width: 70,
                  ),
                  Container(
                    color: Colors.grey,
                    height: 70,
                    width: 70,
                  ),
                  Container(
                    color: Colors.grey,
                    height: 70,
                    width: 70,
                  ),
                ],
              ),
              Container(
                margin:
                    EdgeInsets.only(top: 20, bottom: 10, left: 20, right: 20),
                height: 1,
                color: Color(0xffF3C1B5),
              ),
              Container(
                margin: EdgeInsets.all(20),
                child: Text(
                  "Kenapa Produk Lokal?",
                  style: TextStyle(
                    fontSize: 22,
                    fontFamily: "Yeseva",
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: 150,
                    width: 100,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          color: Colors.grey,
                          height: 70,
                          width: 70,
                        ),
                        Text(
                          "Sesuai Kondisi Kulit Indonesia",
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: 150,
                    width: 90,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          color: Colors.grey,
                          height: 70,
                          width: 70,
                        ),
                        Text(
                          "Harga Ramah di Kantong",
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: 150,
                    width: 90,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          color: Colors.grey,
                          height: 70,
                          width: 70,
                        ),
                        Text(
                          "Dukung Kreasi Anak Bangsa",
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                margin:
                    EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
                height: 1,
                color: Color(0xffF3C1B5),
              ),
              Container(
                margin: EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Produk Rekomendasi",
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: "Yeseva",
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                    InkWell(
                      child: Text(
                        "view more",
                        style: TextStyle(
                            color: Colors.blue,
                            decoration: TextDecoration.underline),
                      ),
                      onTap: () {},
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Flexible(
                      child: Container(
                          margin: EdgeInsets.only(left: 5, right: 5),
                          child: product(context))),
                  Flexible(
                      child: Container(
                          margin: EdgeInsets.only(left: 5, right: 5),
                          child: product(context))),
                  Flexible(
                      child: Container(
                          margin: EdgeInsets.only(left: 5, right: 5),
                          child: product(context))),
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 20, bottom: 20),
                height: 1,
                color: Color(0xffF3C1B5),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Flexible(
                        child: Container(
                            margin: EdgeInsets.only(left: 5, right: 5),
                            child: product(context))),
                    Flexible(
                        child: Container(
                            margin: EdgeInsets.only(left: 5, right: 5),
                            child: product(context))),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: new PonnyBottomNavbar(selectedIndex: 1),
      ),
    );
  }
}

Widget product(context) {
  return Column(
    children: <Widget>[
      Container(
        child: Stack(
          children: <Widget>[
            GestureDetector(
              onTap: () {
                Navigator.of(context)
                    .pushReplacementNamed(ProductDetailsScreen.id);
              },
              child: Image.asset(
                "assets/images/produk.png",
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10.0),
              child: Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.0),
                      child: const Text(
                        '35%',
                        style: TextStyle(
                            color: Colors.white, fontFamily: 'Brandon'),
                      ),
                    ),
                    color: Color(0xffF48262),
                  )),
            ),
            Padding(
              padding: EdgeInsets.all(5.0),
              child: Align(
                alignment: Alignment.topRight,
                child: Icon(
                  Icons.favorite_border,
                  color: Color(0xffF48262),
                  size: 20,
                ),
              ),
            ),
          ],
        ),
      ),
      Container(
        alignment: Alignment.bottomCenter,
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: const Text(
            'ADD TO BAG',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontFamily: 'Brandon'),
          ),
          color: Color(0xffF3C1B5),
        ),
      ),
      Padding(
        padding: EdgeInsets.only(top: 7.0),
        child: Text(
          'Skin Game',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Yeseva',
            fontSize: 16,
          ),
        ),
      ),
      Text(
        'Acne Warrior',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontFamily: 'Brandon',
          fontSize: 14,
        ),
      ),
      Text(
        'Rp. 125.000',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontFamily: 'Brandon',
          fontSize: 14,
        ),
      ),
      Center(
        child: RichText(
          text: TextSpan(
              text: 'Rp. 125.000',
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'Brandon',
                fontSize: 12,
                decoration: TextDecoration.lineThrough,
              ),
              children: [
                TextSpan(
                  text: '(35%)',
                  style: TextStyle(
                    color: Color(0xffF48262),
                    fontFamily: 'Brandon',
                    fontSize: 12,
                    decoration: TextDecoration.none,
                  ),
                ),
              ]),
        ),
      ),
      Text.rich(TextSpan(children: <InlineSpan>[
        WidgetSpan(
          child: RatingBar(
            initialRating: 4,
            minRating: 1,
            direction: Axis.horizontal,
            allowHalfRating: true,
            itemCount: 5,
            itemSize: 14.0,
            itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
            itemBuilder: (context, index) => Icon(
              Icons.favorite,
              color: Color(0xffF48262),
            ),
            unratedColor: Color(0xffFBD2CD),
          ),
        ),
        TextSpan(
            text: '(5)',
            style: TextStyle(
              fontSize: 12,
            ))
      ])),
    ],
  );
}