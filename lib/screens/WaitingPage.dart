import 'dart:async';

import 'package:agora_rtm/agora_rtm.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:ponny/common/constant.dart';
import 'package:ponny/model/App.dart';
import 'package:ponny/model/Order.dart';
import 'package:ponny/model/User.dart';
import 'package:ponny/model/Voucher.dart';
import 'package:ponny/screens/CallPage.dart';
import 'package:ponny/util/AppId.dart';
import 'package:ponny/widgets/PonnyBottomNavbar.dart';
import 'package:provider/provider.dart';

class WaitingPage extends StatefulWidget {
  static const String id = "Waiting_call";
  OrderDetailVoucher voucher;
  AgoraRtmClient client;
  AgoraRtmChannel channel;
  String DokterID;
  WaitingPage({Key key,@required this.voucher,this.channel,this.client,this.DokterID });
  @override
  _WaitingPageState createState() => _WaitingPageState();

}
class _WaitingPageState extends State<WaitingPage> {
  final scaffollKey = GlobalKey<ScaffoldState>();
  BuildContext _context;
  bool status_build =true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      Provider.of<UserModel>(context).getUser(Provider.of<AppModel>(context, listen: false).auth.access_token).then((value) {
        _createClient();
        kirimPesan(widget.DokterID,"list");
        Timer(Duration(minutes: 1), () {
          showdialog();
        });
      });
    });

  }
  @override
  void dispose() {
    // TODO: implement dispose
    // widget.channel.leave();
    // widget.client.logout();
    super.dispose();
  }

  void _createClient() async {
    widget.client.onMessageReceived = (AgoraRtmMessage message, String peerId) {
      print("Peer msg: " + peerId + ", msg: " + message.text);
      if(message.text == 'answer'){
        var param={
          "id_voucher":widget.voucher.id,
          "dokter_id":int.parse(peerId.replaceFirst("d", ""))
        };
        Provider.of<VoucherModel>(context).incall(Provider.of<AppModel>(context,listen: false).auth.access_token, param).then((value) async {
           widget.channel.leave();
           widget.client.logout();
          if(value){
            Navigator.pushReplacement(
              _context,
              MaterialPageRoute(
                builder: (context) => CallPage(chanel: peerId.replaceFirst("d", ""), voucher: widget.voucher),
              ),
            );
          }else{
            Navigator.pop(_context,true);
          }
        });
      }
    };
    widget.client.onConnectionStateChanged = (int state, int reason) {
      print('Connection state changed: ' +
          state.toString() +
          ', reason: ' +
          reason.toString());
      if (state == 5) {
        widget.client.logout();
        print('Logout.');
      }
    };

  }

  void kirimPesan(peerId,pesan){
    AgoraRtmMessage message = new AgoraRtmMessage(pesan, null, null);
    widget.client.sendMessageToPeer(peerId, message);
  }


  Future<bool> _onWillPop() async {
     // widget.channel.leave();
     // widget.client.logout();
    return true;
  }


  showdialog() async {
    await showDialog(
      context: _context,
      builder: (context) => new AlertDialog(
        title: new Text('Dokter Sedang Sibuk'),
        content: new Text('Sepertinya dokter sedang sibuk, apakah anda ingin menunggu?'),
        actions: <Widget>[
          new FlatButton(
            onPressed: () async {
              kirimPesan(widget.DokterID,"exit");
              Navigator.pop(_context,true);
            },
            child: new Text('Tidak'),
          ),
          new FlatButton(
            onPressed: () => Navigator.of(_context).pop(false),
            child: new Text('Ya'),
          ),
        ],
      ),
    );
  }



  @override
  Widget build(BuildContext context) {
    if(status_build){
      setState(() {
        _context =context;
        status_build =false;
      });
    }
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        key: scaffollKey,
        appBar: AppBar(title: Text(
          "Konsultasi",
          style: TextStyle(
            fontSize: 22,
            fontFamily: "Yeseva",
            fontWeight: FontWeight.w500,
            color: Color(0xffF48262),
          ),
        ),
          leading: Container(
            margin: EdgeInsets.only(right: 14),
            child: GestureDetector(
              child: Icon(
                Icons.arrow_back_ios,
                color: Color(0xffF48262),
                size: 26,
              ),
              onTap: () {
                _onWillPop();
              },
            ),
          ),
          toolbarHeight: 70,
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/konsultasi.jpg"),
              fit: BoxFit.cover,
              colorFilter:ColorFilter.mode(Color(0xffF48262), BlendMode.hue),
            ),
          ),
          height: MediaQuery.of(context).size.height,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Tunggu sebentar...",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: "Brandon",
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text("Kamu akan segera dihubungkan",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: "Brandon",
                    color: Colors.black54,
                    fontSize: 20,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: LoadingWidgetPulse(context),
                )
              ],
            ),
          ),
        ),
        bottomNavigationBar: PonnyBottomNavbar(selectedIndex: 2,),
      ),
    );
  }

}