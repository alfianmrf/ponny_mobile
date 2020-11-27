import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:ponny/common/constant.dart';
import 'package:ponny/model/App.dart';
import 'package:ponny/model/PointHistory.dart';
import 'package:ponny/model/User.dart';
import 'package:ponny/util/globalUrl.dart';
import 'package:ponny/widgets/PonnyBottomNavbar.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class RincianPoint extends StatefulWidget {
  static const String id = "RincianPoints";

  @override
  _RincianPointState createState() => _RincianPointState();
}

class _RincianPointState extends State<RincianPoint> {
  List<PointHistory> _result=[];

  int current_page=0;
  int last_page =0;
  String _valFriends;
  String _q ="";
  String NextPage;
  bool isLoading = true;
  bool loadingmore =false;
  ScrollController _scrollController = new ScrollController();

  @override
  void initState() {
    this._getMoreData();
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _getData();
    });

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _getMoreData();
      }
    });

  }

  Widget _buildProgressIndicator() {
    return new Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Center(
        child: new Opacity(
          opacity: isLoading ? 1.0 : 00,
          child: LoadingWidget(context),
        ),
      ),
    );
  }


  Future<Null> _getData()  async {
    setState(() {
      isLoading = true;
      NextPage=null;
      _result=[];
    });
    var token = Provider.of<AppModel>(context, listen: false).auth.access_token;
    final response = await http.get(historyPointurl,headers: { HttpHeaders.contentTypeHeader: 'application/json',HttpHeaders.authorizationHeader: "Bearer $token" });
    if(response.statusCode == 200)
    {
      final responseJson = json.decode(response.body);

      setState(() {
        for (Map item in responseJson['data']){
          _result.add(PointHistory.fromJson(item));
        }
        isLoading =false;
        current_page = responseJson['current_page'];
        last_page = responseJson['last_page'];
        NextPage = responseJson["next_page_url"];
      });
      print(_result.length);

    }else{

    }

  }

  void _getMoreData() async {
    if(NextPage != null && !isLoading  && current_page <= last_page){
      setState(() {
        isLoading = true;
        current_page ++;
      });
      var token = Provider.of<AppModel>(context).auth.access_token;
      final response = await http.get(NextPage,headers: { HttpHeaders.contentTypeHeader: 'application/json',HttpHeaders.authorizationHeader: "Bearer $token" });
      final responseJson = json.decode(response.body);
      print(responseJson);
      setState(() {
        for (Map item in responseJson["data"]) {
          _result.add(PointHistory.fromJson(item));
        }
      });
      setState(() {
        isLoading =false;
        NextPage = responseJson["next_page_url"];
        last_page = responseJson['last_page'];
      });
    }
  }

  Widget tabDiperoleh() {
    List<PointHistory> diperOleh = _result.where((element) => element.status == 1).toList();
    return ListView.builder(
        itemCount: diperOleh.length,
        itemBuilder: (builder, i) {
          final item =diperOleh[i] ;
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      item.createdAt,
                      style: TextStyle(
                        fontSize: 11,
                        fontFamily: "Brandon",
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    Text(
                      item.points.toString()+" POIN",
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: "Brandon",
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    Text(
                      item.keterangan,
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
        itemCount: _result.length,
        itemBuilder: (builder, i) {
          final item =_result[i] ;
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      item.createdAt,
                      style: TextStyle(
                        fontSize: 11,
                        fontFamily: "Brandon",
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    Text(
                      item.points.toString()+" POIN",
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: "Brandon",
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    Text(
                      item.keterangan,
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
    List<PointHistory> terpakai = _result.where((element) => element.status == 0).toList();
    return ListView.builder(
        itemCount: terpakai.length,
        itemBuilder: (builder, i) {
          final item =terpakai[i] ;
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      item.createdAt,
                      style: TextStyle(
                        fontSize: 11,
                        fontFamily: "Brandon",
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    Text(
                      item.points.toString()+" POIN",
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: "Brandon",
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    Text(
                      item.keterangan,
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

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel>(context).user;
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
                                  user.point.toString(),
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontFamily: "Brandon",
                                      color: Color(0xffF48262)),
                                ),
                              ),
                              FittedBox(
                                child: Text(
                                  " POIN",
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
                      child: isLoading? Container(
                        height: 250,
                        child: Center(

                          child: LoadingWidgetFadingCircle(context),
                        ),
                      ) : TabBarView(
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


