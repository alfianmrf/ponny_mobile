import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:ponny/screens/home_screen.dart';
import 'package:ponny/screens/account_screen.dart';
import 'package:ponny/screens/account/edit_beauty_profile_screen.dart';
import 'package:ponny/widgets/PonnyBottomNavbar.dart';

class EditBeautyProfileScreen extends StatefulWidget {
  static const String id = "edit_beauty_profile_Screen";
  @override
  _EditBeautyProfileStateScreen createState() =>
      _EditBeautyProfileStateScreen();
}

class _EditBeautyProfileStateScreen extends State<EditBeautyProfileScreen> {
  void showAlertDialog(BuildContext context) {
    // set up the AlertDialog
    var container = Container(
      alignment: Alignment.center,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Image.asset(
          "assets/images/kulit-kering.png",
          width: 60,
        ),
      ),
    );
    SimpleDialog alert = SimpleDialog(
      backgroundColor: Color(0xfffdf8f0),
      contentPadding: EdgeInsets.all(0.0),
      children: <Widget>[
        Container(
          // color: Colors.greenAccent,
          margin: EdgeInsets.only(top: 10, bottom: 0),
          child: Column(
            children: [
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      // color: Colors.amberAccent,
                      child: Text(
                        "APA JENIS KULIT KAMU ?",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: "Brandon",
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                // color: Colors.amberAccent,
                child: Row(
                  children: [
                    Container(
                      child: Column(
                        children: [
                          Container(
                            width: 80,
                            height: 80,
                            // color: Colors.blueAccent,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  alignment: Alignment.center,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10.0),
                                    child: Image.asset(
                                      "assets/images/kulit-berminyak.png",
                                      width: 60,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: 80,
                            height: 38,
                            // color: Colors.redAccent,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  child: Text(
                                    "Kulit",
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontFamily: "Brandon",
                                    ),
                                  ),
                                ),
                                Container(
                                  child: Text(
                                    "Berminyak",
                                    style: TextStyle(
                                      fontSize: 11,
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
                      height: 118,
                      width: 240,
                      // color: Colors.purpleAccent,
                      child: Text(
                        'Kulit berminyak ditandai dengan pori-pori besar yang mudah terlihat. Produksi sebum atau minyak pada wajahmu tergolong banyak sehingga kulit wajah akan terlihat berminyak hampir di seluruh bagian wajah.',
                        style: TextStyle(
                          fontFamily: "Brandon",
                          fontSize: 11,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 15),
                // color: Colors.amberAccent,
                child: Row(
                  children: [
                    Container(
                      child: Column(
                        children: [
                          Container(
                            width: 80,
                            height: 80,
                            // color: Colors.blueAccent,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  alignment: Alignment.center,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10.0),
                                    child: Image.asset(
                                      "assets/images/kulit-kombinasi.png",
                                      width: 60,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: 80,
                            height: 38,
                            // color: Colors.redAccent,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  child: Text(
                                    "Kulit",
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontFamily: "Brandon",
                                    ),
                                  ),
                                ),
                                Container(
                                  child: Text(
                                    "Kombinasi",
                                    style: TextStyle(
                                      fontSize: 11,
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
                      height: 118,
                      width: 240,
                      // color: Colors.purpleAccent,
                      child: Text(
                        'Kulit kombinasi ditandai dengan wajah yang berminyak di area dahi, batang hidung, dan dagu (T-Zone) sementara area pipi dan rahang (U-Zone) tergolong kering. Biasanya pori-pori terlihat jelas di area T-Zone.',
                        style: TextStyle(
                          fontFamily: "Brandon",
                          fontSize: 11,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 15),
                // color: Colors.amberAccent,
                child: Row(
                  children: [
                    Container(
                      child: Column(
                        children: [
                          Container(
                            width: 80,
                            height: 80,
                            // color: Colors.blueAccent,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  alignment: Alignment.center,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10.0),
                                    child: Image.asset(
                                      "assets/images/kulit-normal.png",
                                      width: 60,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: 80,
                            height: 38,
                            // color: Colors.redAccent,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  child: Text(
                                    "Kulit",
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontFamily: "Brandon",
                                    ),
                                  ),
                                ),
                                Container(
                                  child: Text(
                                    "Normal",
                                    style: TextStyle(
                                      fontSize: 11,
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
                      height: 118,
                      width: 240,
                      // color: Colors.purpleAccent,
                      child: Text(
                        'Kulit normal ditandai dengan pori-pori kecil. Jenis kulit normal punya produksi minyak yang imbang sehingga kulit wajahmu nggak terlalu berminyak maupun kering.',
                        style: TextStyle(
                          fontFamily: "Brandon",
                          fontSize: 11,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 15),
                // color: Colors.amberAccent,
                child: Row(
                  children: [
                    Container(
                      child: Column(
                        children: [
                          Container(
                            width: 80,
                            height: 80,
                            // color: Colors.blueAccent,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                container,
                              ],
                            ),
                          ),
                          Container(
                            width: 80,
                            height: 38,
                            // color: Colors.redAccent,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  child: Text(
                                    "Kulit",
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontFamily: "Brandon",
                                    ),
                                  ),
                                ),
                                Container(
                                  child: Text(
                                    "Kering",
                                    style: TextStyle(
                                      fontSize: 11,
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
                      height: 118,
                      width: 240,
                      // color: Colors.purpleAccent,
                      child: Text(
                        'Kulit kering ditandai dengan kulit yang bersisik, terasa kencang, gatal, dan kusam. Produksi sebum yang kurang membuat kulit tetap kering sehingga jarang terlihat berminyak.',
                        style: TextStyle(
                          fontFamily: "Brandon",
                          fontSize: 11,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 15),
                // color: Colors.amberAccent,
                child: Row(
                  children: [
                    Container(
                      child: Column(
                        children: [
                          Container(
                            width: 80,
                            height: 80,
                            // color: Colors.blueAccent,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  alignment: Alignment.center,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10.0),
                                    child: Image.asset(
                                      "assets/images/kulit-sensitif.png",
                                      width: 60,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: 80,
                            height: 38,
                            // color: Colors.redAccent,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  child: Text(
                                    "Kulit",
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontFamily: "Brandon",
                                    ),
                                  ),
                                ),
                                Container(
                                  child: Text(
                                    "Sensitif",
                                    style: TextStyle(
                                      fontSize: 11,
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
                      height: 118,
                      width: 240,
                      // color: Colors.purpleAccent,
                      child: Text(
                        'Kulit sensitif ditandai dengan kondisi kulit seperti rosacea, eczema, atau psoriasis. Umumnya kulit sensifitif akan menunjukkan reaksi iritasi seperti kemerahan atau sensasi terbakar setelah mencoba produk skincare baru dengan kandungan seperti fragrance.',
                        style: TextStyle(
                          fontFamily: "Brandon",
                          fontSize: 11,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            decoration: BoxDecoration(
              color: Color(0xffF3C1B5),
              borderRadius: BorderRadius.all(Radius.circular(0)),
            ),
            margin: EdgeInsets.only(top: 20),
            height: 50,
            width: MediaQuery.of(context).size.width,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: Text(
                    "MENGERTI",
                    style: TextStyle(
                      fontFamily: "Brandon",
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

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
                      "Edit Beauty Profile",
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
              margin: EdgeInsets.only(top: 20, left: 20, right: 20),
              padding: EdgeInsets.only(bottom: 5),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Color(0xffF3C1B5),
                    width: 2,
                  ),
                ),
                // color: Colors.cyanAccent,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    // color: Colors.blueAccent,
                    child: Row(
                      children: [
                        Container(
                          child: Text(
                            "WARNA KULIT",
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: "Brandon",
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 1,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    // color: Colors.deepOrangeAccent,
                    padding: EdgeInsets.only(top: 5),
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 10, right: 10),
                          child: Column(
                            children: [
                              Container(
                                // color: Colors.greenAccent,
                                width: 80,
                                height: 50,
                                child: Column(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Hexcolor('#F1D7C3'),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(100)),
                                      ),
                                      width: 50,
                                      height: 50,
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: 80,
                                height: 20,
                                margin: EdgeInsets.only(
                                  top: 1,
                                ),
                                child: Text(
                                  "Putih",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: "Brandon",
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 10),
                          child: Column(
                            children: [
                              Container(
                                // color: Colors.greenAccent,
                                width: 80,
                                height: 50,
                                child: Column(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Hexcolor('#F5CEA9'),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(100)),
                                      ),
                                      width: 50,
                                      height: 50,
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: 80,
                                height: 20,
                                margin: EdgeInsets.only(
                                  top: 1,
                                ),
                                child: Text(
                                  "Kuning Langsat",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: "Brandon",
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 10),
                          child: Column(
                            children: [
                              Container(
                                // color: Colors.greenAccent,
                                width: 80,
                                height: 50,
                                child: Column(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Hexcolor('#E0A16E'),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(100)),
                                      ),
                                      width: 50,
                                      height: 50,
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: 80,
                                height: 20,
                                margin: EdgeInsets.only(
                                  top: 1,
                                ),
                                child: Text(
                                  "Sawo Matang",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: "Brandon",
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(),
                          child: Column(
                            children: [
                              Container(
                                // color: Colors.greenAccent,
                                width: 80,
                                height: 50,
                                child: Column(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Hexcolor('#6A4332'),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(100)),
                                      ),
                                      width: 50,
                                      height: 50,
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: 80,
                                height: 20,
                                margin: EdgeInsets.only(
                                  top: 1,
                                ),
                                child: Text(
                                  "Gelap",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: "Brandon",
                                    fontSize: 12,
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
            Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              padding: EdgeInsets.only(top: 10, bottom: 15),
              decoration: BoxDecoration(
                // color: Colors.greenAccent,
                border: Border(
                  bottom: BorderSide(
                    color: Color(0xffF3C1B5),
                    width: 2,
                  ),
                ),
                // color: Colors.cyanAccent,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    // color: Colors.blueAccent,
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                            left: 10,
                          ),
                          child: Text(
                            "JENIS KULIT",
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: "Brandon",
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 1,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    // color: Colors.redAccent,
                    // color: Colors.blueAccent,
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                            left: 10,
                          ),
                          child: Text(
                            "Apa jenis kulit kamu ?",
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: "Yeseva",
                              fontSize: 10,
                              fontWeight: FontWeight.w200,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 5),
                          child: GestureDetector(
                            onTap: () {
                              showAlertDialog(context);
                            },
                            child: Text(
                              "Pelajari",
                              style: TextStyle(
                                color: Color(0xffF3C1B5),
                                fontFamily: "Yeseva",
                                fontSize: 10,
                                fontWeight: FontWeight.w200,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5),
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Color(0xffF3C1B5),
                              width:
                                  1, //                   <--- border width here
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(7)),
                          ),
                          margin: EdgeInsets.only(left: 8, top: 5, right: 13),
                          width: 60,
                          height: 107,
                          child: Column(
                            children: [
                              Container(
                                width: 70,
                                height: 70,
                                child: Image.asset(
                                  "assets/images/kulit-normal.png",
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Container(
                                color: Color(0xffF3C1B5),
                                width: 70,
                                height: 35,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      child: Text(
                                        "Normal",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontFamily: "Brandon",
                                          fontSize: 10,
                                          color: Colors.white,
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
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Color(0xffF3C1B5),
                              width:
                                  1, //                   <--- border width here
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(7)),
                          ),
                          margin: EdgeInsets.only(top: 5, right: 13),
                          width: 60,
                          height: 107,
                          child: Column(
                            children: [
                              Container(
                                width: 70,
                                height: 70,
                                child: Image.asset(
                                  "assets/images/kulit-kering.png",
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Container(
                                color: Color(0xffF3C1B5),
                                width: 70,
                                height: 35,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      child: Text(
                                        "Kering",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontFamily: "Brandon",
                                          fontSize: 10,
                                          color: Colors.white,
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
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Color(0xffF3C1B5),
                              width:
                                  1, //                   <--- border width here
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(7)),
                          ),
                          margin: EdgeInsets.only(top: 5, right: 13),
                          width: 60,
                          height: 107,
                          child: Column(
                            children: [
                              Container(
                                width: 70,
                                height: 70,
                                child: Image.asset(
                                  "assets/images/kulit-berminyak.png",
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Container(
                                color: Color(0xffF3C1B5),
                                width: 70,
                                height: 35,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      child: Text(
                                        "Berminyak",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontFamily: "Brandon",
                                          fontSize: 10,
                                          color: Colors.white,
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
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Color(0xffF3C1B5),
                              width:
                                  1, //                   <--- border width here
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(7)),
                          ),
                          margin: EdgeInsets.only(top: 5, right: 13),
                          width: 60,
                          height: 107,
                          child: Column(
                            children: [
                              Container(
                                width: 70,
                                height: 70,
                                child: Image.asset(
                                  "assets/images/kulit-kombinasi.png",
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Container(
                                color: Color(0xffF3C1B5),
                                width: 70,
                                height: 35,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      child: Text(
                                        "Kombinasi",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontFamily: "Brandon",
                                          fontSize: 10,
                                          color: Colors.white,
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
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Color(0xffF3C1B5),
                              width:
                                  1, //                   <--- border width here
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(7)),
                          ),
                          margin: EdgeInsets.only(
                            top: 5,
                          ),
                          width: 60,
                          height: 107,
                          child: Column(
                            children: [
                              Container(
                                width: 70,
                                height: 70,
                                child: Image.asset(
                                  "assets/images/kulit-sensitif.png",
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Container(
                                color: Color(0xffF3C1B5),
                                width: 70,
                                height: 35,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      child: Text(
                                        "Sensitif",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontFamily: "Brandon",
                                          fontSize: 10,
                                          color: Colors.white,
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
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              padding: EdgeInsets.only(top: 10, bottom: 15),
              decoration: BoxDecoration(
                // color: Colors.greenAccent,
                border: Border(
                  bottom: BorderSide(
                    color: Color(0xffF3C1B5),
                    width: 2,
                  ),
                ),
                // color: Colors.cyanAccent,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    // color: Colors.blueAccent,
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                            left: 10,
                          ),
                          child: Text(
                            "KONDISI KULIT",
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: "Brandon",
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 1,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    // color: Colors.redAccent,
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                            left: 10,
                          ),
                          child: Text(
                            "Bisa pilih lebih dari satu",
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: "Yeseva",
                              fontSize: 10,
                              fontWeight: FontWeight.w200,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5),
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Color(0xffF3C1B5),
                              width:
                                  1, //                   <--- border width here
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(7)),
                          ),
                          margin: EdgeInsets.only(left: 8, top: 5, right: 13),
                          width: 60,
                          height: 107,
                          child: Column(
                            children: [
                              Container(
                                width: 70,
                                height: 70,
                                child: Image.asset(
                                  "assets/images/jerawat.png",
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Container(
                                color: Color(0xffF3C1B5),
                                width: 70,
                                height: 35,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      child: Text(
                                        "Jerawat",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontFamily: "Brandon",
                                          fontSize: 10,
                                          color: Colors.white,
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
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Color(0xffF3C1B5),
                              width:
                                  1, //                   <--- border width here
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(7)),
                          ),
                          margin: EdgeInsets.only(top: 5, right: 13),
                          width: 60,
                          height: 107,
                          child: Column(
                            children: [
                              Container(
                                width: 70,
                                height: 70,
                                child: Image.asset(
                                  "assets/images/keriput.png",
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Container(
                                color: Color(0xffF3C1B5),
                                width: 70,
                                height: 35,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      child: Column(
                                        children: [
                                          Container(
                                            child: Text(
                                              "Garis Halus",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontFamily: "Brandon",
                                                fontSize: 10,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            child: Text(
                                              "/ Keriput",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontFamily: "Brandon",
                                                fontSize: 10,
                                                color: Colors.white,
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
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Color(0xffF3C1B5),
                              width:
                                  1, //                   <--- border width here
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(7)),
                          ),
                          margin: EdgeInsets.only(top: 5, right: 13),
                          width: 60,
                          height: 107,
                          child: Column(
                            children: [
                              Container(
                                width: 70,
                                height: 70,
                                child: Image.asset(
                                  "assets/images/komedo.png",
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Container(
                                color: Color(0xffF3C1B5),
                                width: 70,
                                height: 35,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      child: Text(
                                        "Komedo",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontFamily: "Brandon",
                                          fontSize: 10,
                                          color: Colors.white,
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
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Color(0xffF3C1B5),
                              width:
                                  1, //                   <--- border width here
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(7)),
                          ),
                          margin: EdgeInsets.only(top: 5, right: 13),
                          width: 60,
                          height: 107,
                          child: Column(
                            children: [
                              Container(
                                width: 70,
                                height: 70,
                                child: Image.asset(
                                  "assets/images/pori-besar.png",
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Container(
                                color: Color(0xffF3C1B5),
                                width: 70,
                                height: 35,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      child: Text(
                                        "Pori Besar",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontFamily: "Brandon",
                                          fontSize: 10,
                                          color: Colors.white,
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
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Color(0xffF3C1B5),
                              width:
                                  1, //                   <--- border width here
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(7)),
                          ),
                          margin: EdgeInsets.only(
                            top: 5,
                          ),
                          width: 60,
                          height: 107,
                          child: Column(
                            children: [
                              Container(
                                width: 70,
                                height: 70,
                                child: Image.asset(
                                  "assets/images/kulit-kusam.png",
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Container(
                                color: Color(0xffF3C1B5),
                                width: 70,
                                height: 35,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      child: Text(
                                        "Kulit Kusam",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontFamily: "Brandon",
                                          fontSize: 10,
                                          color: Colors.white,
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
                  Container(
                    margin: EdgeInsets.only(top: 5),
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Color(0xffF3C1B5),
                              width:
                                  1, //                   <--- border width here
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(7)),
                          ),
                          margin: EdgeInsets.only(left: 8, top: 5, right: 13),
                          width: 60,
                          height: 107,
                          child: Column(
                            children: [
                              Container(
                                width: 70,
                                height: 70,
                                child: Image.asset(
                                  "assets/images/darkspot.png",
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Container(
                                color: Color(0xffF3C1B5),
                                width: 70,
                                height: 35,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      child: Text(
                                        "Dark Spot",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontFamily: "Brandon",
                                          fontSize: 10,
                                          color: Colors.white,
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
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Color(0xffF3C1B5),
                              width:
                                  1, //                   <--- border width here
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(7)),
                          ),
                          margin: EdgeInsets.only(top: 5, right: 13),
                          width: 60,
                          height: 107,
                          child: Column(
                            children: [
                              Container(
                                width: 70,
                                height: 70,
                                child: Image.asset(
                                  "assets/images/kantung-mata.png",
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Container(
                                color: Color(0xffF3C1B5),
                                width: 70,
                                height: 35,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      child: Column(
                                        children: [
                                          Container(
                                            child: Text(
                                              "Kantung",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontFamily: "Brandon",
                                                fontSize: 10,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            child: Text(
                                              "Mata",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontFamily: "Brandon",
                                                fontSize: 10,
                                                color: Colors.white,
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
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Color(0xffF3C1B5),
                              width:
                                  1, //                   <--- border width here
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(7)),
                          ),
                          margin: EdgeInsets.only(top: 5, right: 13),
                          width: 60,
                          height: 107,
                          child: Column(
                            children: [
                              Container(
                                width: 70,
                                height: 70,
                                child: Image.asset(
                                  "assets/images/kemerahan.png",
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Container(
                                color: Color(0xffF3C1B5),
                                width: 70,
                                height: 35,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      child: Text(
                                        "Kemerahan",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontFamily: "Brandon",
                                          fontSize: 10,
                                          color: Colors.white,
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
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Color(0xffF3C1B5),
                              width:
                                  1, //                   <--- border width here
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(7)),
                          ),
                          margin: EdgeInsets.only(top: 5, right: 13),
                          width: 60,
                          height: 107,
                          child: Column(
                            children: [
                              Container(
                                width: 70,
                                height: 70,
                                child: Image.asset(
                                  "assets/images/flek.png",
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Container(
                                color: Color(0xffF3C1B5),
                                width: 70,
                                height: 35,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      child: Text(
                                        "Flek",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontFamily: "Brandon",
                                          fontSize: 10,
                                          color: Colors.white,
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
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              padding: EdgeInsets.only(top: 10, bottom: 15),
              decoration: BoxDecoration(
                // color: Colors.greenAccent,
                border: Border(
                  bottom: BorderSide(
                    color: Color(0xffF3C1B5),
                    width: 2,
                  ),
                ),
                // color: Colors.cyanAccent,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    // color: Colors.blueAccent,
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                            left: 10,
                          ),
                          child: Text(
                            "KONDISI RAMBUT",
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: "Brandon",
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 1,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    // color: Colors.redAccent,
                    // color: Colors.blueAccent,
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                            left: 10,
                          ),
                          child: Text(
                            "Bisa pilih lebih dari satu",
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: "Yeseva",
                              fontSize: 10,
                              fontWeight: FontWeight.w200,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5),
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Color(0xffF3C1B5),
                              width:
                                  1, //                   <--- border width here
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(7)),
                          ),
                          margin: EdgeInsets.only(left: 8, top: 5, right: 13),
                          width: 60,
                          height: 107,
                          child: Column(
                            children: [
                              Container(
                                width: 70,
                                height: 70,
                                child: Image.asset(
                                  "assets/images/ketombe.png",
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Container(
                                color: Color(0xffF3C1B5),
                                width: 70,
                                height: 35,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      child: Text(
                                        "Ketombe",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontFamily: "Brandon",
                                          fontSize: 10,
                                          color: Colors.white,
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
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Color(0xffF3C1B5),
                              width:
                                  1, //                   <--- border width here
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(7)),
                          ),
                          margin: EdgeInsets.only(top: 5, right: 13),
                          width: 60,
                          height: 107,
                          child: Column(
                            children: [
                              Container(
                                width: 70,
                                height: 70,
                                child: Image.asset(
                                  "assets/images/rontok.png",
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Container(
                                color: Color(0xffF3C1B5),
                                width: 70,
                                height: 35,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      child: Text(
                                        "Rontok",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontFamily: "Brandon",
                                          fontSize: 10,
                                          color: Colors.white,
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
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Color(0xffF3C1B5),
                              width:
                                  1, //                   <--- border width here
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(7)),
                          ),
                          margin: EdgeInsets.only(top: 5, right: 13),
                          width: 60,
                          height: 107,
                          child: Column(
                            children: [
                              Container(
                                width: 70,
                                height: 70,
                                child: Image.asset(
                                  "assets/images/bercabang.png",
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Container(
                                color: Color(0xffF3C1B5),
                                width: 70,
                                height: 35,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      child: Text(
                                        "Bercabang",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontFamily: "Brandon",
                                          fontSize: 10,
                                          color: Colors.white,
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
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Color(0xffF3C1B5),
                              width:
                                  1, //                   <--- border width here
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(7)),
                          ),
                          margin: EdgeInsets.only(top: 5, right: 13),
                          width: 60,
                          height: 107,
                          child: Column(
                            children: [
                              Container(
                                width: 70,
                                height: 70,
                                child: Image.asset(
                                  "assets/images/kusut.png",
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Container(
                                color: Color(0xffF3C1B5),
                                width: 70,
                                height: 35,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      child: Text(
                                        "Kusut",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontFamily: "Brandon",
                                          fontSize: 10,
                                          color: Colors.white,
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
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Color(0xffF3C1B5),
                              width:
                                  1, //                   <--- border width here
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(7)),
                          ),
                          margin: EdgeInsets.only(
                            top: 5,
                          ),
                          width: 60,
                          height: 107,
                          child: Column(
                            children: [
                              Container(
                                width: 70,
                                height: 70,
                                child: Image.asset(
                                  "assets/images/kusam.png",
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Container(
                                color: Color(0xffF3C1B5),
                                width: 70,
                                height: 35,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      child: Text(
                                        "Kusam",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontFamily: "Brandon",
                                          fontSize: 10,
                                          color: Colors.white,
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
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              padding: EdgeInsets.only(top: 10, bottom: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    // color: Colors.blueAccent,
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                            left: 10,
                          ),
                          child: Text(
                            "PREFERENSI PRODUK",
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: "Brandon",
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 1,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    // color: Colors.redAccent,
                    // color: Colors.blueAccent,
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                            left: 10,
                          ),
                          child: Text(
                            "Bisa pilih lebih dari satu",
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: "Yeseva",
                              fontSize: 10,
                              fontWeight: FontWeight.w200,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5),
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Color(0xffF3C1B5),
                              width:
                                  1, //                   <--- border width here
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(7)),
                          ),
                          margin: EdgeInsets.only(left: 8, top: 5, right: 13),
                          width: 60,
                          height: 107,
                          child: Column(
                            children: [
                              Container(
                                width: 70,
                                height: 70,
                                child: Image.asset(
                                  "assets/images/indonesia.png",
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Container(
                                color: Color(0xffF3C1B5),
                                width: 70,
                                height: 35,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      child: Text(
                                        "Lokal",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontFamily: "Brandon",
                                          fontSize: 10,
                                          color: Colors.white,
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
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Color(0xffF3C1B5),
                              width:
                                  1, //                   <--- border width here
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(7)),
                          ),
                          margin: EdgeInsets.only(top: 5, right: 13),
                          width: 60,
                          height: 107,
                          child: Column(
                            children: [
                              Container(
                                width: 70,
                                height: 70,
                                child: Image.asset(
                                  "assets/images/korea.png",
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Container(
                                color: Color(0xffF3C1B5),
                                width: 70,
                                height: 35,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      child: Text(
                                        "Korean",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontFamily: "Brandon",
                                          fontSize: 10,
                                          color: Colors.white,
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
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Color(0xffF3C1B5),
                              width:
                                  1, //                   <--- border width here
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(7)),
                          ),
                          margin: EdgeInsets.only(top: 5, right: 13),
                          width: 60,
                          height: 107,
                          child: Column(
                            children: [
                              Container(
                                width: 70,
                                height: 70,
                                child: Image.asset(
                                  "assets/images/amerika.png",
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Container(
                                color: Color(0xffF3C1B5),
                                width: 70,
                                height: 35,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      child: Text(
                                        "Western",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontFamily: "Brandon",
                                          fontSize: 10,
                                          color: Colors.white,
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
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Color(0xffF3C1B5),
                borderRadius: BorderRadius.all(Radius.circular(5)),
              ),
              margin: EdgeInsets.only(
                left: 20,
                right: 20,
                top: 40,
                bottom: 40,
              ),
              padding: EdgeInsets.only(top: 15, bottom: 15),
              child: Column(
                children: [
                  Container(
                    child: Text(
                      "SIMPAN",
                      style: TextStyle(
                        fontFamily: "Brandon",
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
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
