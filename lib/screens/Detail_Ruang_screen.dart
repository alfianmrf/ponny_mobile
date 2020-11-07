import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:readmore/readmore.dart';
import 'Forum_screen.dart';
import 'Detail_komen_screen.dart';

class DetailForum extends StatefulWidget {
  bool gabung = false;
  int index;

  DetailForum({this.gabung, this.index});

  @override
  _DetailForumState createState() => _DetailForumState();
}

class _DetailForumState extends State<DetailForum> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Container(
                color: Hexcolor('#FCF8F0'),
                child: Column(
                  children: [
                    Container(height: 20),
                    Expanded(
                      flex: 2,
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.grey),
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                    "Kulit Berminyak",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontFamily: 'Yeseva',
                                      fontWeight: FontWeight.w800,
                                      letterSpacing: 1,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.people,
                                          size: 12, color: Color(0xffF48262)),
                                      Text(
                                        "1200",
                                        style: TextStyle(
                                            color: Color(0xffF48262),
                                            fontSize: 12),
                                      ),
                                      Container(width: 10),
                                      Icon(Icons.comment,
                                          size: 12, color: Color(0xffF48262)),
                                      Text("500",
                                          style: TextStyle(
                                              color: Color(0xffF48262),
                                              fontSize: 12))
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    "Ga setiap saat harus glowing",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontFamily: 'Yeseva',
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: 1,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Container(
                                          width: double.infinity,
                                          child: widget.gabung
                                              ? RaisedButton(
                                                  color: Color(0xffF3C1B5),
                                                  onPressed: () {
                                                    setState(() {
                                                      widget.gabung = false;
                                                    });
                                                  },
                                                  child: FittedBox(
                                                    fit: BoxFit.fitWidth,
                                                    child: Text(
                                                      "MEMBER",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontFamily:
                                                              "Brandon"),
                                                    ),
                                                  ),
                                                )
                                              : RaisedButton(
                                                  color: Color(0xffF48262),
                                                  onPressed: () {
                                                    setState(() {
                                                      widget.gabung = true;
                                                    });
                                                  },
                                                  child: FittedBox(
                                                    fit: BoxFit.fitWidth,
                                                    child: Text(
                                                      "Bergabung",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontFamily:
                                                              "Brandon"),
                                                    ),
                                                  ),
                                                ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: Colors.transparent,
                                              border: Border.all(
                                                  color: Color(0xffF48262))),
                                          width: double.infinity,
                                          child: RaisedButton(
                                            onPressed: () {
                                              setState(() {
                                                widget.gabung = false;
                                              });
                                            },
                                            child: FittedBox(
                                              fit: BoxFit.fitWidth,
                                              child: Text(
                                                "Mulai Obrolan",
                                                style: TextStyle(
                                                    fontFamily: "Brandon"),
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 20),
                      height: 1,
                      color: Color(0xffF3C1B5),
                    ),
                    Expanded(
                        flex: 1,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            listCategory("Trending"),
                            listCategory("Popular"),
                            listCategory("Terbaru"),
                          ],
                        )),
                  ],
                )),
          ),
          Expanded(
            flex: 2,
            child: ListView.builder(
              itemCount: 2,
              itemBuilder: (context, i) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DetailKomenScreen()));
                  },
                  child: Container(
                    color: Hexcolor('#FCF8F0'),
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: Card(
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
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            DetailKomenScreen()));
                              },
                              child: Text(
                                "Sunscreen yang bikin kulit berminyak",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: 'Yeseva',
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: 1,
                                ),
                              ),
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
                            Container(height: 5),
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
                            ReadMoreText(
                              "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam pretium turpis sed lectus molestie, ac convallis ante faucibus. Vivamus id porta tellus, at accumsan dolor. Class aptent taciti sociosqu ad litora",
                              style: TextStyle(fontFamily: "Brandon"),
                              trimLines: 2,
                              colorClickableText: Colors.blue,
                              trimMode: TrimMode.Line,
                              trimCollapsedText: '...baca selengkapnya',
                              trimExpandedText: ' show less',
                            ),
                            Container(
                              height: 5,
                            ),
                            Container(
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
                                        padding:
                                            EdgeInsets.symmetric(horizontal: 3),
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
                                  Container(
                                    height: 5,
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                          style:
                                              TextStyle(fontFamily: "Brandon"),
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
                                    children: [
                                      Icon(
                                        Icons.favorite,
                                        color: Color(0xffF48262),
                                      ),
                                      Text("52",
                                          style:
                                              TextStyle(fontFamily: "Brandon")),
                                      Container(width: 10),
                                      Icon(
                                        Icons.reply,
                                        color: Color(0xffF48262),
                                      ),
                                      Text("Balas",
                                          style:
                                              TextStyle(fontFamily: "Brandon")),
                                      Container(width: 10),
                                      Text("|",
                                          style:
                                              TextStyle(fontFamily: "Brandon")),
                                      Container(width: 10),
                                      Text("39 Balasan",
                                          style:
                                              TextStyle(fontFamily: "Brandon")),
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

Widget listCategory(String tagCategory) {
  return Wrap(
    children: [
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: Color(0xffF3C1B5),
        ),
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        margin: EdgeInsets.symmetric(horizontal: 5),
        child: Text(
          tagCategory,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 12,
            fontFamily: 'Brandon',
            fontWeight: FontWeight.w800,
            letterSpacing: 1,
          ),
        ),
      ),
    ],
  );
}
