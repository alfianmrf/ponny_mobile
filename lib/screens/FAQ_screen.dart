import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:ponny/widgets/PonnyBottomNavbar.dart';
import 'package:ponny/screens/FAQ_TopQuestion_screen.dart';

class FAQScreen extends StatefulWidget {
  static const String id = "FAQ_Screen";

  @override
  _FAQScreenState createState() => _FAQScreenState();
}

class _FAQScreenState extends State<FAQScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Hexcolor('#FCF8F0'),
        body: Column(
          children: [
            Container(
              margin: EdgeInsets.all(5),
              child: Row(
                children: [
                  Container(
                    child: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.arrow_back_ios,
                          color: Color(0xffF48262),
                          size: 26,
                        )),
                  ),
                  Container(
                    child: Text(
                      "FAQ",
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
            Expanded(
                          child: SingleChildScrollView(
                child: Stack(
                  children: [
                    Column(
                      children: [
                        Container(
                          width: double.infinity,
                          height: 170,
                          color: Color(0xffF3C1B5),
                        ),
                      ],
                    ),
                    Column(children: [
                      Container(
                        height: 50,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            margin: EdgeInsets.all(5),
                            child: Text(
                              "Hi Beauties,",
                              style: TextStyle(
                                fontSize: 24,
                                fontFamily: "Yeseva",
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.all(5),
                            child: Text(
                              'Apa yang bisa Phoebe bantu ?',
                              style: TextStyle(
                                fontFamily: 'Brandon',
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Colors.white),
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.only(left: 20, top: 25, right: 20),
                        child: Row(children: [
                          Expanded(
                            child: TextField(
                              onTap: () {
                                // showSearch(context: null, delegate: Search());
                              },
                              cursorColor: Colors.black,
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.go,
                              decoration: new InputDecoration.collapsed(
                                  hintText: "Cari..."),
                            ),
                          ),
                          Icon(Icons.search, color: Color(0xffF48262)),
                        ]),
                      ),
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.only(top: 30, right: 20, left: 20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: Color(0xffF48262),
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Container(
                          margin: EdgeInsets.only(top: 10, bottom: 20),
                          child: Column(children: [
                            faqList("Top Question", TopQuestionScreen(), context),
                            faqList("Orders", TopQuestionScreen(), context),
                            faqList("Payment", TopQuestionScreen(), context),
                            faqList("Shipping and Delivery", TopQuestionScreen(),
                                context),
                            faqList("Returns", TopQuestionScreen(), context),
                            faqList("Account", TopQuestionScreen(), context),
                            faqList("Others", TopQuestionScreen(), context),
                          ]),
                        ),
                      ),
                      Container(height: 20)
                    ]),
                  ],
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: new PonnyBottomNavbar(selectedIndex: 4),
      ),
    );
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
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => faqChoice));
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
