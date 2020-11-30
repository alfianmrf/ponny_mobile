import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:ponny/common/constant.dart';
import 'package:ponny/model/App.dart';
import 'package:ponny/screens/search_faq_screen.dart';
import 'package:ponny/widgets/PonnyBottomNavbar.dart';
import 'package:ponny/screens/FAQ_TopQuestion_screen.dart';
import 'package:provider/provider.dart';

class FAQScreen extends StatefulWidget {
  static const String id = "FAQ_Screen";

  @override
  _FAQScreenState createState() => _FAQScreenState();
}

class _FAQScreenState extends State<FAQScreen> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0.0,
        elevation: 0.0,
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context,false);
          },
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            color: Color(0xffF48262),
          ),
        ),
        title: Text(
          'FAQ',
          style: TextStyle(
            fontSize: 24,
            fontFamily: 'Yeseva',
            color: Hexcolor('#F48262'),
          ),
        ),
        bottom: PreferredSize(
            child: Container(
              color: Color(0xffF48262),
              height: 1.0,
            ),
            preferredSize: Size.fromHeight(1.0)
        ),
      ),
      resizeToAvoidBottomInset: false,
      backgroundColor: Hexcolor('#FCF8F0'),
      body: Consumer<AppModel>(
          builder: (context,value,child){
            if(value.loadingFaq){
            return Center(
            child: LoadingWidgetFadingCircle(context),
            );
            }else{
              return Column(
                children: [
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
                                    readOnly: true,
                                    onTap: () {
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (context) => SearchFaqScreen()));
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
                                child: Column(
                                    children: value.listFaq.map((e) =>
                                        InkWell(
                                          onTap: (){
                                            Navigator.push(context,
                                                MaterialPageRoute(builder: (context) => TopQuestionScreen(header: e,)));

                                          },
                                          child: Container(
                                          margin: EdgeInsets.only(left: 20, right: 20),
                                          child: Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text(
                                                    e.title.toUpperCase(),
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
                                                            MaterialPageRoute(builder: (context) => TopQuestionScreen(header: e,)));
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
                                        ),)

                                    ).toList()
                                ),
                              ),
                            ),
                            Container(height: 20)
                          ]),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }
          }
      ),


      bottomNavigationBar: new PonnyBottomNavbar(selectedIndex: 4),
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
