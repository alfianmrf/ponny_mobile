import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class Browse_Brands extends StatefulWidget {
  Browse_Brands({Key key}) : super(key: key);

  @override
  _Browse_BrandsState createState() => _Browse_BrandsState();
}

class _Browse_BrandsState extends State<Browse_Brands> {
  final _controller = ScrollController();
  final _height = 500.0;

  var alphabets = [
    'A',
    'B',
    'C',
    'D',
    'E',
    'F',
    'G',
    'H',
    'I',
    'J',
    'K',
    'L',
    'M',
    'N',
    'O',
    'P',
    'Q',
    'R',
    'S',
    'T',
    'U',
    'V',
    'W',
    'X',
    'Y',
    'Z'
  ];
  _animateToIndex(i) => _controller.animateTo(_height * i,
      duration: Duration(seconds: 2), curve: Curves.fastOutSlowIn);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Container(
          decoration: BoxDecoration(
            color: Hexcolor('#F48262'),
            borderRadius: BorderRadius.circular(50),
          ),
          width: 50.0,
          height: 300.0,
          child: ListView.builder(
              itemCount: alphabets.length,
              itemBuilder: (context, i) {
                return new RawMaterialButton(
                    onPressed: () {
                      return _animateToIndex(i);
                    },
                    shape: new CircleBorder(),
                    elevation: 0.0,
                    child: Text(
                      alphabets[i],
                      style: TextStyle(
                          fontSize: 12,
                          fontFamily: 'Brandon',
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1,
                          color: Colors.white),
                    ));
              })),
      body: ListView.builder(
          controller: _controller,
          itemCount: alphabets.length,
          itemBuilder: (context, i) {
            return Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 50,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      margin: EdgeInsets.all(10),
                      child: Text(
                        alphabets[i],
                        style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'Brandon',
                            fontWeight: FontWeight.w800,
                            letterSpacing: 1,
                            color: Hexcolor('#F48262')),
                      ),
                    ),
                  ),
                  color: Hexcolor('#FFC5AD'),
                ),
                Container(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Text("Aeris"),
                      margin: EdgeInsets.fromLTRB(25, 20, 0, 10),
                    ),
                    Container(
                      color: Colors.black,
                      height: 1,
                      width: double.infinity,
                      margin: EdgeInsets.fromLTRB(20, 0, 20, 20),
                    )
                  ],
                )),
              ],
            );
          }),
    );
  }
}
