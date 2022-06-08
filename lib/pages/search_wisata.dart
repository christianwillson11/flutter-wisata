import 'package:flutter/material.dart';

class SearchWisata extends StatefulWidget {
  const SearchWisata({ Key? key }) : super(key: key);

  @override
  State<SearchWisata> createState() => _SearchWisataState();
}

class _SearchWisataState extends State<SearchWisata> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(8, 30, 8, 8),
      child: Column(
        children: [
          Text("Hello World"),
        ],
      ),
    );
  }
}