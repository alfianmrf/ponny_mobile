import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class LoginOTP extends StatefulWidget {
  static const String id = "login_otp";
  @override
  _LoginOTPScreen createState() => _LoginOTPScreen();
}

class _LoginOTPScreen extends State<LoginOTP> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  bool _validate = false;

  final myemail = TextEditingController();
  final mypass = TextEditingController();

  void validateInput() {
    FormState form = this.formKey.currentState;
    ScaffoldState scaffold = this.scaffoldKey.currentState;

    // if (form.validate()) {
    //   _fetchLogin();
    // }
  }

  // _fetchLogin() async {
  //   FocusScope.of(context).requestFocus(new FocusNode());
  //   if (myemail.text.isEmpty || mypass.text.isEmpty) {
  //     setState(() {
  //       _validate = false;
  //     });
  //   } else {
  //     UIBlock.block(context, customLoaderChild: LoadingWidget(context));
  //     var param = {"email": myemail.text, "password": mypass.text};
  //     final res = await http.post(loginUrl,
  //         headers: {HttpHeaders.contentTypeHeader: 'application/json'},
  //         body: json.encode(param));
  //     final _user = UserModel();

  //     UIBlock.unblock(context);
  //     if (res.statusCode == 200) {
  //       var result = json.decode(res.body);
  //       final us = User.fromLocalJson(result['user']);
  //       await Provider.of<UserModel>(context).saveUser(result['user']);

  //       Navigator.pushReplacement(
  //           context,
  //           new MaterialPageRoute(
  //             builder: (BuildContext context) => new AccountScreen(),
  //           ));
  //     } else {
  //       final snackBar = SnackBar(
  //         content: Text('Email atau password salah!',
  //             style: TextStyle(color: Colors.white)),
  //         backgroundColor: Colors.redAccent,
  //       );
  //       scaffoldKey.currentState.showSnackBar(snackBar);
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomPadding: false,
      resizeToAvoidBottomInset: false,
      key: scaffoldKey,
      backgroundColor: Hexcolor('#FCF8F0'),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                height: 100.0,
              ),
              // Container(
              //   alignment: Alignment.centerLeft,
              //   padding: EdgeInsets.only(left: 20.0),
              //   child: Text(
              //     'Akun Saya',
              //     style: TextStyle(
              //         fontSize: 30,
              //         fontFamily: 'Yeseva',
              //         color: Hexcolor('#F48262'),
              //         fontWeight: FontWeight.w500,
              //         letterSpacing: 1),
              //   ),
              // ),
              Container(
                color: Hexcolor('#F48262'),
                margin: EdgeInsets.only(top: 20),
                height: 2,
              ),
              Container(
                margin: EdgeInsets.only(left: 35, right: 35, top: 70),
                padding: EdgeInsets.only(top: 20, bottom: 20),
                child: Column(
                  children: [
                    Container(
                      child: Row(
                        children: [
                          Flexible(
                            child: Text(
                              "SELAMAT DATANG DI PONNY BEAUTE!",
                              style: TextStyle(
                                fontFamily: "Brandon",
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        top: 5,
                        bottom: 15,
                      ),
                      child: Row(
                        children: [
                          Flexible(
                            child: Text(
                              "Masukkan nomor telepon kamu untuk masuk",
                              style: TextStyle(
                                fontFamily: "Brandon",
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      // color: Colors.white,
                      child: Row(
                        children: [
                          Container(
                            color: Colors.white,
                            width: 50,
                            child: TextFormField(
                              textAlign: TextAlign.center,
                              readOnly: true,
                              initialValue: "+62",
                              style: TextStyle(
                                fontFamily: "Brandon",
                                fontSize: 15,
                                fontWeight: FontWeight.w300,
                              ),
                              decoration: InputDecoration(
                                hintText: 'Nomor Telepon ?',
                                contentPadding: const EdgeInsets.all(10.0),
                                isDense: true,
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(3.0)),
                                  borderSide:
                                      BorderSide(color: Hexcolor('#F48262')),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(7.0),
                                    bottomLeft: Radius.circular(7.0),
                                  ),
                                  borderSide:
                                      BorderSide(color: Hexcolor('#F48262')),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width:
                                MediaQuery.of(context).size.width - (70 + 50),
                            color: Colors.white,
                            child: TextFormField(
                              // initialValue: " 8123456910",
                              style: TextStyle(
                                fontFamily: "Brandon",
                                fontSize: 15,
                                fontWeight: FontWeight.w300,
                              ),
                              decoration: InputDecoration(
                                hintText: 'Nomor Handphone',
                                contentPadding: const EdgeInsets.all(10.0),
                                isDense: true,
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(3.0)),
                                  borderSide:
                                      BorderSide(color: Hexcolor('#F48262')),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(7.0),
                                    bottomRight: Radius.circular(7.0),
                                  ),
                                  borderSide:
                                      BorderSide(color: Hexcolor('#F48262')),
                                ),
                              ),
                              maxLines: 1,
                              minLines: 1,
                              keyboardType: TextInputType.phone,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Hexcolor('#F48262'),
                        borderRadius: BorderRadius.circular(7.0),
                      ),
                      margin: EdgeInsets.only(top: 40),
                      width: MediaQuery.of(context).size.width - 70,
                      child: FlatButton(
                        onPressed: () {},
                        child: Text(
                          "DAFTAR",
                          style: TextStyle(
                            fontFamily: "Brandon",
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
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
      ),
    );
  }
}
