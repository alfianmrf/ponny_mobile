import 'package:flutter/material.dart';
import 'package:ponny/main.dart';
import 'package:ponny/model/App.dart';
import 'package:ponny/model/User.dart';
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
            Navigator.pushNamedAndRemoveUntil(
                context,
                KonsultasiScreen.id,(_) => false
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
            icon: Icon(Icons.home),
            title: Text(
              'Home',
              style: TextStyle(fontSize: 12.0, fontFamily: 'Brandon'),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            title: Text(
              'Browse',
              style: TextStyle(fontSize: 12.0, fontFamily: 'Brandon'),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.headset_mic),
            title: Text(
              'Consultation',
              style: TextStyle(fontSize: 12.0, fontFamily: 'Brandon'),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.forum),
            title: Text(
              'Forums',
              style: TextStyle(fontSize: 12.0, fontFamily: 'Brandon'),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            title: Text(
              'Account',
              style: TextStyle(fontSize: 12.0, fontFamily: 'Brandon'),
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
