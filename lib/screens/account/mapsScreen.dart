import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:ponny/common/constant.dart';
import 'package:ponny/screens/home_screen.dart';
import 'package:ponny/screens/account_screen.dart';
import 'package:ponny/screens/account/daftar_keinginan_sukses_screen.dart';
import 'package:ponny/widgets/PonnyBottomNavbar.dart';
import 'package:search_map_place/search_map_place.dart';

class MapsScreen extends StatefulWidget {
  LatLng param;
  MapsScreen({Key key,this.param});

  @override
  _MapsScreenState createState() => _MapsScreenState();
}

class _MapsScreenState extends State<MapsScreen> {
  Completer<GoogleMapController> _controller = Completer();
  bool loading=true;
  Set<Marker> markerSet = Set();
  LatLng ParamLatLang = new LatLng(37.43296265331129,-122.08832357078792);

  @override
  void initState() {
    super.initState();
    getLokasi();
  }


  Future<void> getLokasi() async {

    bool isLocationServiceEnabled  = await Geolocator.isLocationServiceEnabled();
    if(isLocationServiceEnabled){
      Position position = await Geolocator.getLastKnownPosition();
      // Position position =await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      if(position == null){
        position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      }
      if(widget.param != null && loading){
        _updateMarker(widget.param);
        setState(() {
          loading =false;
        });
      }else{
        _updateMarker(LatLng(position.latitude, position.longitude));
        setState(() {
          loading =false;
        });
      }

      print(ParamLatLang);
    }else{
      print("location disable");
    }

  }

  @override
  void dispose() {
    super.dispose();
  }

  _updateMarker(LatLng latLng){
    Marker _marker = Marker(markerId: MarkerId("1"),
        position: latLng,
        infoWindow: InfoWindow(title: "Lokasi Pengiriman",snippet: "Lokasi Pengiriman anda")
    );
    print(markerSet.length);
    setState(() {
      ParamLatLang = latLng;
      markerSet.clear();
      markerSet.add(_marker);
      markerSet.toSet();
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child:  Scaffold(
        appBar: AppBar(
          leading: null,
          title: Text("Lokasi Pengiriman"),
          centerTitle: true,
        ),
        body: loading? Center(
          child: LoadingWidget(context),
        )  :Center(
            child: Stack(
              children: [

                Positioned(
                  child: Container(
                    child: GoogleMap(
                      mapType: MapType.normal,
                      initialCameraPosition: CameraPosition(
                        target: ParamLatLang,
                        zoom: 14.4746,
                      ),
                      onMapCreated: (GoogleMapController controller) {
                        if(!_controller.isCompleted)
                          _controller.complete(controller);
                        controller.showMarkerInfoWindow(MarkerId("1"));
                        print(markerSet.length);

                      },
                      markers: markerSet.toSet(),
                      onTap: (lokasi) async {

                        // updateMarker(MarkerId("1"),lokasi.latitude,lokasi.longitude);
                        _updateMarker(LatLng(lokasi.latitude, lokasi.longitude));
                        print(lokasi.latitude.toString()+","+lokasi.longitude.toString());
                        final GoogleMapController controller = await _controller.future;
                        controller.showMarkerInfoWindow(MarkerId("1"));
                      },
                    ),
                  ),
                ),
                Positioned(
                  top: 3,
                  left: 3,
                  right: 3,
                  child: Container(
                    padding: EdgeInsets.all(5),
                    width: MediaQuery.of(context).size.width,
                    child:  SearchMapPlaceWidget(
                      apiKey: "AIzaSyBdBABaAAqSSiipNb6FKUBQIfJu_WHE0-Q",
                      onSelected: (Place place) async {
                        final geolocation = await place.geolocation;
                        // Will animate the GoogleMap camera, taking us to the selected position with an appropriate zoom
                        final GoogleMapController controller = await _controller.future;
                        controller.animateCamera(CameraUpdate.newLatLng(geolocation.coordinates));
                        controller.animateCamera(CameraUpdate.newLatLngBounds(geolocation.bounds, 0));
                        _updateMarker(geolocation.coordinates);
                        controller.showMarkerInfoWindow(MarkerId("1"));
                      },
                      language: "id",
                    ),
                  ),
                ),
                Positioned(
                  bottom: 100,
                  right: 4,
                  child: IconButton(
                    onPressed: () async {

                      await getLokasi();
                      final GoogleMapController controller = await _controller.future;
                      controller.animateCamera(CameraUpdate.newLatLng(ParamLatLang));
                      // controller.animateCamera(CameraUpdate.newLatLngBounds(ParamLatLang.bounds, 0));

                    },
                    iconSize: 35,
                    icon: Icon(Icons.my_location,),
                    tooltip: "Lokasi Sekarang",
                  ),
                )

              ],
            )
        ),
        bottomNavigationBar:Wrap(
          children: [
            GestureDetector(
              onTap: (){
                Navigator.pop(context,ParamLatLang);
              },
              child:  Container(
                color: Color(0xffF48262),
                height: 70,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.all(5),
                child: Center(
                  child: Text("PILIH LOKASI PENGIRIMAN",style: TextStyle( fontSize: 18,fontWeight: FontWeight.bold,color: Colors.white),),
                ),
              ),
            ),
          ],
        ),
      ),
      onWillPop: () async {
       return Navigator.canPop(context);
      },
    );
  }
}
