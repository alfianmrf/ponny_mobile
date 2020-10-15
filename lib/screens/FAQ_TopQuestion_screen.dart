import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:ponny/screens/FAQ_screen.dart';
import 'package:ponny/widgets/PonnyBottomNavbar.dart';
import 'package:ponny/screens/FAQ_PengembalianBarang_screen.dart';

class TopQuestionScreen extends StatefulWidget {
  TopQuestionScreen({Key key}) : super(key: key);

  @override
  _TopQuestionScreenState createState() => _TopQuestionScreenState();
}

class _TopQuestionScreenState extends State<TopQuestionScreen> {
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
                    faqList("Bagaimana Cara Mengembalikan Barang?", PengembailanBarang(),
                        context),
                    faqList("Apa Itu Happy Skin Reward?", FAQScreen(), context),
                    faqList("Apa Itu Happy Skin Reward?", FAQScreen(), context),
                    faqList("Apa Itu Happy Skin Reward?", FAQScreen(), context),
                    faqList("Apa Itu Happy Skin Reward?", FAQScreen(), context),
           
                  ],
                ),
              )
            ],
          ),
        ),bottomNavigationBar: new PonnyBottomNavbar(selectedIndex: 4)
      ),
    );
  }
}
