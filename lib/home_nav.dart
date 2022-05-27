import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter_wisata/pages/home.dart';
import 'package:flutter_wisata/pages/input_cerita.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _page = 0;
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  var page_displayed;

  @override
  void initState() {
    page_displayed = Home(index: "0");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Flutter Wisata"),
        ),
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
              _page = index;
              if (index == 2) {
                page_displayed = InputCerita();
              } else {
                page_displayed = Home(index: index.toString());
              }
            });
          },
          letIndexChange: (index) => true,
        ),
        body: Container(
          child: Center(
            child: page_displayed,
          ),
        ),
      ),
    );
  }
}