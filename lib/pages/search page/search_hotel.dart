// ignore_for_file: prefer_const_constructors, unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:flutter_wisata/services/apiservices.dart';
import 'package:flutter_wisata/pages/search%20page/detailhotel.dart';
import 'package:flutter_wisata/model/hotelData.dart';
import 'package:fluttertoast/fluttertoast.dart';

class searchHotel extends StatefulWidget {
  const searchHotel({ Key? key }) : super(key: key);

  @override
  State<searchHotel> createState() => _searchHotelState();
}

class _searchHotelState extends State<searchHotel> {

  TextEditingController tfCity = TextEditingController();
  hotelService hotelApi = hotelService();
  late List<listHotel> data2;

  String city = "Jakarta";

  bool isLoading = true;
  bool isError = false;

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  void fetchData() async {
    setState(() {
      isLoading = true;
      isError = false;
    });
    try {
      data2 = await hotelApi.getDestinationID(city);
      setState(() {
        //jika sukses jaya
        isLoading = false;
        isError = false;
      });
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString(), toastLength: Toast.LENGTH_LONG);
      setState(() {
        //jika tidak sukses
        isLoading = false;
        isError = true;
      });
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
                        "Best Deals",
                        textAlign: TextAlign.left,
                        style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                      ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
                child: Row(
                  children: [
                    
                    Expanded(
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
                                city = tfCity.text.toString();
                                fetchData();
                              }, 
                              icon: Icon(Icons.arrow_forward_ios))
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
          )
        ),
      ),
    );
  }

  Widget contentWidget() {
    if (isLoading == false && isError == false) {
      return ListView.builder(
              itemCount: data2.length,
              itemBuilder: (context, index){
                return Column(
                  children: [
                    // Card(
                    //   child: ListTile(
                    //     title: Text("${isiData[index].hotelName}"),
                    //     subtitle: Text("${isiData[index].alamat}"),
                    //     onTap: (){
                    //       Navigator.push(
                    //       context,
                    //       MaterialPageRoute(
                    //         builder: (context) {
                    //           return detailHotel(
                    //             myhotel: isiData[index],
                    //           );
                    //         },
                    //       ),
                    //     );
                    //     },
                    //   ),
                    // ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8,8,8,0),
                      child: Card(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        color: Colors.white,
                        child: ClipRect(
                          child: AspectRatio(
                            aspectRatio: 2.7,
                            child: Stack(children: [
                              GestureDetector(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context){
                                    return detailHotel(myhotel: data2[index]);
                                  }));
                                },
                                child: Container(
                                  child: Row(
                                    children: [
                                      AspectRatio(
                                        aspectRatio: 0.9,
                                        child: Image.network("${data2[index].gambar.toString()}", fit: BoxFit.cover,),
                                      ),
                                      Expanded(
                                        child: Container(
                                          padding: EdgeInsets.all(10),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "${data2[index].hotelName}",
                                                textAlign: TextAlign.left,
                                                maxLines: 2,
                                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                              ),
                                              Text(
                                                "${data2[index].locality}",
                                                textAlign: TextAlign.left,
                                                style: TextStyle(fontSize: 14),
                                              ),
                                              Expanded(
                                                child: Row(
                                                  crossAxisAlignment: CrossAxisAlignment.end,
                                                  children: [
                                                    Text("${data2[index].price} /night",
                                                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold), )
                                                  ],
                                                )
                                                )
                                            ],
                                          ),
                                        )
                                      )
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
