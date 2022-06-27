import 'package:flutter/material.dart';
import 'package:flutter_wisata/model/MDestination.dart';
import 'package:flutter_wisata/pages/search%20page/detailwisata.dart';
import 'package:flutter_wisata/services/apiservices.dart';

class attractionPage extends StatefulWidget {
  const attractionPage({Key? key}) : super(key: key);

  @override
  State<attractionPage> createState() => _attractionPageState();
}

class _attractionPageState extends State<attractionPage> {
  TextEditingController tfCity = TextEditingController();
  DestinationApiService attractionID = DestinationApiService();
  late Future<List<DestinationAttractionData>> data2;
  String city = "Jakarta";

  var isLoading = false;

  @override
  void initState() {
    data2 = attractionID.getAttractionList('Jakarta');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // MediaQuery to get Device Width
    double width = MediaQuery.of(context).size.width * 0.6;
    return Scaffold(
      // Main List View With Builder
      body: SafeArea(
        child: Center(
            child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
              alignment: Alignment.centerLeft,
              child: Text(
                "Trending destinations",
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      child: Material(
                        elevation: 10,
                        borderRadius: BorderRadius.circular(30),
                        shadowColor: Color(0x55434343),
                        child: TextField(
                          controller: tfCity,
                          decoration: InputDecoration(
                              hintText: "Search city",
                              prefixIcon: Icon(Icons.search),
                              border: InputBorder.none,
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      isLoading = true;
                                    });
                                    city = tfCity.text.toString();
                                    data2 =
                                        attractionID.getAttractionList(city);
                                    data2.whenComplete(() {
                                      setState(() {
                                        isLoading = false;
                                      });
                                    });
                                  },
                                  icon: Icon(Icons.arrow_forward_ios))),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(20, 0, 0, 10),
              alignment: Alignment.centerLeft,
              child: Text("Current Location: $city"),
            ),
            Expanded(
                child: (isLoading == false)
                    ? FutureBuilder<List<DestinationAttractionData>>(
                        future: data2,
                        builder: ((context, snapshot) {
                          if (snapshot.hasData) {
                            List<DestinationAttractionData> isiData =
                                snapshot.data!;
                            return ListView.builder(
                              itemCount: isiData.length,
                              itemBuilder: (context, index) {
                                return Column(
                                  children: [
                                    // Card(
                                    //   child: ListTile(
                                    //     title: Text("${isiData[index].cnama}"),
                                    //     subtitle: Text("${isiData[index].caddress}"),
                                    //     onTap: (){
                                    //       Navigator.push(
                                    //       context,
                                    //       MaterialPageRoute(
                                    //         builder: (context) {
                                    //           return detailWisata(
                                    //             myDestination: isiData[index],
                                    //           );
                                    //         },
                                    //       ),
                                    //     );
                                    //     },
                                    //   ),
                                    // ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(8, 8, 8, 0),
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        color: Colors.white,
                                        child: ClipRect(
                                          child: AspectRatio(
                                            aspectRatio: 2.7,
                                            child: Stack(children: [
                                              GestureDetector(
                                                onTap: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) {
                                                        return detailWisata(
                                                            myDestination:
                                                                isiData[index]);
                                                      },
                                                    ),
                                                  );
                                                },
                                                child: Container(
                                                  child: Row(
                                                    children: [
                                                      AspectRatio(
                                                        aspectRatio: 0.9,
                                                        child: Image.network(
                                                          "${isiData[index].thumbnail.toString()}",
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                      Expanded(
                                                          child: Container(
                                                        padding:
                                                            EdgeInsets.all(10),
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              "${isiData[index].cnama}",
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                              maxLines: 2,
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 16),
                                                            ),
                                                            Text(
                                                              "${isiData[index].caddress}",
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                              style: TextStyle(
                                                                  fontSize: 14),
                                                            ),
                                                            Expanded(
                                                                child: Row(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .end,
                                                              children: [
                                                                Expanded(
                                                                  child: Text(
                                                                    "${isiData[index].location}",
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            17,
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                                  ),
                                                                )
                                                              ],
                                                            ))
                                                          ],
                                                        ),
                                                      ))
                                                    ],
                                                  ),
                                                ),
                                              )
                                            ]),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                );
                              },
                            );
                          }
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }),
                      )
                    : Center(
                        child: CircularProgressIndicator(),
                      )),
          ],
        )),
      ),
    );
  }
}
