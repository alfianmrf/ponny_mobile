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
  Function goToTab;

  @override
  void initState(){
    super.initState();

    slides.add(
      new Slide(
        title: "100% ASLI",
        styleTitle: TextStyle(
            color: Color(0xffF48262),
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'Brandon'),
        description: "Semua produk di Ponny Beaute pasti asli.\nNo tipu-tipu. Anti kaleng-kaleng",
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
        title: "PRODUK BER-BPOM",
        styleTitle: TextStyle(
            color: Color(0xffF48262),
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'Brandon'),
        description: "Percayalah produknya sudah punya izin edar.\nCek aja di situs BPOM / Kemenkes.",
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
        "Butuh teman curhat?\nPhoebe siap mendengarkan dan membantu.",
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
        description: "PAKEEETTTT!!\nPhoebe mau kamu terima produk ini\nseutuhnya, selamat, tanpa cacat.\n#antibocorbocorclub",
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

  List<Widget> renderListCustomTabs() {
    List<Widget> tabs = new List();
    for (int i = 0; i < slides.length; i++) {
      Slide currentSlide = slides[i];
      tabs.add(Container(
        width: double.infinity,
        height: double.infinity,
        child: Center(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  currentSlide.pathImage,
                  width: 300.0,
                  height: 300.0,
                  fit: BoxFit.contain,
                ),
                Container(
                  child: Text(
                    currentSlide.title,
                    style: currentSlide.styleTitle,
                    textAlign: TextAlign.center,
                  ),
                  margin: EdgeInsets.only(top: 5.0),
                ),
                Container(
                  child: Text(
                    currentSlide.description,
                    style: currentSlide.styleDescription,
                    textAlign: TextAlign.center,
                    maxLines: 5,
                    overflow: TextOverflow.ellipsis,
                  ),
                  margin: EdgeInsets.only(top: 15.0),
                ),
                i == 2 ? Container(
                  child: Text(
                    '(untuk informasi produk aja, bukan masalah sama pasangan yhaaa)',
                    style: TextStyle(
                        color: Color(0xff231F20),
                        fontSize: 10.0,
                        fontFamily: 'Brandon'),
                    textAlign: TextAlign.center,
                  ),
                  margin: EdgeInsets.only(top: 5.0),
                ) : Container(),
              ],
            ),
          ),
        ),
      ));
    }
    return tabs;
  }

  @override
  Widget build(BuildContext context) {
    return new IntroSlider(
      slides: this.slides,
      onDonePress: this.onDonePress,
      colorDot: Color(0xffE6E7E9),
      colorActiveDot: Color(0xffF3795D),
      sizeDot: 12,
      isShowNextBtn: false,
      styleNameSkipBtn: TextStyle(
        color: Color(0xff231F20),
      ),
      styleNameDoneBtn: TextStyle(
        color: Color(0xff231F20),
      ),
      styleNamePrevBtn: TextStyle(
        color: Color(0xff231F20),
      ),
      listCustomTabs: this.renderListCustomTabs(),
      backgroundColorAllSlides: Colors.white,
      refFuncGoToTab: (refFunc) {
        this.goToTab = refFunc;
      },
    );
  }
}