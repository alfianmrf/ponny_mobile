import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:ponny/screens/Browse_Screen.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:ponny/widgets/PonnyBottomNavbar.dart';
import 'package:ponny/screens/product_details_screen.dart';
import 'package:ponny/common/constant.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:waterfall_flow/waterfall_flow.dart';

class HairAndMakeup extends StatefulWidget {
  static const String id = "HairAndMakeup_Screen";

  @override
  _HairAndMakeupState createState() => _HairAndMakeupState();
}

class _HairAndMakeupState extends State<HairAndMakeup> {
  int itemlength = 427;

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
                        Navigator.of(context)
                            .pushReplacementNamed(Browse.id);
                      },
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: Color(0xffF48262),
                        size: 26,
                      )),
                ),
                Container(
                  child: Text(
                    "Hair & Make Up",
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
                  top: BorderSide(
                    width: 1,
                    color: Color(0xffF48262),
                  ),
                ),
              ),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 2,
                itemBuilder: (context, i) {
                  return Container(
                      margin: EdgeInsets.all(10),
                      width: 100,
                      child: rectanglebutton(context, "BEAUTY & MAKE UP"));
                },
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
    );
  }
}

Widget rectanglebutton(context, String subtext) {
  return ButtonTheme(
    buttonColor: Hexcolor('#FCF8F0'),
    child: RaisedButton(
      onPressed: () {},
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              Icons.sanitizer_outlined,
              color: Color(0xffF48262),
              size: 50,
            ),
            Text(
              subtext,
              style: TextStyle(
                fontSize: 12,
                fontFamily: 'Brandon',
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(5.0),
      side: BorderSide(color: Hexcolor('#F48262')),
    ),
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
