import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:ponny/widgets/PonnyBottomNavbar.dart';

class RincianPoint extends StatefulWidget {
  static const String id = "RincianPoints";

  @override
  _RincianPointState createState() => _RincianPointState();
}

class _RincianPointState extends State<RincianPoint> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
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
                          "Rincian Point",
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
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      color: Color(0xffF3C1B5),
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: Column(
                        children: [
                          FittedBox(
                            child: Text(
                              "POIN KAMU ADA",
                              style: TextStyle(
                                fontSize: 14,
                                fontFamily: "Brandon",
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FittedBox(
                                child: Text(
                                  "260 ",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontFamily: "Brandon",
                                      color: Color(0xffF48262)),
                                ),
                              ),
                              FittedBox(
                                child: Text(
                                  "POIN",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontFamily: "Brandon",
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(color: Color(0xffF3C1B5))),
                      ),
                      margin: EdgeInsets.symmetric(vertical: 20),
                      child: TabBar(
                        tabs: [
                          FittedBox(
                            child: Text(
                              "SEMUA",
                              style: TextStyle(
                                fontSize: 14,
                                fontFamily: "Brandon",
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                          FittedBox(
                            child: Text(
                              "DIPEROLEH",
                              style: TextStyle(
                                fontSize: 14,
                                fontFamily: "Brandon",
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                          FittedBox(
                            child: Text(
                              "TERPAKAI",
                              style: TextStyle(
                                fontSize: 14,
                                fontFamily: "Brandon",
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                      fit: FlexFit.loose,
                      child: TabBarView(
                        children: [
                          tabSemua(),
                          tabDiperoleh(),
                          tabTerpakai(),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          bottomNavigationBar: new PonnyBottomNavbar(selectedIndex: 4)),
    );
  }
}

Widget tabDiperoleh() {
  return ListView.builder(
      itemCount: 2,
      itemBuilder: (builder, i) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    "12/07/2020",
                    style: TextStyle(
                      fontSize: 11,
                      fontFamily: "Brandon",
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Text(
                    "50 POIN",
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: "Brandon",
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Text(
                    "Aktivasi akun",
                    style: TextStyle(
                      fontSize: 11,
                      fontFamily: "Brandon",
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              Container(
                height: 1,
                color: Color(0xffF3C1B5),
              ),
            ],
          ),
        );
      });
}

Widget tabSemua() {
  return ListView.builder(
      itemCount: 2,
      itemBuilder: (builder, i) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    "12/07/2020",
                    style: TextStyle(
                      fontSize: 11,
                      fontFamily: "Brandon",
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Text(
                    "50 POIN",
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: "Brandon",
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Text(
                    "Aktivasi akun",
                    style: TextStyle(
                      fontSize: 11,
                      fontFamily: "Brandon",
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              Container(
                height: 1,
                color: Color(0xffF3C1B5),
              ),
            ],
          ),
        );
      });
}

Widget tabTerpakai() {
  return ListView.builder(
      itemCount: 2,
      itemBuilder: (builder, i) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    "12/07/2020",
                    style: TextStyle(
                      fontSize: 11,
                      fontFamily: "Brandon",
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Text(
                    "50 POIN",
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: "Brandon",
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Text(
                    "Aktivasi akun",
                    style: TextStyle(
                      fontSize: 11,
                      fontFamily: "Brandon",
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              Container(
                height: 1,
                color: Color(0xffF3C1B5),
              ),
            ],
          ),
        );
      });
}
