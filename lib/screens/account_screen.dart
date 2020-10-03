import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:ponny/screens/login.dart';
import 'package:ponny/widgets/PonnyBottomNavbar.dart';

class AccountScreen extends StatefulWidget {
  static const String id = "account_screen";
  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  void initState() {
    super.initState();
  }

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    List<Widget> _widgetOptions = <Widget>[
      Text(
        'Index 1: Browse',
        style: optionStyle,
      ),
      Text(
        'Index 2: Consultation',
        style: optionStyle,
      ),
      Text(
        'Index 3: Forums',
        style: optionStyle,
      ),
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text('Hello World!',
              style: TextStyle(fontSize: 28, color: Colors.black)),
          RaisedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
            },
            textColor: Colors.deepOrange,
            padding: const EdgeInsets.all(0.0),
            child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(colors: <Color>[
                    Color(0xFF0D474A1),
                    Color(0xFF1976D2),
                    Color(0xFF42A5F5)
                  ]),
                ),
                padding: const EdgeInsets.all(10.0),
                child: const Text(
                  'Login!',
                  style: TextStyle(fontSize: 31),
                )),
          )
        ],
      ),
    ];
    Row flatButton = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        FlatButton(
          child: Text('Saya FlatButton'),
          onPressed: () => debugPrint('FlatButton di tekan'),
        )
      ],
    );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Hexcolor('#FCF8F0'),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 100,
            ),
            Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    child: Text(
                      "Hi, Carla",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Yeseva',
                        color: Hexcolor('#F48262'),
                      ),
                    ),
                  ),
                  Container(
                    child: Text(
                      "Logout",
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: Hexcolor('#F48262'),
                        fontFamily: 'Yeseva',
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 10,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 300,
              color: Hexcolor('#F48262'),
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    padding: EdgeInsets.only(right: 20, left: 20),
                    decoration: new BoxDecoration(
                      color: Hexcolor('#FCF8F0'),
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    width: 300,
                    height: 190,
                    child: Column(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(top: 7),
                          child: Text(
                            "DEWY",
                            style: TextStyle(
                              color: Hexcolor('#F48262'),
                              fontFamily: "Brandon",
                              fontSize: 45,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 3,
                            ),
                          ),
                        ),
                        Container(
                          child: Text(
                            "SKIN",
                            style: TextStyle(
                              fontSize: 20,
                              color: Hexcolor('#F48262'),
                              fontFamily: "Yeseva",
                              fontWeight: FontWeight.w300,
                              letterSpacing: 1,
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          margin: EdgeInsets.only(top: 10),
                          child: Text(
                            "Aninda Anita",
                            style: TextStyle(
                              fontFamily: "Yeseva",
                              fontSize: 12,
                              color: Hexcolor('#F48262'),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            top: 6,
                          ),
                          height: 1,
                          color: Hexcolor('#F48262'),
                        ),
                        Container(
                          // margin: EdgeInsets.only(top: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                child: Text(
                                  "170 POINTS",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: 'Brandon',
                                    color: Hexcolor('#F48262'),
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 2),
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      child: Column(
                                        children: <Widget>[
                                          Container(
                                            child: Text(
                                              "Berlaku",
                                              style: TextStyle(
                                                fontFamily: "Brandon",
                                                fontSize: 11,
                                                color: Hexcolor('#F48262'),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            child: Text(
                                              "Hingga",
                                              style: TextStyle(
                                                fontFamily: "Brandon",
                                                fontSize: 11,
                                                color: Hexcolor('#F48262'),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      child: Column(
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(left: 5),
                                            child: Text(
                                              "Desember",
                                              style: TextStyle(
                                                fontFamily: "Brandon",
                                                fontSize: 11,
                                                color: Hexcolor('#F48262'),
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            // margin: EdgeInsets.only(left: 10),
                                            child: Text(
                                              "2021",
                                              style: TextStyle(
                                                fontFamily: "Brandon",
                                                fontSize: 11,
                                                color: Hexcolor('#F48262'),
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: new PonnyBottomNavbar(selectedIndex: 4),
    );
  }
}
