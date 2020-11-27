import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:lodash_dart/lodash_dart.dart';
import 'package:ponny/common/constant.dart';
import 'package:ponny/model/Brand.dart';
import 'package:http/http.dart' as http;
import 'package:ponny/util/globalUrl.dart';

import 'Detail_Brand_Screen.dart';

class Browse_Brands extends StatefulWidget {
  Browse_Brands({Key key}) : super(key: key);

  @override
  _Browse_BrandsState createState() => _Browse_BrandsState();
}

class _Browse_BrandsState extends State<Browse_Brands> {
  final _controller = ScrollController();
  final _height = 500.0;
  bool LoadingBrand = true;
  List<Brand> listBrand =[];
  var alphabets = [];

  void initState() {
    super.initState();
    getBrandAll();
  }


  Future<void> getBrandAll() async {
    final result = await http.get(brandSearch);
    if(result.statusCode == 200){
      final respone =  json.decode(result.body);
      setState(() {
        for(Map item in respone){
          var brand = Brand.fromJson(item);
          listBrand.add(brand);
          alphabets.add(brand.name.substring(0,1).toUpperCase());
        }
        LoadingBrand =false;
      });
    }
  }


  _animateToIndex(i) => _controller.animateTo(_height * i,
      duration: Duration(seconds: 2), curve: Curves.fastOutSlowIn);
  @override
  Widget build(BuildContext context) {
    final alphabetsUniq = Lodash().uniq(array: alphabets);
    return Scaffold(
      backgroundColor: Color(0xffFDF8F0),
      floatingActionButton: LoadingBrand?Container() :Container(
          decoration: BoxDecoration(
            color: Hexcolor('#F48262'),
            borderRadius: BorderRadius.circular(10),
          ),
          width: 20.0,
          height: 400.0,
          child: ListView.builder(
              itemCount: alphabetsUniq.length,
              itemBuilder: (context, i) {
                return new FlatButton(
                    onPressed: () {
                      if(i==0){
                        return _animateToIndex(i);
                      }else{
                        return _animateToIndex(i+1);
                      }

                    },
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    padding: EdgeInsets.symmetric(vertical: 3),
                    height: 0,
                    child: Text(
                      alphabetsUniq[i],
                      style: TextStyle(
                          fontSize: 12,
                          fontFamily: 'Brandon',
                          color: Colors.white),
                    ));
              })),
      body: LoadingBrand? Container(
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: LoadingWidgetFadingCircle(context),
        ),
      ):
      ListView.builder(
          controller: _controller,
          itemCount: alphabetsUniq.length,
          itemBuilder: (context, i) {
            return Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 35,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      margin: EdgeInsets.only(left: 20),
                      child: Text(
                        alphabetsUniq[i],
                        style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'Brandon',
                            fontWeight: FontWeight.w800,
                            letterSpacing: 1,
                            color: Colors.black),
                      ),
                    ),
                  ),
                  color: Color(0xffFBDFD2),
                ),
                InkWell(
                  onTap: (){
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: listBrand.where((element) => element.name.startsWith(alphabetsUniq[i])).map((e){
                          return InkWell(
                            onTap: (){
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => DetailBrand(brand:e,)),
                              );
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  child: Text(e.name,
                                    style: TextStyle(
                                      fontFamily: 'Brandon'
                                    ),
                                  ),
                                  margin: EdgeInsets.fromLTRB(25, 10, 20, 5),
                                ),
                                Container(
                                  color: Colors.black26,
                                  height: 1,
                                  width: double.infinity,
                                  margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                                )
                              ],
                            ),
                          );
                        }).toList()
                      )),
                ),
              ],
            );
          }),
    );
  }
}
