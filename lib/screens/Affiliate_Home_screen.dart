import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:ponny/widgets/PonnyBottomNavbar.dart';


class AffiliateHomeScreen extends StatefulWidget {
  static const String id = "Affiliate_Home_screen";

  @override
  _AffiliateHomeScreenState createState() => _AffiliateHomeScreenState();
}

class _AffiliateHomeScreenState extends State<AffiliateHomeScreen>
    with SingleTickerProviderStateMixin {
  bool login = false;
  bool regist = true;
  bool menu = true;
  bool daftarInfluencer = false;
  bool daftarBrand = false;
  bool vision = true;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        setState(() {
          login = false;
          daftarInfluencer = false;
          daftarBrand = false;
          regist = true;
          menu = true;
        });
      },
      child: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: Hexcolor('#FCF8F0'),
          body: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(new FocusNode());
            },
            child: Column(
              children: [
                Container(
                  height: 35,
                ),
                Container(
                  margin: EdgeInsets.all(5),
                  child: Row(
                    children: [
                      Container(
                        child: IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.arrow_back_ios,
                              color: Color(0xffF48262),
                              size: 26,
                            )),
                      ),
                      Container(
                        child: Text(
                          menu ? "Affiliate With Us" : "Daftar",
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
                  margin: EdgeInsets.only(),
                  height: 1,
                  color: Color(0xffF3C1B5),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Stack(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          child: Image.network(
                            "https://via.placeholder.com/288x188",
                            fit: BoxFit.cover,
                          ),
                        ),
                        Column(
                          children: [
                            Container(
                              width: double.infinity,
                              margin: EdgeInsets.fromLTRB(20, 180, 20, 0),
                              padding: EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: Color(0xffFCF6F0),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(20),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    spreadRadius: 1,
                                    blurRadius: 1,// changes position of shadow
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    "Yuk Join \ndan Dapatkan Keuntungan",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontFamily: "Yeseva",
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    'Isi formulir di bawah ini dan Tim Phoebe akan menghubungi kamu lebih lanjut',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: 'Brandon',
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            daftarInfluencer
                                ? form_Influencer()
                                : daftarBrand
                                ? form_Brands()
                                : Container(),
                            login
                                ? Container(
                                    margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "HALO PARTNER PHOEBE!",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontFamily: 'Brandon',
                                              fontWeight: FontWeight.w800,
                                              color: Colors.black),
                                        ),
                                        Text(
                                          "Masukan email dan password kamu untuk masuk",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontFamily: 'Brandon',
                                              fontWeight: FontWeight.w800,
                                              color: Colors.black),
                                        ),
                                        Container(height: 10),
                                        Container(
                                          height: 40,
                                          child: TextField(
                                            obscureText: vision,
                                            textAlignVertical:
                                                TextAlignVertical.bottom,
                                            decoration: new InputDecoration(
                                              fillColor: Colors.white,
                                              filled: true,
                                              hintStyle: TextStyle(
                                                fontFamily: 'Brandon',
                                              ),
                                              focusedBorder:
                                                  new OutlineInputBorder(
                                                      borderSide:
                                                          new BorderSide(
                                                              color: Hexcolor(
                                                                  '#F48262'))),
                                              errorBorder: InputBorder.none,
                                              disabledBorder: InputBorder.none,
                                              hintText: "Email",
                                              enabledBorder:
                                                  new OutlineInputBorder(
                                                      borderSide:
                                                          new BorderSide(
                                                              color: Hexcolor(
                                                                  '#F48262'))),
                                            ),
                                          ),
                                        ),
                                        Container(height: 10),
                                        Container(
                                          height: 40,
                                          child: TextField(
                                            obscureText: vision,
                                            textAlignVertical:
                                                TextAlignVertical.bottom,
                                            decoration: new InputDecoration(
                                              suffixIcon: GestureDetector(
                                                  child: vision
                                                      ? Icon(Icons.visibility)
                                                      : Icon(
                                                          Icons.visibility_off),
                                                  onTap: () {
                                                    setState(() {
                                                      vision = !vision;
                                                    });
                                                  }),
                                              fillColor: Colors.white,
                                              filled: true,
                                              hintStyle: TextStyle(
                                                fontFamily: 'Brandon',
                                              ),
                                              focusedBorder:
                                                  new OutlineInputBorder(
                                                      borderSide:
                                                          new BorderSide(
                                                              color: Hexcolor(
                                                                  '#F48262'))),
                                              errorBorder: InputBorder.none,
                                              disabledBorder: InputBorder.none,
                                              hintText: "Password",
                                              enabledBorder:
                                                  new OutlineInputBorder(
                                                      borderSide:
                                                          new BorderSide(
                                                              color: Hexcolor(
                                                                  '#F48262'))),
                                            ),
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: InkWell(
                                            child: Text(
                                              "Lupa kata sandi anda?",
                                              style: TextStyle(
                                                decoration:
                                                    TextDecoration.underline,
                                                fontSize: 14,
                                                fontFamily: 'Brandon',
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(height: 10),
                                        Container(
                                            width: double.infinity,
                                            child: rectanglebutton(
                                                context, "MASUK"))
                                      ],
                                    ),
                                  )
                                : menu
                                    ? Container(
                                        margin: EdgeInsets.only(top: 20),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Color(0xffF48262)),
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(5),
                                                ),
                                              ),
                                              width: 100,
                                              height: 100,
                                              child: FlatButton(
                                                onPressed: () {
                                                  setState(() {
                                                    daftarInfluencer =
                                                        !daftarInfluencer;
                                                    daftarBrand = false;
                                                    menu = false;
                                                  });
                                                },
                                                child:
                                                    Icon(Icons.account_circle),
                                              ),
                                            ),
                                            Container(
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Color(0xffF48262)),
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(5),
                                                ),
                                              ),
                                              width: 100,
                                              height: 100,
                                              child: FlatButton(
                                                onPressed: () {
                                                  setState(() {
                                                    daftarBrand = !daftarBrand;
                                                    daftarInfluencer = false;
                                                    menu = false;
                                                  });
                                                },
                                                child: Icon(Icons.business),
                                              ),
                                            )
                                          ],
                                        ),
                                      )
                                    : /*Container(
                                        margin: EdgeInsets.only(top: 20),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            ButtonTheme(
                                              buttonColor: Hexcolor('#F48262'),
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 30, vertical: 10),
                                              child: RaisedButton(
                                                onPressed: () {
                                                  setState(() {
                                                    regist = true;
                                                  });
                                                },
                                                child: Text(
                                                  "DAFTAR",
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontFamily: 'Brandon',
                                                      fontWeight:
                                                          FontWeight.w800,
                                                      color: Colors.white),
                                                ),
                                              ),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5.0),
                                                side: BorderSide(
                                                    color: Hexcolor('#F48262')),
                                              ),
                                            ),
                                            ButtonTheme(
                                              buttonColor: Hexcolor('#F48262'),
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 30, vertical: 10),
                                              child: RaisedButton(
                                                onPressed: () {
                                                  setState(() {
                                                    login = true;
                                                  });
                                                },
                                                child: Text(
                                                  "MASUK",
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontFamily: 'Brandon',
                                                      fontWeight:
                                                          FontWeight.w800,
                                                      color: Colors.white),
                                                ),
                                              ),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5.0),
                                                side: BorderSide(
                                                    color: Hexcolor('#F48262')),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),*/
                            Container(height: 30),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: new PonnyBottomNavbar(selectedIndex: 4)),
    );
  }
}

Widget rectanglebutton(context, String subtext) {
  return ButtonTheme(
    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
    child: FlatButton(
      color: Hexcolor('#F48262'),
      onPressed: () {},
      child: Text(
        subtext,
        style: TextStyle(
            fontSize: 14,
            fontFamily: 'Brandon',
            fontWeight: FontWeight.w800,
            color: Colors.white),
      ),
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
  );
}

Widget form_Influencer() {
  String genderValueInfluencer;
  return StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Nama Lengkap*",
            style: TextStyle(
              fontSize: 15,
              fontFamily: 'Brandon',
            ),
          ),
          daftar_TextField(
            "",
            null,
          ),
          Container(height: 10),
          Text(
            "Email*",
            style: TextStyle(
              fontSize: 15,
              fontFamily: 'Brandon',
            ),
          ),
          daftar_TextField(
            "",
            null,
          ),
          Container(height: 10),
          Text(
            "Nomor Handphone(PIC)*",
            style: TextStyle(
              fontSize: 15,
              fontFamily: 'Brandon',
            ),
          ),
          daftar_TextField(
            "",
            null,
          ),
          Container(height: 10),
          Text(
            "Nama Social Media*",
            style: TextStyle(
              fontSize: 15,
              fontFamily: 'Brandon',
            ),
          ),
          daftar_TextField(
            "Username",
            Image.asset("assets/images/ponny.png"),
          ),
          Container(height: 10),
          daftar_TextField(
            "Username",
            Image.asset("assets/images/ponny.png"),
          ),
          Container(height: 10),
          daftar_TextField(
            "Username",
            Image.asset("assets/images/ponny.png"),
          ),
          Container(height: 10),
          daftar_TextField(
            "Username",
            Image.asset("assets/images/ponny.png"),
          ),
          Container(height: 10),
          Text(
            "Jenis Kelamin",
            style: TextStyle(
              fontSize: 15,
              fontFamily: 'Brandon',
            ),
          ),
          Row(
            children: [
              Radio(
                activeColor: Color(0xffF48262),
                value: "LakiLaki",
                groupValue: genderValueInfluencer,
                onChanged: (String value) {
                  setState(() {
                    genderValueInfluencer = value;
                  });
                },
              ),
              Text(
                "Perempuan",
                style: TextStyle(
                  fontSize: 15,
                  fontFamily: 'Brandon',
                ),
              ),
              Radio(
                activeColor: Color(0xffF48262),
                value: "Perempuan",
                groupValue: genderValueInfluencer,
                onChanged: (String value) {
                  setState(() {
                    genderValueInfluencer = value;
                  });
                },
              ),
              Text(
                "Laki-Laki",
                style: TextStyle(
                  fontSize: 15,
                  fontFamily: 'Brandon',
                ),
              ),
            ],
          ),
          rectanglebutton(context, "KIRIM")
        ],
      ),
    );
  });
}

Widget form_Brands() {
  String genderValueBrand;
  return StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Nama Lengkap*",
            style: TextStyle(
              fontSize: 15,
              fontFamily: 'Brandon',
            ),
          ),
          TextFormField(
            style: TextStyle(
              fontFamily: 'Brandon',
              fontSize: 14,
            ),
            decoration: InputDecoration(
              isDense: true,
              contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              filled: true,
              fillColor: Colors.white,
              labelStyle: TextStyle(color: Colors.black),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(
                  color: Hexcolor('#F48262'),
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(
                  color: Hexcolor('#F48262'),
                  width: 1.0,
                ),
              ),
            ),
            keyboardType: TextInputType.name,
            validator: (String value) {
              if (value.isEmpty) {
                return 'Nama Lengkap tidak boleh kosong';
              }
            },
          ),
          Container(height: 10),
          Text(
            "Email*",
            style: TextStyle(
              fontSize: 15,
              fontFamily: 'Brandon',
            ),
          ),
          TextFormField(
            style: TextStyle(
              fontFamily: 'Brandon',
              fontSize: 14,
            ),
            decoration: InputDecoration(
              isDense: true,
              contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              filled: true,
              fillColor: Colors.white,
              labelStyle: TextStyle(color: Colors.black),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(
                  color: Hexcolor('#F48262'),
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(
                  color: Hexcolor('#F48262'),
                  width: 1.0,
                ),
              ),
            ),
            keyboardType: TextInputType.emailAddress,
            validator: (String value) {
              if (value.isEmpty) {
                return 'Email tidak boleh kosong';
              }
            },
          ),
          Container(height: 10),
          RichText(
            text: TextSpan(
              text: 'Kata Sandi',
              style: TextStyle(
                fontSize: 15,
                color: Colors.black,
                fontFamily: 'Brandon',
              ),
              children: [
                TextSpan(
                  text: '*',
                  style: TextStyle(
                    color: Hexcolor('#F48262'),
                  ),
                ),
              ],
            ),
          ),
          TextFormField(
            obscureText: true,
            style: TextStyle(
              fontFamily: 'Brandon',
              fontSize: 14,
            ),
            decoration: InputDecoration(
              isDense: true,
              contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              filled: true,
              fillColor: Colors.white,
              labelStyle: TextStyle(color: Colors.black),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(
                  color: Hexcolor('#F48262'),
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(
                  color: Hexcolor('#F48262'),
                  width: 1.0,
                ),
              ),
            ),
            keyboardType: TextInputType.visiblePassword,
            validator: (String value) {
              if (value.isEmpty) {
                return 'Kata Sandi tidak boleh kosong';
              }
              if (value.length<8) {
                return 'Kata Sandi minimal 8 karakter';
              }
            },
          ),
          Container(height: 10),
          RichText(
            text: TextSpan(
              text: 'Konfirmasi Kata Sandi',
              style: TextStyle(
                fontSize: 15,
                color: Colors.black,
                fontFamily: 'Brandon',
              ),
              children: [
                TextSpan(
                  text: '*',
                  style: TextStyle(
                    color: Hexcolor('#F48262'),
                  ),
                ),
              ],
            ),
          ),
          TextFormField(
            obscureText: true,
            style: TextStyle(
              fontFamily: 'Brandon',
              fontSize: 14,
            ),
            decoration: InputDecoration(
              isDense: true,
              contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              filled: true,
              fillColor: Colors.white,
              labelStyle: TextStyle(color: Colors.black),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(
                  color: Hexcolor('#F48262'),
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(
                  color: Hexcolor('#F48262'),
                  width: 1.0,
                ),
              ),
            ),
            keyboardType: TextInputType.visiblePassword,
            validator: (String value) {
              if (value.isEmpty) {
                return 'Konfirmasi Kata Sandi tidak boleh kosong';
              }
              if (value.length<8) {
                return 'Konfirmasi Kata Sandi minimal 8 karakter';
              }
            },
          ),
          Container(height: 10),
          Text(
            "Nomor Handphone (PIC)*",
            style: TextStyle(
              fontSize: 15,
              fontFamily: 'Brandon',
            ),
          ),
          TextFormField(
            style: TextStyle(
              fontFamily: 'Brandon',
              fontSize: 14,
            ),
            decoration: InputDecoration(
              isDense: true,
              contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              filled: true,
              fillColor: Colors.white,
              labelStyle: TextStyle(color: Colors.black),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(
                  color: Hexcolor('#F48262'),
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(
                  color: Hexcolor('#F48262'),
                  width: 1.0,
                ),
              ),
            ),
            keyboardType: TextInputType.phone,
            validator: (String value) {
              if (value.isEmpty) {
                return 'Nomor Handphone (PIC) tidak boleh kosong';
              }
            },
          ),
          Container(height: 10),
          Text(
            "Toko/Nama Perusahaan*",
            style: TextStyle(
              fontSize: 15,
              fontFamily: 'Brandon',
            ),
          ),
          TextFormField(
            style: TextStyle(
              fontFamily: 'Brandon',
              fontSize: 14,
            ),
            decoration: InputDecoration(
              isDense: true,
              contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              filled: true,
              fillColor: Colors.white,
              labelStyle: TextStyle(color: Colors.black),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(
                  color: Hexcolor('#F48262'),
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(
                  color: Hexcolor('#F48262'),
                  width: 1.0,
                ),
              ),
            ),
            keyboardType: TextInputType.name,
            validator: (String value) {
              if (value.isEmpty) {
                return 'Toko/Nama Perusahaan tidak boleh kosong';
              }
            },
          ),
          Container(height: 10),
          Text(
            "Alamat Toko/Perusahaan*",
            style: TextStyle(
              fontSize: 15,
              fontFamily: 'Brandon',
            ),
          ),
          TextFormField(
            style: TextStyle(
              fontFamily: 'Brandon',
              fontSize: 14,
            ),
            decoration: InputDecoration(
              isDense: true,
              contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              filled: true,
              fillColor: Colors.white,
              labelStyle: TextStyle(color: Colors.black),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(
                  color: Hexcolor('#F48262'),
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(
                  color: Hexcolor('#F48262'),
                  width: 1.0,
                ),
              ),
            ),
            keyboardType: TextInputType.streetAddress,
            validator: (String value) {
              if (value.isEmpty) {
                return 'Alamat Toko/Perusahaan tidak boleh kosong';
              }
            },
          ),
          Container(height: 10),
          Text(
            "Nomor Handphone Perusahaan*",
            style: TextStyle(
              fontSize: 15,
              fontFamily: 'Brandon',
            ),
          ),
          TextFormField(
            style: TextStyle(
              fontFamily: 'Brandon',
              fontSize: 14,
            ),
            decoration: InputDecoration(
              isDense: true,
              contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              filled: true,
              fillColor: Colors.white,
              labelStyle: TextStyle(color: Colors.black),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(
                  color: Hexcolor('#F48262'),
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(
                  color: Hexcolor('#F48262'),
                  width: 1.0,
                ),
              ),
            ),
            keyboardType: TextInputType.phone,
            validator: (String value) {
              if (value.isEmpty) {
                return 'Nomor Handphone Perusahaan tidak boleh kosong';
              }
            },
          ),
          Container(height: 10),
          Text(
            "Deskripsi Produk*",
            style: TextStyle(
              fontSize: 15,
              fontFamily: 'Brandon',
            ),
          ),
          TextFormField(
            style: TextStyle(
              fontFamily: 'Brandon',
              fontSize: 14,
            ),
            maxLines: 4,
            textAlignVertical: TextAlignVertical.top,
            decoration: InputDecoration(
              hintText: "Deskripsi mengenai merek/produk anda...",
              isDense: true,
              contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              filled: true,
              fillColor: Colors.white,
              labelStyle: TextStyle(color: Colors.black),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(
                  color: Hexcolor('#F48262'),
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(
                  color: Hexcolor('#F48262'),
                  width: 1.0,
                ),
              ),
            ),
            keyboardType: TextInputType.multiline,
            validator: (String value) {
              if (value.isEmpty) {
                return 'Deskripsi Produk tidak boleh kosong';
              }
            },
          ),
          Container(height: 10),
          rectanglebutton(context, "KIRIM")
        ],
      ),
    );
  });
}

Widget daftar_TextField(String hintText, Image prefiksIcon) {
  return Container(
    height: 30,
    child: TextField(
      textAlignVertical: TextAlignVertical.bottom,
      decoration: new InputDecoration(
        fillColor: Colors.white,
        filled: true,
        hintStyle: TextStyle(
          fontFamily: 'Brandon',
        ),
        focusedBorder: new OutlineInputBorder(
            borderSide: new BorderSide(color: Hexcolor('#F48262'))),
        errorBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
        hintText: hintText,
        prefixIcon: prefiksIcon,
        enabledBorder: new OutlineInputBorder(
            borderSide: new BorderSide(color: Hexcolor('#F48262'))),
      ),
    ),
  );
}
