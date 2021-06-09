import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:ponny/common/constant.dart';
import 'package:ponny/model/App.dart';
import 'package:ponny/model/Order.dart';
import 'package:ponny/model/Product.dart';
import 'package:ponny/screens/account_screen.dart';
import 'package:ponny/util/globalUrl.dart';
import 'package:ponny/widgets/PonnyBottomNavbar.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:uiblock/uiblock.dart';

class KomplainDalamPerjalananScreen extends StatefulWidget {
  static const String id = "Komplain_Dalam_Perjalanan_Screen";
  Order order;
  KomplainDalamPerjalananScreen({Key key,this.order});
  @override
  _KomplainDalamPerjalananStateScreen createState() =>
      _KomplainDalamPerjalananStateScreen();
}

class _KomplainDalamPerjalananStateScreen extends State<KomplainDalamPerjalananScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _value1 = false;
  bool _value2 = false;
  bool loading =true;
  final _catatan = TextEditingController();
  List<KomplainInput> _masalah =[];
  List<KomplainInput> _solusi =[];
  List<KomplainInputProduct> _product=[];
  List<File> files =[];

  //we omitted the brackets '{}' and are using fat arrow '=>' instead, this is dart syntax
  void _value1Changed(bool value) => setState(() => _value1 = value);
  void _value2Changed(bool value) => setState(() => _value2 = value);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _getParam();
      widget.order.order_details.forEach((element) {
        _product.add(KomplainInputProduct(
          element.id,
          element.product,
          false
          )
        );
      });
    });
  }

  Future<bool> _getParam() async {
    bool result =false;
    String token = Provider.of<AppModel>(context).auth.access_token;
    final res = await http.get(listParamKompain+"/"+"66", headers: { HttpHeaders.contentTypeHeader: 'application/json', HttpHeaders.authorizationHeader: "Bearer $token"});
    if(res.statusCode == 200){
      final responseJson = json.decode(res.body);
      // print(res.body);
      setState(() {
      for (Map item in responseJson["masalah"]) {
          _masalah.add(
            KomplainInput(
                item["param_3"],
                item["param_2"],
                false
            )
          );
      }
      for (Map item in responseJson["solusi"]) {
        _solusi.add(
            KomplainInput(
                item["param_3"],
                item["param_2"],
                false
            )
        );
      }
      loading =false;
      });
      result = true;
    }
    return result;

  }
  Future<bool> _validation() async {
    if(_masalah.where((element) => element.val ==true).length>0 && _solusi.where((element) => element.val ==true).length>0 && _catatan.value.text.isNotEmpty && files.length>0 && _product.where((element) => element.val == true).length > 0&& _value1){
      return await _fetchInsert();
    }else{
      final snackBar = SnackBar(
        content: Text('Form komplain belum lengkap!',style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.redAccent,
      );
      _scaffoldKey.currentState.showSnackBar(snackBar);
    }
    return false;
  }

  Future<bool>_fetchInsert() async {
    bool result =false;
    UIBlock.block(context,customLoaderChild: LoadingWidget(context));
    var token = Provider.of<AppModel>(context,listen: false).auth.access_token;
    Map<String, String> headers = { "Authorization": "Bearer $token"};
    var request = http.MultipartRequest(
        "POST", Uri.parse(listParamKompain+"/"+widget.order.id.toString()));
    List<int> _product_komplain = [];
    _product.forEach((element) { if(element.val == true) _product_komplain.add(element.id);});

    for (var file in files) {
      var multipartFile = await http.MultipartFile.fromPath(
          "photos[]", file.path,
          contentType:  MediaType('image', 'jpeg'));

      request.files.add(multipartFile);
    }
    request.fields["problem_id"] = _masalah.firstWhere((element) => element.val ==true).id;
    request.fields["solusi"] = _solusi.firstWhere((element) => element.val ==true).id;
    request.fields["catatan"] = _catatan.value.text;
    request.fields["product_komplain"] = "["+_product_komplain.join(',')+"]";
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();

    if(response.statusCode == 200)
    {
      result =true;
    }else{
      _scaffoldKey.currentState.showSnackBar(snackBarError);
    }
    UIBlock.unblock(context);
    return result;

  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        key: _scaffoldKey,
        appBar:  AppBar(
          titleSpacing: 0.0,
          elevation: 0.0,
          leading: IconButton(
            onPressed: (){
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios_rounded,
              color: Color(0xffF48262),
            ),
          ),
          title: Text(
            'Komplain',
            style: TextStyle(
              fontSize: 24,
              fontFamily: 'Yeseva',
              color: Hexcolor('#F48262'),
            ),
          ),
          bottom: PreferredSize(
              child: Container(
                color: Color(0xffF48262),
                height: 1.0,
              ),
              preferredSize: Size.fromHeight(1.0)
          ),
        ),
        resizeToAvoidBottomInset: true,
        backgroundColor: Hexcolor('#FCF8F0'),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: 27, bottom: 27),
                width: MediaQuery.of(context).size.width,
                color: Hexcolor("#F59379"),
                child: Column(
                  children: [
                    Container(
                      child: Text(
                        "Pengajuan Komplain",
                        style: TextStyle(
                          fontFamily: "Yeseva",
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 25, right: 25, top: 5),
                width: MediaQuery.of(context).size.width,
                child: loading ? Container(
                  child: Center(
                    child: LoadingWidgetFadingCircle(context),
                  )
                ):Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Text(
                        "Masalah apa yang kamu hadapi ?",
                        style: TextStyle(
                          fontFamily: "Brandon",
                          fontWeight: FontWeight.w600,
                          fontSize: 17,
                        ),
                      ),
                    ),
                    Column(
                        children: _masalah.map((e) => Container(
                          height: 35,
                          child: Row(
                            children: [
                              Container(
                                width: 30,
                                margin: EdgeInsets.only(top: 0),
                                child: Checkbox(
                                  onChanged: (bool value) {
                                    setState(() {
                                      _masalah.forEach((ev) {
                                        ev.val = false;
                                      });
                                      _masalah.firstWhere((element) => element.id == e.id).val =value;
                                    });
                                  },
                                  value: e.val,
                                  checkColor: Hexcolor("#F59379"),
                                  activeColor: Hexcolor('#FCF8F0'),
                                ),
                              ),
                              Container(
                                child: Text(
                                  e.label,
                                  style: TextStyle(
                                    fontFamily: "Brandon",
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),).toList()
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        top: 35,
                        bottom: 10,
                      ),
                      child: Text(
                        "Foto barang komplain",
                        style: TextStyle(
                          fontFamily: "Brandon",
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    ListView(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        GridView.count(
                            shrinkWrap: true,
                            primary: true,
                            physics:  const NeverScrollableScrollPhysics(),
                            padding: const EdgeInsets.all(20.0),
                            crossAxisSpacing: 10.0,
                            crossAxisCount: 3,
                            children: <Widget>[
                              for(File file in files)
                                Container(
                                  alignment: Alignment.center,
                                  width: 100,
                                  margin: EdgeInsets.only(bottom: 5),
                                  child: Stack(
                                    // overflow: Overflow.visible,
                                    children: [
                                      Container(
                                        width: MediaQuery.of(context).size.width,
                                        child: Image.file(file,
                                          fit: BoxFit.cover,

                                        ),
                                      ),
                                      InkWell(
                                        onTap: (){
                                          setState(() {
                                            files.remove(file);
                                          });
                                        },
                                        child: Container(
                                          margin: EdgeInsets.only(top: 2, right: 10),
                                          alignment: Alignment.topRight,
                                          child: Icon(
                                            Icons.close,
                                            size: 20,
                                            color: Hexcolor("#F59379"),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  height: 125,
                                ),
                              InkWell(
                                onTap: () async {
                                  FilePickerResult result = await FilePicker.platform.pickFiles(
                                    type: FileType.image,
                                    allowMultiple: true,
                                  );

                                  if(result != null) {
                                    setState(() {
                                      List<File> files2 = result.paths.map((path) => File(path)).toList();
                                      files.addAll(files2);
                                    });
                                  } else {
                                    // User canceled the picker
                                  }
                                },
                                child:  Container(
                                  margin: EdgeInsets.only(left: 20),
                                  height: 125,
                                  width: 100,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Hexcolor("#F59379"),
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(5.0),
                                    ),
                                    color: Hexcolor("#FDEDE3"),
                                  ),
                                  child: Stack(
                                    children: [
                                      Container(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              alignment: Alignment.center,
                                              child: Icon(
                                                Icons.add,
                                                color: Hexcolor("#F59379"),
                                                size: 45,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),


                            ]),
                      ],
                    ),

                    Container(
                      margin: EdgeInsets.only(
                        top: 15,
                        bottom: 10,
                      ),
                      child: Text(
                        "Solusi Komplain",
                        style: TextStyle(
                          fontFamily: "Brandon",
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),

                    Column(
                        children: _solusi.map((e) => Container(
                          height: 35,
                          child: Row(
                            children: [
                              Container(
                                width: 30,
                                margin: EdgeInsets.only(top: 0),
                                child: Checkbox(
                                  onChanged: (bool value) {
                                    setState(() {
                                      _solusi.forEach((ev) {
                                        ev.val = false;
                                      });
                                      _solusi.firstWhere((element) => element.id == e.id).val =value;
                                    });
                                  },
                                  value: e.val,
                                  checkColor: Hexcolor("#F59379"),
                                  activeColor: Hexcolor('#FCF8F0'),
                                ),
                              ),
                              Container(
                                child: Text(
                                  e.label,
                                  style: TextStyle(
                                    fontFamily: "Brandon",
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),).toList()
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        top: 15,
                        bottom: 10,
                      ),
                      child: Text(
                        "Catatan",
                        style: TextStyle(
                          fontFamily: "Brandon",
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      child: InputDecorator(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                        child: TextFormField(
                          controller: _catatan,
                          keyboardType: TextInputType.multiline,
                          maxLines: 6,
                          maxLength: 3000,
                          decoration: InputDecoration(
                            fillColor: Colors.blue,
                            hintText: "Tulis detail masalah kamu",
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                          ),


                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        top: 15,
                        bottom: 10,
                      ),
                      child: Text(
                        "Pilih Barang Yang Dikomplain",
                        style: TextStyle(
                          fontFamily: "Brandon",
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    ListView(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        GridView.count(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            primary: true,
                            padding: const EdgeInsets.all(4.0),
                            childAspectRatio: (100 / 180),
                            crossAxisSpacing: 10.0,
                            crossAxisCount: 2,
                            children: <Widget>[
                              for(KomplainInputProduct komplainProduct in _product)
                              Container(
                                alignment: Alignment.center,
                                width: 100,
                                margin: EdgeInsets.only(bottom: 5),
                                child: Column(
                                  // overflow: Overflow.visible,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          width: 30,
                                          margin: EdgeInsets.only(top: 0),
                                          child: Checkbox(
                                            onChanged: (bool value) {
                                              setState(() {
                                                _product.firstWhere((element) => element.id == komplainProduct.id).val =value;
                                              });
                                            },
                                            value:komplainProduct.val,
                                            checkColor: Hexcolor("#F59379"),
                                            activeColor: Hexcolor('#FCF8F0'),
                                          ),
                                        ),
                                        Container(
                                          child: Text(
                                            komplainProduct.label.name,
                                            style: TextStyle(
                                              fontFamily: "Brandon",
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width,
                                      child: CachedNetworkImage(
                                        imageUrl: komplainProduct.label.thumbnail_image != null ? img_url+komplainProduct.label.thumbnail_image : '',
                                        placeholder: (context, url) => LoadingWidgetPulse(context),
                                        errorWidget: (context, url, error) => Image.asset('assets/images/210x265.png'),
                                        width: MediaQuery.of(context).size.width,
                                        fit: BoxFit.cover,
                                      ),
                                    ),

                                  ],
                                ),
                                height: 140,
                              ),
                            ]),
                      ],
                    ),

                    Container(
                      margin: EdgeInsets.only(
                        top: 25,
                        bottom: 25,
                      ),
                      height: 1,
                      color: Hexcolor("#F59379"),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        bottom: 25,
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 30,
                            height: 25,
                            child: Checkbox(
                              onChanged: (bool value) {
                                setState(() => this._value1 = value);
                              },
                              value: this._value1,
                              checkColor: Hexcolor("#F59379"),
                              activeColor: Hexcolor('#FCF8F0'),
                            ),
                          ),
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  child: Text(
                                    "Saya setuju dan menanggung ongkos kirim",
                                    style: TextStyle(
                                      fontFamily: "Brandon",
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                                Container(
                                  child: Text(
                                    "jika harus mengembalikan barang",
                                    style: TextStyle(
                                      fontFamily: "Brandon",
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        _validation().then((hasil){
                          if(hasil){
                            Navigator.pop(context,true);
                          }
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(0xffF3C1B5),
                          borderRadius: BorderRadius.all(
                            Radius.circular(5),
                          ),
                        ),
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.only(bottom: 15),
                        height: 45,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              child: Text(
                                "KIRIM",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: "Brandon",
                                  color: Colors.white,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                )
              ),

            ],
          ),
        ),
        bottomNavigationBar: new PonnyBottomNavbar(selectedIndex: 4),
      ),
    );
  }
}

class KomplainInput{
  String id;
  String label;
  bool val ;
  KomplainInput(this.id,this.label,this.val);
}
class KomplainInputProduct{
  int id;
  Product label;
  bool val ;
  KomplainInputProduct(this.id,this.label,this.val);
}