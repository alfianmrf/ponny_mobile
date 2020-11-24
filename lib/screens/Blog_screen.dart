import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:ponny/widgets/PonnyBottomNavbar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:ponny/util/globalUrl.dart';
import 'package:ponny/screens/Blog_Detail_screen.dart';
import 'package:intl/intl.dart';
import 'package:date_format/date_format.dart';

class Blog extends StatefulWidget {


  static const String id = "Blog";


  @override
  _BlogState createState() => _BlogState();
}

class _BlogState extends State<Blog> {
  bool onSearch = false;
  String currentTag = "ALL";
  int categoryId = 0;
  int lostData = 0;
  var categoryFilter;

 

  Future<List> filterData(int categoryId) async {
    final response = await http.get(blogUrl +
        (() {
          if (categoryId == 0) {
            return "/all";
          } else {
            return "/category/" + categoryId.toString();
          }
        }()));
    return json.decode(response.body);
  }

  Future<List> getOtherArticles() async {
    final response = await http.get(blogUrl);
    Map<String, dynamic> map = json.decode(response.body);
    List<dynamic> data = map["other_articles"];
    return data;
  }

  @override
  Widget build(BuildContext context) {


    return WillPopScope(
      onWillPop: () {
        setState(() {
          onSearch = false;
        });
        Navigator.of(context).pop(true);
      },
      child: DefaultTabController(
        length: 5,
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Hexcolor('#FCF8F0'),
            body: Column(
              children: [
                Container(
                  color: Color(0xffF48262),
                  height: 35,
                ),
                onSearch
                    ? Container(
                        width: double.infinity,
                        color: Color(0xffF48262),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              color: Colors.white),
                          padding: EdgeInsets.all(10),
                          margin: EdgeInsets.all(10),
                          child: Row(children: [
                            Icon(Icons.search, color: Color(0xffF48262)),
                            Expanded(
                                child: TextField(
                              cursorColor: Colors.black,
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.go,
                              decoration: new InputDecoration.collapsed(
                                  hintText: "Search..."),
                            ))
                          ]),
                        ),
                      )
                    : Container(
                        width: double.infinity,
                        color: Color(0xffF48262),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Container(
                                alignment: Alignment.centerLeft,
                                child: IconButton(
                                  icon: Icon(
                                    Icons.search,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      onSearch = true;
                                    });
                                  },
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Container(
                                  child: Image.asset(
                                "assets/images/blogTitle.png",
                                color: Colors.white,
                              )),
                            ),
                            Expanded(flex: 1, child: Container())
                          ],
                        ),
                      ),
                Container(
                  width: double.infinity,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              currentTag = "ALL";
                              categoryId = 0;
                            });
                          },
                          child: Container(
                            height: 50,
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            alignment: Alignment.center,
                            color: categoryId == 0 ? Color(0xffFBDFD2) : null,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "ALL",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontFamily: "Brandon",
                                      fontWeight: FontWeight.bold,
                                      color: categoryId == 0 ? Colors.black : Color(0xffF48262)),
                                ),
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              currentTag = "BASIC SKINCARE";
                              categoryId = 1;
                            });
                          },
                          child: Container(
                            height: 50,
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            alignment: Alignment.center,
                            color: categoryId == 1 ? Color(0xffFBDFD2) : null,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "BASIC\nSKINCARE",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontFamily: "Brandon",
                                      fontWeight: FontWeight.bold,
                                      color: categoryId == 1 ? Colors.black : Color(0xffF48262)),
                                ),
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              currentTag = "SKIN CONCERN";
                              categoryId = 2;
                            });
                          },
                          child: Container(
                            height: 50,
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            alignment: Alignment.center,
                            color: categoryId == 2 ? Color(0xffFBDFD2) : null,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "MASALAH\nKULIT",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontFamily: "Brandon",
                                      fontWeight: FontWeight.bold,
                                      color: categoryId == 2 ? Colors.black : Color(0xffF48262)),
                                ),
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              currentTag = "SKINCARE ROUTINE";
                              categoryId = 3;
                            });
                          },
                          child: Container(
                            height: 50,
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            alignment: Alignment.center,
                            color: categoryId == 3 ? Color(0xffFBDFD2) : null,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "SKINCARE\nROUTINE",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontFamily: "Brandon",
                                      fontWeight: FontWeight.bold,
                                      color: categoryId == 3 ? Colors.black : Color(0xffF48262)),
                                ),
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              currentTag = "MITOS ATAU FAKTA";
                              categoryId = 4;
                            });
                          },
                          child: Container(
                            height: 50,
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            alignment: Alignment.center,
                            color: categoryId == 4 ? Color(0xffFBDFD2) : null,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "MITOS\nATAU FAKTA",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontFamily: "Brandon",
                                      fontWeight: FontWeight.bold,
                                      color: categoryId == 4 ? Colors.black : Color(0xffF48262)),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                    width: double.infinity,
                    color: Color(0xffFACAC1),
                    child: Text(
                      currentTag,
                      style: TextStyle(color: Color(0xffF48262), fontSize: 20),
                    )),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                            child: new FutureBuilder<List>(
                                future: filterData(categoryId),
                                builder: (context, snapshot) {
                                  if (snapshot.hasError) print(snapshot.error);
                                  return snapshot.hasData
                                      ? categoryList(
                                          context, snapshot.data, categoryId)
                                      : Center(
                                          child:
                                              new CircularProgressIndicator());
                                })),
                        Container(
                          margin: EdgeInsets.only(top: 30, bottom: 30),
                          height: 1,
                          color: Color(0xffF3C1B5),
                        ),
                        Container(
                          child: Text(
                            "TRENDING",
                            style: TextStyle(
                                color: Color(0xffF48262), fontSize: 20),
                          ),
                          margin: EdgeInsets.only(bottom: 30),
                        ),
                        new FutureBuilder<List>(
                            future: getOtherArticles(),
                            builder: (context, snapshot) {
                              if (snapshot.hasError) print(snapshot.error);
                              return snapshot.hasData
                                  ? otherArticlesScreen(snapshot.data)
                                  : Center(
                                      child: new CircularProgressIndicator());
                            })
                      ],
                    ),
                  ),
                ),
              ],
            ),
            bottomNavigationBar: new PonnyBottomNavbar(selectedIndex: 0)),
      ),
    );
  }
}

class otherArticlesScreen extends StatefulWidget {
  List list;
  otherArticlesScreen(this.list);

  @override
  _otherArticlesScreenState createState() => _otherArticlesScreenState();
}

class _otherArticlesScreenState extends State<otherArticlesScreen> {

DateTime convertDateFromString(String strDate){
   DateTime todayDate = DateTime.parse(strDate);
  
    return todayDate;
 }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: widget.list.length,
        shrinkWrap: true,
        primary: false,
        itemBuilder: (context, i) {
          return Container(
              margin: EdgeInsets.only(bottom: 10),
              child: ListTile(
                leading: Image.asset(
                  "assets/images/blogImage.png",
                  fit: BoxFit.cover,
                ),
                title: Text(
                  widget.list[i]["title"],
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: "Brandon",
                    fontWeight: FontWeight.w500,
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.list[i]["user"]["name"],
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: "Brandon",
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      DateFormat('dd MMMM yyyy').format(convertDateFromString(widget.list[i]["created_at"])),
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: "Brandon",
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ));
        });
  }
}



Widget categoryList(context, List list, int categoryId) {
  return GridView.builder(
      primary: false,
      shrinkWrap: true,
      itemCount: list == null ? 0 : list.length,
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 0.7),
      itemBuilder: (BuildContext context, int i) {
        return GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => BlogDetailData(contentId:list[i]["id"])));
          },
          child: Container(
            margin: EdgeInsets.all(5),
            child: Column(children: [
              Expanded(
                  flex: 3,
                  child: Container(
                      width: double.infinity,
                      child: Image.asset(
                        "assets/images/blogImage.png",
                        fit: BoxFit.cover,
                      ))),
              Container(height: 5),
              Expanded(
                flex: 1,
                child: Text(
                  list[i]["title"],
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: "Brandon",
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              )
            ]),
          ),
        );
      });
}

/*class categoryFilter extends StatefulWidget {
  int categoryId;
  categoryFilter({this.categoryId});

  @override
  _categoryFilterState createState() => _categoryFilterState();
}

class _categoryFilterState extends State<categoryFilter> {
 
 Future <List> filterData(int categoryId) async {
    final response = await http.post(
        "http://localhost/something/app/http/controllers/blogFilterController.php",
        body: {'categoryId': widget.categoryId});
    return json.decode(response.body);
    
  }

  @override
  Widget build(BuildContext context) {
    return new FutureBuilder<List>(
        future: filterData(widget.categoryId),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          return snapshot.hasData
              ? BasicSkincare(
                  list: snapshot.data,
                )
              : Center(child: new CircularProgressIndicator());
        });
  }
}
  }
}*/
