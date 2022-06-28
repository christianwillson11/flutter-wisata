import 'package:flutter/material.dart';
import 'package:flutter_wisata/model/MDestination.dart';
import 'package:flutter_wisata/pages/search%20page/detailwisata.dart';
import 'package:flutter_wisata/services/apiservices.dart';
import 'package:fluttertoast/fluttertoast.dart';

class attractionPage extends StatefulWidget {
  const attractionPage({Key? key}) : super(key: key);

  @override
  State<attractionPage> createState() => _attractionPageState();
}

class _attractionPageState extends State<attractionPage> {
  TextEditingController tfCity = TextEditingController();
  DestinationApiService attractionApi = DestinationApiService();
  late List<DestinationAttractionData> data2;
  String city = "Jakarta";
  late String cityId;

  bool isLoading = true;
  bool isError = false;

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  void fetchData() async {
    bool status1 = true;
    try {
      cityId = await attractionApi.getLocId(city);
      status1 = true;
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString(), toastLength: Toast.LENGTH_LONG);
      status1 = false;
    }

    if (status1 == true) {
      try {
        data2 = await attractionApi.getAttractionData(cityId);
        setState(() {
          isLoading = false;
        });
      } catch (e) {
        Fluttertoast.showToast(msg: e.toString(), toastLength: Toast.LENGTH_LONG);
        setState(() {
          isLoading = false;
          isError = true;  
        });
        
      }
    }
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
                                      isError = false;
                                    });
                                    city = tfCity.text.toString();
                                    fetchData();
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
              child: contentWidget(),
            ),
          ],
        )),
      ),
    );
  }

  Widget contentWidget() {
    if (isLoading == false && isError == false) {
      return ListView.builder(
        itemCount: data2.length,
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
                padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
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
                                      myDestination: data2[index]);
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
                                    "${data2[index].thumbnail.toString()}",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Expanded(
                                    child: Container(
                                  padding: EdgeInsets.all(10),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${data2[index].cnama}",
                                        textAlign: TextAlign.left,
                                        maxLines: 2,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      ),
                                      Text(
                                        "${data2[index].caddress}",
                                        textAlign: TextAlign.left,
                                        style: TextStyle(fontSize: 14),
                                      ),
                                      Expanded(
                                          child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              "${data2[index].location}",
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.bold),
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
    } else if (isLoading == true && isError == false) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                
                child: Image.asset("assets/images/error.png", width: 200,),
              ),
              SizedBox(height: 20,),
              Text("Sorry, something went wrong", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)
            ],
          ),
        ));
    }
  }
}
