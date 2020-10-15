import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:ponny/screens/home_screen.dart';
import 'package:ponny/screens/account_screen.dart';
import 'package:ponny/widgets/PonnyBottomNavbar.dart';

class EditAkunScreen extends StatefulWidget {
  static const String id = "edit_akun_Screen";
  @override
  _EditAkunStateScreen createState() => _EditAkunStateScreen();
}

class _EditAkunStateScreen extends State<EditAkunScreen> {
  TextEditingController dateCtl = TextEditingController();
  List<String> list = ["Female", "Male"];
  String item = "Female";

  void onChanged(String value) {
    setState(() {
      item = value;
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
                      "Edit Akun",
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
                bottom: 15,
              ),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(bottom: 8),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Color(0xffF48262),
                          width: 1,
                        ),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Text(
                            "Account",
                            style: TextStyle(
                              fontFamily: "Brandon",
                              fontSize: 15,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                        Container(
                          width: 180,
                          child: TextFormField(
                            initialValue: "carlastarla@gmail.com",
                            style: TextStyle(
                              fontFamily: "Brandon",
                              fontSize: 15,
                              fontWeight: FontWeight.w300,
                            ),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Email Akun ?',
                              isDense: true,
                            ),
                            maxLines: 1,
                            minLines: 1,
                            keyboardType: TextInputType.emailAddress,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(bottom: 8, top: 8),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Color(0xffF48262),
                          width: 1,
                        ),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Text(
                            "First Name",
                            style: TextStyle(
                              fontFamily: "Brandon",
                              fontSize: 15,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                        Container(
                          width: 180,
                          child: TextFormField(
                            initialValue: "Carla",
                            style: TextStyle(
                              fontFamily: "Brandon",
                              fontSize: 15,
                              fontWeight: FontWeight.w300,
                            ),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Nama Depan ?',
                              isDense: true,
                            ),
                            maxLines: 1,
                            minLines: 1,
                            keyboardType: TextInputType.name,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(bottom: 8, top: 8),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Color(0xffF48262),
                          width: 1,
                        ),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Text(
                            "Last Name",
                            style: TextStyle(
                              fontFamily: "Brandon",
                              fontSize: 15,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                        Container(
                          width: 180,
                          child: TextFormField(
                            initialValue: "Starla",
                            style: TextStyle(
                              fontFamily: "Brandon",
                              fontSize: 15,
                              fontWeight: FontWeight.w300,
                            ),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Nama Belakang ?',
                              isDense: true,
                            ),
                            maxLines: 1,
                            minLines: 1,
                            keyboardType: TextInputType.name,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(bottom: 8, top: 8),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Color(0xffF48262),
                          width: 1,
                        ),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Text(
                            "Gender",
                            style: TextStyle(
                              fontFamily: "Brandon",
                              fontSize: 15,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 8, bottom: 8),
                          width: 180,
                          child: Column(
                            children: [
                              DropdownButtonFormField(
                                decoration: InputDecoration.collapsed(),
                                isExpanded: true,
                                value: item,
                                icon: Icon(Icons.keyboard_arrow_down),
                                iconSize: 26,
                                iconEnabledColor: Color(0xffF48262),
                                iconDisabledColor: Color(0xffF48262),
                                items: list.map((String val) {
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
                          // child: TextFormField(
                          //   initialValue: "Female",
                          //   style: TextStyle(
                          //     fontFamily: "Brandon",
                          //     fontSize: 15,
                          //     fontWeight: FontWeight.w300,
                          //   ),
                          //   decoration: InputDecoration(
                          //     border: InputBorder.none,
                          //     hintText: 'Jenis Kelamin ?',
                          //     isDense: true,
                          //   ),
                          //   maxLines: 1,
                          //   minLines: 1,
                          // ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(bottom: 8, top: 8),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Color(0xffF48262),
                          width: 1,
                        ),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Text(
                            "Date of Birth",
                            style: TextStyle(
                              fontFamily: "Brandon",
                              fontSize: 15,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                        Container(
                          width: 180,
                          child: TextFormField(
                            readOnly: true,
                            onTap: () async {
                              DateTime date = DateTime(1900);
                              FocusScope.of(context)
                                  .requestFocus(new FocusNode());

                              date = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1900),
                                  lastDate: DateTime(2100));

                              dateCtl.text = date.toIso8601String();
                            },
                            initialValue: "11/05/1990",
                            style: TextStyle(
                              fontFamily: "Brandon",
                              fontSize: 15,
                              fontWeight: FontWeight.w300,
                            ),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Tanggal Lahir ?',
                              isDense: true,
                            ),
                            maxLines: 1,
                            minLines: 1,
                            keyboardType: TextInputType.name,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(bottom: 8, top: 8),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Color(0xffF48262),
                          width: 1,
                        ),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Text(
                            "Phone Number",
                            style: TextStyle(
                              fontFamily: "Brandon",
                              fontSize: 15,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                        Container(
                          child: Row(children: [
                            Container(
                              width: 30,
                              child: TextFormField(
                                readOnly: true,
                                initialValue: "+62",
                                style: TextStyle(
                                  fontFamily: "Brandon",
                                  fontSize: 15,
                                  fontWeight: FontWeight.w300,
                                ),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Nomor Telepon ?',
                                  isDense: true,
                                ),
                              ),
                            ),
                            Container(
                              width: 150,
                              child: TextFormField(
                                initialValue: " 8123456910",
                                style: TextStyle(
                                  fontFamily: "Brandon",
                                  fontSize: 15,
                                  fontWeight: FontWeight.w300,
                                ),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Nomor Telepon ?',
                                  isDense: true,
                                ),
                                maxLines: 1,
                                minLines: 1,
                                keyboardType: TextInputType.phone,
                              ),
                            ),
                          ]),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 15, bottom: 0),
                    child: GestureDetector(
                      onTap: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => EditAkunScreen(),
                        //   ),
                        // );
                      },
                      child: Text(
                        "Save",
                        style: TextStyle(
                          fontFamily: "Brandon",
                          color: Color(0xffF48262),
                          fontSize: 17,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: new PonnyBottomNavbar(selectedIndex: 4),
    );
  }
}
