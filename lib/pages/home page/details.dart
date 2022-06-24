import 'package:flutter/material.dart';
import 'package:flutter_wisata/model/MDestination.dart';
import 'package:flutter_wisata/model/MStories.dart';
import 'package:flutter_wisata/services/apiservices.dart';

class Details extends StatefulWidget {
  final StoriesItem data;

  const Details({Key? key, required this.data}) : super(key: key);

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
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
        body: SizedBox.expand(
          child: Stack(
            children: <Widget>[
              Align(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    Image(
                      image: NetworkImage(widget.data.image.last),
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
                        decoration: const BoxDecoration(
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
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              widget.data.judulCerita,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                              ),
                            ),
                            const SizedBox(height: 20),
                            ListTile(
                              title: Text(widget.data.isiCerita),
                            ),
                            Container(
                              padding: EdgeInsets.fromLTRB(15, 5, 15, 10),
                              height: 150,
                              child: ListView(
                                scrollDirection: Axis.horizontal,
                                children: [
                                  for (var i in widget.data.image) buildCard(i)
                                ],
                              ),
                            ),
                            ListTile(
                                title: ElevatedButton(
                                    onPressed: () {
                                      //TODO
                                      //pergi ke detail hotel / detail attraction punya richardo
                                    },
                                    child: Text(
                                        "Go to ${widget.data.category} details"))),
                          ],
                        ),
                      );
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCard(String i) {
    return Row(children: [
      SizedBox(
        width: 150,
        height: 150,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Card(
            elevation: 3.0,
            child: AspectRatio(
              aspectRatio: 4/3,
              child: Image.network(
                i,
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
      ),
      SizedBox(width: 12),
    ]);
  }
}
