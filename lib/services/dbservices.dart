import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_wisata/model/MStories.dart';

CollectionReference tblCerita = FirebaseFirestore.instance.collection("stories");

class Database {
  static Stream<QuerySnapshot> getAllData () {
    return tblCerita.snapshots();
  }

  static Future<bool> insertData({required StoriesItem item}) async {
    DocumentReference docRef = tblCerita.doc();

    bool success = false;

    await docRef
    .set(item.toJson())
    .whenComplete(() => success = true)
    .catchError((e) => success = false);
    return success;
  }
}