import 'package:flutter/material.dart';
import 'package:ponny/main.dart';
import 'package:ponny/model/App.dart';
import 'package:ponny/model/User.dart';
import 'package:ponny/screens/bantuan_screen.dart';
import 'package:ponny/screens/home_screen.dart';
import 'package:ponny/screens/account_screen.dart';
import 'package:ponny/screens/Browse_Screen.dart';
import 'package:ponny/screens/forums_screen.dart';
import 'package:ponny/screens/Forum_screen.dart';
import 'package:ponny/screens/konsultasi_screen.dart';
import 'package:ponny/screens/login.dart';
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
            if(ModalRoute.of(context).settings.name != "home_screen"){
              Navigator.pushNamedAndRemoveUntil(
                  context,
                  HomeScreen.id,(_) => false
              );
            }
          break;
        case 1:
            if(ModalRoute.of(context).settings.name != "Browse_Category_Screen")
            Navigator.pushNamedAndRemoveUntil(
                context,
                Browse.id,(_) => false
            );
          break;
        case 2:
          if(ModalRoute.of(context).settings.name != "konsultasi_screen")
            Provider.of<AppModel>(context).loggedIn ? Navigator.pushNamedAndRemoveUntil(
                context,
                BantuanScreen.id,(_) => false
            ):Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LoginScreen()),
            );
          break;
        case 3:
            if( ModalRoute.of(context).settings.name != "forums_screen"){
              Navigator.pushNamedAndRemoveUntil(
                  context,
                  ForumData.id,(_) => false
              );
            }
          break;
        case 4:
            if(ModalRoute.of(context).settings.name !=  "account_screen"){
              Provider.of<AppModel>(context).loggedIn ?Navigator.pushNamedAndRemoveUntil(
                  context,
                  AccountScreen.id,(_) => false
              ) :  Navigator.push(
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
          primaryColor: Colors.white,
          textTheme: Theme.of(context)
              .textTheme
              .copyWith(caption: new TextStyle(color: Colors.white))),
      child: new BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage('assets/images/bottomNavbar/beranda.png'),
            ),
            title: Text(
              'Beranda',
              style: TextStyle(fontSize: 11.0, fontFamily: 'Brandon'),
            ),
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage('assets/images/bottomNavbar/cari.png'),
            ),
            title: Text(
              'Cari',
              style: TextStyle(fontSize: 11.0, fontFamily: 'Brandon'),
            ),
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage('assets/images/bottomNavbar/bantuan.png'),
            ),
            title: Text(
              'Butuh Bantuan?',
              style: TextStyle(fontSize: 11.0, fontFamily: 'Brandon'),
            ),
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage('assets/images/bottomNavbar/forum.png'),
            ),
            title: Text(
              'Forum',
              style: TextStyle(fontSize: 11.0, fontFamily: 'Brandon'),
            ),
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage('assets/images/bottomNavbar/akun.png'),
            ),
            title: Text(
              'Akun Saya',
              style: TextStyle(fontSize: 11.0, fontFamily: 'Brandon'),
            ),
          ),
        ],
        selectedItemColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        currentIndex: selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
