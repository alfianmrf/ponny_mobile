import 'package:flutter/material.dart';
import 'package:ponny/screens/Promotion_Detail_screen.dart';
import 'package:ponny/widgets/PonnyBottomNavbar.dart';
import 'package:ponny/screens/product_details_screen.dart';

class PromotionScreen extends StatefulWidget {
  PromotionScreen({Key key}) : super(key: key);

  @override
  _PromotionScreenState createState() => _PromotionScreenState();
}

class _PromotionScreenState extends State<PromotionScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Column(
            children: [
              Container(
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
                        "Promotion",
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
                padding: EdgeInsets.all(10),
                child: Text(
                  "Kupon Diskon",
                  style: TextStyle(
                    fontSize: 24,
                    fontFamily: "Yeseva",
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 20,
                  itemBuilder: (context, i) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PromotionDetailScreen()));
                      },
                      child: Container(
                          margin: EdgeInsets.all(10),
                          child: Image.network(
                            "https://via.placeholder.com/288x188",
                            fit: BoxFit.cover,
                          )),
                    );
                  },
                ),
              ),
              Expanded(
                flex: 3,
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: 20,
                  itemBuilder: (context, i) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PromotionDetailScreen()));
                      },
                      child: Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 35, vertical: 10),
                        decoration: BoxDecoration(
                            border: Border.all(color: Color(0xffF3C1B5)),
                            borderRadius: BorderRadius.circular(3)),
                        child: Column(
                          children: [
                            Container(
                                child: Image.network(
                              "https://via.placeholder.com/288x188",
                              fit: BoxFit.cover,
                            )),
                            Container(
                              padding: EdgeInsets.all(20),
                              child: Text(
                                "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontFamily: "Yeseva",
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
          bottomNavigationBar: new PonnyBottomNavbar(selectedIndex: 1)),
    );
  }
}
