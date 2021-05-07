import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:ponny/model/Cart.dart';
import 'package:provider/provider.dart';

class MidtransOTP extends StatefulWidget{
  final String url;

  MidtransOTP({this.url});

  @override
  State<StatefulWidget> createState() {
    return MidtransOTPState();
  }

}
class MidtransOTPState extends State<MidtransOTP>{
  InAppWebViewController webView;
  @override
  initState(){
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        actions: <Widget>[
          TextButton(
            child: Text(
              'DONE',
              style: TextStyle(
                color: Color(0xffF48262),
              ),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ],
      ),
      body: Container(
        child: InAppWebView(
          initialUrl: widget.url,
          initialHeaders: {},
          initialOptions: InAppWebViewGroupOptions(
              crossPlatform: InAppWebViewOptions(
                debuggingEnabled: true,
              )
          ),
        ),
      ),
    );
  }

}