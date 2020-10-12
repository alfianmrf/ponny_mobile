import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:ponny/screens/home_screen.dart';
import 'package:ponny/screens/login.dart';

class RegisterScreen extends StatefulWidget {
  static const String id = "register_Screen";
  @override
  _RegisterScreen createState() => _RegisterScreen();
}

class _RegisterScreen extends State<RegisterScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  DateTime date = DateTime.now();

  Future<Null> selectDate(BuildContext context) async {
    final DateTime selected = await showDatePicker(
        context: context,
        initialDate: this.date,
        firstDate: DateTime(1980),
        lastDate: DateTime(2021));

    if (selected != null && selected != this.date) {
      setState(() {
        this.date = selected;
      });
    }
  }

  final nama_depan = TextEditingController();
  final nama_belakang = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final konfirmasi_password = TextEditingController();
  final no_telepon = TextEditingController();

  void validateInput() {
    FormState form = this.formKey.currentState;
    ScaffoldState scaffold = this.scaffoldKey.currentState;

    if (form.validate()) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: Text("Terkonfirmasi"),
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Hexcolor('#FCF8F0'),
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                  height: 70.0,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: 20.0),
                  child: Text(
                    'Daftar',
                    style: TextStyle(
                        fontSize: 30,
                        fontFamily: 'Yeseva',
                        color: Hexcolor('#F48262'),
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1),
                  ),
                ),
                Container(
                  color: Hexcolor('#F48262'),
                  margin: EdgeInsets.only(top: 20),
                  height: 2,
                ),
                Container(
                  margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 40.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          controller: nama_depan,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'Nama Depan',
                            labelText: 'Nama Depan : ',
                            labelStyle: TextStyle(color: Colors.black),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: BorderSide(
                                color: Hexcolor('#F48262'),
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: BorderSide(
                                color: Hexcolor('#F48262'),
                                width: 2.0,
                              ),
                            ),
                          ),
                          keyboardType: TextInputType.name,
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'Nama Depan tidak boleh kosong';
                            }
                          },
                        ),
                        Container(
                          height: 20.0,
                        ),
                        TextFormField(
                          controller: nama_belakang,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'Nama Belakang',
                            labelText: 'Nama Belakang : ',
                            labelStyle: TextStyle(color: Colors.black),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: BorderSide(
                                color: Hexcolor('#F48262'),
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: BorderSide(
                                color: Hexcolor('#F48262'),
                                width: 2.0,
                              ),
                            ),
                          ),
                          keyboardType: TextInputType.name,
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'Nama Belakang tidak boleh kosong';
                            }
                          },
                        ),
                        Container(
                          height: 20.0,
                        ),
                        TextFormField(
                          controller: email,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'Email',
                            labelText: 'Email : ',
                            labelStyle: TextStyle(color: Colors.black),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: BorderSide(
                                color: Hexcolor('#F48262'),
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: BorderSide(
                                color: Hexcolor('#F48262'),
                                width: 2.0,
                              ),
                            ),
                          ),
                          keyboardType: TextInputType.emailAddress,
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'Email tidak boleh kosong';
                            } else if (!value.contains('@')) {
                              return 'Email tidak valid';
                            }
                          },
                        ),
                        Container(
                          height: 20.0,
                        ),
                        TextFormField(
                          controller: password,
                          obscureText: true,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'Password',
                            labelText: 'Password : ',
                            labelStyle: TextStyle(color: Colors.black),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: BorderSide(
                                color: Hexcolor('#F48262'),
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: BorderSide(
                                color: Hexcolor('#F48262'),
                                width: 2.0,
                              ),
                            ),
                          ),
                          keyboardType: TextInputType.visiblePassword,
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'Password tidak boleh kosong';
                            }
                          },
                        ),
                        Container(
                          height: 20.0,
                        ),
                        TextFormField(
                          controller: konfirmasi_password,
                          obscureText: true,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'Konfirmasi Password',
                            labelText: 'Konfirmasi Password : ',
                            labelStyle: TextStyle(color: Colors.black),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: BorderSide(
                                color: Hexcolor('#F48262'),
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: BorderSide(
                                color: Hexcolor('#F48262'),
                                width: 2.0,
                              ),
                            ),
                          ),
                          keyboardType: TextInputType.visiblePassword,
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'Konfirmasi Password tidak boleh kosong';
                            }
                          },
                        ),
                        Container(
                          height: 20.0,
                        ),
                        TextFormField(
                          controller: no_telepon,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'Nomor Handphone',
                            labelText: 'Nomor Handphone : ',
                            labelStyle: TextStyle(color: Colors.black),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: BorderSide(
                                color: Hexcolor('#F48262'),
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: BorderSide(
                                color: Hexcolor('#F48262'),
                                width: 2.0,
                              ),
                            ),
                          ),
                          keyboardType: TextInputType.phone,
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'Nomor Telepon tidak boleh kosong';
                            }
                          },
                        ),
                        Container(
                          height: 20.0,
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          margin: EdgeInsets.only(left: 3.0),
                          child: Text(
                            'Jenis Kelamin',
                            style: TextStyle(
                              fontSize: 15,
                              fontFamily: 'Brandon',
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Container(
                          height: 3,
                        ),
                        Container(
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                ButtonTheme(
                                  buttonColor: Hexcolor('#FCF8F0'),
                                  minWidth: 180.0,
                                  height: 45.0,
                                  child: RaisedButton(
                                    onPressed: () {},
                                    child: Text(
                                      "Perempuan",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontFamily: 'Brandon',
                                          fontWeight: FontWeight.w800,
                                          letterSpacing: 1,
                                          color: Hexcolor('#F48262')),
                                    ),
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                    side:
                                        BorderSide(color: Hexcolor('#F48262')),
                                  ),
                                ),
                                ButtonTheme(
                                  buttonColor: Hexcolor('#FCF8F0'),
                                  minWidth: 180.0,
                                  height: 45.0,
                                  child: RaisedButton(
                                    onPressed: () {},
                                    child: Text(
                                      "Laki-laki",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontFamily: 'Brandon',
                                          fontWeight: FontWeight.w800,
                                          letterSpacing: 1,
                                          color: Hexcolor('#F48262')),
                                    ),
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                    side:
                                        BorderSide(color: Hexcolor('#F48262')),
                                  ),
                                ),
                              ]),
                        ),
                        Container(
                          height: 10,
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 3.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                'Tanggal Lahir',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontFamily: 'Brandon',
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              ButtonTheme(
                                buttonColor: Hexcolor('#FCF8F0'),
                                minWidth: 250.0,
                                height: 45.0,
                                child: RaisedButton(
                                  onPressed: () {
                                    selectDate(context);
                                  },
                                  child: Text(
                                    "Pilih Tanggal Lahir",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: 'Brandon',
                                        fontWeight: FontWeight.w800,
                                        letterSpacing: 1,
                                        color: Hexcolor('#F48262')),
                                  ),
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                  side: BorderSide(color: Hexcolor('#F48262')),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 50,
                ),
                Container(
                  child: ButtonTheme(
                    buttonColor: Hexcolor('#F48262'),
                    minWidth: 250.0,
                    height: 45.0,
                    child: RaisedButton(
                      onPressed: validateInput,
                      child: Text(
                        "DAFTAR",
                        style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'Brandon',
                            fontWeight: FontWeight.w800,
                            letterSpacing: 1,
                            color: Colors.white),
                      ),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                ),
                Container(
                  height: 50,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}