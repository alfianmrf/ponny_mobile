import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:lodash_dart/lodash_dart.dart';
import 'package:ponny/model/App.dart';
import 'package:ponny/model/User.dart';
import 'package:ponny/screens/home_screen.dart';
import 'package:ponny/screens/account_screen.dart';
import 'package:ponny/screens/account/edit_beauty_profile_screen.dart';
import 'package:ponny/widgets/PonnyBottomNavbar.dart';
import 'package:provider/provider.dart';

class BeautyProfileScreen extends StatefulWidget {
  static const String id = "beauty_profile_Screen";
  @override
  _BeautyProfileStateScreen createState() => _BeautyProfileStateScreen();
}

class _BeautyProfileStateScreen extends State<BeautyProfileScreen> {
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

    });

  }

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<UserModel>(context).user;
     bool isComplete (){
       if(user.warna_kulit != null && user.jenis_kulit != null && user.kondisi_kulit != null && user.kondisi_rambut != null && user.preferensi_product !=null ) return true;
       return false;
     }
    if(isComplete()){
      setState(() {
        listwarnaKulit.forEach((element) {
          element.value =0;
        });
        listJenisKulit.forEach((element) {
          element.Value =0;
        });
        KondisiKulit.forEach((element) {
          element.Value =0;
        });
        KondisiRambut.forEach((element) {
          element.Value =0;
        });
        PreferensiProduk.forEach((element) {
          element.Value =0;
        });
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
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Hexcolor('#FCF8F0'),
      appBar: AppBar(
        elevation: 0,
        titleSpacing: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Color(0xffF48262),
            size: 26,
          ),
        ),
        title:  Text(
          "Profil Kecantikan",
          style: TextStyle(
            fontSize: 24,
            fontFamily: "Yeseva",
            fontWeight: FontWeight.w500,
            color: Color(0xffF48262),
          ),
        ),
        bottom: PreferredSize(
            child: Container(
              color: Color(0xffF48262),
              height: 1.0,
            ),
            preferredSize: Size.fromHeight(1.0)),
      ),
      body: !isComplete()? Center(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width*.7,

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.center,
                child: Text("SEDIKIT LAGI UNTUK DAPATKAN BONUS POIN!",style: TextStyle( fontWeight: FontWeight.bold,fontSize: 18,fontFamily: 'Brandon' ),textAlign: TextAlign.center,),
              ),
              Text("Lengkapi halaman Beauty Profile dan dapatkan 50 poin rewards!",textAlign: TextAlign.center,style: TextStyle(fontFamily: 'Brandon'),),
              FlatButton(
                color: Color(0xffF48262),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                textColor: Colors.white,
                disabledColor: Colors.grey,
                disabledTextColor: Colors.black,
                padding: EdgeInsets.all(8.0),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditBeautyProfileScreen(),
                    ),
                  );
                },
                child: Text(
                  "YUK, LENGKAPI!",
                  style: TextStyle(fontSize: 20.0, fontFamily: 'Brandon'),
                ),
              )

            ],
          ),
        ),
      ): 
      SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Hexcolor('#F48262'),
                    width: 1,
                  ),
                ),
                // color: Colors.cyanAccent,
              ),
              margin: EdgeInsets.only(
                left: 20,
                right: 20,
                top: 10,
              ),
              padding: EdgeInsets.only(top: 0, bottom: 20),
              child: Row(
                children: [
                  Container(
                    width: 100,
                    // color: Colors.redAccent,
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "WARNA\nKULIT",
                        style: TextStyle(
                          fontFamily: "Brandon",
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    // color: Colors.redAccent,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: listwarnaKulit.where((element) => element.value == 1).map((e){
                        print(e);
                        return Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(
                                top: 30,
                              ),
                              decoration: BoxDecoration(
                                color: Hexcolor(e.Hexcolor),
                                borderRadius:
                                BorderRadius.all(Radius.circular(100)),
                              ),
                              width: 65,
                              height: 60,
                            ),
                            Container(
                              padding: EdgeInsets.only(
                                top: 5,
                              ),
                              width: 65,
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
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Hexcolor('#F48262'),
                    width: 1,
                  ),
                ),
                // color: Colors.cyanAccent,
              ),
              margin: EdgeInsets.only(
                left: 20,
                right: 20,
                top: 10,
              ),
              padding: EdgeInsets.only(top: 20, bottom: 20),
              child: Row(
                children: [
                  Container(
                    width: 100,
                    // color: Colors.redAccent,
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "JENIS\nKULIT",
                        style: TextStyle(
                          fontFamily: "Brandon",
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    // color: Colors.redAccent,
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:listJenisKulit.where((element) => element.Value ==1).map((e){
                          return Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Hexcolor('#F48262'),
                                    width: 1,
                                  ),
                                  borderRadius:
                                  BorderRadius.only(topLeft: Radius.circular(5), topRight: Radius.circular(5)),
                                ),
                                width: 65,
                                height: 90,
                                child: Image.asset(
                                 e.Gambar,
                                  width: 30,
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Hexcolor('#F48262'),
                                  border: Border.all(
                                    color: Hexcolor('#F48262'),
                                    width: 1,
                                  ),
                                  borderRadius:
                                  BorderRadius.only(bottomLeft: Radius.circular(5), bottomRight: Radius.circular(5)),
                                ),
                                padding: EdgeInsets.only(
                                  top: 5,
                                ),
                                width: 65,
                                height: 28,
                                child: Text(
                                  e.Label,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: "Brandon",
                                    fontSize: 12,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          );
                        }).toList()
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Hexcolor('#F48262'),
                    width: 1,
                  ),
                ),
                // color: Colors.cyanAccent,
              ),
              margin: EdgeInsets.only(
                left: 20,
                right: 20,
                top: 10,
              ),
              padding: EdgeInsets.only(top: 20, bottom: 20),
              child: Row(
                children: [
                  Container(
                    width: 100,
                    // color: Colors.redAccent,
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "KONDISI\nKULIT",
                        style: TextStyle(
                          fontFamily: "Brandon",
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        for(List<ParamVariable> item in Lodash().chunk(array: KondisiKulit.where((element) => element.Value ==1).toList(), size: 3))(
                            Container(
                              width: 220,
                              height: 120,
                              margin: EdgeInsets.only(bottom: 10),
                              // color: Colors.redAccent,
                              child: Row(
                                children: item.map((e) {
                                  return Container(
                                    margin: EdgeInsets.only(
                                      right: 5,
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: Hexcolor('#F48262'),
                                              width: 1,
                                            ),
                                            borderRadius:
                                            BorderRadius.only(topLeft: Radius.circular(5), topRight: Radius.circular(5)),
                                          ),
                                          width: 65,
                                          height: 90,
                                          child: Image.asset(
                                            e.Gambar,
                                            width: 30,
                                          ),
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            color: Hexcolor('#F48262'),
                                            border: Border.all(
                                              color: Hexcolor('#F48262'),
                                              width: 1,
                                            ),
                                            borderRadius:
                                            BorderRadius.only(bottomLeft: Radius.circular(5), bottomRight: Radius.circular(5)),
                                          ),
                                          padding: EdgeInsets.only(
                                            top: 5,
                                          ),
                                          width: 65,
                                          height: 28,
                                          child: Text(
                                            e.Label,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontFamily: "Brandon",
                                              fontSize: 12,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }).toList()
                              ),
                            )
                        )
                      ],
                    ),
                  )

                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Hexcolor('#F48262'),
                    width: 1,
                  ),
                ),
                // color: Colors.cyanAccent,
              ),
              margin: EdgeInsets.only(
                left: 20,
                right: 20,
                top: 10,
              ),
              padding: EdgeInsets.only(top: 20, bottom: 20),
              child: Row(
                children: [
                  Container(
                    width: 100,
                    // color: Colors.redAccent,
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "KONDISI\nRAMBUT",
                        style: TextStyle(
                          fontFamily: "Brandon",
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        for(List<ParamVariable> item in Lodash().chunk(array: KondisiRambut.where((element) => element.Value ==1).toList(), size: 3))(
                            Container(
                              width: 220,
                              height: 120,
                              margin: EdgeInsets.only(bottom: 10),
                              // color: Colors.redAccent,
                              child: Row(
                                  children: item.map((e) {
                                    return Container(
                                      margin: EdgeInsets.only(
                                        right: 5,
                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: Hexcolor('#F48262'),
                                                width: 1,
                                              ),
                                              borderRadius:
                                              BorderRadius.only(topLeft: Radius.circular(5), topRight: Radius.circular(5)),
                                            ),
                                            width: 65,
                                            height: 90,
                                            child: Image.asset(
                                              e.Gambar,
                                              width: 30,
                                            ),
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                              color: Hexcolor('#F48262'),
                                              border: Border.all(
                                                color: Hexcolor('#F48262'),
                                                width: 1,
                                              ),
                                              borderRadius:
                                              BorderRadius.only(bottomLeft: Radius.circular(5), bottomRight: Radius.circular(5)),
                                            ),
                                            padding: EdgeInsets.only(
                                              top: 5,
                                            ),
                                            width: 65,
                                            height: 28,
                                            child: Text(
                                              e.Label,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontFamily: "Brandon",
                                                fontSize: 12,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }).toList()
                              ),
                            )
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                left: 20,
                right: 20,
                top: 10,
              ),
              padding: EdgeInsets.only(top: 20, bottom: 20),
              child: Row(
                children: [
                  Container(
                    width: 100,
                    // color: Colors.redAccent,
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "PREFERENSI\nPRODUK",
                        style: TextStyle(
                          fontFamily: "Brandon",
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        for(List<ParamVariable> item in Lodash().chunk(array: PreferensiProduk.where((element) => element.Value ==1).toList(), size: 3))(
                            Container(
                              width: 220,
                              height: 120,
                              margin: EdgeInsets.only(bottom: 10),
                              // color: Colors.redAccent,
                              child: Row(
                                  children: item.map((e) {
                                    return Container(
                                      margin: EdgeInsets.only(
                                        right: 5,
                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: Hexcolor('#F48262'),
                                                width: 1,
                                              ),
                                              borderRadius:
                                              BorderRadius.only(topLeft: Radius.circular(5), topRight: Radius.circular(5)),
                                            ),
                                            width: 65,
                                            height: 90,
                                            child: Image.asset(
                                              e.Gambar,
                                              width: 30,
                                            ),
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                              color: Hexcolor('#F48262'),
                                              border: Border.all(
                                                color: Hexcolor('#F48262'),
                                                width: 1,
                                              ),
                                              borderRadius:
                                              BorderRadius.only(bottomLeft: Radius.circular(5), bottomRight: Radius.circular(5)),
                                            ),
                                            padding: EdgeInsets.only(
                                              top: 5,
                                            ),
                                            width: 65,
                                            height: 28,
                                            child: Text(
                                              e.Label,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontFamily: "Brandon",
                                                fontSize: 12,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }).toList()
                              ),
                            )
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditBeautyProfileScreen(),
                  ),
                );
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Hexcolor('#F48262'),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                margin:
                    EdgeInsets.only(right: 20, left: 20, bottom: 20, top: 10),
                padding: EdgeInsets.only(top: 10, bottom: 10),
                child: Text(
                  "UBAH",
                  style: TextStyle(
                    fontFamily: "Brandon",
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: new PonnyBottomNavbar(selectedIndex: 4),
    );
  }
}
