// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_wisata/pages/search page/search_hotel.dart';

class searchPage extends StatefulWidget {
  const searchPage({Key? key}) : super(key: key);

  @override
  State<searchPage> createState() => _searchPageState();
}

class _searchPageState extends State<searchPage> {
  void moveToHotel() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return const searchHotel();
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Center(
        child: Container(
          padding: EdgeInsets.fromLTRB(20, 30, 20, 10),
          child: ListView(
            children: [
              Text(
                "What do you want to find ?",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 30,),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)
                ),
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
                              style:
                                  TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      )),
                ),
              ),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)
                ),
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
                              "assets/images/eiffel.jpg",
                            ),
                            fit: BoxFit.fill,
                          ),
                          Container(
                            padding: EdgeInsets.all(20),
                            child: Text(
                              "Attractions",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      )),
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
