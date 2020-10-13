import 'package:flutter/material.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';
import 'package:ponny/screens/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IntroScreen extends StatefulWidget {
  static const String id = "intro_screen";
  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  List<Slide> slides = new List();

  @override
  void initState(){
    super.initState();

    slides.add(
      new Slide(
        title: "PENGIRIMAN KILAT",
        styleTitle: TextStyle(
            color: Color(0xffF48262),
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'Brandon'),
        description: "Allow miles wound place the leave had. To sitting subject no improve studied limited",
        styleDescription: TextStyle(
            color: Color(0xff231F20),
            fontSize: 14.0,
            fontFamily: 'Brandon'),
        pathImage: "assets/images/Slider1.png",
        backgroundColor: Color(0xFFFDF8F0),
      ),
    );
    slides.add(
      new Slide(
        title: "PRODUK TERDAFTAR BPOM",
        styleTitle: TextStyle(
            color: Color(0xffF48262),
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'Brandon'),
        description: "Ye indulgence unreserved connection alteration appearance",
        styleDescription: TextStyle(
            color: Color(0xff231F20),
            fontSize: 14.0,
            fontFamily: 'Brandon'),
        pathImage: "assets/images/Slider2.png",
        backgroundColor: Color(0xFFFDF8F0),
      ),
    );
    slides.add(
      new Slide(
        title: "LAYANAN KONSUMEN",
        styleTitle: TextStyle(
            color: Color(0xffF48262),
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'Brandon'),
        description:
        "Much evil soon high in hope do view. Out may few northward believing attempted. Yet timed being songs marry one defer men our. Although finished blessing do of",
        styleDescription: TextStyle(
            color: Color(0xff231F20),
            fontSize: 14.0,
            fontFamily: 'Brandon'),
        pathImage: "assets/images/Slider3.png",
        backgroundColor: Color(0xFFFDF8F0),
      ),
    );
    slides.add(
      new Slide(
        title: "KEMASAN AMAN",
        styleTitle: TextStyle(
            color: Color(0xffF48262),
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'Brandon'),
        description: "Allow miles wound place the leave had. To sitting subject no improve studied limited",
        styleDescription: TextStyle(
            color: Color(0xff231F20),
            fontSize: 14.0,
            fontFamily: 'Brandon'),
        pathImage: "assets/images/Slider4.png",
        backgroundColor: Color(0xFFFDF8F0),
      ),
    );
  }

  Future<void> onDonePress() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool('is_intro', true);
    Navigator.of(context).pushReplacementNamed(HomeScreen.id);
  }

  @override
  Widget build(BuildContext context) {
    return new IntroSlider(
      slides: this.slides,
      onDonePress: this.onDonePress,
      colorDot: Color(0xffE6E7E9),
      colorActiveDot: Color(0xffF3795D),
      styleNameSkipBtn: TextStyle(
        color: Color(0xff231F20),
      ),
      styleNameDoneBtn: TextStyle(
        color: Color(0xff231F20),
      ),
      styleNamePrevBtn: TextStyle(
        color: Color(0xff231F20),
      ),
    );
  }
}