import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:ponny/common/constant.dart';
import 'package:ponny/model/App.dart';
import 'package:ponny/model/Product.dart';
import 'package:ponny/model/User.dart';
import 'package:ponny/screens/account_screen.dart';
import 'package:ponny/screens/metode_verifikasi_screen.dart';
import 'package:ponny/screens/pra_daftar.dart';
import 'package:ponny/screens/home_screen.dart';
import 'package:ponny/screens/login_otp.dart';
import 'package:keyboard_attachable/keyboard_attachable.dart';
import 'package:http/http.dart' as http;
import 'package:ponny/widgets/PonnyBottomNavbar.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uiblock/uiblock.dart';
import 'package:ponny/util/globalUrl.dart';
import 'package:http_parser/http_parser.dart';

enum BeliProduk { beli, tidak }

class ReviewScreen extends StatefulWidget {
  static const String id = "review_Screen";
  Product product;
  ReviewScreen({Key key,@required this.product});

  @override
  _ReviewStateScreen createState() => _ReviewStateScreen();
}

class _ReviewStateScreen extends State<ReviewScreen> {
  final _scaffoldKey =GlobalKey<ScaffoldState>();
  List<File> files =[];
  int kemasan=0;
  int kegunaan =0;
  int efektif =0;
  int harga =0;
  bool _status;
  bool _recomended;
  final _catatan = TextEditingController();

  _fetchInsert() async {
    UIBlock.block(context,customLoaderChild: LoadingWidget(context));
    var token = Provider.of<AppModel>(context,listen: false).auth.access_token;
    Map<String, String> headers = { "Authorization": "Bearer $token"};
    var request = http.MultipartRequest(
        "POST", Uri.parse(revieStore));

    for (var file in files) {
      var multipartFile = await http.MultipartFile.fromPath(
          "photos[]", file.path,
          contentType:  MediaType('image', 'jpeg'));

      request.files.add(multipartFile);
    }
    request.fields["product_id"] = widget.product.id.toString();
    request.fields["packaging_rate"] = kemasan.toString();
    request.fields["usability_rate"] = kegunaan.toString();
    request.fields["effective_rate"] = efektif.toString();
    request.fields["price_rate"] = harga.toString();
    request.fields["comment"] = _catatan.value.text;
    request.fields["recommended"] = _recomended ? "1":"0";
    request.fields["at_ponny"] = _status ? "1":"0";
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();

    if(response.statusCode == 200)
    {
      Navigator.pop(context,true);
    }else{

      _scaffoldKey.currentState.showSnackBar(snackBarError);
    }
    UIBlock.unblock(context);

  }
  _validation(){
    if(_recomended != null && _catatan.value.text.isNotEmpty && _catatan.value.text.length >= 50 && _status != null ){
      _fetchInsert();
    }else{
      final snackBar = SnackBar(
        content: Text('Form Review belum lengkap!',style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.redAccent,
      );
      _scaffoldKey.currentState.showSnackBar(snackBar);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
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
          'Review',
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
      resizeToAvoidBottomInset: false,
      backgroundColor: Hexcolor('#FCF8F0'),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    IntrinsicHeight(
                      child: Row(
                        children: [
                          Image.network(
                            img_url+widget.product.thumbnail_image,
                            width: 80,
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.product.brand.name,
                                  style: TextStyle(
                                    fontFamily: 'Yeseva',
                                    fontSize: 20,
                                  ),
                                ),
                                Text(
                                  widget.product.name,
                                  style: TextStyle(
                                    fontFamily: 'Brandon',
                                    fontSize: 20,
                                  ),
                                ),
                              for(Varian item in widget.product.varian)(
                              Align(
                                  alignment: Alignment.centerLeft,
                                  child: Container(
                                    padding: EdgeInsets.only(top: 9.0),
                                    child: Row(
                                      children: <Widget>[
                                        Text(item.atribut_name+" :"),
                                        for(String xitem in item.values)(
                                            Container(
                                              margin: EdgeInsets.symmetric(horizontal: 7),
                                              padding: EdgeInsets.symmetric(horizontal: 7),
                                              child: Text(
                                                xitem,
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontFamily: 'Brandon'
                                                ),
                                              ),
                                              decoration: BoxDecoration(
                                                border: Border.all(color: Color(0xffF48262)),
                                                borderRadius: BorderRadius.circular(5),
                                              ),
                                            )
                                        )
                                      ],
                                    ),
                                  )
                              ))
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      child: Text(
                        'Nilai produk ini',
                        style: TextStyle(
                          fontFamily: 'Brandon',
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Container(
                              padding: EdgeInsets.only(right: 7.5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Kemasan',
                                    style: TextStyle(fontFamily: 'Brandon',fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    'Buka produk ini ribet nggak, sih?',
                                    style: TextStyle(fontFamily: 'Brandon'),
                                  ),
                                  RatingBar(
                                    initialRating: 0,
                                    minRating: 1,
                                    direction: Axis.horizontal,
                                    allowHalfRating: false,
                                    itemCount: 5,
                                    itemSize: 18.0,
                                    itemPadding: EdgeInsets.only(right: 3, top: 3),
                                    itemBuilder: (context, index) => Icon(
                                      Icons.favorite,
                                      color: Color(0xffF48262),
                                    ),
                                    unratedColor: Color(0xffFBD2CD),
                                    onRatingUpdate: (rating) {
                                      setState(() {
                                        kemasan = int.parse(rating.toStringAsFixed(0));
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              padding: EdgeInsets.only(left: 7.5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Kegunaan',
                                    style: TextStyle(fontFamily: 'Brandon',fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    'Produk ini bekerja optimal nggak?',
                                    style: TextStyle(fontFamily: 'Brandon'),
                                  ),
                                  RatingBar(
                                    initialRating: 0,
                                    minRating: 1,
                                    direction: Axis.horizontal,
                                    allowHalfRating: false,
                                    itemCount: 5,
                                    itemSize: 18.0,
                                    itemPadding: EdgeInsets.only(right: 3, top: 3),
                                    itemBuilder: (context, index) => Icon(
                                      Icons.favorite,
                                      color: Color(0xffF48262),
                                    ),
                                    unratedColor: Color(0xffFBD2CD),
                                    onRatingUpdate: (rating) {
                                      setState(() {
                                        kegunaan = int.parse(rating.toStringAsFixed(0));
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Container(
                              padding: EdgeInsets.only(right: 7.5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Efektif',
                                    style: TextStyle(fontFamily: 'Brandon',fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    'Apa kamu dapat hasil yang cocok dengan kulitmu?',
                                    style: TextStyle(fontFamily: 'Brandon'),
                                  ),
                                  RatingBar(
                                    initialRating: 0,
                                    minRating: 1,
                                    direction: Axis.horizontal,
                                    allowHalfRating: false,
                                    itemCount: 5,
                                    itemSize: 18.0,
                                    itemPadding: EdgeInsets.only(right: 3, top: 3),
                                    itemBuilder: (context, index) => Icon(
                                      Icons.favorite,
                                      color: Color(0xffF48262),
                                    ),
                                    unratedColor: Color(0xffFBD2CD),
                                    onRatingUpdate: (rating) {
                                      setState(() {
                                        efektif = int.parse(rating.toStringAsFixed(0));
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              padding: EdgeInsets.only(left: 7.5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Harga',
                                    style: TextStyle(fontFamily: 'Brandon',fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    'Sesuai dengan kualitasnya, harga produk ini...',
                                    style: TextStyle(fontFamily: 'Brandon'),
                                  ),
                                  RatingBar(
                                    initialRating: 0,
                                    minRating: 1,
                                    direction: Axis.horizontal,
                                    allowHalfRating: false,
                                    itemCount: 5,
                                    itemSize: 18.0,
                                    itemPadding: EdgeInsets.only(right: 3, top: 3),
                                    itemBuilder: (context, index) => Icon(
                                      Icons.favorite,
                                      color: Color(0xffF48262),
                                    ),
                                    unratedColor: Color(0xffFBD2CD),
                                    onRatingUpdate: (rating) {
                                      setState(() {
                                        harga = int.parse(rating.toStringAsFixed(0));
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20, bottom: 5),
                      child: Text(
                        'Review',
                        style: TextStyle(
                          fontFamily: 'Brandon',
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    TextField(
                      controller: _catatan,
                      maxLines: 6,
                      cursorColor: Color(0xffF48262),
                      keyboardType: TextInputType.multiline,
                      style: TextStyle(
                        fontFamily: 'Brandon',
                        fontSize: 12,
                      ),
                      decoration: InputDecoration(
                        filled: true,
                        hintText: 'Tulis review kamu',
                        hintStyle: TextStyle(
                          fontFamily: 'Brandon',
                          fontSize: 12,
                        ),
                        fillColor: Color(0xFFFDEDE3),
                        isDense: true,
                        contentPadding: EdgeInsets.symmetric(horizontal: 17, vertical: 10),
                        labelStyle: TextStyle(color: Colors.black),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: BorderSide(
                            color: Hexcolor('#F48262'),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: BorderSide(
                            color: Hexcolor('#F48262'),
                            width: 1.0,
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        'Minimum 50 karakter',
                        style: TextStyle(
                          fontFamily: 'Brandon',
                          fontSize: 12,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20, bottom: 5),
                      child: RichText(
                        text: TextSpan(
                          text: 'Upload Foto ',
                          style: TextStyle(
                            fontFamily: 'Brandon',
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                          children: [
                            TextSpan(
                              text: '(max. 5MB)',
                              style: TextStyle(
                                fontFamily: 'Brandon',
                                fontSize: 12,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ]
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            for(File file in files)
                            Container(
                              width: 100,
                              height: 140,
                              margin: EdgeInsets.only(right: 20),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.blue,
                              ),
                              child: Stack(
                                fit: StackFit.expand,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(5),
                                    child: Image.file(
                                      file,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(5.0),
                                    child: Align(
                                      alignment: Alignment.topRight,
                                      child: Transform.rotate(
                                        angle: 45 * pi / 180,
                                        child: InkWell(
                                          onTap: (){
                                            setState(() {
                                              files.remove(file);
                                            });
                                          },
                                          child: Icon(
                                            Icons.add_circle,
                                            color: Color(0xffF48262),
                                            size: 20,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            InkWell(
                              onTap: () async {
                                FilePickerResult result = await FilePicker.platform.pickFiles(
                                  type: FileType.custom,
                                  allowMultiple: true,
                                  allowedExtensions: ['jpg', 'png', 'gif'],
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
                              child: Container(
                                width: 100,
                                height: 140,
                                decoration: BoxDecoration(
                                  color: Color(0xFFFDEDE3),
                                  border: Border.all(width: 1,color: Color(0xffF48262)),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Center(
                                  child: Icon(
                                    Icons.add,
                                    color: Colors.black,
                                    size: 40,
                                  ),
                                ),
                              ),
                            )
                            ,
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        'Apa kamu akan merekomendasikan produk ini?',
                        style: TextStyle(fontFamily: 'Brandon'),
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(bottom: 15, right: 10),
                          child: ButtonTheme(
                            child: FlatButton(
                              onPressed: (){
                                setState(() {
                                  _recomended =true;
                                });
                              },
                              height: 24,
                              minWidth: 100,
                              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              color: _recomended == null ?  Color(0xffFBD2CD): _recomended? Color(0xffF48262) : Color(0xffFBD2CD),
                              child: Text(
                                "YA",
                                style: TextStyle(
                                  fontFamily: 'Brandon',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  color: Colors.white),
                              ),
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 15),
                          child: ButtonTheme(
                            child: FlatButton(
                              onPressed: (){
                                setState(() {
                                  _recomended =false;
                                });
                              },
                              height: 24,
                              minWidth: 100,
                              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              color: _recomended == null ?  Color(0xffFBD2CD): !_recomended? Color(0xffF48262) : Color(0xffFBD2CD),
                              child: Text(
                                "TIDAK",
                                style: TextStyle(
                                    fontFamily: 'Brandon',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                    color: Colors.white),
                              ),
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Theme(
                          data: Theme.of(context).copyWith(
                            unselectedWidgetColor: Color(0xffF48262),
                          ),
                          child: Radio(
                            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            value: true,
                            groupValue: _status,
                            activeColor: Color(0xffF48262),
                            onChanged: (bool value) {
                              setState(() {
                                _status = value;
                              });
                            },
                          ),
                        ),
                        Expanded(
                          child: Text(
                            'Ya, Saya membeli produk ini di Ponny Beaute',
                            style: TextStyle(
                              fontFamily: 'Brandon',
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Theme(
                          data: Theme.of(context).copyWith(
                            unselectedWidgetColor: Color(0xffF48262),
                          ),
                          child: Radio(
                            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            value: false,
                            groupValue: _status,
                            activeColor: Color(0xffF48262),
                            onChanged: (bool value) {
                              setState(() {
                                _status = value;
                              });
                            },
                          ),
                        ),
                        Expanded(
                          child: Text(
                            'Tidak, saya tidak membeli produk ini di Ponny Beaute',
                            style: TextStyle(
                              fontFamily: 'Brandon',
                            ),
                          ),
                        ),
                      ],
                    ),
                    Center(
                      child: Container(
                        width: double.infinity,
                        margin: EdgeInsets.symmetric(vertical: 25),
                        child: ButtonTheme(
                          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 70),
                          child: FlatButton(
                            onPressed: (){
                              _validation();
                            },
                            color: Color(0xffF48262),
                            child: Text(
                              "SAVE",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'Brandon',
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: 1,
                                  color: Colors.white),
                            ),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
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
      bottomNavigationBar: new PonnyBottomNavbar(selectedIndex: 4),
    );
  }
}
