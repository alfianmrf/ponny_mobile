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
  WaitingPage({Key key,@required this.voucher });
  @override
  _WaitingPageState createState() => _WaitingPageState();

}
class _WaitingPageState extends State<WaitingPage> {
  final scaffollKey = GlobalKey<ScaffoldState>();
  AgoraRtmClient _client;
  AgoraRtmChannel _channel;
  BuildContext _context;
  bool status_build =true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      Provider.of<UserModel>(context).getUser(Provider.of<AppModel>(context, listen: false).auth.access_token).then((value) {
        _createClient();
      });
      Timer(Duration(minutes: 1), () {
        showdialog();
      });
    });

  }
  @override
  void dispose() {
    // TODO: implement dispose
    _channel.leave();
    _client.logout();
    super.dispose();
  }

  void _createClient() async {
    _client =
    await AgoraRtmClient.createInstance(appID);
    _client.login(null, Provider.of<UserModel>(context,listen: false).user.id.toString());
    _client.onMessageReceived = (AgoraRtmMessage message, String peerId) {
      print("Peer msg: " + peerId + ", msg: " + message.text);
      if(message.text == 'answer'){
        var param={
          "id_voucher":widget.voucher.id,
          "dokter_id":int.parse(peerId)
        };
        Provider.of<VoucherModel>(context).incall(Provider.of<AppModel>(context,listen: false).auth.access_token, param).then((value) async {
           _channel.leave();
           _client.logout();
          if(value){
            Navigator.pushReplacement(
              _context,
              MaterialPageRoute(
                builder: (context) => CallPage(chanel: peerId, voucher: widget.voucher),
              ),
            );
          }else{
            Navigator.pop(_context,true);
          }
        });
      }
    };
    _client.onConnectionStateChanged = (int state, int reason) {
      print('Connection state changed: ' +
          state.toString() +
          ', reason: ' +
          reason.toString());
      if (state == 5) {
        _client.logout();
        print('Logout.');
      }
    };
    try {
      _channel = await _createChannel("loby");
      await _channel.join();
      print('Join channel success.');
    } catch (errorCode) {
      print('Join channel error: ' + errorCode.toString());
    }
  }

  Future<AgoraRtmChannel> _createChannel(String name) async {
    AgoraRtmChannel channel = await _client.createChannel(name);
    channel.onMemberJoined = (AgoraRtmMember member) {
      print(
          "Member joined: " + member.userId + ', channel: ' + member.channelId);
    };
    channel.onMemberLeft = (AgoraRtmMember member) {
      print("Member left: " + member.userId + ', channel: ' + member.channelId);
    };
    channel.onMessageReceived =
        (AgoraRtmMessage message, AgoraRtmMember member) {
          print("Channel msg: " + member.userId + ", msg: " + message.text);

    };
    return channel;
  }

  Future<bool> _onWillPop() async {
     _channel.leave();
     _client.logout();
    return true;
  }


  showdialog() async {
    await showDialog(
      context: _context,
      builder: (context) => new AlertDialog(
        title: new Text('Dokter Sedang Sibuk'),
        content: new Text('Sepertinya semua dokter sedang sibuk, apakah anda ingin menunggu?'),
        actions: <Widget>[
          new FlatButton(
            onPressed: () async {
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