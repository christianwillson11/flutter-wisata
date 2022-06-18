import 'package:flutter/material.dart';
import 'package:flutter_wisata/pages/apiservices.dart';
import 'package:flutter_wisata/pages/hotelData.dart';

class SearchWisata extends StatefulWidget {
  const SearchWisata({Key? key}) : super(key: key);

  @override
  State<SearchWisata> createState() => _SearchWisataState();
}

class _SearchWisataState extends State<SearchWisata> {
  hotelService hotelID = hotelService();
  hotelData hotelList = hotelData();
  late Future<listHotel> dataa;
  late Future<List<listHotel>> data2;

  @override
  void initState() {
    //dataa = hotelID.getDestinationID('Jakarta');
    data2 = hotelID.getDestinationID('Jakarta');
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
          child: FutureBuilder<List<listHotel>>(
            future: data2,
            builder: ((context, snapshot){
              if (snapshot.hasData){
                List<listHotel> isiData = snapshot.data!;
                return ListView.builder(
                  itemCount: isiData.length,
                  itemBuilder: (context, index){
                    return Card(
                      child: ListTile(
                        title: Text("${isiData[index].hotelName}"),
                        subtitle: Text("${isiData[index].geoID}"),
                      ),
                    );
                  },
                );
              }
              return Center(
                          child: CircularProgressIndicator(),
                        );
            }),
          )
        ),
      ),
    );
  }
}
