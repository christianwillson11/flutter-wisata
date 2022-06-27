// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_wisata/pages/search page/search_hotel.dart';
import 'package:flutter_wisata/pages/search%20page/search_attractions.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  void moveToHotel() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return const searchHotel();
    }));
  }

  void moveToAttraction() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return const attractionPage();
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(20, 25, 10, 10),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "What do you want to find ?",
                  style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      semanticContainer: true,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: InkWell(
                        splashColor: Colors.blue.withAlpha(30),
                        onTap: () {
                          moveToHotel();
                        },
                        child: SizedBox(
                            height: 250,
                            child: Stack(
                              children: [
                                Ink.image(
                                  image: AssetImage(
                                    "assets/images/hotelillustration.jpg",
                                  ),
                                  fit: BoxFit.fill,
                                ),
                                Container(
                                  padding: EdgeInsets.all(20),
                                  child: Text(
                                    "Hotel",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold),
                                  ),
                                )
                              ],
                            )),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 20),
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      semanticContainer: true,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: InkWell(
                        splashColor: Colors.blue.withAlpha(30),
                        onTap: () {
                          moveToAttraction();
                        },
                        child: SizedBox(
                            height: 250,
                            child: Stack(
                              children: [
                                Ink.image(
                                  image: AssetImage(
                                    "assets/images/eiffel.jpg",
                                  ),
                                  fit: BoxFit.fill,
                                ),
                                Container(
                                  padding: EdgeInsets.all(20),
                                  child: Text(
                                    "Attractions",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold),
                                  ),
                                )
                              ],
                            )),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
