import 'package:flutter/material.dart';
import 'package:flutter_wisata/model/MResep.dart';

class ListWisata extends StatefulWidget {
  final MResep postresep;

  const ListWisata({Key? key, required this.postresep}) : super(key: key);

  @override
  State<ListWisata> createState() => _ListWisataState();
}

class _ListWisataState extends State<ListWisata> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Detail Makanan"),
        ),
        body: Column(
          children: [
            Image.network(widget.postresep.gambarURL),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                widget.postresep.namamenu,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(15),
              child: Text(widget.postresep.alamatURL),
            ),
            ElevatedButton(
                onPressed: Navigator.of(context).pop,
                child: Text("Back"),
              )
          ],
        ),
      ),
    );
  }
}
