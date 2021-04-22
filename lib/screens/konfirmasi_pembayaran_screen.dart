import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:ponny/common/constant.dart';
import 'package:ponny/model/App.dart';
import 'package:ponny/model/ManualInfo.dart';
import 'package:ponny/model/Order.dart';
import 'package:ponny/util/globalUrl.dart';
import 'package:ponny/widgets/PonnyBottomNavbar.dart';
import 'package:ponny/screens/pesanan_berhasil_screen.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:uiblock/uiblock.dart';

class KonfirmasiPembayaranScreen extends StatefulWidget {
  static const String id = "konfirmasi_pembayaran_screen";
  NewManualInfo manualInfo;
  KonfirmasiPembayaranScreen({Key key,this.manualInfo});

  @override
  _KonfirmasiPembayaranScreenState createState() => _KonfirmasiPembayaranScreenState();
}

class _KonfirmasiPembayaranScreenState extends State<KonfirmasiPembayaranScreen> {
  File _image;
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final bank = TextEditingController();
  final rek = TextEditingController();
  final an = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if(widget.manualInfo.orderConfrim != null){
        setState(() {
          bank.text = widget.manualInfo.orderConfrim.bank;
          rek.text = widget.manualInfo.orderConfrim.noRek;
          an.text = widget.manualInfo.orderConfrim.anRek;
        });
      }
    });
  }

  Future getImage() async {
    FilePickerResult result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg','png'],
    );

    setState(() {
      if (result != null) {
        _image = File(result.files.single.path);
        print(_image.path);
      } else {
        print('No image selected.');

      }
    });
  }

  _fetchInsert() async {
    UIBlock.block(context,customLoaderChild: LoadingWidget(context));
    var token = Provider.of<AppModel>(context,listen: false).auth.access_token;
    Map<String, String> headers = { "Authorization": "Bearer $token"};
    var request = http.MultipartRequest(
        "POST", Uri.parse(paymentConfrim+"/"+widget.manualInfo.id.toString()));
    if(_image != null){
      var multipartFile = await http.MultipartFile.fromPath(
          "photo", _image.path,
          contentType:  MediaType('image', 'jpeg'));

      request.files.add(multipartFile);
    }
    request.fields["bank"] = bank.value.text;
    request.fields["an"] = an.value.text;
    request.fields["norek"] = rek.value.text;
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();

    if(response.statusCode == 200)
    {
      _scaffoldKey.currentState.showSnackBar(snackBarSuccess);
      Future.delayed(const Duration(milliseconds: 1000), () {
        Navigator.pop(context);
      });
    }else{

      _scaffoldKey.currentState.showSnackBar(snackBarError);
    }
    UIBlock.unblock(context);

  }

  Widget _imageFile(){
    return InkWell(
      onTap: getImage ,
      child: Center(
        child: _image != null ? Image.file(_image):Image.network(img_url+widget.manualInfo.orderConfrim.uploadImg),
      ),
    );
  }

  Widget _iconUpload(){
    return InkWell(
      onTap: getImage,
      child: Icon(Icons.add,size: 50,color: Colors.black12,),
    );
  }


    @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Theme.of(context).primaryColor,
      body: Stack(children: <Widget>[
        Scaffold(
          backgroundColor: Color(0xffFDF8F0),
          appBar: AppBar(
            elevation: 0,
            titleSpacing: 0,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: Color(0xffF48262),
                size: 26,
              ),
            ),
            title: Text(
              'Konfirmasi Pembayaran',
              style: TextStyle(
                fontSize: 20,
                fontFamily: "Yeseva",
                fontWeight: FontWeight.w500,
                color: Color(0xffF48262),
              ),
            ),
            bottom: PreferredSize(
                child: Container(
                  color: Color(0xffF48262),
                  height: 1.0,
                ),
                preferredSize: Size.fromHeight(1.0)),
          ),
          body: Container(
            // margin: MediaQuery.of(context).padding,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width,
                    color: Color(0xffF48262),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                            padding: EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'NOMOR PESANAN',
                                  style: TextStyle(
                                    fontFamily: 'Brandon',
                                    color: Colors.white,
                                    fontSize: 14,
                                  ),
                                ),
                                Text(
                                  "#"+widget.manualInfo.code,
                                  style: TextStyle(
                                    fontFamily: 'Brandon',
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            padding: EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  'TOTAL PESANAN',
                                  style: TextStyle(
                                    fontFamily: 'Brandon',
                                    color: Colors.white,
                                    fontSize: 14,
                                  ),
                                ),
                                Text(
                                  nm_format.format(int.parse(widget.manualInfo.grandTotal)+int.parse(widget.manualInfo.uniqTfManual)),
                                  style: TextStyle(
                                    fontFamily: 'Brandon',
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                    child: IntrinsicHeight(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Metode Pembayaran',
                                style: TextStyle(
                                  fontFamily: 'Brandon',
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                widget.manualInfo.typePayment,
                                style: TextStyle(
                                  fontFamily: 'Brandon',
                                ),
                              ),
                            ],
                          ),
                          Image.network(
                            widget.manualInfo.path,
                            height: 70,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width*0.9,
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xffF48262)),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: IntrinsicHeight(
                          child: Column(
                            children: <Widget>[
                              Container(
                                width: MediaQuery.of(context).size.width,
                                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Nama Bank',
                                      style: TextStyle(
                                        fontFamily: 'Brandon',
                                      ),
                                    ),
                                    Text(
                                      bank.value.text,
                                      style: TextStyle(
                                        fontFamily: 'Brandon',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Nomor Rekening',
                                      style: TextStyle(
                                        fontFamily: 'Brandon',
                                      ),
                                    ),
                                    Text(
                                      rek.value.text,
                                      style: TextStyle(
                                        fontFamily: 'Brandon',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                padding: EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 15),
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: Color(0xffF48262),
                                      width: 1.0,
                                    ),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Nama Pemilik Rekening',
                                      style: TextStyle(
                                        fontFamily: 'Brandon',
                                      ),
                                    ),
                                    Text(
                                      an.value.text,
                                      style: TextStyle(
                                        fontFamily: 'Brandon',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              InkWell(
                                onTap: (){
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          backgroundColor: Color(0xffFDF8F0),
                                          content: Stack(
                                            overflow: Overflow.visible,
                                            children: <Widget>[
                                              Positioned(
                                                right: -40.0,
                                                top: -40.0,
                                                child: InkResponse(
                                                  onTap: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: CircleAvatar(
                                                    child: Icon(Icons.close,color: Colors.white,),
                                                    backgroundColor: Color(0xffF48262),
                                                  ),
                                                ),
                                              ),
                                              Form(
                                                key: _formKey,
                                                child: Column(
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: <Widget>[
                                                    Padding(
                                                      padding: EdgeInsets.all(8.0),
                                                      child: TextFormField(
                                                        controller: bank,
                                                        decoration: InputDecoration(
                                                          filled: true,
                                                          fillColor: Colors.white,
                                                          hintText: 'Nama Bank',
                                                          labelText: 'Nama Bank:',
                                                          labelStyle: TextStyle(color: Colors.black),
                                                          focusedBorder: OutlineInputBorder(
                                                            borderRadius: BorderRadius.circular(8.0),
                                                            borderSide: BorderSide(
                                                              color: Hexcolor('#F48262'),
                                                            ),
                                                          ),
                                                          enabledBorder: OutlineInputBorder(
                                                            borderRadius: BorderRadius.circular(8.0),
                                                            borderSide: BorderSide(
                                                              color: Hexcolor('#F48262'),
                                                              width: 2.0,
                                                            ),
                                                          ),
                                                        ),
                                                        keyboardType: TextInputType.emailAddress,
                                                        validator: (String value) {
                                                          if (value.isEmpty) {
                                                            return 'Nama Bank tidak boleh kosong';
                                                          }
                                                        },
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.all(8.0),
                                                      child: TextFormField(
                                                        controller: rek,
                                                        decoration: InputDecoration(
                                                          filled: true,
                                                          fillColor: Colors.white,
                                                          hintText: 'Nomor Rekening',
                                                          labelText: 'Nomor Rekening:',
                                                          labelStyle: TextStyle(color: Colors.black),
                                                          focusedBorder: OutlineInputBorder(
                                                            borderRadius: BorderRadius.circular(8.0),
                                                            borderSide: BorderSide(
                                                              color: Hexcolor('#F48262'),
                                                            ),
                                                          ),
                                                          enabledBorder: OutlineInputBorder(
                                                            borderRadius: BorderRadius.circular(8.0),
                                                            borderSide: BorderSide(
                                                              color: Hexcolor('#F48262'),
                                                              width: 2.0,
                                                            ),
                                                          ),
                                                        ),
                                                        keyboardType: TextInputType.number,
                                                        validator: (String value) {
                                                          if (value.isEmpty) {
                                                            return 'Nomor Rekening tidak boleh kosong';
                                                          }
                                                        },
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.all(8.0),
                                                      child: TextFormField(
                                                        controller: an,
                                                        decoration: InputDecoration(
                                                          filled: true,
                                                          fillColor: Colors.white,
                                                          hintText: 'Nama Pemilik Rekening',
                                                          labelText: 'Nama Pemilik Rekening:',
                                                          labelStyle: TextStyle(color: Colors.black),
                                                          focusedBorder: OutlineInputBorder(
                                                            borderRadius: BorderRadius.circular(8.0),
                                                            borderSide: BorderSide(
                                                              color: Hexcolor('#F48262'),
                                                            ),
                                                          ),
                                                          enabledBorder: OutlineInputBorder(
                                                            borderRadius: BorderRadius.circular(8.0),
                                                            borderSide: BorderSide(
                                                              color: Hexcolor('#F48262'),
                                                              width: 2.0,
                                                            ),
                                                          ),
                                                        ),
                                                        validator: (String value) {
                                                          if (value.isEmpty) {
                                                            return 'Nama Pemilik Rekening tidak boleh kosong';
                                                          }
                                                        },
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.all(8.0),
                                                      child: RaisedButton(
                                                        color: Color(0xffF48262),
                                                        textColor: Colors.white,
                                                        child: Text("Simpan"),
                                                        onPressed: () {
                                                          if (_formKey.currentState.validate()) {
                                                            _formKey.currentState.save();
                                                            Navigator.of(context).pop();
                                                          }
                                                        },
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      });
                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  padding: EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 0),
                                  child: Center(
                                    child: Text(
                                      'UBAH',
                                      style: TextStyle(
                                        fontFamily: 'Brandon',
                                        color: Color(0xffF48262),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    width: MediaQuery.of(context).size.width*0.9,
                    decoration: BoxDecoration(
                      color: Color(0xffFDEDE3),
                      border: Border.all(color: Color(0xffF48262)),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 30),
                        child: Column(

                          children: [
                            widget.manualInfo.orderConfrim != null ?
                            Container(
                              padding: EdgeInsets.only(bottom: 10),
                              child:  _imageFile(),
                            ) : Container(
                              padding: EdgeInsets.only(bottom: 10),
                              child:   _image != null ? _imageFile() : _iconUpload(),
                            )

                            ,
                            Text(
                              'Upload Bukti Pembayaran',
                              style: TextStyle(
                                fontFamily: 'Brandon',
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              '(max. 5MB)',
                              style: TextStyle(
                                fontFamily: 'Brandon',
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.95,
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Padding(
                            padding: EdgeInsets.only(right: 10),
                            child: FlatButton(
                              color: Color(0xffF48262),
                              child: Text(
                                'BATAL',
                                style: TextStyle(
                                  fontFamily: 'Brandon',
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(7.0),
                              ),
                              onPressed: (){
                                Navigator.of(context).pop();
                              },
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: FlatButton(
                              color: Color(0xffF48262),
                              child: Text(
                                'KONFIRMASI',
                                style: TextStyle(
                                  fontFamily: 'Brandon',
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(7.0),
                              ),
                              onPressed: (){
                                if(bank.text.isNotEmpty && rek.text.isNotEmpty && an.text.isNotEmpty && _image != null && widget.manualInfo.orderConfrim == null){
                                  _fetchInsert();
                                } else if(bank.text.isNotEmpty && rek.text.isNotEmpty && an.text.isNotEmpty && widget.manualInfo.orderConfrim != null){
                                  _fetchInsert();
                                } else{
                                  final snackBar = SnackBar(
                                    content: Text('Bukti pembayaran belum lengkap.!',style: TextStyle(color: Colors.white)),
                                    backgroundColor: Colors.redAccent,
                                  );
                                  _scaffoldKey.currentState.showSnackBar(snackBar);

                                }


                              },
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
        )
      ]),
      bottomNavigationBar: new PonnyBottomNavbar(selectedIndex: 1),
    );
  }
}
