import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:ponny/widgets/PonnyBottomNavbar.dart';
import 'package:ponny/screens/Browse_Category_Screen.dart';
import 'package:ponny/screens/Browse_Skin_Guru_Screen.dart';
import 'package:ponny/screens/Browse_Brands_Screen.dart';
import 'package:ponny/screens/home_screen.dart';

class Browse extends StatefulWidget {
  static const String id = "Browse_Category_Screen";

  @override
  _BrowseState createState() => _BrowseState();
}

class _BrowseState extends State<Browse> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Hexcolor('#FCF8F0'),
        body: Column(
          children: [Container(
              height: 35,
            ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Colors.white),
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.only(left: 10, top: 10, right: 10),
              child: Row(children: [
                Icon(Icons.search, color: Color(0xffF48262)),
                Expanded(
                    child: TextField(
                  onTap: () {
                    showSearch(context: null, delegate: Search());
                  },
                  cursorColor: Colors.black,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.go,
                  decoration:
                      new InputDecoration.collapsed(hintText: "Search..."),
                ))
              ]),
            ),
            Container(
              margin: EdgeInsets.all(5),
              child: Row(
                children: [
                  Container(
                    child: IconButton(
                        onPressed: () {
                          Navigator.of(context)
                              .pushReplacementNamed(HomeScreen.id);
                        },
                        icon: Icon(
                          Icons.arrow_back_ios,
                          color: Color(0xffF48262),
                          size: 26,
                        )),
                  ),
                  Container(
                    child: Text(
                      "Browse",
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
              margin: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.all(5),
                    child: ButtonTheme(
                      buttonColor: Hexcolor('#FCF8F0'),
                      minWidth: 60.0,
                      height: 30.0,
                      child: RaisedButton(
                        onPressed: () {
                          setState(() {
                            index = 0;
                          });
                        },
                        child: Text(
                          "BRANDS",
                          style: TextStyle(
                              fontSize: 12,
                              fontFamily: 'Brandon',
                              fontWeight: FontWeight.w800,
                              letterSpacing: 1,
                              color: Hexcolor('#F48262')),
                        ),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        side: BorderSide(color: Hexcolor('#F48262')),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(5),
                    child: ButtonTheme(
                      buttonColor: Hexcolor('#FCF8F0'),
                      minWidth: 60.0,
                      height: 30.0,
                      child: RaisedButton(
                        onPressed: () {
                          setState(() {
                            index = 1;
                          });
                        },
                        child: Text(
                          "CATEGORY",
                          style: TextStyle(
                              fontSize: 12,
                              fontFamily: 'Brandon',
                              fontWeight: FontWeight.w800,
                              letterSpacing: 1,
                              color: Hexcolor('#F48262')),
                        ),
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          side: BorderSide(color: Hexcolor('#F48262'))),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(5),
                    child: ButtonTheme(
                      buttonColor: Hexcolor('#FCF8F0'),
                      minWidth: 60.0,
                      height: 30.0,
                      child: RaisedButton(
                        onPressed: () {
                          setState(() {
                            index = 2;
                          });
                        },
                        child: Text(
                          "SKIN GURU",
                          style: TextStyle(
                              fontSize: 12,
                              fontFamily: 'Brandon',
                              fontWeight: FontWeight.w800,
                              letterSpacing: 1,
                              color: Hexcolor('#F48262')),
                        ),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        side: BorderSide(color: Hexcolor('#F48262')),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(child: () {
              if (index == 0) {
                return Browse_Brands();
              }

              if (index == 1) {
                return Browse_Category();
              }

              if (index == 2) {
                return Browse_Skin_Guru();
              }
            }())
          ],
        ),
        bottomNavigationBar: new PonnyBottomNavbar(selectedIndex: 1),
      ),
    );
  }
}

class Search extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            query = "";
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: Icon(
          Icons.arrow_back,
        ),
        onPressed: () {
          Navigator.pop(context);
        });
  }

  String selectedResults;

  @override
  Widget buildResults(BuildContext context) {
    return Container(child: Center(child: Text(selectedResults)));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    throw UnimplementedError();
  }
}
