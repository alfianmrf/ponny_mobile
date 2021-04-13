import 'package:flutter/material.dart';
import 'dart:async';

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoteView;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:ponny/common/constant.dart';
import 'package:ponny/model/App.dart';
import 'package:ponny/model/Order.dart';
import 'package:ponny/model/Voucher.dart';
import 'package:ponny/util/AppId.dart';
import 'package:agora_rtm/agora_rtm.dart';
import 'package:provider/provider.dart';
import 'package:uiblock/uiblock.dart';

import 'konsultasi_screen.dart';

class CallPage extends StatefulWidget {
  static const String id = "inCall_screen";
  String chanel;
  OrderDetailVoucher voucher;
  CallPage({Key key,@required this.chanel,@required this.voucher });
  @override
  _CallPageState createState() => _CallPageState();

}
class _CallPageState extends State<CallPage> {
  bool _joined = false;
  int _remoteUid = null;
  bool _switch = false;
  bool muted = false;
  var engine;
  bool status_build =true;
  BuildContext _context;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      initPlatformState();
    });

  }
  void endCallStatus(){
    Provider.of<VoucherModel>(_context).incallStatus(Provider.of<AppModel>(_context,listen: false).auth.access_token, {"id":widget.voucher.id});
  }

  Future<void> _handleCameraAndMic(Permission permission) async {
    final status = await permission.request();
    print(status);
  }

  Future<void> initPlatformState() async {
    await _handleCameraAndMic(Permission.camera);
    await _handleCameraAndMic(Permission.microphone);
    await _handleCameraAndMic(Permission.storage);

    var engine = await RtcEngine.create(appID);
    engine.setEventHandler(RtcEngineEventHandler(
        joinChannelSuccess: (String channel, int uid, int elapsed) {
          print('joinChannelSuccess ${channel} ${uid}');
          setState(() {
            _joined = true;
          });
        }, userJoined: (int uid, int elapsed) {
      print('userJoined ${uid}');
      setState(() {
        _remoteUid = uid;
      });
    }, userOffline: (int uid, UserOfflineReason reason) {
      print('userOffline ${uid}');
      setState(() {
        _remoteUid = null;
      });
      _onCallEnd(context);
    },streamMessage: (uid, streamId, data) {
          print(data);
    },
    ));
    await engine.enableVideo();
    await engine.joinChannel(null, widget.chanel, null, 0);
    // Timer.periodic(new Duration(seconds: 15), (timer) {
    //   endCallStatus();
    // });
    Timer(Duration(seconds: widget.voucher.durasi), () {
      _onCallEnd(_context);
    });
  }


  @override
  Widget build(BuildContext context) {

    SystemChrome.setEnabledSystemUIOverlays([]);
    if(status_build){
      setState(() {
        _context =context;
        status_build =false;
      });
    }

    // TODO: implement build
    return WillPopScope(
      child: Scaffold(
        body: Stack(
          children: [
            Center(
              child: _switch ? _renderRemoteVideo() : _renderLocalPreview(),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                padding: EdgeInsets.all(5.0),
                width: 100,
                height: 120,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _switch = !_switch;
                    });
                  },
                  child: Center(
                    child:
                    _switch ? _renderLocalPreview() : _renderRemoteVideo(),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                alignment: Alignment.bottomCenter,
                padding: const EdgeInsets.symmetric(vertical: 48),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    RawMaterialButton(
                      onPressed: _onToggleMute,
                      child: Icon(
                        muted ? Icons.mic_off : Icons.mic,
                        color: muted ? Colors.white : Colors.blueAccent,
                        size: 20.0,
                      ),
                      shape: CircleBorder(),
                      elevation: 2.0,
                      fillColor: muted ? Colors.blueAccent : Colors.white,
                      padding: const EdgeInsets.all(12.0),
                    ),
                    RawMaterialButton(
                      onPressed: ()=>_onCallEnd(context),
                      child: Icon(
                        Icons.call_end,
                        color: Colors.white,
                        size: 35.0,
                      ),
                      shape: CircleBorder(),
                      elevation: 2.0,
                      fillColor: Colors.redAccent,
                      padding: const EdgeInsets.all(15.0),
                    ),
                    RawMaterialButton(
                      onPressed:() async {
                        var engine = await RtcEngine.create(appID);
                        engine.switchCamera();
                      },
                      child: Icon(
                        Icons.switch_camera,
                        color: Colors.blueAccent,
                        size: 20.0,
                      ),
                      shape: CircleBorder(),
                      elevation: 2.0,
                      fillColor: Colors.white,
                      padding: const EdgeInsets.all(12.0),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      onWillPop: _onWillPop,
    );
  }

  Future<void> _onCallEnd(BuildContext context) async {
    UIBlock.block(context,customLoaderChild: LoadingWidget(context));
    Provider.of<VoucherModel>(context).incallStatus(Provider.of<AppModel>(context,listen: false).auth.access_token, {"id":widget.voucher.id}).then((value) async {
      UIBlock.unblock(context);
      if(value){
        var engine = await RtcEngine.create(appID);
        engine.leaveChannel();
        Navigator.pushNamedAndRemoveUntil(
            context,
            KonsultasiScreen.id,(_) => false
        );
      }
    });

  }

  Future<void> _onToggleMute() async {
    setState(() {
      muted = !muted;
    });
    var engine = await RtcEngine.create(appID);
    engine.muteLocalAudioStream(muted);
  }


  Widget _renderLocalPreview() {
    if (_joined) {
      return RtcLocalView.SurfaceView();
    } else {
      return Text(
        'Harap tunggu...',
        textAlign: TextAlign.center,
      );
    }
  }

  Widget _renderRemoteVideo() {
    if (_remoteUid != null) {
      return RtcRemoteView.SurfaceView(uid: _remoteUid);
    } else {
      return Container();
    }
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
      context: _context,
      builder: (context) => new AlertDialog(
        title: new Text('Apa kamu yakin?'),
        content: new Text('Apa anda yakin ingin mengakhiri panggilan.'),
        actions: <Widget>[
          new FlatButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: new Text('No'),
          ),
          new FlatButton(
            onPressed: () async {
              _onCallEnd(context);
            },
            child: new Text('Yes'),
          ),
        ],
      ),
    )) ?? false;
  }

}