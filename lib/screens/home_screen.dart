import 'dart:async';
import 'dart:collection';
import 'dart:convert';
//import 'dart:wasm';
import 'package:agora_rtm/agora_rtm.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:lodash_dart/lodash_dart.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:ponny/common/constant.dart';
import 'package:ponny/model/App.dart';
import 'package:ponny/model/Cart.dart';
import 'package:ponny/model/Category.dart';
import 'package:ponny/model/ChanelBroadcast.dart';
import 'package:ponny/model/FlashDeal.dart';
import 'package:ponny/model/Product.dart';
import 'package:ponny/model/ProductFlashDeal.dart';
import 'package:ponny/model/Slider.dart';
import 'package:ponny/model/User.dart';
import 'package:ponny/model/listCabangModel.dart';
import 'package:ponny/screens/pages.dart';
import 'package:ponny/screens/Blog_screen.dart';
import 'package:ponny/screens/Browse_Screen.dart';
import 'package:ponny/screens/FullSiaran.dart';
import 'package:ponny/screens/Localpride_Screen.dart';
import 'package:ponny/screens/Promotion_screen.dart';
import 'package:ponny/screens/Skincare_Screen.dart';
import 'package:ponny/screens/Skinklopedia_Screen.dart';
import 'package:ponny/screens/bantuan_screen.dart';
import 'package:ponny/screens/flash_sale_screen.dart';
import 'package:ponny/model/WishProduct.dart';
import 'package:ponny/screens/konsultasi_screen.dart';
import 'package:ponny/screens/login.dart';
import 'package:ponny/screens/product_details_screen.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:ponny/screens/skin_type_screen.dart';
import 'package:ponny/util/AppId.dart';
import 'package:ponny/util/globalUrl.dart';
import 'package:ponny/widgets/MyProduct.dart';
import 'package:ponny/widgets/MyProductFlash.dart';
import 'package:ponny/widgets/PonnyBottomNavbar.dart';
import 'package:ponny/widgets/PonnyAppBar.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ponny/screens/cart_screen.dart';
import 'package:uiblock/uiblock.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:ponny/util/globalUrl.dart';

import 'account/daftar_keinginan_screen.dart';
import 'package:ponny/common/constant.dart';
import 'package:agora_rtc_engine/rtc_engine.dart' as RtcE;
import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoteView;
import 'dart:io' show HttpHeaders, Platform;

import 'bantuan_screen.dart';

class HomeScreen extends StatefulWidget {
  static const String id = "home_screen";

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Timer _timer;

  final double targetElevation = 3;
  final targetColor = Color(0xfffdf8f0);
  var _color = Colors.transparent;
  double _elevation = 0;
  ScrollController _controller;
  bool loading_flashdeal = false;
  bool loading_youtube = true;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  String urlYoutube = "";
  bool isbrodcasting = false;
  int _remoteUid = null;
  AgoraRtmClient _client;
  static String videoId = '';
  int viewer = 0;
  bool isSiaran = false;
  YoutubePlayerController _controllersYoutube;

  bool _joined = false;

  var _channel;

  showModal() {
    return _timer = Timer(Duration(seconds: 2), () {
      showAlertDialogPromo(context);
    });
  }

  _launchURL(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<List<Category>> getCategory() async {
    List<Category> categoris = List<Category>();
    final res = await http.get(categoryList);
    // print(res.body);
    if (res.statusCode == 200) {
      final responejson = json.decode(res.body);
      responejson.forEach((v) {
        categoris.add(new Category.fromJson(v));
      });
    }
    return categoris;
  }

  Future<void> getbrodcaster() async {
    String urls =
        "https://api.agora.io/dev/v1/channel/user/1a2ac884df8a4c4c886353e5580a8580/broadcast";
    final res = await http.get(urls, headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader:
          "Basic OGI4YjdiYjA2NGU5NDFlMDhkMTFlNDg0Y2Q5MTY1MjM6OGJhNWMzNjczM2RkNDQzY2IzZjE3ZjE2Mzc3YjIwOTQ="
    });
    print(res.body);
    if (res.statusCode == 200) {
      final responejson = json.decode(res.body);
      final channelbc = ChanelBroadcast.fromJson(responejson);
      print(responejson);
      if (channelbc.success == true &&
          channelbc.data.broadcasters.length > 0 &&
          channelbc.data.broadcasters[0] == 1) {
        setState(() {
          _remoteUid = 1;
        });
        print(responejson);
        print(_remoteUid);
      } else {
        setState(() {
          _remoteUid = null;
        });
        print(responejson);
        print(_remoteUid);
      }
    } else {
      setState(() {
        _remoteUid = null;
      });
    }
  }

  Future<Null> _updateCart() async {
    var token = Provider.of<AppModel>(context).auth.access_token;
    final response = await http.get(listCarturl, headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader: "Bearer $token"
    });
    if (response.statusCode == 200) {
      final responseJson = json.decode(response.body);
      print("DATA CART");
      print(responseJson['data']);
    } else {
      print("DATA CART");
      print(response.statusCode);
    }
  }

  @override
  void initState() {
    super.initState();
    // showModal();
    _controller = ScrollController();
    _controller.addListener(_scrollListener);

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _getCartOfitem();
      _getWishListCount();
      initChanelBrodcaster();
      getbrodcaster();
      getyt();
      print("SUCCESS");
      print(_controllersYoutube);
      _updateCart();
      Provider.of<ProductModel>(context).getFlashSale();
    });
  }

  Future<void> initChanelBrodcaster() async {
    var engine = await RtcE.RtcEngine.create(appID);
    engine.setEventHandler(RtcE.RtcEngineEventHandler(
      joinChannelSuccess: (
        String channel,
        int uid,
        int elapsed,
      ) {
        print('joinChannelSuccess ${channel} ${uid}');
        setState(() {
          _joined = true;
        });
      },
      userJoined: (int uid, int elapsed) async {
        print('userJoined ${uid}');
        String urls =
            "https://api.agora.io/dev/v1/channel/user/1a2ac884df8a4c4c886353e5580a8580/broadcast";
        final res = await http.get(urls, headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.authorizationHeader:
              "Basic OGI4YjdiYjA2NGU5NDFlMDhkMTFlNDg0Y2Q5MTY1MjM6OGJhNWMzNjczM2RkNDQzY2IzZjE3ZjE2Mzc3YjIwOTQ="
        });
        final responejson = json.decode(res.body);
        final channelbc = ChanelBroadcast.fromJson(responejson);
        if (channelbc.success == true &&
            channelbc.data.broadcasters.length > 0 &&
            channelbc.data.broadcasters[0] == 1) {
          setState(() {
            _remoteUid = 1;
          });
        }
      },
      userOffline: (int uid, RtcE.UserOfflineReason reason) {
        print('userOffline ${uid}');
        setState(() {
          _remoteUid = null;
        });
      },
      streamMessage: (uid, streamId, data) {
        print(data);
      },
    ));
    engine.enableVideo();
    engine.enableLocalAudio(false);
    engine.enableLocalVideo(false);
    engine.enableVideo();
    engine.setParameters(
        '''{\"che.video.lowBitRateStreamParameter\":{\"width\":320,\"height\":180,\"frameRate\":15,\"bitRate\":140}}''');
    await engine.joinChannel(null, "broadcast", null, 0);

    _client = await AgoraRtmClient.createInstance(appID);
    await _client.login(
        null,
        Provider.of<UserModel>(context).loading
            ? Provider.of<UserModel>(context).user.id.toString()
            : DateTime.now().toString());
    _channel = await _createChannel("broadcast");
    await _channel.join();
    _channel.getMembers().then((value) {
      setState(() {
        viewer = value.length;
      });
      print("jumlah :" + value.length.toString());
    });
  }

  Future<AgoraRtmChannel> _createChannel(String name) async {
    AgoraRtmChannel channel = await _client.createChannel(name);
    channel.onMemberJoined = (AgoraRtmMember member) async {
      _channel.getMembers().then((value) {
        setState(() {
          viewer = value.length;
        });
      });
    };
    channel.onMemberLeft = (AgoraRtmMember member) {
      var len;
      _channel.getMembers().then((value) {
        setState(() {
          viewer = value.length;
        });
      });
    };
    channel.onMemberJoined = (AgoraRtmMember member) {
      _channel.getMembers().then((value) {
        setState(() {
          viewer = value.length;
        });
      });
    };
    return channel;
  }

  Widget _renderRemoteVideo() {
    if (_remoteUid != null) {
      return RtcRemoteView.SurfaceView(uid: _remoteUid);
    } else {
      return Container();
    }
  }

  Future ytplayer() async {
    videoId = YoutubePlayer.convertUrlToId(
        Provider.of<AppModel>(context).setting.embedVideo);
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        _controllersYoutube = YoutubePlayerController(
          initialVideoId: videoId,
          flags: const YoutubePlayerFlags(
            autoPlay: false,
          ),
        );
      });
    });
    return _controllersYoutube;
  }

  Future getyt() {
    var textId = YoutubePlayer.convertUrlToId(
        Provider.of<AppModel>(context).setting.embedVideo);
    setState(() {
      _controllersYoutube = YoutubePlayerController(
        initialVideoId: textId,
        flags: const YoutubePlayerFlags(
          autoPlay: false,
        ),
      );
      loading_youtube = false;
      return _controllersYoutube;
    });
  }

  @override
  void dispose() {
    _controller?.removeListener(_scrollListener);
    _controller?.dispose();

    super.dispose();
  }

  void _scrollListener() {
    double newElevation = _controller.offset > 1 ? targetElevation : 0;
    final newColor = _controller.offset > 1 ? targetColor : Colors.transparent;
    if (_elevation != newElevation) {
      setState(() {
        _elevation = newElevation;
      });
    }
    if (_color != newColor) {
      setState(() {
        _color = newColor;
      });
    }
  }

  Future<void> _getCartOfitem() async {
    final auth = Provider.of<AppModel>(context);
    if (auth.loggedIn) {
      await Provider.of<CartModel>(context).getCart(auth.auth.access_token);
    }
  }

  Future<void> _getWishListCount() async {
    final auth = Provider.of<AppModel>(context);
    if (auth.loggedIn) {
      await Provider.of<WishModel>(context)
          .getCountWislist(auth.auth.access_token);
    }
  }

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  Widget title(String nameTitle) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Text(
        nameTitle,
        style: TextStyle(
          fontFamily: 'Yeseva',
          fontSize: 20,
        ),
      ),
    );
  }

  void showAlertDialogPromo(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // set up the AlertDialog
    SimpleDialog alert = SimpleDialog(
      backgroundColor: Color(0xfffdf8f0),
      contentPadding: EdgeInsets.all(5.0),
      children: <Widget>[
        Align(
          alignment: Alignment.centerRight,
          child: IconButton(
              icon: Icon(Icons.close),
              color: Color(0xffF48262),
              onPressed: () {
                Navigator.of(context).pop();
              }),
        ),
        Center(
            child: Image.asset(
          'assets/images/ponny.png',
          height: 100,
        )),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Center(
              child: Text(
            'HALO!',
            style: TextStyle(
              fontFamily: 'Brandon',
              fontWeight: FontWeight.w600,
              fontSize: 20,
            ),
          )),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Center(
              child: Text(
            'Nikmati diskon 10% untuk pesanan pertamamu. Mau? Tulis email aktifmu di bawah ini dan Phoebe akan kirim kode promonya ke email.',
            style: TextStyle(
              fontFamily: 'Brandon',
              fontSize: 14,
            ),
            textAlign: TextAlign.center,
          )),
        ),
        Padding(
          padding: EdgeInsets.only(top: 20, bottom: 10, left: 30, right: 30),
          child: TextFormField(
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              hintText: 'Email',
              hintStyle: TextStyle(color: Color(0xffBCBDC0)),
              labelText: 'Email',
              labelStyle: TextStyle(color: Colors.black),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                borderSide: BorderSide(
                  color: Color(0xffF48262),
                  width: 1.0,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                borderSide: BorderSide(
                  color: Color(0xffF48262),
                  width: 1.0,
                ),
              ),
            ),
            keyboardType: TextInputType.emailAddress,
            validator: (String value) {
              if (value.isEmpty) {
                return 'Email tidak boleh kosong';
              } else if (!value.contains('@')) {
                return 'Email tidak valid';
              }
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 30),
          child: Center(
            child: Wrap(children: <Widget>[
              FlatButton(
                color: Color(0xffF48262),
                padding: EdgeInsets.symmetric(horizontal: 30),
                textColor: Colors.white,
                onPressed: () {},
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Text(
                  "DAFTAR",
                  style: TextStyle(
                    fontSize: 16.0,
                    fontFamily: 'Brandon',
                  ),
                ),
              ),
            ]),
          ),
        ),
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Are you sure?'),
            content: new Text('Do you want to exit an App'),
            actions: <Widget>[
              new FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: new Text('No'),
              ),
              new FlatButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: new Text('Yes'),
              ),
            ],
          ),
        )) ??
        false;
  }

  // bool checkDialog = false;

  Future<void> _refresh(BuildContext context) async {
    _getCartOfitem();
    _getWishListCount();
    initChanelBrodcaster();
    getbrodcaster();
    getyt();
    _updateCart();
    Provider.of<ProductModel>(context).getFlashSale();
  }

  @override
  Widget build(BuildContext context) {
    final silder = Provider.of<SliderModel>(context).listSlider;
    List<Widget> ListFlash;
    List<Widget> ListBestsale;
    List<Widget> ListPhobe;
    final jmlCard = Provider.of<CartModel>(context).getCountOfquantity();

    final flashdeal = Provider.of<ProductModel>(context).flashsale;

    return new WillPopScope(
      onWillPop: _onWillPop,
      child: RefreshIndicator(
        onRefresh: () => _refresh(context),
        child: Scaffold(
          backgroundColor: Theme.of(context).primaryColor,
          body: Stack(children: <Widget>[
            Scaffold(
              key: scaffoldKey,
              backgroundColor: Color(0xffFDF8F0),
              extendBodyBehindAppBar: true,
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(100.0),
                child: SafeArea(
                  child: Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.symmetric(vertical: 5),
                        color: Color(0xffF48262),
                        child: Center(
                          child: Text(
                            'GRATIS ONGKIR DENGAN PEMBELANJAAN RP 250.000',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Brandon',
                            ),
                            textScaleFactor: .8,
                          ),
                        ),
                      ),
                      new AppBar(
                        primary: false,
                        title: Image.asset('assets/images/PonnyBeaute.png',
                            fit: BoxFit.contain, height: 46),
                        centerTitle: true,
                        backgroundColor: _color,
                        elevation: _elevation,
                        leading: IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Browse()));
                          },
                          icon: ImageIcon(
                              AssetImage('assets/images/home/search.png')),
                        ),
                        iconTheme: IconThemeData(
                          color: Color(0xffF48262),
                        ),
                        actions: <Widget>[
                          IconButton(
                            icon: new Stack(children: <Widget>[
                              Provider.of<AppModel>(context).loggedIn
                                  ? new Container(
                                      padding: EdgeInsets.all(5),
                                      child: Provider.of<WishModel>(context)
                                              .loading
                                          ? LoadingRing(context)
                                          : ImageIcon(
                                              AssetImage(
                                                  'assets/images/home/wishlist.png'),
                                            ),
                                    )
                                  : new Container(
                                      padding: EdgeInsets.all(5),
                                      child: ImageIcon(
                                        AssetImage(
                                            'assets/images/home/wishlist.png'),
                                      ),
                                    ),
                              if (Provider.of<WishModel>(context)
                                          .countwishlist >
                                      0 &&
                                  Provider.of<AppModel>(context).loggedIn)
                                new Positioned(
                                  // draw a red marble
                                  top: 0.0,
                                  right: 0.0,
                                  child: Container(
                                    width: 12,
                                    height: 12,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(40),
                                      color: Colors.redAccent,
                                    ),
                                    child: Center(
                                      child: Text(
                                        Provider.of<WishModel>(context)
                                            .countwishlist
                                            .toString(),
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'Brandon',
                                          fontSize: 8,
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                            ]),
                            onPressed: () {
                              if (Provider.of<AppModel>(context).loggedIn) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          DaftarKeinginanScreen()),
                                );
                              } else {
                                Navigator.push(
                                    context,
                                    new MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          new LoginScreen(),
                                    ));
                              }
                            },
                          ),
                          IconButton(
                            icon: new Stack(children: <Widget>[
                              Provider.of<AppModel>(context).loggedIn
                                  ? new Container(
                                      padding: EdgeInsets.all(5),
                                      child: Provider.of<CartModel>(context)
                                              .loadingCard
                                          ? LoadingRing(context)
                                          : ImageIcon(
                                              AssetImage(
                                                  'assets/images/home/cart.png'),
                                            ),
                                    )
                                  : new Container(
                                      padding: EdgeInsets.all(5),
                                      child: ImageIcon(
                                        AssetImage(
                                            'assets/images/home/cart.png'),
                                      ),
                                    ),
                              if (jmlCard > 0)
                                new Positioned(
                                  // draw a red marble
                                  top: 0.0,
                                  right: 0.0,
                                  child: Container(
                                    width: 12,
                                    height: 12,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(40),
                                      color: Colors.redAccent,
                                    ),
                                    child: Center(
                                      child: Text(
                                        jmlCard.toString(),
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'Brandon',
                                          fontSize: 8,
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                            ]),
                            onPressed: () {
                              if (Provider.of<AppModel>(context).loggedIn) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CartScreen()),
                                );
                              } else {
                                Navigator.push(
                                    context,
                                    new MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          new LoginScreen(),
                                    ));
                              }
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              body: new Container(
                  margin:
                      EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                  child: SingleChildScrollView(
                      controller: _controller,
                      child: Column(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(top: 25),
                            height: MediaQuery.of(context).size.width * 0.45,
                            color: Colors.white,
                            child: Center(
                              child: new Swiper(
                                itemBuilder: (BuildContext context, int index) {
                                  return new CachedNetworkImage(
                                    imageUrl: img_url + silder[index].photo,
                                    placeholder: (context, url) =>
                                        LoadingWidgetPulse(context),
                                    errorWidget: (context, url, error) =>
                                        Image.asset('assets/images/basic.jpg'),
                                    fit: BoxFit.fill,
                                  );
                                },
                                itemCount: silder.length,
                                pagination: new SwiperPagination(
                                    margin: new EdgeInsets.all(5.0),
                                    builder: new DotSwiperPaginationBuilder(
                                        color: Color(0xffE6E7E9),
                                        activeColor: Color(0xffF48262))),
                                control: null,
                                autoplay: true,
                              ),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.only(bottom: 10),
                            child: Consumer<CategoryModel>(
                                builder: (context, value, child) {
                              if (value.loadingCategory) {
                                return LoadingWidgetFadingCircle(context);
                              } else {
                                return Column(
                                  children: [
                                    // IntrinsicHeight(
                                    //   child: Row(
                                    //     children: [
                                    //       Expanded(
                                    //           flex: 1,
                                    //           child: Container(
                                    //               color: Color(0xffFACAC1),
                                    //               padding: EdgeInsets.symmetric(
                                    //                   vertical: 5),
                                    //               child: Column(children: [
                                    //                 Container(
                                    //                   height: 20,
                                    //                   child: Image.asset(
                                    //                     'assets/images/home/asli.png',
                                    //                     fit: BoxFit.contain,
                                    //                   ),
                                    //                 ),
                                    //                 Container(
                                    //                   child: Text(
                                    //                     '100%\nASLI',
                                    //                     style: TextStyle(
                                    //                       fontFamily: 'Brandon',
                                    //                       fontSize: 12,
                                    //                       color:
                                    //                           Color(0xffF48262),
                                    //                       fontWeight:
                                    //                           FontWeight.w600,
                                    //                     ),
                                    //                     textAlign:
                                    //                         TextAlign.center,
                                    //                   ),
                                    //                 ),
                                    //               ]))),
                                    //       Expanded(
                                    //         flex: 1,
                                    //         child: Container(
                                    //           color: Color(0xffFBDFD2),
                                    //           padding: EdgeInsets.symmetric(
                                    //               vertical: 5),
                                    //           child: Column(
                                    //             children: [
                                    //               Container(
                                    //                 height: 20,
                                    //                 child: Image.asset(
                                    //                   'assets/images/home/bpom.png',
                                    //                   fit: BoxFit.contain,
                                    //                 ),
                                    //               ),
                                    //               Container(
                                    //                 child: Text(
                                    //                   'PRODUK\nBER-BPOM',
                                    //                   style: TextStyle(
                                    //                     fontFamily: 'Brandon',
                                    //                     fontSize: 12,
                                    //                     color: Color(0xffF48262),
                                    //                     fontWeight:
                                    //                         FontWeight.w600,
                                    //                   ),
                                    //                   textAlign: TextAlign.center,
                                    //                 ),
                                    //               ),
                                    //             ],
                                    //           ),
                                    //         ),
                                    //       ),
                                    //       Expanded(
                                    //         flex: 1,
                                    //         child: Container(
                                    //           color: Color(0xffFACAC1),
                                    //           padding: EdgeInsets.symmetric(
                                    //               vertical: 5),
                                    //           child: Column(
                                    //             children: [
                                    //               Container(
                                    //                 height: 20,
                                    //                 child: Image.asset(
                                    //                   'assets/images/home/konsumen.png',
                                    //                   fit: BoxFit.contain,
                                    //                 ),
                                    //               ),
                                    //               Container(
                                    //                 child: Text(
                                    //                   'LAYANAN\nKONSUMEN',
                                    //                   style: TextStyle(
                                    //                     fontFamily: 'Brandon',
                                    //                     fontSize: 12,
                                    //                     color: Color(0xffF48262),
                                    //                     fontWeight:
                                    //                         FontWeight.w600,
                                    //                   ),
                                    //                   textAlign: TextAlign.center,
                                    //                 ),
                                    //               ),
                                    //             ],
                                    //           ),
                                    //         ),
                                    //       ),
                                    //       Expanded(
                                    //           flex: 1,
                                    //           child: Container(
                                    //             color: Color(0xffFBDFD2),
                                    //             padding: EdgeInsets.symmetric(
                                    //                 vertical: 5),
                                    //             child: Column(
                                    //               children: [
                                    //                 Container(
                                    //                   height: 20,
                                    //                   child: Image.asset(
                                    //                     'assets/images/home/aman.png',
                                    //                     fit: BoxFit.contain,
                                    //                   ),
                                    //                 ),
                                    //                 Container(
                                    //                   child: Text(
                                    //                     'KEMASAN\nAMAN',
                                    //                     style: TextStyle(
                                    //                       fontFamily: 'Brandon',
                                    //                       fontSize: 12,
                                    //                       color:
                                    //                           Color(0xffF48262),
                                    //                       fontWeight:
                                    //                           FontWeight.w600,
                                    //                     ),
                                    //                     textAlign:
                                    //                         TextAlign.center,
                                    //                   ),
                                    //                 ),
                                    //               ],
                                    //             ),
                                    //           ))
                                    //     ],
                                    //   ),
                                    // ),
                                    Container(
                                      width: MediaQuery.of(context).size.width,
                                      margin: EdgeInsets.symmetric(
                                          horizontal: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.030,
                                          vertical: 7),
                                      height: 60,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(18)),
                                          boxShadow: [
                                            BoxShadow(
                                                offset: Offset(0, 0),
                                                blurRadius: 2,
                                                color: Colors.grey[300])
                                          ]),
                                      child: Row(children: [
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      QRScreen()),
                                            );
                                          },
                                          child: Row(
                                            children: [
                                              Container(
                                                  margin:
                                                      EdgeInsets.only(left: 15),
                                                  width: 35,
                                                  child: Image.asset(
                                                      'assets/images/icon-scan.png')),
                                              Container(
                                                margin:
                                                    EdgeInsets.only(left: 7),
                                                child: RichText(
                                                    text: TextSpan(children: [
                                                  TextSpan(
                                                      text: 'Scan QR Produk\n',
                                                      style: TextStyle(
                                                          color: Colors.black87,
                                                          fontFamily: 'Brandon',
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 12)),
                                                  TextSpan(
                                                      text:
                                                          'Untuk belanja di toko Ponny Beaute',
                                                      style: TextStyle(
                                                        fontFamily: 'Brandon',
                                                        fontSize: 9,
                                                        color: Colors.black45,
                                                      ))
                                                ])),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 10),
                                          child: VerticalDivider(),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            Provider.of<UserModel>(context)
                                                        .user ==
                                                    null
                                                ? Navigator.push(
                                                    context,
                                                    new MaterialPageRoute(
                                                      builder: (BuildContext
                                                              context) =>
                                                          new LoginScreen(),
                                                    ))
                                                : null;
                                          },
                                          child: Row(
                                            children: [
                                              Container(
                                                  margin:
                                                      EdgeInsets.only(left: 6),
                                                  width: 30,
                                                  child: Image.asset(
                                                      'assets/images/Asset 13.png')),
                                              Container(
                                                margin:
                                                    EdgeInsets.only(left: 7),
                                                child: RichText(
                                                    text: TextSpan(children: [
                                                  TextSpan(
                                                      text: Provider.of<
                                                                      AppModel>(
                                                                  context)
                                                              .loggedIn
                                                          ? '${Provider.of<CartModel>(context).CurentPoint} POIN\n'
                                                          : "Point Reward\n",
                                                      style: TextStyle(
                                                          color: Colors.black87,
                                                          fontFamily: 'Brandon',
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 12)),
                                                  TextSpan(
                                                      text:
                                                          'Happy Skin Rewards',
                                                      style: TextStyle(
                                                        fontFamily: 'Brandon',
                                                        fontSize: 9,
                                                        color: Colors.black45,
                                                      ))
                                                ])),
                                              ),
                                            ],
                                          ),
                                        )
                                      ]),
                                    ),
                                    // SizedBox(height: 20),
                                    IntrinsicHeight(
                                      child: Row(
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: InkWell(
                                              onTap: () {
                                                final skincare = value.categoris
                                                    .firstWhere((element) =>
                                                        element.id == 9);
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            Skincare(
                                                              category:
                                                                  skincare,
                                                            )));
                                              },
                                              child: Column(
                                                children: [
                                                  AspectRatio(
                                                    aspectRatio: 1,
                                                    child: Container(
                                                      margin: EdgeInsets.all(7),
                                                      padding:
                                                          EdgeInsets.all(5),
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        border: Border.all(
                                                          width: 1,
                                                          color:
                                                              Color(0xffF48262),
                                                        ),
                                                      ),
                                                      child: Image.asset(
                                                          'assets/images/home/skincare.png'),
                                                    ),
                                                  ),
                                                  Text(
                                                    'Skincare',
                                                    style: TextStyle(
                                                      fontFamily: 'Brandon',
                                                      fontSize: 12,
                                                    ),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: InkWell(
                                              onTap: () {
                                                final skincare = value.categoris
                                                    .firstWhere((element) =>
                                                        element.id == 10);
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            Skincare(
                                                              category:
                                                                  skincare,
                                                            )));
                                              },
                                              child: Column(
                                                children: [
                                                  AspectRatio(
                                                    aspectRatio: 1,
                                                    child: Container(
                                                      margin: EdgeInsets.all(7),
                                                      padding:
                                                          EdgeInsets.all(5),
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        border: Border.all(
                                                          width: 1,
                                                          color:
                                                              Color(0xffF48262),
                                                        ),
                                                      ),
                                                      child: Image.asset(
                                                          'assets/images/home/hair.png'),
                                                    ),
                                                  ),
                                                  Text(
                                                    'Hair & Makeup',
                                                    style: TextStyle(
                                                      fontFamily: 'Brandon',
                                                      fontSize: 12,
                                                    ),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: InkWell(
                                              onTap: () {
                                                final skincare = value.categoris
                                                    .firstWhere((element) =>
                                                        element.id == 11);
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            Skincare(
                                                              category:
                                                                  skincare,
                                                            )));
                                              },
                                              child: Column(
                                                children: [
                                                  AspectRatio(
                                                    aspectRatio: 1,
                                                    child: Container(
                                                      margin: EdgeInsets.all(7),
                                                      padding:
                                                          EdgeInsets.all(5),
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        border: Border.all(
                                                          width: 1,
                                                          color:
                                                              Color(0xffF48262),
                                                        ),
                                                      ),
                                                      child: Image.asset(
                                                          'assets/images/home/peralatan.png'),
                                                    ),
                                                  ),
                                                  Text(
                                                    'Peralatan Kecantikan',
                                                    style: TextStyle(
                                                      fontFamily: 'Brandon',
                                                      fontSize: 12,
                                                    ),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: InkWell(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            LocalPride()));
                                              },
                                              child: Column(
                                                children: [
                                                  AspectRatio(
                                                    aspectRatio: 1,
                                                    child: Container(
                                                      margin: EdgeInsets.all(7),
                                                      padding:
                                                          EdgeInsets.all(7),
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        border: Border.all(
                                                          width: 1,
                                                          color:
                                                              Color(0xffF48262),
                                                        ),
                                                      ),
                                                      child: Image.asset(
                                                          'assets/images/home/bangga.png'),
                                                    ),
                                                  ),
                                                  Text(
                                                    'Bangga Produk Indonesia',
                                                    style: TextStyle(
                                                      fontFamily: 'Brandon',
                                                      fontSize: 12,
                                                    ),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: InkWell(
                                              onTap: () {
                                                final skincare = value.categoris
                                                    .firstWhere((element) =>
                                                        element.id == 15 ||
                                                        element.name ==
                                                            "SKIN CONCERN");
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            Skincare(
                                                              category:
                                                                  skincare,
                                                            )));
                                              },
                                              child: Column(
                                                children: [
                                                  AspectRatio(
                                                    aspectRatio: 1,
                                                    child: Container(
                                                      margin: EdgeInsets.all(7),
                                                      padding:
                                                          EdgeInsets.all(5),
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        border: Border.all(
                                                          width: 1,
                                                          color:
                                                              Color(0xffF48262),
                                                        ),
                                                      ),
                                                      child: Image.asset(
                                                          'assets/images/home/masalah.png'),
                                                    ),
                                                  ),
                                                  Text(
                                                    'Masalah\nKulit',
                                                    style: TextStyle(
                                                      fontFamily: 'Brandon',
                                                      fontSize: 12,
                                                    ),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    IntrinsicHeight(
                                      child: Row(
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: InkWell(
                                              onTap: () {
                                                if (Provider.of<AppModel>(
                                                        context)
                                                    .loggedIn) {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            PromotionScreen()),
                                                  );
                                                } else {
                                                  Navigator.push(
                                                      context,
                                                      new MaterialPageRoute(
                                                        builder: (BuildContext
                                                                context) =>
                                                            new LoginScreen(),
                                                      ));
                                                }
                                              },
                                              child: Column(
                                                children: [
                                                  AspectRatio(
                                                    aspectRatio: 1,
                                                    child: Container(
                                                      margin: EdgeInsets.all(7),
                                                      padding:
                                                          EdgeInsets.all(5),
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        border: Border.all(
                                                          width: 1,
                                                          color:
                                                              Color(0xffF48262),
                                                        ),
                                                      ),
                                                      child: Image.asset(
                                                          'assets/images/home/promosi.png'),
                                                    ),
                                                  ),
                                                  Text(
                                                    'Promosi',
                                                    style: TextStyle(
                                                      fontFamily: 'Brandon',
                                                      fontSize: 12,
                                                    ),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: InkWell(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            Skinklopedia()));
                                              },
                                              child: Column(
                                                children: [
                                                  AspectRatio(
                                                    aspectRatio: 1,
                                                    child: Container(
                                                      margin: EdgeInsets.all(7),
                                                      padding:
                                                          EdgeInsets.all(5),
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        border: Border.all(
                                                          width: 1,
                                                          color:
                                                              Color(0xffF48262),
                                                        ),
                                                      ),
                                                      child: Image.asset(
                                                          'assets/images/home/skinklopedia.png'),
                                                    ),
                                                  ),
                                                  Text(
                                                    'Skinklopedia',
                                                    style: TextStyle(
                                                      fontFamily: 'Brandon',
                                                      fontSize: 12,
                                                    ),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: InkWell(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            SkinTypeScreen()));
                                              },
                                              child: Column(
                                                children: [
                                                  AspectRatio(
                                                    aspectRatio: 1,
                                                    child: Container(
                                                      margin: EdgeInsets.all(7),
                                                      padding:
                                                          EdgeInsets.all(5),
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        border: Border.all(
                                                          width: 1,
                                                          color:
                                                              Color(0xffF48262),
                                                        ),
                                                      ),
                                                      child: Image.asset(
                                                          'assets/images/home/jenis.png'),
                                                    ),
                                                  ),
                                                  Text(
                                                    'Jenis Kulit',
                                                    style: TextStyle(
                                                      fontFamily: 'Brandon',
                                                      fontSize: 12,
                                                    ),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: InkWell(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            Blog(
                                                              category: 0,
                                                              tag: "ALL",
                                                            )));
                                              },
                                              child: Column(
                                                children: [
                                                  AspectRatio(
                                                    aspectRatio: 1,
                                                    child: Container(
                                                      margin: EdgeInsets.all(7),
                                                      padding:
                                                          EdgeInsets.all(5),
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        border: Border.all(
                                                          width: 1,
                                                          color:
                                                              Color(0xffF48262),
                                                        ),
                                                      ),
                                                      child: Image.asset(
                                                          'assets/images/home/blog.png'),
                                                    ),
                                                  ),
                                                  Text(
                                                    'Blog',
                                                    style: TextStyle(
                                                      fontFamily: 'Brandon',
                                                      fontSize: 12,
                                                    ),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: InkWell(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            BantuanScreen()));
                                              },
                                              child: Column(
                                                children: [
                                                  AspectRatio(
                                                    aspectRatio: 1,
                                                    child: Container(
                                                      margin: EdgeInsets.all(7),
                                                      padding:
                                                          EdgeInsets.all(5),
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        border: Border.all(
                                                          width: 1,
                                                          color:
                                                              Color(0xffF48262),
                                                        ),
                                                      ),
                                                      child: Image.asset(
                                                          'assets/images/home/bantuan.png'),
                                                    ),
                                                  ),
                                                  Text(
                                                    'Butuh Bantuan?',
                                                    style: TextStyle(
                                                      fontFamily: 'Brandon',
                                                      fontSize: 12,
                                                    ),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                );
                              }
                            }),
                          ),
                          if (_remoteUid != null)
                            Container(
                              width: MediaQuery.of(context).size.width,
                              child: Stack(
                                children: [
                                  Column(
                                    children: [
                                      Container(
                                        height: 20,
                                        width: double.infinity,
                                      ),
                                      Container(
                                        color: Color(0xffFBDFD2),
                                        height: 20,
                                        width: double.infinity,
                                      ),
                                    ],
                                  ),
                                  Positioned.fill(
                                    child: Center(
                                      child: Text(
                                        'LIVE NOW',
                                        style: TextStyle(
                                          fontSize: 24,
                                          fontFamily: 'Brandon',
                                          color: Color(0xffF48262),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          if (_remoteUid != null)
                            Container(
                              color: Color(0xffFBDFD2),
                              padding: EdgeInsets.symmetric(horizontal: 30),
                              child: Stack(children: [
                                Container(
                                  width: double.infinity,
                                  height: 250,
                                  color: Colors.grey,
                                  child: _renderRemoteVideo(),
                                ),
                                Positioned(
                                  top: 10,
                                  right: 10,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 3, horizontal: 5),
                                    color: Color(0xff000000).withOpacity(0.1),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.remove_red_eye,
                                          color: Colors.white,
                                          size: 12,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 5),
                                          child: Text(
                                            viewer.toString(),
                                            style: TextStyle(
                                              fontFamily: 'Brandon',
                                              fontSize: 12,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 10,
                                  right: 10,
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          new MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                new FullSiaran(
                                              remoteUid: _remoteUid,
                                            ),
                                          ));
                                    },
                                    child: Icon(
                                      Icons.fullscreen,
                                      size: 22,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ]),
                            ),
                          if (_remoteUid != null)
                            Container(
                              color: Color(0xffFBDFD2),
                              width: double.infinity,
                              padding: EdgeInsets.fromLTRB(30, 10, 30, 30),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'Menuju Glowing Bersama Phoebe',
                                    style: TextStyle(
                                      fontFamily: 'Brandon',
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    'Halo teman Phoebe, kita lagi ada diskon gede-gedean.',
                                    style: TextStyle(
                                      fontFamily: 'Brandon',
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          if (flashdeal != null &&
                              DateTime.now().millisecondsSinceEpoch <
                                  flashdeal.detail.endDate * 1000 &&
                              !loading_flashdeal)
                            Container(
                              color: Color(0xffFACAC1),
                              width: MediaQuery.of(context).size.width,
                              padding: EdgeInsets.only(top: 8, bottom: 3),
                              child: Image.asset('assets/images/flash-sale.png',
                                  height: 40),
                            ),
                          if (flashdeal != null &&
                              DateTime.now().millisecondsSinceEpoch <
                                  flashdeal.detail.endDate * 1000 &&
                              !loading_flashdeal)
                            Container(
                              color: Color(0xffFBDFD2),
                              child: Column(
                                children: [
                                  Container(
                                    width: double.infinity,
                                    padding: EdgeInsets.only(top: 10),
                                    child: Text(
                                      flashdeal.detail.title,
                                      style: TextStyle(
                                        fontFamily: 'Yeseva',
                                        fontSize: 26,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(vertical: 10),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: Padding(
                                            padding: EdgeInsets.only(right: 10),
                                            child: Text(
                                              DateTime.now().isBefore(DateTime
                                                      .fromMillisecondsSinceEpoch(
                                                          flashdeal.detail
                                                                  .startDate *
                                                              1000))
                                                  ? 'DIMULAI DALAM'
                                                  : 'BERAKHIR DALAM',
                                              style: TextStyle(
                                                fontFamily: 'Brandon',
                                              ),
                                              textAlign: TextAlign.right,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Padding(
                                              padding:
                                                  EdgeInsets.only(left: 10),
                                              child: CountdownTimer(
                                                  onEnd: () {
                                                    setState(() {
                                                      loading_flashdeal = true;
                                                    });
                                                    UIBlock.block(context,
                                                        customLoaderChild:
                                                            LoadingWidget(
                                                                context));
                                                    Provider.of<ProductModel>(
                                                            context)
                                                        .getFlashSale()
                                                        .then((value) {
                                                      UIBlock.unblock(context);
                                                      setState(() {
                                                        loading_flashdeal =
                                                            false;
                                                      });
                                                    }).catchError((onError) {
                                                      UIBlock.unblock(context);
                                                      setState(() {
                                                        loading_flashdeal =
                                                            false;
                                                      });
                                                    });
                                                  },
                                                  endTime: DateTime.now().isBefore(
                                                          DateTime.fromMillisecondsSinceEpoch(
                                                              flashdeal.detail
                                                                      .startDate *
                                                                  1000))
                                                      ? flashdeal.detail
                                                              .startDate *
                                                          1000
                                                      : flashdeal
                                                              .detail.endDate *
                                                          1000,
                                                  widgetBuilder:
                                                      (BuildContext context,
                                                          CurrentRemainingTime
                                                              time) {
                                                    return Row(
                                                      children: [
                                                        Container(
                                                          width: 24,
                                                          height: 24,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Color(
                                                                0xffF48262),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        3),
                                                          ),
                                                          child: Center(
                                                            child: Text(
                                                              time.days != null
                                                                  ? time.days
                                                                      .toString()
                                                                  : "00",
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    'Brandon',
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      5),
                                                          child: Text(
                                                            ':',
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Brandon',
                                                              color: Color(
                                                                  0xffF48262),
                                                            ),
                                                          ),
                                                        ),
                                                        Container(
                                                          width: 24,
                                                          height: 24,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Color(
                                                                0xffF48262),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        3),
                                                          ),
                                                          child: Center(
                                                            child: Text(
                                                              time.hours != null
                                                                  ? time.hours
                                                                      .toString()
                                                                  : "00",
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    'Brandon',
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      5),
                                                          child: Text(
                                                            ':',
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Brandon',
                                                              color: Color(
                                                                  0xffF48262),
                                                            ),
                                                          ),
                                                        ),
                                                        Container(
                                                          width: 24,
                                                          height: 24,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Color(
                                                                0xffF48262),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        3),
                                                          ),
                                                          child: Center(
                                                            child: Text(
                                                              time.min != null
                                                                  ? time.min
                                                                      .toString()
                                                                  : "00",
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    'Brandon',
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      5),
                                                          child: Text(
                                                            ':',
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Brandon',
                                                              color: Color(
                                                                  0xffF48262),
                                                            ),
                                                          ),
                                                        ),
                                                        Container(
                                                          width: 24,
                                                          height: 24,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Color(
                                                                0xffF48262),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        3),
                                                          ),
                                                          child: Center(
                                                            child: Text(
                                                              time.sec != null
                                                                  ? time.sec
                                                                      .toString()
                                                                  : "00",
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    'Brandon',
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    );
                                                  })),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height:
                                        MediaQuery.of(context).size.width * .9,
                                    padding: EdgeInsets.only(top: 10),
                                    child: Consumer<ProductModel>(
                                      builder: (context, value, child) {
                                        if (value.loadingBestSale) {
                                          return LoadingWidgetFadingCircle(
                                              context);
                                        } else {
                                          var data = Lodash().chunk(
                                              array: flashdeal.flash_products,
                                              size: 3);
                                          return new Swiper(
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              if (data[index].length == 3) {
                                                return Container(
                                                    child: Row(children: [
                                                  for (FlashSaleProduct e
                                                      in data[index])
                                                    Expanded(
                                                      flex: 1,
                                                      child: Container(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal: 7),
                                                        child: MyProductFlash(
                                                          productFlash: e,
                                                          IsLiked: Provider.of<WishModel>(context).rawlist.firstWhere(
                                                                      (element) =>
                                                                          element
                                                                              .productId ==
                                                                          e.product
                                                                              .id,
                                                                      orElse: () =>
                                                                          null) !=
                                                                  null
                                                              ? true
                                                              : false,
                                                          onFavorit: () {
                                                            if (Provider.of<
                                                                        AppModel>(
                                                                    context)
                                                                .loggedIn) {
                                                              Provider.of<WishModel>(
                                                                      context)
                                                                  .addProductToWish(
                                                                      e.product,
                                                                      Provider.of<AppModel>(
                                                                              context)
                                                                          .auth
                                                                          .access_token);
                                                            } else {
                                                              Navigator.push(
                                                                  context,
                                                                  new MaterialPageRoute(
                                                                    builder: (BuildContext
                                                                            context) =>
                                                                        new LoginScreen(),
                                                                  ));
                                                            }
                                                          },
                                                          onUnFavorit: () {
                                                            if (Provider.of<
                                                                        AppModel>(
                                                                    context)
                                                                .loggedIn) {
                                                              Provider.of<WishModel>(
                                                                      context)
                                                                  .removeProductFromWish(
                                                                      e.product,
                                                                      Provider.of<AppModel>(
                                                                              context)
                                                                          .auth
                                                                          .access_token);
                                                            } else {
                                                              Navigator.push(
                                                                  context,
                                                                  new MaterialPageRoute(
                                                                    builder: (BuildContext
                                                                            context) =>
                                                                        new LoginScreen(),
                                                                  ));
                                                            }
                                                          },
                                                          onTobag: () {
                                                            if (Provider.of<
                                                                        AppModel>(
                                                                    context)
                                                                .loggedIn) {
                                                              UIBlock.block(
                                                                  context,
                                                                  customLoaderChild:
                                                                      LoadingWidget(
                                                                          context));
                                                              Provider.of<CartModel>(
                                                                      context)
                                                                  .addProductToCart(
                                                                      e.product,
                                                                      Provider.of<AppModel>(
                                                                              context)
                                                                          .auth
                                                                          .access_token,
                                                                      null)
                                                                  .then(
                                                                      (value) {
                                                                UIBlock.unblock(
                                                                    context);
                                                                showAlertDialog(
                                                                    context,
                                                                    e.product);
                                                              });
                                                            } else {
                                                              Navigator.push(
                                                                  context,
                                                                  new MaterialPageRoute(
                                                                    builder: (BuildContext
                                                                            context) =>
                                                                        new LoginScreen(),
                                                                  ));
                                                            }
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                ]));
                                              } else if (data[index].length ==
                                                  2) {
                                                return Container(
                                                    child: Row(
                                                  children: [
                                                    for (FlashSaleProduct e
                                                        in data[index])
                                                      Expanded(
                                                        flex: 1,
                                                        child: Container(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      7),
                                                          child: MyProductFlash(
                                                            productFlash: e,
                                                            IsLiked: Provider.of<WishModel>(context).rawlist.firstWhere(
                                                                        (element) =>
                                                                            element.productId ==
                                                                            e.product
                                                                                .id,
                                                                        orElse: () =>
                                                                            null) !=
                                                                    null
                                                                ? true
                                                                : false,
                                                            onFavorit: () {
                                                              if (Provider.of<
                                                                          AppModel>(
                                                                      context)
                                                                  .loggedIn) {
                                                                Provider.of<WishModel>(
                                                                        context)
                                                                    .addProductToWish(
                                                                        e
                                                                            .product,
                                                                        Provider.of<AppModel>(context)
                                                                            .auth
                                                                            .access_token);
                                                              } else {
                                                                Navigator.push(
                                                                    context,
                                                                    new MaterialPageRoute(
                                                                      builder: (BuildContext
                                                                              context) =>
                                                                          new LoginScreen(),
                                                                    ));
                                                              }
                                                            },
                                                            onUnFavorit: () {
                                                              if (Provider.of<
                                                                          AppModel>(
                                                                      context)
                                                                  .loggedIn) {
                                                                Provider.of<WishModel>(
                                                                        context)
                                                                    .removeProductFromWish(
                                                                        e
                                                                            .product,
                                                                        Provider.of<AppModel>(context)
                                                                            .auth
                                                                            .access_token);
                                                              } else {
                                                                Navigator.push(
                                                                    context,
                                                                    new MaterialPageRoute(
                                                                      builder: (BuildContext
                                                                              context) =>
                                                                          new LoginScreen(),
                                                                    ));
                                                              }
                                                            },
                                                            onTobag: () {
                                                              if (Provider.of<
                                                                          AppModel>(
                                                                      context)
                                                                  .loggedIn) {
                                                                UIBlock.block(
                                                                    context,
                                                                    customLoaderChild:
                                                                        LoadingWidget(
                                                                            context));
                                                                Provider.of<CartModel>(
                                                                        context)
                                                                    .addProductToCart(
                                                                        e
                                                                            .product,
                                                                        Provider.of<AppModel>(context)
                                                                            .auth
                                                                            .access_token,
                                                                        null)
                                                                    .then(
                                                                        (value) {
                                                                  UIBlock.unblock(
                                                                      context);
                                                                  showAlertDialog(
                                                                      context,
                                                                      e.product);
                                                                });
                                                              } else {
                                                                Navigator.push(
                                                                    context,
                                                                    new MaterialPageRoute(
                                                                      builder: (BuildContext
                                                                              context) =>
                                                                          new LoginScreen(),
                                                                    ));
                                                              }
                                                            },
                                                          ),
                                                        ),
                                                      ),
                                                    Expanded(
                                                      flex: 1,
                                                      child: Container(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal: 7),
                                                      ),
                                                    )
                                                  ],
                                                ));
                                              } else {
                                                return Container(
                                                    child: Row(
                                                  children: [
                                                    for (FlashSaleProduct e
                                                        in data[index])
                                                      Expanded(
                                                        flex: 1,
                                                        child: Container(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      7),
                                                          child: MyProductFlash(
                                                            productFlash: e,
                                                            IsLiked: Provider.of<WishModel>(context).rawlist.firstWhere(
                                                                        (element) =>
                                                                            element.productId ==
                                                                            e.product
                                                                                .id,
                                                                        orElse: () =>
                                                                            null) !=
                                                                    null
                                                                ? true
                                                                : false,
                                                            onFavorit: () {
                                                              if (Provider.of<
                                                                          AppModel>(
                                                                      context)
                                                                  .loggedIn) {
                                                                Provider.of<WishModel>(
                                                                        context)
                                                                    .addProductToWish(
                                                                        e
                                                                            .product,
                                                                        Provider.of<AppModel>(context)
                                                                            .auth
                                                                            .access_token);
                                                              } else {
                                                                Navigator.push(
                                                                    context,
                                                                    new MaterialPageRoute(
                                                                      builder: (BuildContext
                                                                              context) =>
                                                                          new LoginScreen(),
                                                                    ));
                                                              }
                                                            },
                                                            onUnFavorit: () {
                                                              if (Provider.of<
                                                                          AppModel>(
                                                                      context)
                                                                  .loggedIn) {
                                                                Provider.of<WishModel>(
                                                                        context)
                                                                    .removeProductFromWish(
                                                                        e
                                                                            .product,
                                                                        Provider.of<AppModel>(context)
                                                                            .auth
                                                                            .access_token);
                                                              } else {
                                                                Navigator.push(
                                                                    context,
                                                                    new MaterialPageRoute(
                                                                      builder: (BuildContext
                                                                              context) =>
                                                                          new LoginScreen(),
                                                                    ));
                                                              }
                                                            },
                                                            onTobag: () {
                                                              if (Provider.of<
                                                                          AppModel>(
                                                                      context)
                                                                  .loggedIn) {
                                                                UIBlock.block(
                                                                    context,
                                                                    customLoaderChild:
                                                                        LoadingWidget(
                                                                            context));
                                                                Provider.of<CartModel>(
                                                                        context)
                                                                    .addProductToCart(
                                                                        e
                                                                            .product,
                                                                        Provider.of<AppModel>(context)
                                                                            .auth
                                                                            .access_token,
                                                                        null)
                                                                    .then(
                                                                        (value) {
                                                                  UIBlock.unblock(
                                                                      context);
                                                                  showAlertDialog(
                                                                      context,
                                                                      e.product);
                                                                });
                                                              } else {
                                                                Navigator.push(
                                                                    context,
                                                                    new MaterialPageRoute(
                                                                      builder: (BuildContext
                                                                              context) =>
                                                                          new LoginScreen(),
                                                                    ));
                                                              }
                                                            },
                                                          ),
                                                        ),
                                                      ),
                                                    Expanded(
                                                      flex: 1,
                                                      child: Container(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal: 7),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 1,
                                                      child: Container(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal: 7),
                                                      ),
                                                    )
                                                  ],
                                                ));
                                              }
                                            },
                                            itemCount: data.length,
                                            pagination: null,
                                            control: null,
                                            autoplay: false,
                                          );
                                        }
                                      },
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(vertical: 10),
                                    child: FlatButton(
                                      height: 30,
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 20),
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            new MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  new FlashSaleScreen(),
                                            ));
                                      },
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      color: Color(0xffF48262),
                                      child: Text(
                                        'LIHAT SEMUA',
                                        style: TextStyle(
                                          fontFamily: 'Brandon',
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          title("Best Seller"),
                          Container(
                            height: MediaQuery.of(context).size.width * .8,
                            child: Consumer<ProductModel>(
                              builder: (context, value, child) {
                                if (value.loadingBestSale) {
                                  return LoadingWidgetFadingCircle(context);
                                } else {
                                  // ListBestsale = getColumProduct(context,value.Best_sell,3);
                                  var dataBest = Lodash()
                                      .chunk(array: value.Best_sell, size: 3);
                                  return new Swiper(
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      if (dataBest[index].length == 3) {
                                        return Container(
                                            child: Row(children: [
                                          for (Product e in dataBest[index])
                                            Expanded(
                                              flex: 1,
                                              child: Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 7),
                                                child: MyProduct(
                                                  product: e,
                                                  IsLiked: Provider.of<
                                                                      WishModel>(
                                                                  context)
                                                              .rawlist
                                                              .firstWhere(
                                                                  (element) =>
                                                                      element
                                                                          .productId ==
                                                                      e.id,
                                                                  orElse: () =>
                                                                      null) !=
                                                          null
                                                      ? true
                                                      : false,
                                                  onFavorit: () {
                                                    if (Provider.of<AppModel>(
                                                            context)
                                                        .loggedIn) {
                                                      Provider.of<WishModel>(
                                                              context)
                                                          .addProductToWish(
                                                              e,
                                                              Provider.of<AppModel>(
                                                                      context)
                                                                  .auth
                                                                  .access_token);
                                                    } else {
                                                      Navigator.push(
                                                          context,
                                                          new MaterialPageRoute(
                                                            builder: (BuildContext
                                                                    context) =>
                                                                new LoginScreen(),
                                                          ));
                                                    }
                                                  },
                                                  onUnFavorit: () {
                                                    if (Provider.of<AppModel>(
                                                            context)
                                                        .loggedIn) {
                                                      Provider.of<WishModel>(
                                                              context)
                                                          .removeProductFromWish(
                                                              e,
                                                              Provider.of<AppModel>(
                                                                      context)
                                                                  .auth
                                                                  .access_token);
                                                    } else {
                                                      Navigator.push(
                                                          context,
                                                          new MaterialPageRoute(
                                                            builder: (BuildContext
                                                                    context) =>
                                                                new LoginScreen(),
                                                          ));
                                                    }
                                                  },
                                                  onTobag: () {
                                                    if (Provider.of<AppModel>(
                                                            context)
                                                        .loggedIn) {
                                                      UIBlock.block(context,
                                                          customLoaderChild:
                                                              LoadingWidget(
                                                                  context));
                                                      Provider.of<CartModel>(
                                                              context)
                                                          .addProductToCart(
                                                              e,
                                                              Provider.of<AppModel>(
                                                                      context)
                                                                  .auth
                                                                  .access_token,
                                                              null)
                                                          .then((value) {
                                                        UIBlock.unblock(
                                                            context);
                                                        showAlertDialog(
                                                            context, e);
                                                      });
                                                    } else {
                                                      Navigator.push(
                                                          context,
                                                          new MaterialPageRoute(
                                                            builder: (BuildContext
                                                                    context) =>
                                                                new LoginScreen(),
                                                          ));
                                                    }
                                                  },
                                                ),
                                              ),
                                            ),
                                        ]));
                                      } else if (dataBest[index].length == 2) {
                                        return Container(
                                            child: Row(
                                          children: [
                                            for (Product e in dataBest[index])
                                              Expanded(
                                                flex: 1,
                                                child: Container(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 7),
                                                  child: MyProduct(
                                                    product: e,
                                                    IsLiked: Provider.of<
                                                                        WishModel>(
                                                                    context)
                                                                .rawlist
                                                                .firstWhere(
                                                                    (element) =>
                                                                        element
                                                                            .productId ==
                                                                        e.id,
                                                                    orElse: () =>
                                                                        null) !=
                                                            null
                                                        ? true
                                                        : false,
                                                    onFavorit: () {
                                                      if (Provider.of<AppModel>(
                                                              context)
                                                          .loggedIn) {
                                                        Provider.of<WishModel>(
                                                                context)
                                                            .addProductToWish(
                                                                e,
                                                                Provider.of<AppModel>(
                                                                        context)
                                                                    .auth
                                                                    .access_token);
                                                      } else {
                                                        Navigator.push(
                                                            context,
                                                            new MaterialPageRoute(
                                                              builder: (BuildContext
                                                                      context) =>
                                                                  new LoginScreen(),
                                                            ));
                                                      }
                                                    },
                                                    onUnFavorit: () {
                                                      if (Provider.of<AppModel>(
                                                              context)
                                                          .loggedIn) {
                                                        Provider.of<WishModel>(
                                                                context)
                                                            .removeProductFromWish(
                                                                e,
                                                                Provider.of<AppModel>(
                                                                        context)
                                                                    .auth
                                                                    .access_token);
                                                      } else {
                                                        Navigator.push(
                                                            context,
                                                            new MaterialPageRoute(
                                                              builder: (BuildContext
                                                                      context) =>
                                                                  new LoginScreen(),
                                                            ));
                                                      }
                                                    },
                                                    onTobag: () {
                                                      if (Provider.of<AppModel>(
                                                              context)
                                                          .loggedIn) {
                                                        UIBlock.block(context,
                                                            customLoaderChild:
                                                                LoadingWidget(
                                                                    context));
                                                        Provider.of<CartModel>(
                                                                context)
                                                            .addProductToCart(
                                                                e,
                                                                Provider.of<AppModel>(
                                                                        context)
                                                                    .auth
                                                                    .access_token,
                                                                null)
                                                            .then((value) {
                                                          UIBlock.unblock(
                                                              context);
                                                          showAlertDialog(
                                                              context, e);
                                                        });
                                                      } else {
                                                        Navigator.push(
                                                            context,
                                                            new MaterialPageRoute(
                                                              builder: (BuildContext
                                                                      context) =>
                                                                  new LoginScreen(),
                                                            ));
                                                      }
                                                    },
                                                  ),
                                                ),
                                              ),
                                            Expanded(
                                              flex: 1,
                                              child: Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 7),
                                              ),
                                            )
                                          ],
                                        ));
                                      } else {
                                        return Container(
                                            child: Row(
                                          children: [
                                            for (Product e in dataBest[index])
                                              Expanded(
                                                flex: 1,
                                                child: Container(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 7),
                                                  child: MyProduct(
                                                    product: e,
                                                    IsLiked: Provider.of<
                                                                        WishModel>(
                                                                    context)
                                                                .rawlist
                                                                .firstWhere(
                                                                    (element) =>
                                                                        element
                                                                            .productId ==
                                                                        e.id,
                                                                    orElse: () =>
                                                                        null) !=
                                                            null
                                                        ? true
                                                        : false,
                                                    onFavorit: () {
                                                      if (Provider.of<AppModel>(
                                                              context)
                                                          .loggedIn) {
                                                        Provider.of<WishModel>(
                                                                context)
                                                            .addProductToWish(
                                                                e,
                                                                Provider.of<AppModel>(
                                                                        context)
                                                                    .auth
                                                                    .access_token);
                                                      } else {
                                                        Navigator.push(
                                                            context,
                                                            new MaterialPageRoute(
                                                              builder: (BuildContext
                                                                      context) =>
                                                                  new LoginScreen(),
                                                            ));
                                                      }
                                                    },
                                                    onUnFavorit: () {
                                                      if (Provider.of<AppModel>(
                                                              context)
                                                          .loggedIn) {
                                                        Provider.of<WishModel>(
                                                                context)
                                                            .removeProductFromWish(
                                                                e,
                                                                Provider.of<AppModel>(
                                                                        context)
                                                                    .auth
                                                                    .access_token);
                                                      } else {
                                                        Navigator.push(
                                                            context,
                                                            new MaterialPageRoute(
                                                              builder: (BuildContext
                                                                      context) =>
                                                                  new LoginScreen(),
                                                            ));
                                                      }
                                                    },
                                                    onTobag: () {
                                                      if (Provider.of<AppModel>(
                                                              context)
                                                          .loggedIn) {
                                                        UIBlock.block(context,
                                                            customLoaderChild:
                                                                LoadingWidget(
                                                                    context));
                                                        Provider.of<CartModel>(
                                                                context)
                                                            .addProductToCart(
                                                                e,
                                                                Provider.of<AppModel>(
                                                                        context)
                                                                    .auth
                                                                    .access_token,
                                                                null)
                                                            .then((value) {
                                                          UIBlock.unblock(
                                                              context);
                                                          showAlertDialog(
                                                              context, e);
                                                        });
                                                      } else {
                                                        Navigator.push(
                                                            context,
                                                            new MaterialPageRoute(
                                                              builder: (BuildContext
                                                                      context) =>
                                                                  new LoginScreen(),
                                                            ));
                                                      }
                                                    },
                                                  ),
                                                ),
                                              ),
                                            Expanded(
                                              flex: 1,
                                              child: Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 7),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 7),
                                              ),
                                            )
                                          ],
                                        ));
                                      }
                                    },
                                    itemCount: dataBest.length,
                                    pagination: null,
                                    control: null,
                                    autoplay: false,
                                  );
                                }
                              },
                            ),
                          ),
                          Container(
                            height: 1.5,
                            width: MediaQuery.of(context).size.width * 0.9,
                            color: Color(0xffF48262),
                          ),
                          title("Phoebe's Choice"),
                          Container(
                            height: MediaQuery.of(context).size.width * .8,
                            child: Consumer<ProductModel>(
                              builder: (context, value, child) {
                                if (value.loadingPhobe) {
                                  return LoadingWidgetFadingCircle(context);
                                } else {
                                  // ListPhobe = getColumProduct(context,value.PhoebeChoices,3);
                                  var dataPhoby = Lodash().chunk(
                                      array: value.PhoebeChoices, size: 3);

                                  return new Swiper(
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      if (dataPhoby[index].length == 3) {
                                        return Container(
                                            child: Row(children: [
                                          for (Product e in dataPhoby[index])
                                            Expanded(
                                              flex: 1,
                                              child: Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 7),
                                                child: MyProduct(
                                                  product: e,
                                                  IsLiked: Provider.of<
                                                                      WishModel>(
                                                                  context)
                                                              .rawlist
                                                              .firstWhere(
                                                                  (element) =>
                                                                      element
                                                                          .productId ==
                                                                      e.id,
                                                                  orElse: () =>
                                                                      null) !=
                                                          null
                                                      ? true
                                                      : false,
                                                  onFavorit: () {
                                                    if (Provider.of<AppModel>(
                                                            context)
                                                        .loggedIn) {
                                                      Provider.of<WishModel>(
                                                              context)
                                                          .addProductToWish(
                                                              e,
                                                              Provider.of<AppModel>(
                                                                      context)
                                                                  .auth
                                                                  .access_token);
                                                    } else {
                                                      Navigator.push(
                                                          context,
                                                          new MaterialPageRoute(
                                                            builder: (BuildContext
                                                                    context) =>
                                                                new LoginScreen(),
                                                          ));
                                                    }
                                                  },
                                                  onUnFavorit: () {
                                                    if (Provider.of<AppModel>(
                                                            context)
                                                        .loggedIn) {
                                                      Provider.of<WishModel>(
                                                              context)
                                                          .removeProductFromWish(
                                                              e,
                                                              Provider.of<AppModel>(
                                                                      context)
                                                                  .auth
                                                                  .access_token);
                                                    } else {
                                                      Navigator.push(
                                                          context,
                                                          new MaterialPageRoute(
                                                            builder: (BuildContext
                                                                    context) =>
                                                                new LoginScreen(),
                                                          ));
                                                    }
                                                  },
                                                  onTobag: () {
                                                    if (Provider.of<AppModel>(
                                                            context)
                                                        .loggedIn) {
                                                      UIBlock.block(context,
                                                          customLoaderChild:
                                                              LoadingWidget(
                                                                  context));
                                                      Provider.of<CartModel>(
                                                              context)
                                                          .addProductToCart(
                                                              e,
                                                              Provider.of<AppModel>(
                                                                      context)
                                                                  .auth
                                                                  .access_token,
                                                              null)
                                                          .then((value) {
                                                        UIBlock.unblock(
                                                            context);
                                                        showAlertDialog(
                                                            context, e);
                                                      });
                                                    } else {
                                                      Navigator.push(
                                                          context,
                                                          new MaterialPageRoute(
                                                            builder: (BuildContext
                                                                    context) =>
                                                                new LoginScreen(),
                                                          ));
                                                    }
                                                  },
                                                ),
                                              ),
                                            ),
                                        ]));
                                      } else if (dataPhoby[index].length == 2) {
                                        return Container(
                                            child: Row(
                                          children: [
                                            for (Product e in dataPhoby[index])
                                              Expanded(
                                                flex: 1,
                                                child: Container(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 7),
                                                  child: MyProduct(
                                                    product: e,
                                                    IsLiked: Provider.of<
                                                                        WishModel>(
                                                                    context)
                                                                .rawlist
                                                                .firstWhere(
                                                                    (element) =>
                                                                        element
                                                                            .productId ==
                                                                        e.id,
                                                                    orElse: () =>
                                                                        null) !=
                                                            null
                                                        ? true
                                                        : false,
                                                    onFavorit: () {
                                                      if (Provider.of<AppModel>(
                                                              context)
                                                          .loggedIn) {
                                                        Provider.of<WishModel>(
                                                                context)
                                                            .addProductToWish(
                                                                e,
                                                                Provider.of<AppModel>(
                                                                        context)
                                                                    .auth
                                                                    .access_token);
                                                      } else {
                                                        Navigator.push(
                                                            context,
                                                            new MaterialPageRoute(
                                                              builder: (BuildContext
                                                                      context) =>
                                                                  new LoginScreen(),
                                                            ));
                                                      }
                                                    },
                                                    onUnFavorit: () {
                                                      if (Provider.of<AppModel>(
                                                              context)
                                                          .loggedIn) {
                                                        Provider.of<WishModel>(
                                                                context)
                                                            .removeProductFromWish(
                                                                e,
                                                                Provider.of<AppModel>(
                                                                        context)
                                                                    .auth
                                                                    .access_token);
                                                      } else {
                                                        Navigator.push(
                                                            context,
                                                            new MaterialPageRoute(
                                                              builder: (BuildContext
                                                                      context) =>
                                                                  new LoginScreen(),
                                                            ));
                                                      }
                                                    },
                                                    onTobag: () {
                                                      if (Provider.of<AppModel>(
                                                              context)
                                                          .loggedIn) {
                                                        UIBlock.block(context,
                                                            customLoaderChild:
                                                                LoadingWidget(
                                                                    context));
                                                        Provider.of<CartModel>(
                                                                context)
                                                            .addProductToCart(
                                                                e,
                                                                Provider.of<AppModel>(
                                                                        context)
                                                                    .auth
                                                                    .access_token,
                                                                null)
                                                            .then((value) {
                                                          UIBlock.unblock(
                                                              context);
                                                          showAlertDialog(
                                                              context, e);
                                                        });
                                                      } else {
                                                        Navigator.push(
                                                            context,
                                                            new MaterialPageRoute(
                                                              builder: (BuildContext
                                                                      context) =>
                                                                  new LoginScreen(),
                                                            ));
                                                      }
                                                    },
                                                  ),
                                                ),
                                              ),
                                            Expanded(
                                              flex: 1,
                                              child: Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 7),
                                              ),
                                            )
                                          ],
                                        ));
                                      } else {
                                        return Container(
                                            child: Row(
                                          children: [
                                            for (Product e in dataPhoby[index])
                                              Expanded(
                                                flex: 1,
                                                child: Container(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 7),
                                                  child: MyProduct(
                                                    product: e,
                                                    IsLiked: Provider.of<
                                                                        WishModel>(
                                                                    context)
                                                                .rawlist
                                                                .firstWhere(
                                                                    (element) =>
                                                                        element
                                                                            .productId ==
                                                                        e.id,
                                                                    orElse: () =>
                                                                        null) !=
                                                            null
                                                        ? true
                                                        : false,
                                                    onFavorit: () {
                                                      if (Provider.of<AppModel>(
                                                              context)
                                                          .loggedIn) {
                                                        Provider.of<WishModel>(
                                                                context)
                                                            .addProductToWish(
                                                                e,
                                                                Provider.of<AppModel>(
                                                                        context)
                                                                    .auth
                                                                    .access_token);
                                                      } else {
                                                        Navigator.push(
                                                            context,
                                                            new MaterialPageRoute(
                                                              builder: (BuildContext
                                                                      context) =>
                                                                  new LoginScreen(),
                                                            ));
                                                      }
                                                    },
                                                    onUnFavorit: () {
                                                      if (Provider.of<AppModel>(
                                                              context)
                                                          .loggedIn) {
                                                        Provider.of<WishModel>(
                                                                context)
                                                            .removeProductFromWish(
                                                                e,
                                                                Provider.of<AppModel>(
                                                                        context)
                                                                    .auth
                                                                    .access_token);
                                                      } else {
                                                        Navigator.push(
                                                            context,
                                                            new MaterialPageRoute(
                                                              builder: (BuildContext
                                                                      context) =>
                                                                  new LoginScreen(),
                                                            ));
                                                      }
                                                    },
                                                    onTobag: () {
                                                      if (Provider.of<AppModel>(
                                                              context)
                                                          .loggedIn) {
                                                        UIBlock.block(context,
                                                            customLoaderChild:
                                                                LoadingWidget(
                                                                    context));
                                                        Provider.of<CartModel>(
                                                                context)
                                                            .addProductToCart(
                                                                e,
                                                                Provider.of<AppModel>(
                                                                        context)
                                                                    .auth
                                                                    .access_token,
                                                                null)
                                                            .then((value) {
                                                          UIBlock.unblock(
                                                              context);
                                                          showAlertDialog(
                                                              context, e);
                                                        });
                                                      } else {
                                                        Navigator.push(
                                                            context,
                                                            new MaterialPageRoute(
                                                              builder: (BuildContext
                                                                      context) =>
                                                                  new LoginScreen(),
                                                            ));
                                                      }
                                                    },
                                                  ),
                                                ),
                                              ),
                                            Expanded(
                                              flex: 1,
                                              child: Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 7),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 7),
                                              ),
                                            )
                                          ],
                                        ));
                                      }
                                    },
                                    itemCount: dataPhoby.length,
                                    pagination: null,
                                    control: null,
                                    autoplay: false,
                                  );
                                }
                              },
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            child: Stack(
                              children: [
                                Column(
                                  children: [
                                    Container(
                                      height: 20,
                                      width: double.infinity,
                                    ),
                                    Container(
                                      color: Color(0xffFBDFD2),
                                      height: 20,
                                      width: double.infinity,
                                    ),
                                  ],
                                ),
                                Positioned.fill(
                                  child: Center(
                                    child: Text(
                                      'DIARY PHOEBE',
                                      style: TextStyle(
                                        fontSize: 24,
                                        fontFamily: 'Brandon',
                                        color: Color(0xffF48262),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          loading_youtube
                              ? Container(
                                  width: double.infinity,
                                  color: Color(0xffFBDFD2),
                                  child: Center(
                                    child: LoadingWidget(context),
                                  ),
                                )
                              : Container(
                                  color: Color(0xffFBDFD2),
                                  padding: EdgeInsets.symmetric(horizontal: 30),
                                  child: YoutubePlayer(
                                    controller: _controllersYoutube,
                                    bottomActions: [
                                      CurrentPosition(),
                                      ProgressBar(isExpanded: true),
                                      RemainingDuration(),
                                    ],
                                  ),
                                ),
                          Container(
                            color: Color(0xffFBDFD2),
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(
                                horizontal: 30, vertical: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'Menuju Glowing Bersama Phoebe',
                                  style: TextStyle(
                                    fontFamily: 'Brandon',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  'Siapa nih yang masih suka bingung sama skincare routine atau baru mau mulai pakai skincare? Biar nggak salah langkah, kamu bisa tonton video baru dari Ponny Beaute dalam series: Belajar Bareng Phoebe!',
                                  style: TextStyle(
                                    fontFamily: 'Brandon',
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                Container(
                                  padding: EdgeInsets.only(top: 30),
                                  child: FlatButton(
                                    onPressed: () {
                                      _launchURL(
                                          "https://www.youtube.com/c/PonnyBeaute");
                                    },
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    materialTapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      side: BorderSide(
                                        width: 1.0,
                                        color: Color(0xffF48262),
                                      ),
                                    ),
                                    child: Text(
                                      'LIHAT LEBIH BANYAK',
                                      style: TextStyle(
                                        fontFamily: 'Brandon',
                                        color: Color(0xffF48262),
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ))),
            ),
          ]),
          bottomNavigationBar: new PonnyBottomNavbar(selectedIndex: 0),
        ),
      ),
    );
  }
}

class SecondRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Second Route"),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Go back!'),
        ),
      ),
    );
  }
}
