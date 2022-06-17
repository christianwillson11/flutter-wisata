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
  late Future<Hotel> dataa;
  late Future<listHotel> data2;

  @override
  void initState() {
    dataa = hotelID.getDestinationID('Jakarta');

    data2 = hotelList.getHotelData("659455");
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
          child: FutureBuilder(
            future: data2,
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                listHotel simpanData = snapshot.data! as listHotel;
                return ListView.builder(
                  itemCount: 5,
                  itemBuilder: ((context, index) {
                    return Container(
                      child: Text(simpanData.hotelName),
                    );
                  }),
                );
              } else {
                return CircularProgressIndicator();
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }
}
