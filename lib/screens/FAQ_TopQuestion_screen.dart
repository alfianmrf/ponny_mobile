import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import 'package:ponny/widgets/PonnyBottomNavbar.dart';
import 'package:ponny/screens/FAQ_PengembalianBarang_screen.dart';

class TopQuestionScreen extends StatefulWidget {
  static const String id = "FAQ_TopQuestion_screen";

  @override
  _TopQuestionScreenState createState() => _TopQuestionScreenState();
}

class _TopQuestionScreenState extends State<TopQuestionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Hexcolor('#FCF8F0'),
        body: SingleChildScrollView(
          child: Column(
            children: [Container(
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
                        "Top Question",
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
                color: Color(0xffF48262),
              ),
              Container(
                child: Column(
                  children: [
                    faqList("Bagaimana Cara Mengembalikan Barang?",
                        PengembalianBarang.id, context),
                    faqList("Apa Itu Happy Skin Reward?",
                        PengembalianBarang.id, context),
                    faqList("Apa Itu Happy Skin Reward?",
                        PengembalianBarang.id, context),
                    faqList("Apa Itu Happy Skin Reward?",
                        PengembalianBarang.id, context),
                    faqList("Apa Itu Happy Skin Reward?",
                        PengembalianBarang.id, context),
                  ],
                ),
              )
            ],
          ),
        ),
        bottomNavigationBar: new PonnyBottomNavbar(selectedIndex: 4));
  }
}

Widget faqList(String title, var faqChoice, context) {
  return Container(
    margin: EdgeInsets.only(left: 20, right: 20),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                fontFamily: 'Brandon',
                fontSize: 14,
              ),
            ),
            Container(
              child: IconButton(
                icon: Icon(
                  Icons.arrow_forward_ios,
                  color: Color(0xffF48262),
                ),
                onPressed: () {
                  Navigator.pushReplacementNamed(context, faqChoice);
                },
              ),
            )
          ],
        ),
        Container(
          height: 1,
          color: Color(0xffF48262),
        ),
      ],
    ),
  );
}
