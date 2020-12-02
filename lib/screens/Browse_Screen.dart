import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:ponny/screens/search_screen.dart';
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
                  cursorColor: Colors.black,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.go,
                      onSubmitted: (String q){
                        FocusScope.of(context).requestFocus(new FocusNode());
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => SearchScreen(q: q,)));
                      },
                  decoration:
                      new InputDecoration.collapsed(),
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
                      "Pencarian",
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
                    margin: EdgeInsets.all(3),
                    child: ButtonTheme(
                      buttonColor: index == 0 ? Hexcolor('#F48262') : Colors.white,
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
                              color: index == 0 ? Colors.white : Hexcolor('#F48262')),
                        ),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(5), bottomLeft: Radius.circular(5)),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(3),
                    child: ButtonTheme(
                      buttonColor: index == 1 ? Hexcolor('#F48262') : Colors.white,
                      minWidth: 60.0,
                      height: 30.0,
                      child: RaisedButton(
                        onPressed: () {
                          setState(() {
                            index = 1;
                          });
                        },
                        child: Text(
                          "KATEGORI",
                          style: TextStyle(
                              fontSize: 12,
                              fontFamily: 'Brandon',
                              fontWeight: FontWeight.w800,
                              letterSpacing: 1,
                              color: index == 1 ? Colors.white : Hexcolor('#F48262')),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(3),
                    child: ButtonTheme(
                      buttonColor: index == 2 ? Hexcolor('#F48262') : Colors.white,
                      minWidth: 60.0,
                      height: 30.0,
                      child: RaisedButton(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        onPressed: () {
                          setState(() {
                            index = 2;
                          });
                        },
                        child: Text(
                          "BELAJAR BARENG",
                          style: TextStyle(
                              fontSize: 12,
                              fontFamily: 'Brandon',
                              fontWeight: FontWeight.w800,
                              color: index == 2 ? Colors.white : Hexcolor('#F48262')),
                        ),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(topRight: Radius.circular(5), bottomRight: Radius.circular(5)),
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
