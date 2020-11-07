import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:ponny/widgets/PonnyBottomNavbar.dart';

class DetailKomenScreen extends StatefulWidget {
  DetailKomenScreen({Key key}) : super(key: key);

  @override
  _DetailKomenScreenState createState() => _DetailKomenScreenState();
}

class _DetailKomenScreenState extends State<DetailKomenScreen> {
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
                        "Kembali",
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
                color: Hexcolor('#FCF8F0'),
                margin: EdgeInsets.symmetric(vertical: 10),
                child: Container(
                  color: Hexcolor('#FCF8F0'),
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Balasan terbaru di",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 10,
                              fontFamily: 'Brandon',
                              fontWeight: FontWeight.w500,
                              letterSpacing: 1,
                            ),
                          ),
                          Text(
                            " Kulit Berminyak",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 10,
                              fontFamily: 'Brandon',
                              fontWeight: FontWeight.w800,
                              letterSpacing: 1,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            height: 35,
                            width: 35,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xffF48262)),
                          ),
                          Container(
                            width: 5,
                          ),
                          Text(
                            "Phobe",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'Yeseva',
                              fontWeight: FontWeight.w800,
                              letterSpacing: 1,
                            ),
                          ),
                          Container(
                            width: 5,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 3),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Color(0xffF48262)),
                            child: Text(
                              "Dewy Skin",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                                fontFamily: 'Brandon',
                                fontWeight: FontWeight.w800,
                                letterSpacing: 1,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Text(
                            "Posted 20-07-2020",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 10,
                              fontFamily: 'Brandon',
                              color: Colors.grey,
                              letterSpacing: 1,
                            ),
                          ),
                          Container(width: 5),
                          Text(
                            "|",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 10,
                              fontFamily: 'Brandon',
                              color: Colors.grey,
                              letterSpacing: 1,
                            ),
                          ),
                          Container(width: 10),
                          Text(
                            "Diupdate 1 jam yang lalu",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 10,
                              fontFamily: 'Brandon',
                              color: Colors.grey,
                              letterSpacing: 1,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "Sunscreen yang bikin kulit berminyak",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'Yeseva',
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1,
                        ),
                      ),
                      Container(height: 5),
                      Text(
                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam pretium turpis sed lectus molestie, ac convallis ante faucibus. Vivamus id porta tellus, at accumsan dolor. Class aptent taciti sociosqu ad litora",
                        style: TextStyle(fontFamily: "Brandon"),
                      ),
                      Container(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.favorite,
                                color: Color(0xffF48262),
                              ),
                              Text("52",
                                  style: TextStyle(fontFamily: "Brandon")),
                              Container(width: 10),
                              IconButton(
                                icon: Icon(Icons.reply),
                                color: Color(0xffF48262),
                                onPressed: () {
                                  _settingModalBottomSheet(context);
                                },
                              ),
                              Text("Balas",
                                  style: TextStyle(fontFamily: "Brandon")),
                              Container(width: 10),
                              Text("|",
                                  style: TextStyle(fontFamily: "Brandon")),
                              Container(width: 10),
                              Text("39 Balasan",
                                  style: TextStyle(fontFamily: "Brandon")),
                            ],
                          ),
                          IconButton(
                              icon: Image.asset("assets/images/shareIcon.PNG"),
                              onPressed: () {}),
                        ],
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: 2,
                        itemBuilder: (context, i) {
                          return Container(
                            margin: EdgeInsets.symmetric(vertical: 5),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(color: Color(0xffF3C1B5))),
                            padding: EdgeInsets.all(5),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      height: 35,
                                      width: 35,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Color(0xffF48262)),
                                    ),
                                    Container(
                                      width: 5,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              "Phobe",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontFamily: 'Yeseva',
                                                fontWeight: FontWeight.w800,
                                                letterSpacing: 1,
                                              ),
                                            ),
                                            Container(
                                              width: 5,
                                            ),
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 3),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  color: Color(0xffF48262)),
                                              child: Text(
                                                "Dewy Skin",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 11,
                                                  fontFamily: 'Brandon',
                                                  fontWeight: FontWeight.w800,
                                                  letterSpacing: 1,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "Posted 20-07-2020",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontSize: 10,
                                                fontFamily: 'Brandon',
                                                color: Colors.grey,
                                                letterSpacing: 1,
                                              ),
                                            ),
                                            Container(width: 5),
                                            Text(
                                              "|",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontSize: 10,
                                                fontFamily: 'Brandon',
                                                color: Colors.grey,
                                                letterSpacing: 1,
                                              ),
                                            ),
                                            Container(width: 10),
                                            Text(
                                              "12.27",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontSize: 10,
                                                fontFamily: 'Brandon',
                                                color: Colors.grey,
                                                letterSpacing: 1,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Container(
                                  height: 5,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Reply: ",
                                      style: TextStyle(
                                          fontFamily: "Brandon",
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Expanded(
                                      child: ReadMoreText(
                                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam pretium turpis sed lectus molestie, ac convallis ante faucibus. Vivamus id porta tellus, at accumsan dolor. Class aptent taciti sociosqu ad litora",
                                        style: TextStyle(fontFamily: "Brandon"),
                                        trimLines: 2,
                                        colorClickableText: Colors.blue,
                                        trimMode: TrimMode.Line,
                                        trimCollapsedText:
                                            '...baca selengkapnya',
                                        trimExpandedText: ' show less',
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.favorite,
                                          color: Color(0xffF48262),
                                        ),
                                        Text("52",
                                            style: TextStyle(
                                                fontFamily: "Brandon")),
                                        Container(width: 10),
                                        Icon(
                                          Icons.reply,
                                          color: Color(0xffF48262),
                                        ),
                                        Text("Balas",
                                            style: TextStyle(
                                                fontFamily: "Brandon")),
                                        Container(width: 10),
                                        Text("|",
                                            style: TextStyle(
                                                fontFamily: "Brandon")),
                                        Container(width: 10),
                                        Text("39 Balasan",
                                            style: TextStyle(
                                                fontFamily: "Brandon")),
                                      ],
                                    ),
                                    IconButton(
                                        icon: Image.asset(
                                            "assets/images/shareIcon.PNG"),
                                        onPressed: () {}),
                                  ],
                                )
                              ],
                            ),
                          );
                        },
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),bottomNavigationBar: new PonnyBottomNavbar(selectedIndex: 3)
      ),
    );
  }
}

void _settingModalBottomSheet(context) {
  showModalBottomSheet(
    isScrollControlled: true,
    backgroundColor: Hexcolor('#FCF8F0'),
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30), topRight: Radius.circular(30))),
    context: context,
    builder: (builder) {
      return Container(
        padding: EdgeInsets.all(10),
        height: MediaQuery.of(context).size.height * 0.75,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.all(5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 1,
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
                    Expanded(
                      flex: 4,
                      child: Container(
                        margin: EdgeInsets.only(right: 10),
                        child: FittedBox(
                          fit: BoxFit.fitWidth,
                          child: Text(
                            "Tambahkan Komentar",
                            style: TextStyle(
                              fontSize: 24,
                              fontFamily: "Yeseva",
                              fontWeight: FontWeight.w500,
                              color: Color(0xffF48262),
                            ),
                          ),
                        ),
                      ),
                    ),
                    FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Text(
                        "Kirim",
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: "Brandon",
                          fontWeight: FontWeight.w500,
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
                margin: EdgeInsets.all(10),
                child: TextField(
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  cursorColor: Colors.black,
                  textInputAction: TextInputAction.go,
                  decoration: new InputDecoration.collapsed(
                      hintStyle: TextStyle(fontFamily: "Brandon"),
                      hintText: "Tambahkan Komentar"),
                ),
              )
            ],
          ),
        ),
      );
    },
  );
}
