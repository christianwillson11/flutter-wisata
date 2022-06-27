// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter_wisata/pages/home%20page/home.dart';
import 'package:flutter_wisata/pages/input%20cerita/menu.dart';
import 'package:flutter_wisata/pages/login%20register/profile_page.dart';
import 'package:flutter_wisata/pages/pageWeather.dart';
import 'package:flutter_wisata/pages/search page/searchPage.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  var page_displayed;

  @override
  void initState() {
    page_displayed = Home();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          bottomNavigationBar: CurvedNavigationBar(
            key: _bottomNavigationKey,
            index: 0,
            height: 60.0,
            items: const <Widget>[
              Icon(Icons.home, size: 30, color: Colors.white),
              Icon(Icons.search, size: 30, color: Colors.white),
              Icon(Icons.add, size: 30, color: Colors.white),
              Icon(Icons.cloud, size: 30, color: Colors.white),
              Icon(Icons.people, size: 30, color: Colors.white),
            ],
            color: Colors.blueAccent,
            buttonBackgroundColor: Colors.blue,
            backgroundColor: const Color(0x00fafafa),
            animationCurve: Curves.easeInOut,
            animationDuration: const Duration(milliseconds: 600),
            onTap: (index) {
              setState(() {
                if (index == 1) {
                  page_displayed = SearchPage();
                } else if (index == 2) {
                  page_displayed = Menu();
                } else if (index == 3){
                  page_displayed = pageWeather();
                }
                else if (index == 4){
                  page_displayed = profilePage();
                }
                else {
                  page_displayed = Home();
                }
              });
            },
            letIndexChange: (index) => true,
          ),
          body: Center(
            child: page_displayed,
          ),
        ),
      ),
    );
  }
}
