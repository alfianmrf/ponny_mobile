import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:ponny/screens/Browse_Screen.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:ponny/widgets/PonnyBottomNavbar.dart';
import 'package:ponny/screens/product_details_screen.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:waterfall_flow/waterfall_flow.dart';

class Tools extends StatefulWidget {
  static const String id = "Skincare_Screen";

  @override
  _ToolsState createState() => _ToolsState();
}

class _ToolsState extends State<Tools> {
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
            padding: EdgeInsets.fromLTRB(5,5,5,0),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  width: 1,
                  color: Color(0xffF48262),
                ),
              ),
            ),
            child: Row(
              children: [
                Container(
                  child: IconButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pop();
                      },
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: Color(0xffF48262),
                        size: 26,
                      )),
                ),
                Container(
                  child: Text(
                    "Peralatan Kecantikan",
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
              width: double.infinity,
              height: 130,
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    width: 1,
                    color: Color(0xffF48262),
                  ),
                ),
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.all(10),
                      child: rectanglebutton(context, "CLEANSING &\nBRUSH", 'assets/images/browse/tools/cleansing brush.png'),
                    ),
                    Container(
                      margin: EdgeInsets.all(10),
                      child: rectanglebutton(context, "COTTON", 'assets/images/browse/tools/cotton.png'),
                    ),
                    Container(
                      margin: EdgeInsets.all(10),
                      child: rectanglebutton(context, "ELECTRONICS", 'assets/images/browse/tools/electronics.png'),
                    ),
                    Container(
                      margin: EdgeInsets.all(10),
                      child: rectanglebutton(context, "EYE &\nEYE BROW", 'assets/images/browse/tools/eye brow.png'),
                    ),
                    Container(
                      margin: EdgeInsets.all(10),
                      child: rectanglebutton(context, "MAKEUP\nPOUCH & BAG", 'assets/images/browse/tools/pouch.png'),
                    ),
                    Container(
                      margin: EdgeInsets.all(10),
                      child: rectanglebutton(context, "SPONGE", 'assets/images/browse/tools/sponge.png'),
                    ),
                    Container(
                      margin: EdgeInsets.all(10),
                      child: rectanglebutton(context, "BEAUTY\nROLLER", 'assets/images/browse/tools/roller.png'),
                    ),
                    Container(
                      margin: EdgeInsets.all(10),
                      child: rectanglebutton(context, "BRUSH &\nAPPLICATOR", 'assets/images/browse/tools/brush.png'),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '457 produk',
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
                      borderRadius: BorderRadius.circular(10),
                    ),
                    height: 30,
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/images/filter.png',
                          height: 16,
                        ),
                        Container(width: 10,),
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

Widget rectanglebutton(context, String subtext, String subimg) {
  return ButtonTheme(
    buttonColor: Colors.white,
    minWidth: 100.0,
    height: 100.0,
    padding: EdgeInsets.symmetric(horizontal: 0),
    child: RaisedButton(
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Tools()));
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            subimg,
            height: 55,
            width: 70,
            fit: BoxFit.contain,
          ),
          Container(height: 5,),
          Text(
            subtext,
            style: TextStyle(
              fontSize: 13,
              fontFamily: 'Brandon',
              height: 1,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
      side: BorderSide(color: Hexcolor('#F48262')),
    ),
  );
}

Widget product(context) {
  return Column(
    children: <Widget>[
      Container(
        child: Stack(
          children: <Widget>[
            GestureDetector(
              onTap: () {
                Navigator.of(context)
                    .pushReplacementNamed(ProductDetailsScreen.id);
              },
              child: Image.asset(
                "assets/images/produk.png",
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10.0),
              child: Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.0),
                      child: const Text(
                        '35%',
                        style: TextStyle(
                            color: Colors.white, fontFamily: 'Brandon'),
                      ),
                    ),
                    color: Color(0xffF48262),
                  )),
            ),
            Padding(
              padding: EdgeInsets.all(5.0),
              child: Align(
                alignment: Alignment.topRight,
                child: Icon(
                  Icons.favorite_border,
                  color: Color(0xffF48262),
                  size: 20,
                ),
              ),
            ),
          ],
        ),
      ),
      Container(
        alignment: Alignment.bottomCenter,
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(vertical: 3),
          child: const Text(
            'TAMBAHKAN',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontFamily: 'Brandon'),
          ),
          color: Color(0xffF3C1B5),
        ),
      ),
      Padding(
        padding: EdgeInsets.only(top: 7.0),
        child: Text(
          'Skin Game',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Yeseva',
            fontSize: 16,
          ),
        ),
      ),
      Text(
        'Acne Warrior',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontFamily: 'Brandon',
          fontSize: 14,
        ),
      ),
      Text(
        'Rp. 125.000',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontFamily: 'Brandon',
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      ),
      Center(
        child: RichText(
          text: TextSpan(
              text: 'Rp. 125.000',
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'Brandon',
                fontSize: 12,
                decoration: TextDecoration.lineThrough,
              ),
              children: [
                TextSpan(
                  text: '(35%)',
                  style: TextStyle(
                    color: Color(0xffF48262),
                    fontFamily: 'Brandon',
                    fontSize: 12,
                    decoration: TextDecoration.none,
                  ),
                ),
              ]),
        ),
      ),
      Text.rich(TextSpan(children: <InlineSpan>[
        WidgetSpan(
          child: RatingBar(
            initialRating: 4,
            minRating: 1,
            direction: Axis.horizontal,
            allowHalfRating: true,
            itemCount: 5,
            itemSize: 14.0,
            itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
            itemBuilder: (context, index) => Icon(
              Icons.favorite,
              color: Color(0xffF48262),
            ),
            unratedColor: Color(0xffFBD2CD),
          ),
        ),
        TextSpan(
            text: '(5)',
            style: TextStyle(
              fontSize: 12,
            ))
      ])),
    ],
  );
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
