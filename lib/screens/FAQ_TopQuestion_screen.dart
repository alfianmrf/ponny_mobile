import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:ponny/model/FaqHeader.dart';

import 'package:ponny/widgets/PonnyBottomNavbar.dart';
import 'package:ponny/screens/FAQ_PengembalianBarang_screen.dart';

class TopQuestionScreen extends StatefulWidget {
  static const String id = "FAQ_TopQuestion_screen";
  FaqHeader header;
  TopQuestionScreen({Key key,this.header});

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
                      width: MediaQuery.of(context).size.width*.76,
                      child: Text(
                        widget.header.title,
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
                  children:widget.header.faq.map((e) =>
                  InkWell(
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>PengembalianBarang(faq: e,)),
                      );
                    },
                    child:  Container(
                      margin: EdgeInsets.only(left: 20, right: 20),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width*.76,
                                child: Text(
                                  e.ask,
                                  style: TextStyle(
                                    fontFamily: 'Brandon',
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              Container(
                                child: IconButton(
                                  icon: Icon(
                                    Icons.arrow_forward_ios,
                                    color: Color(0xffF48262),
                                  ),
                                  onPressed: () {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>PengembalianBarang(faq: e,)),
                                    );
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
                    ),
                  )
                  ).toList(),
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
