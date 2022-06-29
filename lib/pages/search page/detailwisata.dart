// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wisata/model/MDestination.dart';

import '../../model/MStories.dart';
import '../../services/dbservices.dart';
import '../home page/details.dart';

class detailWisata extends StatefulWidget {
  final DestinationAttractionData myDestination;
  const detailWisata({Key? key, required this.myDestination}) : super(key: key);

  @override
  State<detailWisata> createState() => _detailWisataState();
}

class _detailWisataState extends State<detailWisata> {
  Stream<QuerySnapshot<Object?>> onFetch() {
    return Database.getData(widget.myDestination.cid.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                SizedBox(
                  // height: 230,
                  child: Image(
                    image: NetworkImage(
                        widget.myDestination.cimagesUrl![0].toString()),
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 16,
                    right: 16,
                    top: 16,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.myDestination.cnama.toString(),
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
                        height: 12,
                      ),
                      Text(
                        widget.myDestination.caddress.toString(),
                        style: TextStyle(
                            fontSize: 23,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 16.0,
                      ),
                      Text(
                        "Locality : " +
                            widget.myDestination.ctimezone.toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      Text(
                        widget.myDestination.cwebUrl.toString(),
                        style:
                            TextStyle(fontSize: 14, color: Colors.blueAccent),
                      ),
                      SizedBox(
                        height: 18,
                      ),
                      Text(
                        "User Story",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      StreamBuilder<QuerySnapshot>(
                        stream: onFetch(),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return Text("Error");
                          } else if (snapshot.hasData ||
                              snapshot.data != null) {
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
      ),
    );
  }
}
