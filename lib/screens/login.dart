import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ponny/screens/home_screen.dart';

class LoginScreen extends StatefulWidget {
  static const String id = "login_Screen";
  @override
  _LoginStateScreen createState() => _LoginStateScreen();
}

class _LoginStateScreen extends State<LoginScreen>{
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  final myUsernameController = TextEditingController();
  final myPasswordController = TextEditingController();
  String nUsername, nPassword;

  final email = TextFormField(
    keyboardType: TextInputType.emailAddress,
    autofocus: false,
    initialValue: 'ponnydev@gmail.com',
    maxLength: 20,
    decoration: InputDecoration(
      hintText: 'Email',
      contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
    ),
  );

  final password = TextFormField(
    autofocus: false,
    initialValue: 'some password',
    obscureText: true,
    decoration: InputDecoration(
      hintText: 'Password',
      contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
    ),
  );

  //tambahkan form
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFCF8F0),
      appBar: AppBar(
        title: Text('Akun Saya',style: TextStyle(fontSize: 28, color: Color(0xffF3795C), fontFamily: 'Brandon')),
        backgroundColor: Color(0xffFCF8F0),
        bottom: PreferredSize(
            child: Container(
              color: Color(0xfff3795c),
              height: 1.5,
            ),
            preferredSize: Size.fromHeight(4.0)),
        elevation: 0.0,
      ),

      body: Container(
          margin: const EdgeInsets.all(10.0),
          child: Center(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  email,
                  SizedBox(height: 8.0),
                  password,
                  SizedBox(height: 24.0),
                  SizedBox(
                    height: 0,
                  ),
                  Center(
                    child: MaterialButton(
                      minWidth: 85.0,
                      height: 50.0,
                      color: Color(0xfff3795c),
                      textColor: Colors.white,
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SecondRoute(
                                )));
                      },
                      child: Text('MASUK'),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0)
                      ),

                    ),
                  ),
                ],
              ),
            ),
          )
      ),

    );
  }
}
