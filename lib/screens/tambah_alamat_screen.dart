import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:ponny/screens/home_screen.dart';
import 'package:ponny/screens/account_screen.dart';
import 'package:ponny/screens/daftar_keinginan_sukses_screen.dart';
import 'package:ponny/widgets/PonnyBottomNavbar.dart';

class TambahAlamatScreen extends StatefulWidget {
  static const String id = "tambah_alamat_Screen";
  @override
  _TambahAlamatStateScreen createState() => _TambahAlamatStateScreen();
}

class _TambahAlamatStateScreen extends State<TambahAlamatScreen> {
  List<String> province = [
    "Jawa Timur",
    "Jawa Barat",
    "Jawa Tengah",
    "DKI Jakarta",
  ];

  List<String> city = [
    "Jakarta Utara",
    "Jakarta Barat",
    "Jakarta Timur",
    "Bogor",
  ];

  List<String> district = [
    "Penjaringan",
    "Kebonsari",
    "Jambangan",
  ];

  String prov = "DKI Jakarta";
  String kota = "Jakarta Utara";
  String distrik = "Penjaringan";

  void onChanged(String value) {
    setState(() {
      prov = value;
    });
  }

  void onChangedKota(String value) {
    setState(() {
      kota = value;
    });
  }

  void onChangedDistrik(String value) {
    setState(() {
      distrik = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      "Tambah Alamat Baru",
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
              margin: EdgeInsets.only(left: 20, top: 20, right: 20),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Color(0xffF48262),
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(7),
              ),
              padding: EdgeInsets.only(
                right: 20,
                left: 20,
                top: 15,
                bottom: 30,
              ),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(bottom: 5),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Color(0xffF48262),
                          width: 1,
                        ),
                      ),
                    ),
                    child: TextFormField(
                      style: TextStyle(
                        fontFamily: "Brandon",
                        fontSize: 17,
                        fontWeight: FontWeight.w300,
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        labelText: 'Full Name',
                        hintText: 'Nama Lengkap',
                        labelStyle: TextStyle(color: Colors.black),
                        isDense: true,
                      ),
                      keyboardType: TextInputType.name,
                      maxLines: 1,
                      minLines: 1,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(bottom: 5),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Color(0xffF48262),
                          width: 1,
                        ),
                      ),
                    ),
                    child: TextFormField(
                      style: TextStyle(
                        fontFamily: "Brandon",
                        fontSize: 17,
                        fontWeight: FontWeight.w300,
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        labelText: 'Address',
                        hintText: 'Alamat Anda',
                        labelStyle: TextStyle(color: Colors.black),
                        isDense: true,
                      ),
                      keyboardType: TextInputType.name,
                      maxLines: 1,
                      minLines: 1,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(bottom: 8, top: 5),
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      children: [
                        DropdownButtonFormField(
                          decoration: InputDecoration(
                            border: UnderlineInputBorder(
                              borderSide: new BorderSide(color: Colors.red),
                            ),
                          ),
                          isExpanded: true,
                          // value: prov,
                          icon: Icon(
                            Icons.arrow_forward_ios,
                          ),
                          iconSize: 20,
                          iconEnabledColor: Color(0xffF48262),
                          iconDisabledColor: Color(0xffF48262),
                          hint: Text(
                            "Province",
                            style: TextStyle(
                              fontFamily: "Brandon",
                              fontSize: 15,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          items: province.map((String val) {
                            return DropdownMenuItem(
                              value: val,
                              child: Container(
                                child: Text(
                                  val,
                                  style: TextStyle(
                                    fontFamily: "Brandon",
                                    fontSize: 15,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                          onChanged: (String value) {
                            onChanged(value);
                          },
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(bottom: 8, top: 5),
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      children: [
                        DropdownButtonFormField(
                          decoration: InputDecoration(
                            border: UnderlineInputBorder(
                              borderSide: new BorderSide(color: Colors.red),
                            ),
                          ),
                          isExpanded: true,
                          // value: kota,
                          icon: Icon(Icons.arrow_forward_ios),
                          iconSize: 20,
                          iconEnabledColor: Color(0xffF48262),
                          iconDisabledColor: Color(0xffF48262),
                          hint: Text(
                            "City",
                            style: TextStyle(
                              fontFamily: "Brandon",
                              fontSize: 15,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          items: city.map((String val) {
                            return DropdownMenuItem(
                              value: val,
                              child: Container(
                                child: Text(
                                  val,
                                  style: TextStyle(
                                    fontFamily: "Brandon",
                                    fontSize: 15,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                          onChanged: (String value) {
                            onChangedKota(value);
                          },
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(bottom: 8, top: 5),
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      children: [
                        DropdownButtonFormField(
                          decoration: InputDecoration(
                            border: UnderlineInputBorder(
                              borderSide: new BorderSide(color: Colors.red),
                            ),
                          ),
                          isExpanded: true,
                          // value: distrik,
                          icon: Icon(Icons.arrow_forward_ios),
                          iconSize: 20,
                          iconEnabledColor: Color(0xffF48262),
                          iconDisabledColor: Color(0xffF48262),
                          hint: Text(
                            "District",
                            style: TextStyle(
                              fontFamily: "Brandon",
                              fontSize: 15,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          items: district.map((String val) {
                            return DropdownMenuItem(
                              value: val,
                              child: Container(
                                child: Text(
                                  val,
                                  style: TextStyle(
                                    fontFamily: "Brandon",
                                    fontSize: 15,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                          onChanged: (String value) {
                            onChangedDistrik(value);
                          },
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(bottom: 5),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Color(0xffF48262),
                          width: 1,
                        ),
                      ),
                    ),
                    child: TextFormField(
                      style: TextStyle(
                        fontFamily: "Brandon",
                        fontSize: 17,
                        fontWeight: FontWeight.w300,
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        labelText: 'Postal Code',
                        hintText: 'Kode Pos',
                        labelStyle: TextStyle(color: Colors.black),
                        isDense: true,
                      ),
                      keyboardType: TextInputType.number,
                      maxLines: 1,
                      minLines: 1,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(bottom: 5),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Color(0xffF48262),
                          width: 1,
                        ),
                      ),
                    ),
                    child: TextFormField(
                      style: TextStyle(
                        fontFamily: "Brandon",
                        fontSize: 17,
                        fontWeight: FontWeight.w300,
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        labelText: 'Contact Number',
                        hintText: 'Nomor Telepon',
                        labelStyle: TextStyle(color: Colors.black),
                        isDense: true,
                      ),
                      keyboardType: TextInputType.phone,
                      maxLines: 1,
                      minLines: 1,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Color(0xffF48262),
                borderRadius: BorderRadius.circular(7),
              ),
              margin: EdgeInsets.only(left: 20, top: 20, right: 20, bottom: 10),
              padding: EdgeInsets.only(top: 15, bottom: 15),
              child: Center(
                child: Text(
                  "SAVE",
                  style: TextStyle(
                    fontFamily: "Brandon",
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
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
