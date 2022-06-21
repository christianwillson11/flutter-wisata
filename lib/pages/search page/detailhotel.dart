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
      child: Container(
        child: Column(
          children: [
            Container(
              child: Image(
                image: NetworkImage(
                    widget.myhotel.gambar.toString()),
                fit: BoxFit.cover,
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
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 18,
                  ),
                  Row(
                    children: [
                      Text(
                        widget.myhotel.locality.toString(),
                        style: TextStyle(fontSize: 14),
                      ),
                      SizedBox(
                        width: 32,
                      ),
                      Text(
                        "Rating : ",
                        style: TextStyle(
                            color: Colors.blueGrey,
                            fontStyle: FontStyle.italic),
                      ),
                      Text(
                        widget.myhotel.rating.toString(),
                        style: TextStyle(
                            color: Colors.blueGrey,
                            fontStyle: FontStyle.italic),
                      ),
                      SizedBox(width: 4,),
                      Icon(
                        Icons.star,
                        color: Colors.greenAccent,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 14,
                  ),
                  Text(
                    widget.myhotel.alamat.toString(),
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.blueGrey,
                    ),
                  ),
                  SizedBox(
                    height: 16.0,
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
    ));
  }
}
