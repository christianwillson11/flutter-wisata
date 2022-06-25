// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_wisata/model/MDestination.dart';

class detailWisata extends StatefulWidget {
  final DestinationAttractionData myDestination;
  const detailWisata({Key? key, required this.myDestination}) : super(key: key);

  @override
  State<detailWisata> createState() => _detailWisataState();
}

class _detailWisataState extends State<detailWisata> {
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
                    image: NetworkImage(widget.myDestination.cimagesUrl.toString()),
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
                      Text(
                        widget.myDestination.cnama.toString(),
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
                      SizedBox(
                        height: 12,
                      ),
                      // Text(
                      //   widget.myDestination.caddress.toString() +
                      //       ", " +
                      //       widget.myDestination.c.toString(),
                      //   style: TextStyle(
                      //       fontSize: 23,
                      //       color: Colors.black,
                      //       fontWeight: FontWeight.bold),
                      // ),
                      SizedBox(
                        height: 16.0,
                      ),
                      // Row(
                      //   children: [
                      //     Text(
                      //       "Bintang : ",
                      //       style: TextStyle(
                      //           color: Colors.black,
                      //           fontStyle: FontStyle.italic,
                      //           fontSize: 20.0),
                      //     ),
                      //     Text(
                      //       widget.myDestination..toString(),
                      //       style: TextStyle(
                      //           color: Colors.blueGrey,
                      //           fontWeight: FontWeight.bold,
                      //           fontStyle: FontStyle.italic,
                      //           fontSize: 20.0),
                      //     ),
                      //     SizedBox(
                      //       width: 4,
                      //     ),
                      //     Icon(
                      //       Icons.star,
                      //       color: Colors.yellow,
                      //       size: 28,
                      //     ),
                      //   ],
                      // ),
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
      ),
    );
  }
}
