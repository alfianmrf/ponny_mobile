import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:ponny/model/Cart.dart';
import 'package:provider/provider.dart';

class MidtransTokenRequest extends StatefulWidget{
  final String card_number;
  final String exp_month;
  final String exp_year;
  final String cvv;

  MidtransTokenRequest({this.card_number, this.exp_month, this.exp_year, this.cvv});

  @override
  State<StatefulWidget> createState() {
    return MidtransTokenRequestState();
  }

}
class MidtransTokenRequestState extends State<MidtransTokenRequest>{
  InAppWebViewController webView;
  @override
  initState(){
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Center(
        child: InAppWebView(
          initialUrl: "https://ponnybeaute.co.id/api/v1/mtr-token?card_number=${widget.card_number}&exp_month=${widget.exp_month}&exp_year=${widget.exp_year}&cvv=${widget.cvv}",
          initialHeaders: {},
          initialOptions: InAppWebViewGroupOptions(
              crossPlatform: InAppWebViewOptions(
                debuggingEnabled: true,
              )
          ),
          onWebViewCreated: (InAppWebViewController controller) {
            webView = controller;

            controller.addJavaScriptHandler(handlerName: "mtrtoken", callback: (args) {
              // Here you receive all the arguments from the JavaScript side
              // that is a List<dynamic>
              print("From the JavaScript side:");
              print(args[0]);
              Provider.of<CartModel>(context).tokenMidtrans=args[0];
              Navigator.pop(context);
            });
          },
          onLoadStart: (InAppWebViewController controller, String url) {

          },
          onLoadStop: (InAppWebViewController controller, String url) {

          },
          onConsoleMessage: (InAppWebViewController controller, ConsoleMessage consoleMessage) {
            print("console message: ${consoleMessage.message}");
          },
        ),
    );
  }

}