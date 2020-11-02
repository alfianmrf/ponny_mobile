import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:ponny/common/constant.dart';
import 'package:ponny/widgets/PonnyBottomNavbar.dart';
import 'package:waterfall_flow/waterfall_flow.dart';

class DetailBrand extends StatefulWidget {
  static const String id = "Detail_Brand_Screen";

  @override
  _DetailBrandScreen createState() => _DetailBrandScreen();
}

class _DetailBrandScreen extends State<DetailBrand> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        titleSpacing: 0.0,
        elevation: 0.0,
        title: Container(
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
                  new InputDecoration.collapsed(hintText: ""),
                ))
          ]),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(50.0),
          child: Container(
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
                    "Aeris",
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
        ),
      ),
      backgroundColor: Hexcolor('#FCF8F0'),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.width * 0.5,
              color: Colors.white,
              child: CachedNetworkImage(
                imageUrl: "http://via.placeholder.com/350x150",
                placeholder: (context, url) => LoadingWidgetPulse(context),
                errorWidget: (context, url, error) => Image.asset('assets/images/basic.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    width: 1,
                    color: Color(0xffF48262),
                  ),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Headline About Brand',
                    style: TextStyle(
                      fontFamily: 'Yeseva',
                      fontSize: 16,
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top: 5)),
                  Text(
                    'Lorem ipsum dolor sit amet, constectur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                    style: TextStyle(
                      fontFamily: 'Brandon',
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '457 items',
                    style: TextStyle(
                      fontFamily: 'Brandon',
                      fontSize: 16,
                    ),
                  ),
                  FlatButton(
                    onPressed: (){
                      _settingModalBottomSheet(context);
                    },
                    color: Color(0xffF48262),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    height: 30,
                    child: Row(
                      children: [
                        Icon(
                          Icons.tune,
                          color: Colors.white,
                        ),
                        Text(
                          'Filter',
                          style: TextStyle(
                            fontFamily: 'Brandon',
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            WaterfallFlow.count(
              padding: EdgeInsets.fromLTRB(20.0, 0, 20.0, 10.0),
              shrinkWrap: true,
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 20,
              physics: ScrollPhysics(),
              children: [
                product(context),
                product(context),
                product(context),
                product(context),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: new PonnyBottomNavbar(selectedIndex: 1),
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

void _settingModalBottomSheet(context) {
  bool expandBrand = false;
  bool expandConcern = false;
  bool expandSkinType = false;
  bool expandPrice = false;
  List<String> checked = [];
  var _currentSliderValue = RangeValues(0, 3000);

  showModalBottomSheet(
      backgroundColor: Hexcolor('#FCF8F0'),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30))),
      context: context,
      builder: (builder) {
        return StatefulBuilder(builder: (BuildContext context, setState) {
          return Container(
            padding: EdgeInsets.all(10),
            height: 350.0,
            child: SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Icon(
                        Icons.keyboard_arrow_up,
                        color: Color(0xffF48262),
                      ),
                    ),
                    Center(
                      child: Container(
                        margin: EdgeInsets.only(bottom: 10),
                        child: Text(
                          "Filter",
                          style: TextStyle(
                            fontSize: 24,
                            fontFamily: "Yeseva",
                            fontWeight: FontWeight.w500,
                            color: Color(0xffF48262),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 1,
                      color: Color(0xffF3C1B5),
                    ),
                    Container(
                      margin: EdgeInsets.all(10),
                      child: Text(
                        "URUTKAN",
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: "Yeseva",
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    CheckboxGroup(
                        activeColor: Color(0xffF48262),
                        checked: checked,
                        onSelected: (List selected) => setState(() {
                          if (selected.length > 1) {
                            selected.removeAt(0);
                          } else {
                            print("only one");
                          }
                          checked = selected;
                        }),
                        labels: <String>[
                          "Terlaris",
                          "Baru",
                          "Harga: Tinggi - Rendah",
                          "Harga: Rendah - Tinggi"
                        ]),
                    Container(
                      margin: EdgeInsets.only(top: 10, bottom: 10),
                      height: 1,
                      color: Color(0xffF3C1B5),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: EdgeInsets.all(10),
                          child: Text(
                            "BRANDS",
                            style: TextStyle(
                              fontSize: 20,
                              fontFamily: "Yeseva",
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: Icon(expandBrand ? Icons.remove : Icons.add),
                          color: Color(0xffF48262),
                          onPressed: () {
                            setState(() {
                              expandBrand = !expandBrand;
                            });
                          },
                        )
                      ],
                    ),
                    Container(
                      child: expandBrand
                          ? Column(
                        children: [
                          checkboxtiles("Aeris"),
                          checkboxtiles("Biyu"),
                          checkboxtiles("iUNIK"),
                          checkboxtiles("Thayers"),
                          checkboxtiles("The Ordinary"),
                          checkboxtiles("Upmost Beauty"),
                        ],
                      )
                          : Container(),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        top: 10,
                        bottom: 10,
                      ),
                      height: 1,
                      color: Color(0xffF3C1B5),
                    ),
                    Container(
                      margin: EdgeInsets.all(10),
                      child: Text(
                        "BY PRICE",
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: "Yeseva",
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    RangeSlider(
                      activeColor: Color(0xffF48262),
                      values: _currentSliderValue,
                      min: 0,
                      max: 3000,
                      divisions: 6,
                      labels: RangeLabels(
                        "Rp." +
                            _currentSliderValue.start.round().toString() +
                            ".000",
                        "Rp." +
                            _currentSliderValue.end.round().toString() +
                            ".000",
                      ),
                      onChanged: (RangeValues values) {
                        setState(() {
                          _currentSliderValue = values;
                        });
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [Text("Rp.0"), Text("Rp 3.000.000")],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.all(10),
                            child: RaisedButton(
                              onPressed: () {
                                setState(() {});
                              },
                              color: Color(0xffF48262),
                              child: Text(
                                "RESET",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w800),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.all(10),
                            child: RaisedButton(
                              onPressed: () {},
                              color: Color(0xffF48262),
                              child: Text(
                                "GUNAKAN",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w800),
                              ),
                            ),
                          ),
                        )
                      ],
                    )
                  ]),
            ),
          );
        });
      });
}

Widget checkboxtiles(String subtext) {
  bool checkedvalue = false;
  return StatefulBuilder(
    builder: (BuildContext context, setState) {
      return Column(
        children: [
          CheckboxListTile(
            activeColor: Color(0xffF48262),
            title: Text(
              subtext,
              style: TextStyle(
                  fontSize: 18,
                  fontFamily: "Yeseva",
                  fontWeight: FontWeight.w500),
            ),
            value: checkedvalue,
            onChanged: (bool newValue) {
              setState(() {
                checkedvalue = newValue;
              });
            },
            controlAffinity:
            ListTileControlAffinity.leading, //  <-- leading Checkbox
          ),
        ],
      );
    },
  );
}
