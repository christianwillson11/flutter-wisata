import 'package:flutter/material.dart';
import 'package:flutter_wisata/model/MDestination.dart';
import 'package:flutter_wisata/pages/search%20page/detailwisata.dart';
import 'package:flutter_wisata/services/apiservices.dart';

class attractionPage extends StatefulWidget {
  const attractionPage({ Key? key }) : super(key: key);

  @override
  State<attractionPage> createState() => _attractionPageState();
}

class _attractionPageState extends State<attractionPage> {
  TextEditingController tfCity = TextEditingController();
  DestinationApiService attractionID = DestinationApiService();
  late Future<DestinationAttractionData> dataa;
  late Future<List<DestinationAttractionData>> data2;
  String city = "Jakarta";

  @override
  void initState() {
    //dataa = hotelID.getDestinationID('Jakarta');
    data2 = attractionID.getAttractionList('Jakarta');
    //data2 = hotelList.getHotelList("659455");
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
                padding: EdgeInsets.all(20),
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
                                onPressed: (){  
                                  setState(() {
                                    data2 = attractionID.getAttractionList('${city}');
                                  });    
                                }, 
                                icon: Icon(Icons.arrow_forward_ios))
                            ),
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
                child: Text("Current Location = " + "${city}"),
              ),
              Expanded(
                child: FutureBuilder<List<DestinationAttractionData>>(
                  future: data2,
                  builder: ((context, snapshot){
                    if (snapshot.hasData){
                      List<DestinationAttractionData> isiData = snapshot.data!;
                      return ListView.builder(
                        itemCount: isiData.length,
                        itemBuilder: (context, index){
                          return Column(
                            children: [
                              Card(
                                child: ListTile(
                                  title: Text("${isiData[index].cnama}"),
                                  subtitle: Text("${isiData[index].caddress}"),
                                  // onTap: (){
                                  //   Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //     builder: (context) {
                                  //       return detailWisata(
                                  //         myDestination: isiData[index],
                                  //       );
                                  //     },
                                  //   ),
                                  // );
                                  // },
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    }
                    return Center(
                                child: CircularProgressIndicator(),
                              );
                  }),
                ),
              ),
            ],
          )
        ),
      ),
    );
  }
}