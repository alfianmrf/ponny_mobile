import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:ponny/common/constant.dart';
import 'package:ponny/main.dart';
import 'package:ponny/model/App.dart';
import 'package:ponny/model/Product.dart';
import 'package:ponny/model/User.dart';
import 'package:ponny/screens/bantuan_screen.dart';
import 'package:ponny/screens/home_screen.dart';
import 'package:ponny/screens/account_screen.dart';
import 'package:ponny/screens/Browse_Screen.dart';
import 'package:ponny/screens/forums_screen.dart';
import 'package:ponny/screens/Forum_screen.dart';
import 'package:ponny/screens/konsultasi_screen.dart';
import 'package:ponny/screens/login.dart';
import 'package:ponny/screens/product_details_screen.dart';
import 'package:ponny/util/globalUrl.dart';
import 'package:provider/provider.dart';
import 'package:ponny/screens/Browse_Screen.dart';

class PonnyBottomNavbar extends StatelessWidget {
  PonnyBottomNavbar({this.selectedIndex});
  int selectedIndex;

  @override
  Widget build(BuildContext context) {
    void _onItemTapped(int index) {
      switch (index) {
        case 0:
          print(ModalRoute.of(context).settings.name);
          if (ModalRoute.of(context).settings.name != "home_screen") {
            Navigator.pushNamedAndRemoveUntil(
                context, HomeScreen.id, (_) => false);
          }
          break;
        case 1:
          if (ModalRoute.of(context).settings.name != "Browse_Category_Screen")
            Navigator.pushNamedAndRemoveUntil(context, Browse.id, (_) => false);
          break;
        case 2:
          if (ModalRoute.of(context).settings.name != "bantuan_screen")
            Provider.of<AppModel>(context).loggedIn
                ? Navigator.pushNamedAndRemoveUntil(
                    context, BantuanScreen.id, (_) => false)
                : Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
          break;
        case 3:
          if (ModalRoute.of(context).settings.name != "forums_screen") {
            Provider.of<AppModel>(context).loggedIn
                ? Navigator.pushNamedAndRemoveUntil(
                    context, ForumData.id, (_) => false)
                : Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
          }
          break;
        case 4:
          if (ModalRoute.of(context).settings.name != "account_screen") {
            Provider.of<AppModel>(context).loggedIn
                ? Navigator.pushNamedAndRemoveUntil(
                    context, AccountScreen.id, (_) => false)
                : Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
          }
          break;
        default:
          Navigator.of(context).pushReplacementNamed(HomeScreen.id);
      }
    }

    return new Theme(
      data: Theme.of(context).copyWith(
          canvasColor: Color(0xffF48262),
          textTheme: Theme.of(context)
              .textTheme
              .copyWith(caption: new TextStyle(color: Colors.white))),
      child: new BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            activeIcon: ImageIcon(
              AssetImage('assets/images/bottomNavbar/beranda-aktif.png'),
            ),
            icon: ImageIcon(
              AssetImage('assets/images/bottomNavbar/beranda.png'),
            ),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            activeIcon: ImageIcon(
              AssetImage('assets/images/bottomNavbar/cari-aktif.png'),
            ),
            icon: ImageIcon(
              AssetImage('assets/images/bottomNavbar/cari.png'),
            ),
            label: 'Cari',
          ),
          BottomNavigationBarItem(
            activeIcon: ImageIcon(
              AssetImage('assets/images/bottomNavbar/bantuan-aktif.png'),
            ),
            icon: ImageIcon(
              AssetImage('assets/images/bottomNavbar/bantuan.png'),
            ),
            label: 'Butuh Bantuan?',
          ),
          BottomNavigationBarItem(
            activeIcon: ImageIcon(
              AssetImage('assets/images/bottomNavbar/forum-aktif.png'),
            ),
            icon: ImageIcon(
              AssetImage('assets/images/bottomNavbar/forum.png'),
            ),
            label: 'Forum',
          ),
          BottomNavigationBarItem(
            activeIcon: ImageIcon(
              AssetImage('assets/images/bottomNavbar/akun-aktif.png'),
            ),
            icon: ImageIcon(
              AssetImage('assets/images/bottomNavbar/akun.png'),
            ),
            label: 'Akun Saya',
          ),
        ],
        selectedLabelStyle: TextStyle(
          fontFamily: 'Brandon',
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
        unselectedLabelStyle: TextStyle(
          fontFamily: 'Brandon',
          fontSize: 10,
        ),
        type: BottomNavigationBarType.fixed,
        currentIndex: selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
