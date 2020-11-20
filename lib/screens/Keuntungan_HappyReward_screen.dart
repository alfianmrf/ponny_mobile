import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:ponny/common/constant.dart';
import 'package:ponny/model/User.dart';
import 'package:ponny/screens/account/happy_skin_reward_screen.dart';
import 'package:ponny/widgets/PonnyBottomNavbar.dart';
import 'package:ponny/screens/product_details_screen.dart';
import 'package:gradient_text/gradient_text.dart';
import 'package:provider/provider.dart';

class UntungReward extends StatefulWidget {
  static const String id = "UntungReward";

  @override
  _UntungRewardState createState() => _UntungRewardState();
}

class _UntungRewardState extends State<UntungReward> {

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel>(context).user;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Hexcolor('#FCF8F0'),
        body: Column(
          children: [
            Container(
              height: 35,
            ),
            Container(
              margin: EdgeInsets.all(5),
              child: Row(
                children: [
                  Flexible(
                    child: Container(
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
                  ),
                  Flexible(
                    flex: 4,
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        "Keuntungan Happy Skin Reward",
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: "Yeseva",
                          fontWeight: FontWeight.w500,
                          color: Color(0xffF48262),
                        ),
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
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: double.infinity,
                      color: Color(0xffF3C1B5),
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Column(
                        children: [
                          FittedBox(
                            fit: BoxFit.fitWidth,
                            child: Text(
                              "Happy Skin Reward",
                              style: TextStyle(
                                fontSize: 24,
                                fontFamily: "Yeseva",
                              ),
                            ),
                          ),
                          Container(height: 20),
                          FittedBox(
                            fit: BoxFit.fitWidth,
                            child: Text(
                              user.name+" "+user.last_name,
                              style: TextStyle(
                                fontSize: 18,
                                fontFamily: "Brandon",
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: FittedBox(
                                        fit: BoxFit.fitWidth,
                                        child: Text(
                                          user.dashboard.membershipTitle
                                              .toUpperCase(),
                                          style: TextStyle(
                                              color: Hexcolor('#b08d00'),
                                              fontSize: 24,
                                              fontFamily: "Brandon",
                                              fontWeight: FontWeight.w800),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                        flex: 3,
                                        child: new LinearPercentIndicator(
                                          percent: user.dashboard.percent / 100,
                                          progressColor: Colors.red,
                                          backgroundColor: Color(0xffF3B5B5),
                                        )),
                                    Expanded(
                                      child: FittedBox(
                                        fit: BoxFit.fitWidth,
                                        child: Text(
                                          user.dashboard.next.toUpperCase(),
                                          style: TextStyle(
                                              color: Hexcolor('#b08d00'),
                                              fontSize: 24,
                                              fontFamily: "Brandon",
                                              fontWeight: FontWeight.w800),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                FittedBox(
                                  fit: BoxFit.fitWidth,
                                  child: Text(
                                    "Belanja "+
                                      nm_format
                                      .format(user.dashboard.toNext) +" lagi untuk naik tingkat ke " + user.dashboard.next + " Skin",
                                    style: TextStyle(
                                        fontSize: 10,
                                        fontFamily: "Brandon",
                                        fontWeight: FontWeight.w800),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      margin:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                      child: Text(
                        "Wujudkan impian happy skin dan dapatkan keuntungan menarik lainnya melalui poin yang kamu dapatkan",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: "Brandon",
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(10),
                      child: Text(
                        "REWARD",
                        style: TextStyle(
                            fontSize: 24,
                            fontFamily: "Yeseva",
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Text(
                        "Tukarkan poin yang sudah dikumpulkan dan pilih hadiah yang kamu suka.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 14,
                            fontFamily: "Brandon",
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    Row(
                      children: [
                        Flexible(
                            child: Container(
                                margin: EdgeInsets.all(20),
                                child: product(context))),
                        Flexible(
                            child: Container(
                                margin: EdgeInsets.all(20),
                                child: product(context)))
                      ],
                    ),
                    InkWell(
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  HappySkinRewardScreen()),

                        );
                      },
                      child: Container(
                        margin: EdgeInsets.only(bottom: 20),
                        alignment: Alignment.center,
                        child: Text("Lihat Semua Rewards",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 18,
                                fontFamily: "Brandon",
                                fontWeight: FontWeight.w500,
                                color: Color(0xffF48262))),
                      ),
                    )
                    ,
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      height: 1,
                      color: Color(0xffF3C1B5),
                    ),
                    Container(
                      margin: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(bottom: 20),
                            alignment: Alignment.center,
                            child: Text(
                              "KUMPULKAN POIN",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 24,
                                fontFamily: "Yeseva",
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 20),
                            alignment: Alignment.center,
                            child: Text(
                              "Dapatkan keuntungan menarik lainnya melalui poin yang bisa kamu dapatkan dengan cara-cara berikut:",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: "Brandon",
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                  child: Align(
                                child: AspectRatio(
                                  aspectRatio: 1 / 1,
                                  child: Container(
                                      margin: EdgeInsets.all(5),
                                      child: buttonGroups(
                                          "assets/images/Asset 8.png",
                                          "Belanja",
                                          "Dapatkan 10 poin\n setiap pembelanjaan\n senilai Rp.25.000")),
                                ),
                              )),
                              Expanded(
                                  child: Align(
                                child: AspectRatio(
                                  aspectRatio: 1 / 1,
                                  child: Container(
                                      margin: EdgeInsets.all(5),
                                      child: buttonGroups(
                                          "assets/images/Asset 7.png",
                                          "Daftar Akun",
                                          "Dapatkan 50 poin\n dengan membuat\n akun")),
                                ),
                              )),
                              Expanded(
                                  child: Align(
                                child: AspectRatio(
                                  aspectRatio: 1 / 1,
                                  child: Container(
                                      margin: EdgeInsets.all(5),
                                      child: buttonGroups(
                                          "assets/images/Asset 12.png",
                                          "Lengkapi Beauty\n Profile",
                                          "Dapatkan 50 poin\n setelah melengkapi\n beauty profile")),
                                ),
                              )),
                            ],
                          ),
                          Container(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Expanded(
                                  child: Align(
                                child: AspectRatio(
                                  aspectRatio: 1 / 1,
                                  child: Container(
                                      margin: EdgeInsets.all(5),
                                      child: buttonGroups(
                                          "assets/images/Asset 15.png",
                                          "Ulang Tahun",
                                          "Dapatkan poin 2\n kali lebih banyak\n saat belanja di\n hari ulang tahun")),
                                ),
                              )),
                              Expanded(
                                  child: Align(
                                child: AspectRatio(
                                  aspectRatio: 1 / 1,
                                  child: Container(
                                      margin: EdgeInsets.all(5),
                                      child: buttonGroups(
                                          "assets/images/Asset 22.png",
                                          "Tulis Ulasan\n Produk",
                                          "Dapatkan 25 poin\n setiap meninggalkan\n satu ulasan")),
                                ),
                              )),
                              Expanded(
                                  child: Align(
                                child: AspectRatio(
                                  aspectRatio: 1 / 1,
                                  child: Container(
                                      margin: EdgeInsets.all(5),
                                      child: buttonGroups(
                                          "assets/images/Asset 7.png",
                                          "Download\n Mobile App",
                                          "Dapatkan 30 poin\n dengan mengunduh\n aplikasi Ponny Beaute")),
                                ),
                              )),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                      height: 1,
                      color: Color(0xffF3C1B5),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 20),
                      alignment: Alignment.center,
                      child: Text(
                        "LEVEL\n HAPPY SKIN REWARD",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 24,
                          fontFamily: "Yeseva",
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    tableLevelReward(context),
                    Container(
                      margin:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                      height: 1,
                      color: Color(0xffF3C1B5),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 20),
                      alignment: Alignment.center,
                      child: Text(
                        "CARA MENDAPATKAN\nKEUNTUNGAN",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 24,
                          fontFamily: "Yeseva",
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Flexible(
                          fit: FlexFit.loose,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Flexible(
                                fit: FlexFit.loose,
                                child: Container(
                                  margin: EdgeInsets.all(10),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Flexible(
                                          fit: FlexFit.loose,
                                          child: Image.asset(
                                              "assets/images/Asset 11.png")),
                                      Flexible(
                                        fit: FlexFit.loose,
                                        child: FittedBox(
                                          child: Text(
                                            "BUAT AKUN",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontFamily: "Brandon",
                                              fontWeight: FontWeight.w800,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Flexible(
                                        fit: FlexFit.loose,
                                        child: FittedBox(
                                          child: Text(
                                            "Daftar dengan alamat\nemail aktif",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontFamily: "Brandon",
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Flexible(
                                fit: FlexFit.loose,
                                child: Container(
                                  margin: EdgeInsets.all(10),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Flexible(
                                          fit: FlexFit.loose,
                                          child: Image.asset(
                                              "assets/images/Asset 11.png")),
                                      Flexible(
                                        fit: FlexFit.loose,
                                        child: FittedBox(
                                          child: Text(
                                            "KUMPULKAN POIN",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontFamily: "Brandon",
                                              fontWeight: FontWeight.w800,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Flexible(
                                        fit: FlexFit.loose,
                                        child: FittedBox(
                                          child: Text(
                                            "Dengan terus belanja\ndan beragam cara lainnya",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontFamily: "Brandon",
                                            ),
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
                        Flexible(
                          fit: FlexFit.loose,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Flexible(
                                fit: FlexFit.loose,
                                child: Container(
                                  margin: EdgeInsets.all(10),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Flexible(
                                          fit: FlexFit.loose,
                                          child: Image.asset(
                                              "assets/images/Asset 11.png")),
                                      Flexible(
                                        fit: FlexFit.loose,
                                        child: FittedBox(
                                          child: Text(
                                            "DAPATKAN HADIAH",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontFamily: "Brandon",
                                              fontWeight: FontWeight.w800,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Flexible(
                                        fit: FlexFit.loose,
                                        child: FittedBox(
                                          child: Text(
                                            "Tukarkan poin dengan\nberbagai hadiah eksklusif",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontFamily: "Brandon",
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Flexible(
                                fit: FlexFit.loose,
                                child: Container(
                                  margin: EdgeInsets.all(10),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Flexible(
                                          fit: FlexFit.loose,
                                          child: Image.asset(
                                              "assets/images/Asset 11.png")),
                                      Flexible(
                                        fit: FlexFit.loose,
                                        child: FittedBox(
                                          child: Text(
                                            "NAIK TINGKAT",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontFamily: "Brandon",
                                              fontWeight: FontWeight.w800,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Flexible(
                                        fit: FlexFit.loose,
                                        child: FittedBox(
                                          child: Text(
                                            "Tingkatkan level membership\nuntuk dapat keuntungan lebih",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontFamily: "Brandon",
                                            ),
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
                    Container(
                      margin:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                      height: 1,
                      color: Color(0xffF3C1B5),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 20),
                      child: Text(
                        "FAQs",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 24,
                          fontFamily: "Yeseva",
                        ),
                      ),
                    ),
                    faqCollapsed(),
                    faqCollapsed(),
                    faqCollapsed(),
                    Container(
                      height: 20,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: new PonnyBottomNavbar(selectedIndex: 4));
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

Widget buttonGroups(String iconImg, String title, String subtitle) {
  return ButtonTheme(
    buttonColor: Hexcolor('#FCF8F0'),
    minWidth: 150.0,
    height: 150.0,
    child: RaisedButton(
      onPressed: () {},
      child: Container(
        padding: EdgeInsets.all(5),
        child: Column(
          children: [
            Expanded(flex: 1, child: Image.asset(iconImg)),
            Expanded(
              flex: 1,
              child: FittedBox(
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 11,
                    fontFamily: 'Brandon',
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: FittedBox(
                child: Text(
                  subtitle,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 11,
                    fontFamily: 'Brandon',
                    letterSpacing: 1,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(5.0),
      side: BorderSide(color: Color(0xffF3C1B5)),
    ),
  );
}

Widget faqCollapsed() {
  bool isCollapsed = true;

  return StatefulBuilder(
    builder: (BuildContext context, setState) {
      return Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Apa itu Happy Skin Reward?",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'Brandon',
                    letterSpacing: 1,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                IconButton(
                  icon: isCollapsed ? Icon(Icons.add) : Icon(Icons.remove),
                  color: Color(0xffF48262),
                  onPressed: () {
                    setState(() {
                      isCollapsed = !isCollapsed;
                    });
                  },
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            height: 1,
            color: Color(0xffF3C1B5),
          ),
          isCollapsed
              ? Container()
              : Container(
                  margin: EdgeInsets.symmetric(horizontal: 30),
                  child: Text(
                    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'Brandon',
                      letterSpacing: 1,
                    ),
                  ),
                ),
        ],
      );
    },
  );
}

Widget tableLevelReward(context) {
  return Container(
    width: double.infinity,
    height: MediaQuery.of(context).size.height * 0.6,
    child: Row(
      children: [
        rowReward(
            3,
            " ",
            styledText(
              "Pembelanjaan \ndalam 1 tahun",
            ),
            styledText(
              "Menukar poin \ndengan hadiah",
            ),
            styledText(
              "Poin 2x di Hari \nUlang Tahun",
            ),
            styledText(
              "Gratis \nPengiriman \nStandar",
            ),
            styledText(
              "Kupon Ulang \nTahun",
            ),
            styledText(
              "Akses Produk \nIstimewa",
            ),
            styledText(
              "Double poin \nulang tahun",
            ),
            Alignment.centerLeft,
            Color(0xffF48262),
            Colors.white),
        Container(width: 5),
        rowReward(
            2,
            "DEWY",
            styledText(
              "1 juta",
            ),
            Icon(Icons.favorite, color: Color(0xffF48262)),
            Icon(Icons.favorite, color: Color(0xffF48262)),
            Icon(Icons.favorite, color: Color(0xffF48262)),
            styledText(
              " ",
            ),
            styledText(
              " ",
            ),
            styledText(
              " ",
            ),
            Alignment.center,
            Color(0xffF48262),
            Color(0xffF48262)),
        Container(width: 5),
        rowReward(
            2,
            "HEALTHY",
            styledText(
              "3 juta",
            ),
            Icon(Icons.favorite, color: Color(0xffF48262)),
            Icon(Icons.favorite, color: Color(0xffF48262)),
            Icon(Icons.favorite, color: Color(0xffF48262)),
            Icon(Icons.favorite, color: Color(0xffF48262)),
            styledText(
              " ",
            ),
            styledText(
              " ",
            ),
            Alignment.center,
            Hexcolor("#4a0a07"),
            Hexcolor("#4a0a07")),
        Container(width: 5),
        rowReward(
            2,
            "GLOWING",
            styledText(
              "3-10 juta",
            ),
            Icon(Icons.favorite, color: Color(0xffF48262)),
            Icon(Icons.favorite, color: Color(0xffF48262)),
            Icon(Icons.favorite, color: Color(0xffF48262)),
            Icon(Icons.favorite, color: Color(0xffF48262)),
            Icon(Icons.favorite, color: Color(0xffF48262)),
            Icon(Icons.favorite, color: Color(0xffF48262)),
            Alignment.center,
            Hexcolor("#9aa19f"),
            Hexcolor("#8c8c8c")),
        Container(width: 5),
        rowReward(
            2,
            "OH HAPPY",
            styledText(
              ">10 juta",
            ),
            Icon(Icons.favorite, color: Color(0xffF48262)),
            Icon(Icons.favorite, color: Color(0xffF48262)),
            Icon(Icons.favorite, color: Color(0xffF48262)),
            Icon(Icons.favorite, color: Color(0xffF48262)),
            Icon(Icons.favorite, color: Color(0xffF48262)),
            Icon(Icons.favorite, color: Color(0xffF48262)),
            Alignment.center,
            Hexcolor("#8a7a00"),
            Hexcolor("#b8a200")),
      ],
    ),
  );
}

Widget rowReward(
    int flexNum,
    String rankS,
    Widget row1,
    Widget row2,
    Widget row3,
    Widget row4,
    Widget row5,
    Widget row6,
    Widget row7,
    Alignment aligns,
    Color color1,
    Color color2) {
  return Expanded(
    flex: flexNum,
    child: Column(
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            alignment: Alignment.center,
            width: double.infinity,
            color: Color(0xffF3C1B5),
            child: FittedBox(
                child: GradientText(rankS,
                    gradient: LinearGradient(colors: [
                      color1,
                      color2,
                    ]),
                    style: TextStyle(
                      fontSize: 42,
                      fontFamily: 'Brandon',
                      letterSpacing: 1,
                    ),
                    textAlign: TextAlign.center)),
          ),
        ),
        Expanded(
          child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              alignment: aligns,
              width: double.infinity,
              color: Color(0xffFBD2CD),
              child: row1),
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            alignment: aligns,
            width: double.infinity,
            color: Color(0xffFBD2CD),
            child: row2,
          ),
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            alignment: aligns,
            width: double.infinity,
            color: Color(0xffFBD2CD),
            child: row3,
          ),
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            alignment: aligns,
            width: double.infinity,
            color: Color(0xffFBD2CD),
            child: row4,
          ),
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            alignment: aligns,
            width: double.infinity,
            color: Color(0xffFBD2CD),
            child: row5,
          ),
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            alignment: aligns,
            width: double.infinity,
            color: Color(0xffFBD2CD),
            child: row6,
          ),
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            alignment: aligns,
            width: double.infinity,
            color: Color(0xffFBD2CD),
            child: row7,
          ),
        ),
      ],
    ),
  );
}

Widget styledText(String rowText) {
  return FittedBox(
    child: Text(
      rowText,
      style: TextStyle(
        fontSize: 14,
        fontFamily: 'Brandon',
        letterSpacing: 1,
      ),
    ),
  );
}
