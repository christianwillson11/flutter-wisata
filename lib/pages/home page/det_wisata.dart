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
          backgroundColor: Color(0xfff3f3f3),
          appBar: AppBar(
            title: Text("Details"),
          ),
          body: SizedBox.expand(
              child: Stack(
            children: <Widget>[
              Align(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    Image(
                      image: NetworkImage(
                          "https://media-cdn.tripadvisor.com/media/photo-s/16/37/b8/a9/sunset-beach-every-night.jpg"),
                    ),
                    Spacer(),
                  ],
                ),
              ),
              SizedBox.expand(
                child: DraggableScrollableSheet(
                    initialChildSize: 0.6,
                    minChildSize: 0.6,
                    // maxChildSize: 0.8,
                    builder: (BuildContext context, index) {
                      return Container(
                        padding: EdgeInsets.fromLTRB(10, 15, 10, 15),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20.0),
                              topRight: Radius.circular(20.0),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey,
                                blurRadius: 10.0,
                              ),
                            ]),
                        child: ListView(
                          controller: index,
                          children: <Widget>[
                            Center(
                              child: Container(
                                height: 8,
                                width: 50,
                                decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              widget.data.judulCerita,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                              ),
                            ),
                            SizedBox(height: 20),
                            ListTile(
                              title: Text(widget.data.isiCerita),
                            ),
                            ListTile(
                              title: Text("penjelasan 2"),
                            ),
                            ListTile(
                              title: Text("penjelasan 3"),
                            ),
                          ],
                        ),
                      );
                    }),
              )
            ],
          ))),
    );
  }
}
