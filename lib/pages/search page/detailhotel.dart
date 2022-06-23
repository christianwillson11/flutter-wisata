// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_wisata/pages/hotelData.dart';

class detailHotel extends StatefulWidget {
  final listHotel myhotel;
  const detailHotel({Key? key, required this.myhotel}) : super(key: key);

  @override
  State<detailHotel> createState() => _detailHotelState();
}

class _detailHotelState extends State<detailHotel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: SafeArea(
        child: Container(
          child: Column(
            children: [
              Container(
                height: 230,
                child: Image(
                  image: NetworkImage(widget.myhotel.gambar.toString()),
                  fit: BoxFit.fill,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: 12,
                  right: 24,
                  top: 16,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // SizedBox(
                    //   height: 8,
                    // ),
                    Text(
                      widget.myhotel.hotelName.toString(),
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Divider(
                      height: 10,
                      thickness: 1,
                      color: Colors.black,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    // Text(
                    //   "Alamat Hotel : ",
                    //   style: TextStyle(
                    //     fontSize: 23,
                    //   ),
                    // ),
                    SizedBox(
                      height: 12,
                    ),
                    Text(
                      widget.myhotel.alamat.toString() +
                          ", " +
                          widget.myhotel.locality.toString(),
                      style: TextStyle(
                          fontSize: 23,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    Row(
                      children: [
                        Text(
                          "Bintang : ",
                          style: TextStyle(
                              color: Colors.black,
                              fontStyle: FontStyle.italic,
                              fontSize: 20.0),
                        ),
                        Text(
                          widget.myhotel.rating.toString(),
                          style: TextStyle(
                              color: Colors.blueGrey,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic,
                              fontSize: 20.0),
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.yellow,
                          size: 28,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 14,
                    ),

                    Text(
                      "User Story",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    // Container(
                    //   child: Text("Ini Test Scroll view"),
                    //   height: 150.0,
                    //   decoration: BoxDecoration(
                    //     color: Colors.red
                    //   ),
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
