import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wisata/model/MStories.dart';
import 'package:flutter_wisata/pages/home%20page/details.dart';
import 'package:flutter_wisata/services/dbservices.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(10, 40, 10, 0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Your Posts",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 35,
              ),
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text("Owned by you"),
          ),
        ),
        Expanded(
          child: StreamBuilder<QuerySnapshot>(
              stream: Database.getAllData(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text("ERROR fetch data");
                } else if (snapshot.hasData || snapshot.data != null) {
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      //here
                      DocumentSnapshot dsData = snapshot.data!.docs[index];
                      String lvJudul = dsData['judulCerita'];
                      String lvIsi = dsData['isiCerita'];
                      String lvCategory = dsData['category'];
                      List<String> lvImages = (dsData['image'] as List)
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
                      //here
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                        child: Card(
                          clipBehavior: Clip.antiAlias,
                          elevation: 16,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) {
                                    return Details(data: x);
                                  },
                                ),
                              );
                            },
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Stack(
                                  alignment: Alignment.bottomLeft,
                                  children: [
                                    Ink.image(
                                      height: 200,
                                      image: NetworkImage(lvImages[0]),
                                      fit: BoxFit.fitWidth,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(16),
                                      child: Text(
                                        lvJudul,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold,
                                          shadows: <Shadow>[
                                            Shadow(
                                              offset: Offset(1.2, 1.2),
                                              blurRadius: 3.0,
                                              color:
                                                  Color.fromARGB(255, 0, 0, 0),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(16, 16, 16, 16),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(0, 0, 0, 6),
                                        child: Text(
                                          lvCategory,
                                          style:
                                              TextStyle(color: Colors.black54),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 35,
                                        child: RichText(
                                          overflow: TextOverflow.ellipsis,
                                          strutStyle:
                                              StrutStyle(fontSize: 12.0),
                                          text: TextSpan(
                                            style:
                                                TextStyle(color: Colors.black),
                                            text: lvIsi,
                                          ),
                                        ),
                                      ),
                                      // Text(description2[index]),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Colors.pinkAccent,
                    ),
                  ),
                );
              }),
        ),
      ],
    );
  }
}
