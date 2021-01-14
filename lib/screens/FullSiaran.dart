import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoteView;
import 'package:flutter/services.dart';

class FullSiaran extends StatefulWidget {
  int remoteUid;
  FullSiaran({this.remoteUid});
  @override
  _FullSiaranState createState() => _FullSiaranState();

}

class _FullSiaranState extends State<FullSiaran> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    // TODO: implement build
    return Scaffold(
      body: Stack(
        children: [
          Container(
            child: RtcRemoteView.SurfaceView(uid: widget.remoteUid,renderMode: VideoRenderMode.Fit,),
          ),
          Positioned(child: IconButton(
            onPressed: (){
              Navigator.of(context).pop();
            },
            icon:Icon(
            Icons.close,
            color: Colors.white,
            size: 50,
          )),
            top: 0,left: 0,
          )
        ],
      )
    );
  }

}