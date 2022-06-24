// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_wisata/pages/apiservices.dart';
import 'package:flutter_wisata/pages/search%20page/detailhotel.dart';
import 'package:flutter_wisata/model/hotelData.dart';

class searchHotel extends StatefulWidget {
  const searchHotel({ Key? key }) : super(key: key);

  @override
  State<searchHotel> createState() => _searchHotelState();
}

class _searchHotelState extends State<searchHotel> {

  TextEditingController tfCity = TextEditingController();
  hotelService hotelID = hotelService();
  hotelData hotelList = hotelData();
  late Future<listHotel> dataa;
  late Future<List<listHotel>> data2;

  String city = "Jakarta";

  @override
  void initState() {
    //dataa = hotelID.getDestinationID('Jakarta');
    data2 = hotelID.getDestinationID('${city}');
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
                                    city = tfCity.text.toString();
                                    data2 = hotelID.getDestinationID('${city}');
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
                child: FutureBuilder<List<listHotel>>(
                  future: data2,
                  builder: ((context, snapshot){
                    if (snapshot.hasData){
                      List<listHotel> isiData = snapshot.data!;
                      return ListView.builder(
                        itemCount: isiData.length,
                        itemBuilder: (context, index){
                          return Column(
                            children: [
                              Card(
                                child: ListTile(
                                  title: Text("${isiData[index].hotelName}"),
                                  subtitle: Text("${isiData[index].alamat}"),
                                  onTap: (){
                                    Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return detailHotel(
                                          myhotel: isiData[index],
                                        );
                                      },
                                    ),
                                  );
                                  },
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
