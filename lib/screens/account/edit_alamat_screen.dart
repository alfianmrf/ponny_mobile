import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:ponny/common/constant.dart';
import 'package:ponny/model/Address.dart';
import 'package:ponny/model/App.dart';
import 'package:ponny/screens/account/mapsScreen.dart';
import 'package:ponny/screens/home_screen.dart';
import 'package:ponny/screens/account_screen.dart';
import 'package:ponny/screens/account/daftar_keinginan_sukses_screen.dart';
import 'package:ponny/widgets/PonnyBottomNavbar.dart';
import 'package:provider/provider.dart';
import 'package:search_map_place/search_map_place.dart';
import 'package:uiblock/uiblock.dart';

class EditAlamatScreen extends StatefulWidget {
  static const String id = "edit_alamat_Screen";
  Address address;
  EditAlamatScreen({Key key,@required this.address});
  @override
  _EditAlamatStateScreen createState() => _EditAlamatStateScreen();
}

class _EditAlamatStateScreen extends State<EditAlamatScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  List<MasterAddress> listProvinces =List<MasterAddress>();
  List<MasterAddress> listcities =List<MasterAddress>();
  List<MasterAddress> listsubcities =List<MasterAddress>();
  bool loading=true;

  LatLng lokasi;
  TextEditingController _lokasi = TextEditingController();
  TextEditingController _address = TextEditingController();
  TextEditingController _portalcode = TextEditingController();
  TextEditingController _phone = TextEditingController();
  TextEditingController _nama = TextEditingController();
  TextEditingController _Lastnama = TextEditingController();

  MasterAddress  prov;
  MasterAddress  kota;
  MasterAddress  distrik;

  @override
  void initState() {
    super.initState();
    _nama.text = widget.address.nama_depan;
    _Lastnama.text = widget.address.nama_belakang;
    _address.text = widget.address.alamat_lengkap;
    _portalcode.text = widget.address.postal_code;
    _phone.text= widget.address.nomor_hp;
    lokasi = LatLng(double.parse(widget.address.lat), double.parse(widget.address.lng));
    _lokasi.text = lokasi.latitude.toString()+","+lokasi.longitude.toString();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      Provider.of<AddressModel>(context).getParamAddress("prov", null).then((value){
        setState(() {
          listProvinces =value;
          prov = listProvinces.firstWhere((element) => element.id == widget.address.province_id,orElse: ()=>null);
        });
        Provider.of<AddressModel>(context).getParamAddress("kab", widget.address.province_id).then((value){
          setState(() {
            listcities =value;
            kota = listcities.where((element) => element.id == widget.address.city_id).first;
          });
          Provider.of<AddressModel>(context).getParamAddress("kec", widget.address.city_id).then((value){
            setState(() {
              listsubcities =value;
              distrik = listsubcities.firstWhere((element) => element.id == widget.address.kecamatan_id,orElse: ()=> null);
              loading=false;
            });
          });
        });
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  void onChanged(MasterAddress _prov) {
    UIBlock.block(context,customLoaderChild: LoadingWidget(context));
    Provider.of<AddressModel>(context).getParamAddress("kab", _prov.id).then((value){
      UIBlock.unblock(context);
      setState(() {
        prov = _prov;
        listcities.clear();
        listcities =value;

      });
    });
  }

  void onChangedKota(MasterAddress _kec) {
    UIBlock.block(context,customLoaderChild: LoadingWidget(context));
    Provider.of<AddressModel>(context).getParamAddress("kec", _kec.id).then((value){
      UIBlock.unblock(context);
      setState(() {
        kota = _kec;
        listsubcities.clear();
        listsubcities =value;

      });
    });
  }

  void onChangedDistrik(MasterAddress value) {
    setState(() {
      distrik = value;
    });
  }

  void validateInput() {
    FormState form = this.formKey.currentState;
    if (form.validate()) {
      FocusScope.of(context).requestFocus(new FocusNode());
      final param={
        "id":widget.address.id,
        "nama_depan":_nama.value.text,
        "nama_belakang":_Lastnama.value.text,
        "nomor_hp":_phone.value.text,
        "province_id":prov.id,
        "province":prov.text,
        "city_id":kota.id,
        "city_name":kota.text,
        "kecamatan_id":distrik.id,
        "kecamatan":distrik.text,
        "postal_code":_portalcode.value.text,
        "alamat_lengkap":_address.value.text,
        "lat":lokasi.latitude,
        "lng":lokasi.longitude,
      };
      UIBlock.block(context,customLoaderChild: LoadingWidget(context));
      Provider.of<AddressModel>(context).SaveAddressToServer(Provider.of<AppModel>(context).auth.access_token, param).then((value){
        UIBlock.unblock(context);
        if(value){
          Navigator.pop(context);
        }else{
          scaffoldKey.currentState.showSnackBar(snackBarError);
        }
      });
      // _fetchLogin();
    }
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      key: scaffoldKey,
      resizeToAvoidBottomInset: false,
      backgroundColor: Hexcolor('#FCF8F0'),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 70,
            ),
            Container(
              padding: EdgeInsets.only(left: 15, bottom: 15),
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 14),
                    child: GestureDetector(
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: Color(0xffF48262),
                        size: 26,
                      ),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  Container(
                    child: Text(
                      "Ubah Alamat",
                      style: TextStyle(
                        fontSize: 24,
                        fontFamily: "Yeseva",
                        fontWeight: FontWeight.w500,
                        color: Color(0xffF48262),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 1,
              color: Color(0xffF3C1B5),
            ),
            Container(
              margin: EdgeInsets.only(left: 20, top: 20, right: 20),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Color(0xffF48262),
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(7),
              ),
              padding: EdgeInsets.only(
                right: 20,
                left: 20,
                top: 15,
                bottom: 30,
              ),
              child: loading?Center(
                child: LoadingWidget(context),
              ):Form(
                key: formKey,
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(bottom: 5),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Color(0xffF48262),
                            width: 1,
                          ),
                        ),
                      ),
                      child: TextFormField(
                        controller: _nama,
                        style: TextStyle(
                          fontFamily: "Brandon",
                          fontSize: 17,
                          fontWeight: FontWeight.w300,
                        ),

                        decoration: InputDecoration(
                          border: InputBorder.none,
                          labelText: 'Nama Depan',
                          hintText: 'Nama Depan',
                          labelStyle: TextStyle(color: Colors.black),
                          isDense: true,
                        ),
                        keyboardType: TextInputType.name,
                        maxLines: 1,
                        minLines: 1,
                        validator: (String value){
                          if (value.isEmpty) {
                            return "Nama Depan tidak boleh kosong";
                          }
                        },
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(bottom: 5),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Color(0xffF48262),
                            width: 1,
                          ),
                        ),
                      ),
                      child: TextFormField(
                        controller: _Lastnama,
                        style: TextStyle(
                          fontFamily: "Brandon",
                          fontSize: 17,
                          fontWeight: FontWeight.w300,
                        ),

                        decoration: InputDecoration(
                          border: InputBorder.none,
                          labelText: 'Nama Belakang',
                          hintText: 'Nama Belakang',
                          labelStyle: TextStyle(color: Colors.black),
                          isDense: true,
                        ),
                        keyboardType: TextInputType.name,
                        maxLines: 1,
                        minLines: 1,
                        validator: (String value){
                          if (value.isEmpty) {
                            return "Nama Belakang tidak boleh kosong";
                          }
                        },
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(bottom: 5),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Color(0xffF48262),
                            width: 1,
                          ),
                        ),
                      ),
                      child: TextFormField(
                        controller: _address,
                        style: TextStyle(
                          fontFamily: "Brandon",
                          fontSize: 17,
                          fontWeight: FontWeight.w300,
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          labelText: 'Alamat',
                          hintText: 'Alamat Anda',
                          labelStyle: TextStyle(color: Colors.black),
                          isDense: true,
                        ),
                        keyboardType: TextInputType.name,
                        maxLines: 1,
                        minLines: 1,
                        validator: (String val){
                          if(val.isEmpty){
                            return "Alamat tidak boleh kosong";
                          }
                        },
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(bottom: 8, top: 5),
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        children: [
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.only(top: 5),
                            child: Text(
                              "Provinsi",
                              style: TextStyle(
                                fontFamily: "Brandon",
                                fontSize: 13,
                                fontWeight: FontWeight.w300,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          if(listProvinces.length > 0)
                          DropdownButtonFormField(
                            onTap: (){
                              FocusScope.of(context).requestFocus(new FocusNode());
                            },
                            decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Color(0xffF48262)),
                              ),
                              border: UnderlineInputBorder(
                                borderSide: BorderSide(color: Color(0xffF48262)),
                              ),
                            ),
                            isExpanded: true,
                            value:  prov,
                            icon: Icon(
                              Icons.arrow_forward_ios,
                            ),
                            iconSize: 20,
                            iconEnabledColor: Color(0xffF48262),
                            iconDisabledColor: Color(0xffF48262),
                            hint: Text(
                              "Provinsi",
                              style: TextStyle(
                                fontFamily: "Brandon",
                                fontSize: 17,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            items: listProvinces.map((MasterAddress val) {
                              if(val.id == widget.address.province_id){
                                setState(() {
                                  prov = val;
                                });
                              }
                              return DropdownMenuItem(
                                value: val,
                                child: Container(
                                  child: Text(
                                    val.text,
                                    style: TextStyle(
                                      fontFamily: "Brandon",
                                      fontSize: 17,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                            onChanged: (MasterAddress value) {
                              setState(() {
                                kota=null;
                                distrik=null;
                              });
                              onChanged(value);
                            },
                            validator: (MasterAddress value){
                              if (value == null) {
                                return "Province tidak boleh kosong";
                              }
                            },

                          )
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(bottom: 8, top: 5),
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        children: [
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.only(top: 5),
                            child: Text(
                              "Kota / Kabupaten",
                              style: TextStyle(
                                fontFamily: "Brandon",
                                fontSize: 13,
                                fontWeight: FontWeight.w300,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          DropdownButtonFormField(
                            onTap: (){
                              FocusScope.of(context).requestFocus(new FocusNode());
                            },
                            decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Color(0xffF48262)),
                              ),
                              border: UnderlineInputBorder(
                                borderSide: BorderSide(color: Color(0xffF48262)),
                              ),
                            ),
                            isExpanded: true,
                            value: kota,
                            icon: Icon(Icons.arrow_forward_ios),
                            iconSize: 20,
                            iconEnabledColor: Color(0xffF48262),
                            iconDisabledColor: Color(0xffF48262),
                            hint: Text(
                              "Kota / Kabupaten",
                              style: TextStyle(
                                fontFamily: "Brandon",
                                fontSize: 17,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            items: listcities.map((MasterAddress val) {
                              return DropdownMenuItem(
                                value: val,
                                child: Container(
                                  child: Text(
                                    val.text,
                                    style: TextStyle(
                                      fontFamily: "Brandon",
                                      fontSize: 17,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                            onChanged: (MasterAddress value) {
                              setState(() {
                                distrik =null;
                              });
                              onChangedKota(value);
                            },
                            validator: (MasterAddress value){
                              if (value == null) {
                                return "City tidak boleh kosong";
                              }
                            },
                          )
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(bottom: 8, top: 5),
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        children: [
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.only(top: 5),
                            child: Text(
                              "Kecamatan",
                              style: TextStyle(
                                fontFamily: "Brandon",
                                fontSize: 13,
                                fontWeight: FontWeight.w300,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          DropdownButtonFormField(
                            onTap: (){
                              FocusScope.of(context).requestFocus(new FocusNode());
                            },
                            decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Color(0xffF48262)),
                              ),
                              border: UnderlineInputBorder(
                                borderSide: BorderSide(color: Color(0xffF48262)),
                              ),
                            ),
                            isExpanded: true,
                            value: distrik,
                            icon: Icon(Icons.arrow_forward_ios),
                            iconSize: 20,
                            iconEnabledColor: Color(0xffF48262),
                            iconDisabledColor: Color(0xffF48262),
                            hint: Text(
                              "Kecamatan",
                              style: TextStyle(
                                fontFamily: "Brandon",
                                fontSize: 17,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            items: listsubcities.map((MasterAddress val) {
                              return DropdownMenuItem(
                                value: val,
                                child: Container(
                                  child: Text(
                                    val.text,
                                    style: TextStyle(
                                      fontFamily: "Brandon",
                                      fontSize: 17,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                            onChanged: (MasterAddress value) {
                              onChangedDistrik(value);
                            },
                            validator: (MasterAddress value){
                              if (value == null) {
                                return "Distrik tidak boleh kosong";
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(bottom: 5),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Color(0xffF48262),
                            width: 1,
                          ),
                        ),
                      ),
                      child: TextFormField(
                        controller: _portalcode,
                        style: TextStyle(
                          fontFamily: "Brandon",
                          fontSize: 17,
                          fontWeight: FontWeight.w300,
                        ),
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            labelText: 'Kode Pos',
                            hintText: 'Kode Pos',
                            labelStyle: TextStyle(color: Colors.black),
                            isDense: true,
                            suffixIcon: Icon(
                              Icons.emoji_transportation_sharp,
                              color: Color(0xffF48262),
                            )
                        ),
                        keyboardType: TextInputType.number,
                        maxLines: 1,
                        minLines: 1,
                        validator: (String val){
                          if(val.isEmpty){
                            return "Postal Code tidak boleh kosong";
                          }
                        },

                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(bottom: 5),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Color(0xffF48262),
                            width: 1,
                          ),
                        ),
                      ),
                      child: TextFormField(
                        controller: _phone,
                        style: TextStyle(
                          fontFamily: "Brandon",
                          fontSize: 17,
                          fontWeight: FontWeight.w300,
                        ),
                        decoration: InputDecoration(
                            prefixText: "+62",
                            border: InputBorder.none,
                            labelText: 'Nomor Telepon',
                            hintText: 'Nomor Telepon',
                            labelStyle: TextStyle(color: Colors.black),
                            isDense: true,
                            suffixIcon: Icon(
                              Icons.contact_phone,
                              color: Color(0xffF48262),
                            )
                        ),
                        keyboardType: TextInputType.phone,
                        maxLines: 1,
                        minLines: 1,
                        validator: (String val){
                          if(val.isEmpty){
                            return "Nomor Telepon tidak boleh kosong";
                          }
                        },
                      ),

                    ),
                    Container(
                      padding: EdgeInsets.only(bottom: 5),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Color(0xffF48262),
                            width: 1,
                          ),
                        ),
                      ),
                      child: TextFormField(
                        focusNode: AlwaysDisabledFocusNode(),
                        controller: _lokasi,
                        onTap: () async {
                          FocusScope.of(context).requestFocus(new FocusNode());
                          final result = await Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => MapsScreen(param: lokasi,)),
                          );
                          if(result !=null)
                            setState(() {
                              lokasi= result;
                              _lokasi.text = lokasi.latitude.toString()+","+lokasi.longitude.toString();
                            });

                        },
                        style: TextStyle(
                          fontFamily: "Brandon",
                          fontSize: 17,
                          fontWeight: FontWeight.w300,
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          labelText: 'Lokasi Pengiriman',
                          hintText: 'Pilih Lokasi Pengiriman',
                          labelStyle: TextStyle(color: Colors.black),
                          suffixIcon: Icon(
                            Icons.location_pin,
                            color: Color(0xffF48262),
                          ),
                          isDense: true,
                        ),
                        keyboardType: TextInputType.phone,
                        maxLines: 1,
                        minLines: 1,
                        validator: (String val){
                          if(val.isEmpty){
                            return "Lokasi tidak boleh kosong";
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                validateInput();
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xffF48262),
                  borderRadius: BorderRadius.circular(7),
                ),
                margin: EdgeInsets.only(left: 20, top: 20, right: 20, bottom: 10),
                padding: EdgeInsets.only(top: 15, bottom: 15),
                child: Center(
                  child: Text(
                    "SIMPAN",
                    style: TextStyle(
                      fontFamily: "Brandon",
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            )
            ,
          ],
        ),
      ),
      bottomNavigationBar: new PonnyBottomNavbar(selectedIndex: 4),
    );


  }
}
