// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wisata/model/hotelData.dart';

import '../../model/MStories.dart';
import '../../services/dbservices.dart';
import '../home page/details.dart';

class detailHotel extends StatefulWidget {
  final listHotel myhotel;
  const detailHotel({Key? key, required this.myhotel}) : super(key: key);

  @override
  State<detailHotel> createState() => _detailHotelState();
}

class _detailHotelState extends State<detailHotel> {
  Stream<QuerySnapshot<Object?>> onFetch() {
    return Database.getData(widget.myhotel.id.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 310,
                child: Image(
                  image: NetworkImage(widget.myhotel.gambar.toString()),
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                  left: 16,
                  right: 16,
                  top: 16,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.myhotel.hotelName.toString(),
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Divider(
                      height: 10,
                      thickness: 1,
                      color: Colors.black,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Text(
                      widget.myhotel.alamat.toString() +
                          ", " +
                          widget.myhotel.locality.toString(),
                      style: TextStyle(
                          fontSize: 23,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    Row(
                      children: [
                        Text(
                          "Bintang : ",
                          style: TextStyle(
                              color: Colors.black,
                              fontStyle: FontStyle.italic,
                              fontSize: 20.0),
                        ),
                        Text(
                          widget.myhotel.rating.toString(),
                          style: TextStyle(
                              color: Colors.blueGrey,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic,
                              fontSize: 20.0),
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.yellow,
                          size: 28,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 18,
                    ),
                    Text(
                      "User Story",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    StreamBuilder<QuerySnapshot>(
                      stream: onFetch(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Text("Error");
                        } else if (snapshot.hasData || snapshot.data != null) {
                          return Card(
                            child: ListView.separated(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                DocumentSnapshot dsData =
                                    snapshot.data!.docs[index];
                                String lvJudul = dsData['judulCerita'];
                                String lvIsi = dsData['isiCerita'];
                                String lvCategory = dsData['category'];
                                  List<String> lvImages =
                                      (dsData['image'] as List)
                                          .map((item) => item as String)
                                          .toList();
                                  var x = StoriesItem(
                                      cityId: dsData['cityId'],
                                      locationId: dsData['locationId'],
                                      judulCerita: lvJudul,
                                      isiCerita: lvIsi,
                                      image: lvImages,
                                      owner: dsData['owner'],
                                      category: lvCategory);
                                return ListTile(
                                  onTap: () {
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (context) {
                                        return Details(data: x);
                                      }));
                                  },
                                  title: Text(lvJudul),
                                  subtitle: Text(lvIsi),
                                  leading: Icon(Icons.person),
                                );
                              },
                              separatorBuilder: (context, index) {
                                return SizedBox(height: 4.0);
                              },
                              itemCount: snapshot.data!.docs.length,
                            ),
                          );
                        }
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
