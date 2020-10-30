import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:lodash_dart/lodash_dart.dart';
import 'package:ponny/common/constant.dart';
import 'package:ponny/model/App.dart';
import 'package:ponny/model/User.dart';
import 'package:ponny/screens/home_screen.dart';
import 'package:ponny/screens/account_screen.dart';
import 'package:ponny/screens/account/edit_beauty_profile_screen.dart';
import 'package:ponny/util/globalUrl.dart';
import 'package:ponny/widgets/PonnyBottomNavbar.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:uiblock/uiblock.dart';

class EditBeautyProfileScreen extends StatefulWidget {
  static const String id = "edit_beauty_profile_Screen";
  @override
  _EditBeautyProfileStateScreen createState() =>
      _EditBeautyProfileStateScreen();
}

class _EditBeautyProfileStateScreen extends State<EditBeautyProfileScreen> {
  GlobalKey<ScaffoldState> scafoldKey = GlobalKey<ScaffoldState>();
  List<WarnaKulit> listwarnaKulit = [
    WarnaKulit(1,"#F1D7C3","Putih",0),
    WarnaKulit(2,"#F5CEA9","Kuning Langsat",0),
    WarnaKulit(3,"#E0A16E","Sawo Matang",0),
    WarnaKulit(4,"#6A4332","Gelap",0)
  ];

  List<ParamVariable> listJenisKulit =[
    ParamVariable(1,"assets/images/kulit-normal.png", "Normal", 0),
    ParamVariable(2,"assets/images/kulit-kering.png", "Kering", 0),
    ParamVariable(3,"assets/images/kulit-berminyak.png", "Berminyak", 0),
    ParamVariable(4,"assets/images/kulit-kombinasi.png", "Kombinasi", 0),
    ParamVariable(5,"assets/images/kulit-sensitif.png", "Sensitif",0),
  ];
  
  List<ParamVariable> KondisiKulit=[
    ParamVariable(1,"assets/images/jerawat.png", "Jerawat", 0),
    ParamVariable(2,"assets/images/keriput.png", "Garis Halus \n/ Keriput", 0),
    ParamVariable(3,"assets/images/komedo.png", "Komedo", 0),
    ParamVariable(4,"assets/images/pori-besar.png",  "Pori Besar", 0),
    ParamVariable(5,"assets/images/kulit-kusam.png", "Kulit Kusam", 0),
    ParamVariable(6,"assets/images/darkspot.png", "Dark Spot", 0),
    ParamVariable(7,"assets/images/kantung-mata.png", "Kantung \n Mata", 0),
    ParamVariable(8,"assets/images/kemerahan.png", "Kemerahan", 0),
    ParamVariable(9,"assets/images/flek.png", "Flek", 0)
  ];

  List<ParamVariable> KondisiRambut=[
    ParamVariable(1,"assets/images/ketombe.png", "Ketombe", 0),
    ParamVariable(2,"assets/images/rontok.png", "Rontok", 0),
    ParamVariable(3,"assets/images/bercabang.png", "Bercabang", 0),
    ParamVariable(4,"assets/images/kusut.png", "Kusut", 0),
    ParamVariable(5,"assets/images/kusam.png", "Kusam", 0),
  ];

  List<ParamVariable> PreferensiProduk=[
    ParamVariable(1,"assets/images/indonesia.png", "Lokal", 0),
    ParamVariable(2,"assets/images/korea.png", "Korean", 0),
    ParamVariable(3,"assets/images/amerika.png", "Western", 0),
  ];

  @override
  void initState() {

    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      User user = Provider.of<UserModel>(context).user;
      setState(() {
        listwarnaKulit.firstWhere((element) => element.id == user.warna_kulit).value =1;
        listJenisKulit.firstWhere((element) => element.id == user.jenis_kulit).Value =1;
        for(int i in json.decode(user.kondisi_kulit)){
          KondisiKulit.firstWhere((element) => element.id == i).Value =1;
        }
        for(int i in json.decode(user.kondisi_rambut)){
          KondisiRambut.firstWhere((element) => element.id == i).Value =1;
        }
        for(int i in json.decode(user.preferensi_product)){
          PreferensiProduk.firstWhere((element) => element.id == i).Value =1;
        }
      });
    });

  }

  setWarnaKulit(WarnaKulit index){
    setState(() {
      listwarnaKulit.forEach((element) {
        element.value =0;
      });
      listwarnaKulit.singleWhere((element) => element.Label == index.Label).value =1;
    });
  }
  setJenisKulit(ParamVariable index){
    setState(() {
      listJenisKulit.forEach((element) {
        element.Value =0;
      });
      listJenisKulit.singleWhere((element) => element.Label == index.Label).Value =1;
    });
  }

  bool validation(){

    final jmlListWarnkulit = listwarnaKulit.where((element) => element.value == 1);
    final jmlJenisKulit = listJenisKulit.where((element) => element.Value == 1);
    final jmlKondisiRambut = KondisiRambut.where((element) => element.Value == 1);
    final jmlKondisiKulit = KondisiKulit.where((element) => element.Value == 1);
    final jmlPrefrensi = PreferensiProduk.where((element) => element.Value == 1);
    if(jmlListWarnkulit.length > 0 && jmlJenisKulit.length>0 && jmlKondisiRambut.length>0 && jmlKondisiKulit.length>0 && jmlPrefrensi.length>0){

      return true;
    }else{
      String Pesan;
      if(jmlListWarnkulit.length<=0){
        Pesan = "Pilih Warna Kulit";
      }else if(jmlJenisKulit.length<=0){
        Pesan = "Pilih Jenis Kulit";
      }else if(jmlKondisiRambut.length<=0){
        Pesan = "Pilih Kondisi Rambut Minimal 1.";
      }else if(jmlKondisiKulit.length<=0){
        Pesan = "Pilih Kondisi Kulit Minimal 1.";
      }else if(jmlPrefrensi.length<=0){
        Pesan = "Pilih Preferensi Produk Minimal 1.";
      }

      final snackBarError = SnackBar(
        content: Text(Pesan,style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.redAccent,
      );
      scafoldKey.currentState.showSnackBar(snackBarError);
      return false;
    }
  }
  Future<bool>_simpan() async {

    String token = Provider.of<AppModel>(context).auth.access_token;
    WarnaKulit _warnaKulit = listwarnaKulit.firstWhere((element) => element.value == 1);
    ParamVariable _jenisKulit = listJenisKulit.firstWhere((element) => element.Value == 1);
    List<int> _kondisiKulit = [];
    List<int> _kondisiRambut = [];
    List<int> _prefrensi = [];
    KondisiKulit.forEach((element) { if(element.Value == 1) _kondisiKulit.add(element.id);});
    KondisiRambut.forEach((element) { if(element.Value == 1) _kondisiRambut.add(element.id);});
    PreferensiProduk.forEach((element) { if(element.Value == 1) _prefrensi.add(element.id);});
    final param ={
      "jenis_kulit": _jenisKulit.id,
      "warna_kulit": _warnaKulit.id,
      "kondisi_kulit":"["+_kondisiKulit.join(',')+"]",
      "kondisi_rambut":"["+_kondisiRambut.join(',')+"]",
      "preferensi_produk":"["+_prefrensi.join(',')+"]"
    };

    final res = await http.post(updateBeauteProfile, headers: { HttpHeaders.contentTypeHeader: 'application/json', HttpHeaders.authorizationHeader: "Bearer $token"}, body: json.encode(param));

    if(res.statusCode == 200){
      await Provider.of<UserModel>(context).getUser(token);
      return true;
    }
    return false;
  }

  void showAlertDialog(BuildContext context) {
    // set up the AlertDialog
    var container = Container(
      alignment: Alignment.center,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Image.asset(
          "assets/images/kulit-kering.png",
          width: 60,
        ),
      ),
    );
    SimpleDialog alert = SimpleDialog(
      backgroundColor: Color(0xfffdf8f0),
      contentPadding: EdgeInsets.all(0.0),
      children: <Widget>[
        Container(
          // color: Colors.greenAccent,
          margin: EdgeInsets.only(top: 10, bottom: 0),
          child: Column(
            children: [
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      // color: Colors.amberAccent,
                      child: Text(
                        "APA JENIS KULIT KAMU ?",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: "Brandon",
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                // color: Colors.amberAccent,
                child: Row(
                  children: [
                    Container(
                      child: Column(
                        children: [
                          Container(
                            width: 80,
                            height: 80,
                            // color: Colors.blueAccent,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  alignment: Alignment.center,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10.0),
                                    child: Image.asset(
                                      "assets/images/kulit-berminyak.png",
                                      width: 60,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: 80,
                            height: 38,
                            // color: Colors.redAccent,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  child: Text(
                                    "Kulit",
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontFamily: "Brandon",
                                    ),
                                  ),
                                ),
                                Container(
                                  child: Text(
                                    "Berminyak",
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontFamily: "Brandon",
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 118,
                      width: 240,
                      // color: Colors.purpleAccent,
                      child: Text(
                        'Kulit berminyak ditandai dengan pori-pori besar yang mudah terlihat. Produksi sebum atau minyak pada wajahmu tergolong banyak sehingga kulit wajah akan terlihat berminyak hampir di seluruh bagian wajah.',
                        style: TextStyle(
                          fontFamily: "Brandon",
                          fontSize: 11,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 15),
                // color: Colors.amberAccent,
                child: Row(
                  children: [
                    Container(
                      child: Column(
                        children: [
                          Container(
                            width: 80,
                            height: 80,
                            // color: Colors.blueAccent,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  alignment: Alignment.center,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10.0),
                                    child: Image.asset(
                                      "assets/images/kulit-kombinasi.png",
                                      width: 60,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: 80,
                            height: 38,
                            // color: Colors.redAccent,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  child: Text(
                                    "Kulit",
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontFamily: "Brandon",
                                    ),
                                  ),
                                ),
                                Container(
                                  child: Text(
                                    "Kombinasi",
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontFamily: "Brandon",
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 118,
                      width: 240,
                      // color: Colors.purpleAccent,
                      child: Text(
                        'Kulit kombinasi ditandai dengan wajah yang berminyak di area dahi, batang hidung, dan dagu (T-Zone) sementara area pipi dan rahang (U-Zone) tergolong kering. Biasanya pori-pori terlihat jelas di area T-Zone.',
                        style: TextStyle(
                          fontFamily: "Brandon",
                          fontSize: 11,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 15),
                // color: Colors.amberAccent,
                child: Row(
                  children: [
                    Container(
                      child: Column(
                        children: [
                          Container(
                            width: 80,
                            height: 80,
                            // color: Colors.blueAccent,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  alignment: Alignment.center,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10.0),
                                    child: Image.asset(
                                      "assets/images/kulit-normal.png",
                                      width: 60,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: 80,
                            height: 38,
                            // color: Colors.redAccent,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  child: Text(
                                    "Kulit",
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontFamily: "Brandon",
                                    ),
                                  ),
                                ),
                                Container(
                                  child: Text(
                                    "Normal",
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontFamily: "Brandon",
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 118,
                      width: 240,
                      // color: Colors.purpleAccent,
                      child: Text(
                        'Kulit normal ditandai dengan pori-pori kecil. Jenis kulit normal punya produksi minyak yang imbang sehingga kulit wajahmu nggak terlalu berminyak maupun kering.',
                        style: TextStyle(
                          fontFamily: "Brandon",
                          fontSize: 11,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 15),
                // color: Colors.amberAccent,
                child: Row(
                  children: [
                    Container(
                      child: Column(
                        children: [
                          Container(
                            width: 80,
                            height: 80,
                            // color: Colors.blueAccent,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                container,
                              ],
                            ),
                          ),
                          Container(
                            width: 80,
                            height: 38,
                            // color: Colors.redAccent,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  child: Text(
                                    "Kulit",
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontFamily: "Brandon",
                                    ),
                                  ),
                                ),
                                Container(
                                  child: Text(
                                    "Kering",
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontFamily: "Brandon",
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 118,
                      width: 240,
                      // color: Colors.purpleAccent,
                      child: Text(
                        'Kulit kering ditandai dengan kulit yang bersisik, terasa kencang, gatal, dan kusam. Produksi sebum yang kurang membuat kulit tetap kering sehingga jarang terlihat berminyak.',
                        style: TextStyle(
                          fontFamily: "Brandon",
                          fontSize: 11,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 15),
                // color: Colors.amberAccent,
                child: Row(
                  children: [
                    Container(
                      child: Column(
                        children: [
                          Container(
                            width: 80,
                            height: 80,
                            // color: Colors.blueAccent,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  alignment: Alignment.center,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10.0),
                                    child: Image.asset(
                                      "assets/images/kulit-sensitif.png",
                                      width: 60,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: 80,
                            height: 38,
                            // color: Colors.redAccent,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  child: Text(
                                    "Kulit",
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontFamily: "Brandon",
                                    ),
                                  ),
                                ),
                                Container(
                                  child: Text(
                                    "Sensitif",
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontFamily: "Brandon",
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 118,
                      width: 240,
                      // color: Colors.purpleAccent,
                      child: Text(
                        'Kulit sensitif ditandai dengan kondisi kulit seperti rosacea, eczema, atau psoriasis. Umumnya kulit sensifitif akan menunjukkan reaksi iritasi seperti kemerahan atau sensasi terbakar setelah mencoba produk skincare baru dengan kandungan seperti fragrance.',
                        style: TextStyle(
                          fontFamily: "Brandon",
                          fontSize: 11,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            decoration: BoxDecoration(
              color: Color(0xffF3C1B5),
              borderRadius: BorderRadius.all(Radius.circular(0)),
            ),
            margin: EdgeInsets.only(top: 20),
            height: 50,
            width: MediaQuery.of(context).size.width,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: Text(
                    "MENGERTI",
                    style: TextStyle(
                      fontFamily: "Brandon",
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      key: scafoldKey,
      resizeToAvoidBottomInset: false,
      backgroundColor: Hexcolor('#FCF8F0'),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 70,
            ),
            Container(
              padding: EdgeInsets.only(left: 15, bottom: 15),
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 14),
                    child: GestureDetector(
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: Color(0xffF48262),
                        size: 26,
                      ),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  Container(
                    child: Text(
                      "Edit Beauty Profile",
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
              margin: EdgeInsets.only(top: 20, left: 20, right: 20),
              padding: EdgeInsets.only(bottom: 5),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Color(0xffF3C1B5),
                    width: 2,
                  ),
                ),
                // color: Colors.cyanAccent,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    // color: Colors.blueAccent,
                    child: Row(
                      children: [
                        Container(
                          child: Text(
                            "WARNA KULIT",
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: "Brandon",
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 1,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    // color: Colors.deepOrangeAccent,
                    padding: EdgeInsets.only(top: 5),
                    child: Row(
                      children: listwarnaKulit.map((e){
                       return Container(
                         margin: EdgeInsets.only(left: 10, right: 10),
                         child: Column(
                           children: [
                             Container(
                               // color: Colors.greenAccent,
                               width: 80,
                               height: 50,
                               child: Stack(
                                 alignment: Alignment.center,
                                 children: [
                                   GestureDetector(
                                     onTap: (){
                                       setWarnaKulit(e);
                                     },
                                     child: Container(
                                       decoration: BoxDecoration(
                                         color: Hexcolor(e.Hexcolor),
                                         borderRadius: BorderRadius.all(
                                             Radius.circular(100)),
                                       ),
                                       width: 50,
                                       height: 50,
                                     ),
                                   ),
                                   if(e.value == 1)
                                     Positioned(
                                       child: Icon(Icons.check_circle,color: Colors.green,),
                                     )
                                 ],
                               ),
                             ),
                             Container(
                               width: 80,
                               height: 20,
                               margin: EdgeInsets.only(
                                 top: 1,
                               ),
                               child: Text(
                                 e.Label,
                                 textAlign: TextAlign.center,
                                 style: TextStyle(
                                   fontFamily: "Brandon",
                                   fontSize: 12,
                                 ),
                               ),
                             ),
                           ],
                         ),
                       );
                      }).toList()
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              padding: EdgeInsets.only(top: 10, bottom: 15),
              decoration: BoxDecoration(
                // color: Colors.greenAccent,
                border: Border(
                  bottom: BorderSide(
                    color: Color(0xffF3C1B5),
                    width: 2,
                  ),
                ),
                // color: Colors.cyanAccent,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    // color: Colors.blueAccent,
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                            left: 10,
                          ),
                          child: Text(
                            "JENIS KULIT",
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: "Brandon",
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 1,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    // color: Colors.redAccent,
                    // color: Colors.blueAccent,
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                            left: 10,
                          ),
                          child: Text(
                            "Apa jenis kulit kamu ?",
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: "Yeseva",
                              fontSize: 10,
                              fontWeight: FontWeight.w200,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 5),
                          child: GestureDetector(
                            onTap: () {
                              showAlertDialog(context);
                            },
                            child: Text(
                              "Pelajari",
                              style: TextStyle(
                                color: Color(0xffF3C1B5),
                                fontFamily: "Yeseva",
                                fontSize: 10,
                                fontWeight: FontWeight.w200,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5),
                    child: Row(
                      children: listJenisKulit.map((e){
                        return Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Color(0xffF3C1B5),
                                width:
                                1, //                   <--- border width here
                              ),
                              borderRadius: BorderRadius.all(Radius.circular(7)),
                            ),
                            margin: EdgeInsets.only(left: 8, top: 5, right: 13),
                            width: 60,
                            height: 107,
                            child: Stack(
                              children: [
                                GestureDetector(
                                  onTap: (){
                                    setJenisKulit(e);
                                  },
                                  child: Container(
                                    width: 70,
                                    height: 70,
                                    child: Image.asset(
                                      e.Gambar,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  child:  Container(
                                    color: Color(0xffF3C1B5),
                                    width: 70,
                                    height: 35,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          child: Text(
                                            e.Label,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontFamily: "Brandon",
                                              fontSize: 10,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  bottom: 0,
                                ),
                                if(e.Value == 1)
                                  Positioned(
                                    child: Icon(Icons.check_circle,color: Colors.green,),
                                  )

                              ],
                              alignment: Alignment.topCenter,
                            ),
                        );
                      }).toList()
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              padding: EdgeInsets.only(top: 10, bottom: 15),
              decoration: BoxDecoration(
                // color: Colors.greenAccent,
                border: Border(
                  bottom: BorderSide(
                    color: Color(0xffF3C1B5),
                    width: 2,
                  ),
                ),
                // color: Colors.cyanAccent,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    // color: Colors.blueAccent,
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                            left: 10,
                          ),
                          child: Text(
                            "KONDISI KULIT",
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: "Brandon",
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 1,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    // color: Colors.redAccent,
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                            left: 10,
                          ),
                          child: Text(
                            "Bisa pilih lebih dari satu",
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: "Yeseva",
                              fontSize: 10,
                              fontWeight: FontWeight.w200,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  for(List<ParamVariable> params in Lodash().chunk(array: KondisiKulit, size: 5))(
                      Container(
                        margin: EdgeInsets.only(top: 5),
                        child: Row(
                          children: params.map((e) {
                            return Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Color(0xffF3C1B5),
                                  width:
                                  1, //                   <--- border width here
                                ),
                                borderRadius: BorderRadius.all(Radius.circular(7)),
                              ),
                              margin: EdgeInsets.only(left: 8, top: 5, right: 13),
                              width: 60,
                              height: 107,
                              child: Stack(
                                alignment: Alignment.topCenter,
                                children: [
                                  GestureDetector(
                                    onTap: (){
                                      final v =  KondisiKulit.firstWhere((element) => element.Label == e.Label).Value;
                                      print(v);
                                      setState(() {
                                        KondisiKulit.firstWhere((element) => element.Label == e.Label).Value = v == 0 ? 1 : 0;
                                      });
                                    },
                                    child: Container(
                                      width: 70,
                                      height: 70,
                                      child: Image.asset(
                                        e.Gambar,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    child: Container(
                                      color: Color(0xffF3C1B5),
                                      width: 70,
                                      height: 35,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            child: Text(
                                              e.Label,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontFamily: "Brandon",
                                                fontSize: 10,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  if(e.Value == 1)
                                    Positioned(
                                      child: Icon(Icons.check_circle,color: Colors.green,),
                                    )
                                ],
                              ),
                            );
                          }).toList()
                        ),
                      )
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              padding: EdgeInsets.only(top: 10, bottom: 15),
              decoration: BoxDecoration(
                // color: Colors.greenAccent,
                border: Border(
                  bottom: BorderSide(
                    color: Color(0xffF3C1B5),
                    width: 2,
                  ),
                ),
                // color: Colors.cyanAccent,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    // color: Colors.blueAccent,
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                            left: 10,
                          ),
                          child: Text(
                            "KONDISI RAMBUT",
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: "Brandon",
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 1,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    // color: Colors.redAccent,
                    // color: Colors.blueAccent,
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                            left: 10,
                          ),
                          child: Text(
                            "Bisa pilih lebih dari satu",
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: "Yeseva",
                              fontSize: 10,
                              fontWeight: FontWeight.w200,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5),
                    child: Row(
                      children: KondisiRambut.map((e){
                        return Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Color(0xffF3C1B5),
                              width:
                              1, //                   <--- border width here
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(7)),
                          ),
                          margin: EdgeInsets.only(left: 8, top: 5, right: 13),
                          width: 60,
                          height: 107,
                          child: Stack(
                            alignment: Alignment.topCenter,
                            children: [
                              GestureDetector(
                                onTap: (){
                                  final v =  KondisiRambut.firstWhere((element) => element.Label == e.Label).Value;
                                  print(v);
                                  setState(() {
                                    KondisiRambut.firstWhere((element) => element.Label == e.Label).Value = v == 0 ? 1 : 0;
                                  });
                                },
                                child: Container(
                                  width: 70,
                                  height: 70,
                                  child: Image.asset(
                                    e.Gambar,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                child: Container(
                                  color: Color(0xffF3C1B5),
                                  width: 70,
                                  height: 35,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        child: Text(
                                          e.Label,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontFamily: "Brandon",
                                            fontSize: 10,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              if(e.Value == 1)
                                Positioned(
                                  child: Icon(Icons.check_circle,color: Colors.green,),
                                )

                            ],
                          ),
                        );
                      }).toList()
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              padding: EdgeInsets.only(top: 10, bottom: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    // color: Colors.blueAccent,
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                            left: 10,
                          ),
                          child: Text(
                            "PREFERENSI PRODUK",
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: "Brandon",
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 1,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    // color: Colors.redAccent,
                    // color: Colors.blueAccent,
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                            left: 10,
                          ),
                          child: Text(
                            "Bisa pilih lebih dari satu",
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: "Yeseva",
                              fontSize: 10,
                              fontWeight: FontWeight.w200,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5),
                    child: Row(
                      children: PreferensiProduk.map((e) {
                        return Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Color(0xffF3C1B5),
                              width:
                              1, //                   <--- border width here
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(7)),
                          ),
                          margin: EdgeInsets.only(left: 8, top: 5, right: 13),
                          width: 60,
                          height: 107,
                          child: Stack(
                            alignment: Alignment.topCenter,
                            children: [
                              GestureDetector(
                                child: Container(
                                  width: 70,
                                  height: 70,
                                  child: Image.asset(
                                    e.Gambar,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                onTap: (){
                                  final v =  PreferensiProduk.firstWhere((element) => element.Label == e.Label).Value;
                                  print(v);
                                  setState(() {
                                    PreferensiProduk.firstWhere((element) => element.Label == e.Label).Value = v == 0 ? 1 : 0;
                                  });
                                },
                              ),
                              Positioned(
                                bottom: 0,
                                child:  Container(
                                  color: Color(0xffF3C1B5),
                                  width: 70,
                                  height: 35,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        child: Text(
                                          e.Label,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontFamily: "Brandon",
                                            fontSize: 10,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              if(e.Value == 1)
                                Positioned(
                                  child: Icon(Icons.check_circle,color: Colors.green,),
                                )

                            ],
                          ),
                        );
                      }).toList()
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: (){

              },
              child:Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Color(0xffF3C1B5),
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
                margin: EdgeInsets.only(
                  left: 20,
                  right: 20,
                  top: 40,
                  bottom: 40,
                ),
                padding: EdgeInsets.only(top: 15, bottom: 15),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap:(){
                        if(validation()){
                          UIBlock.block(context,customLoaderChild: LoadingWidget(context));
                          _simpan().then((value){
                            UIBlock.unblock(context);
                            if(value){
                              scafoldKey.currentState.showSnackBar(snackBarSuccess);
                            }else{
                              scafoldKey.currentState.showSnackBar(snackBarError);
                            }
                          });
                        }
                      },
                      child: Container(
                        child: Text(
                          "SIMPAN",
                          style: TextStyle(
                            fontFamily: "Brandon",
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),

                  ],
                ),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: new PonnyBottomNavbar(selectedIndex: 4),
    );
  }
}

class WarnaKulit{
  int id;
  String Hexcolor;
  String Label;
  int value;
  WarnaKulit(this.id, this.Hexcolor,this.Label,this.value);
}

class ParamVariable{
  int id;
  String Gambar;
  String Label;
  int Value;
  ParamVariable(this.id,this.Gambar,this.Label,this.Value);
}
