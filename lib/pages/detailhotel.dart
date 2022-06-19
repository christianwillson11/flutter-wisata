// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

// void main() {
//   runApp(
//     const MaterialApp(
//       title: "Detail Hotel",
//       home: detailHotel(),
//     ),
//   );
// }

class detailHotel extends StatefulWidget {
  const detailHotel({Key? key}) : super(key: key);

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
                    "https://cdn.pixabay.com/photo/2014/07/10/17/17/hotel-389256_960_720.jpg"),
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
                    "OYO Bintang Lima",
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
                        "Makassar",
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
                        "data",
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
                    "Jalan Tupai No.78, Bonto Biraeng, Kecamatan Mamajang, Kota Makassar, Sulawesi Selatan 90132",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.blueGrey,
                    ),
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  Text(
                    "Review",
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
