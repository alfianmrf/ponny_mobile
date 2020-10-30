import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:ponny/common/constant.dart';
import 'package:ponny/model/App.dart';
import 'package:ponny/model/User.dart';
import 'package:ponny/screens/home_screen.dart';
import 'package:ponny/screens/account_screen.dart';
import 'package:ponny/util/globalUrl.dart';
import 'package:ponny/widgets/PonnyBottomNavbar.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:uiblock/uiblock.dart';

class EditAkunScreen extends StatefulWidget {
  static const String id = "edit_akun_Screen";
  @override
  _EditAkunStateScreen createState() => _EditAkunStateScreen();
}

class _EditAkunStateScreen extends State<EditAkunScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController dateCtl = TextEditingController();
  TextEditingController account = TextEditingController();
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  DateTime _tglLahir = DateTime.now();
  List<String> list = ["Female", "Male"];
  String item = "Female";
  final f = new DateFormat('dd/MM/yyyy');

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final user = Provider.of<UserModel>(context).user;
      setState(() {
        account.text= user.provider_id == null ? user.email : user.phone;
        firstName.text = user.name;
        lastName.text =user.last_name;
        item =user.gender != null? user.gender=="P" ? "Female": "Male" :null;
        phoneNumber.text = user.phone;
        _tglLahir =  DateTime.parse(user.tgl_lahir);
        dateCtl.text= f.format(_tglLahir);
      });
    });
  }

  void onChanged(String value) {
    setState(() {
      item = value;
    });
  }

  _selectDate(BuildContext context,DateTime selectedDate,TextEditingController _textController) async {
    FocusScope.of(context).requestFocus(new FocusNode());
    DateTime newSelectedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate != null ? selectedDate : DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now()
    );

    if (newSelectedDate != null) {
      selectedDate = newSelectedDate;
      setState(() {
        _tglLahir = newSelectedDate;
      });
      _textController
        ..text = f.format(selectedDate)
        ..selection = TextSelection.fromPosition(TextPosition(
            offset: _textController.text.length,
            affinity: TextAffinity.upstream));
    }
  }

  Future<void> updateProfile() async {
    FocusScope.of(context).requestFocus(new FocusNode());
    FormState form = this.formKey.currentState;
    if(form.validate()){
      UIBlock.block(context,customLoaderChild: LoadingWidget(context));
      final token = Provider.of<AppModel>(context).auth.access_token;
      var param={
        "first_name": firstName.value.text,
        "last_name": lastName.value.text,
        "phone": phoneNumber.value.text,
        "gender": item == "Female" ? "P":"L",
        "brithdate": new DateFormat("MM/dd/yyyy").format(_tglLahir)
      };
      print(param);
      Provider.of<UserModel>(context).setUser(token, param).then((value){
        UIBlock.unblock(context);
        if(value){
          scaffoldKey.currentState.showSnackBar(snackBarSuccess);
        }else{
          scaffoldKey.currentState.showSnackBar(snackBarError);
        }
      });

    }
  }



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      key: scaffoldKey,
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
              child: Form(
                key: formKey,
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
                              readOnly: true,
                              controller: account,
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
                              controller: firstName,
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
                              validator: (String value){
                                if(value.isEmpty){
                                  return "Nama Depan harus diisi.";
                                }
                              },
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
                              controller: lastName,
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
                              validator: (String value){
                                if(value.isEmpty){
                                  return "Nama Belakang harus diisi.";
                                }
                              },
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
                                  hint: Text("Jenis Kelamin"),
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
                                  validator: (String value){
                                    if(value == null){
                                      return "Jenis Kelamin harus diisi.";
                                    }
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
                                if(dateCtl.text.isEmpty)
                                _selectDate(context,_tglLahir,dateCtl);
                              },
                              controller: dateCtl,
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
                              validator: (String value){
                                if(value.isEmpty){
                                  return "Tanggal Lahir harus diisi.";
                                }
                              },
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
                            width: 180,
                            child: TextFormField(
                              controller: phoneNumber,
                              style: TextStyle(
                                fontFamily: "Brandon",
                                fontSize: 15,
                                fontWeight: FontWeight.w300,
                              ),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: '+62xx',
                                isDense: true,
                              ),
                              maxLines: 1,
                              minLines: 1,
                              keyboardType: TextInputType.name,
                              validator: (String value){
                                if(value.isEmpty){
                                  return "Phone Number harus diisi.";
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 15, bottom: 0),
                      child: GestureDetector(
                        onTap: () {
                          updateProfile();
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


            ),
          ],
        ),
      ),
      bottomNavigationBar: new PonnyBottomNavbar(selectedIndex: 4),
    );
  }
}
