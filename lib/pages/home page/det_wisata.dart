import 'package:flutter/material.dart';
import 'package:flutter_wisata/model/MDestination.dart';
import 'package:flutter_wisata/model/MStories.dart';
import 'package:flutter_wisata/services/apiservices.dart';

class DetailWisata extends StatefulWidget {
  final StoriesItem data;

  const DetailWisata({Key? key, required this.data}) : super(key: key);

  @override
  State<DetailWisata> createState() => _DetailWisataState();
}

class _DetailWisataState extends State<DetailWisata> {

  late Future<List<DestinationAttractionData>> attraction;

  void fetchDetailData() {
    if (widget.data.category == "attraction") {
      DestinationApiService destApi = DestinationApiService();
      attraction = destApi.getAttractionData(widget.data.locationId);

    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Details"),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                widget.data.judulCerita,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),

            Text(widget.data.isiCerita),
            
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
